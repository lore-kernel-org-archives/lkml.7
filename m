Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A06DC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF8220640
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556195877;
	bh=BLYmq2QZWn+4u3G8eVmnymVmSB0aMhc9LVW5DWKsTbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PjActj4rO3O0BFV8TH8f8k2hsAoGdUO1ZtynCADhcet+A2R6VqoniplCyGD96t2QM
	 +h3xV8eof0Q4iwrt5v668ue/YZuBtPz0Cc3noWLYbkQVWR9seR55aDAqfAWwNn35Qb
	 KRSjSwr62MqvH/6xCl71DhrD/f4ESZZCdVCkv7QQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731219AbfDYMh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:37:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:33786 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725965AbfDYMh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:37:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6120AAC3D;
        Thu, 25 Apr 2019 12:37:56 +0000 (UTC)
Date:   Thu, 25 Apr 2019 14:37:55 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>, linux-api@vger.kernel.org
Subject: Re: [PATCH V2] mm: Allow userland to request that the kernel clear
 memory on release
Message-ID: <20190425123755.GX12751@dhcp22.suse.cz>
References: <CACdnJuup-y1xAO93wr+nr6ARacxJ9YXgaceQK9TLktE7shab1w@mail.gmail.com>
 <20190424211038.204001-1-matthewgarrett@google.com>
 <20190425121410.GC1144@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425121410.GC1144@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 25-04-19 14:14:10, Michal Hocko wrote:
> Please cc linux-api for user visible API proposals (now done). Keep the
> rest of the email intact for reference.
> 
> On Wed 24-04-19 14:10:39, Matthew Garrett wrote:
> > From: Matthew Garrett <mjg59@google.com>
> > 
> > Applications that hold secrets and wish to avoid them leaking can use
> > mlock() to prevent the page from being pushed out to swap and
> > MADV_DONTDUMP to prevent it from being included in core dumps. Applications
> > can also use atexit() handlers to overwrite secrets on application exit.
> > However, if an attacker can reboot the system into another OS, they can
> > dump the contents of RAM and extract secrets. We can avoid this by setting
> > CONFIG_RESET_ATTACK_MITIGATION on UEFI systems in order to request that the
> > firmware wipe the contents of RAM before booting another OS, but this means
> > rebooting takes a *long* time - the expected behaviour is for a clean
> > shutdown to remove the request after scrubbing secrets from RAM in order to
> > avoid this.
> > 
> > Unfortunately, if an application exits uncleanly, its secrets may still be
> > present in RAM. This can't be easily fixed in userland (eg, if the OOM
> > killer decides to kill a process holding secrets, we're not going to be able
> > to avoid that), so this patch adds a new flag to madvise() to allow userland
> > to request that the kernel clear the covered pages whenever the page
> > reference count hits zero. Since vm_flags is already full on 32-bit, it
> > will only work on 64-bit systems.

The changelog seems stale. You are hooking into unmap path where the
reference count might be still > 0 and the page still held by somebody.
A previous email from Willy said
"
It could be the target/source of direct I/O, or userspace could have
registered it with an RDMA device, or ...

It depends on the semantics you want.  There's no legacy code to
worry about here.  I was seeing this as the equivalent of an atexit()
handler; userspace is saying "When this page is unmapped, zero it".
So it doesn't matter that somebody else might be able to reference it --
userspace could have zeroed it themselves.
"

I am not sure this is really a bullet proof argumentation but it should
definitely be part of the changelog.

Besides that you inherently assume that the user would do mlock because
you do not try to wipe the swap content. Is this intentional?

Another question would be regarding the targeted user API. There are
some attempts to make all the freed memory to be zeroed/poisoned. Are
users who would like to use this feature also be interested in using
system wide setting as well?
-- 
Michal Hocko
SUSE Labs
