Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2D1C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 00:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7792E21655
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 00:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbfI1AFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 20:05:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57212 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfI1AFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 20:05:12 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DB91030860D1;
        Sat, 28 Sep 2019 00:05:11 +0000 (UTC)
Received: from localhost (ovpn-12-27.pek2.redhat.com [10.72.12.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C79A7600CD;
        Sat, 28 Sep 2019 00:05:08 +0000 (UTC)
Date:   Sat, 28 Sep 2019 08:05:05 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Dave Young <dyoung@redhat.com>, Lianbo Jiang <lijiang@redhat.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, jgross@suse.com,
        dhowells@redhat.com, Thomas.Lendacky@amd.com,
        kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] x86/kdump: Fix 'kmem -s' reported an invalid freepointer
 when SME was active
Message-ID: <20190928000505.GJ31919@MiWiFi-R3L-srv>
References: <20190920035326.27212-1-lijiang@redhat.com>
 <20190927051518.GA13023@dhcp-128-65.nay.redhat.com>
 <87r241piqg.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r241piqg.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Sat, 28 Sep 2019 00:05:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/27/19 at 03:49pm, Eric W. Biederman wrote:
> Dave Young <dyoung@redhat.com> writes:
> >> In order to avoid such problem, lets occupy the first 640k region when
> >> SME is active, which will ensure that the allocated memory does not fall
> >> into the first 640k area. So, no need to worry about whether kernel can
> >> correctly copy the contents of the first 640K area to a backup region in
> >> purgatory().
> 
> We must occupy part of the first 640k so that we can start up secondary
> cpus unless someone has added another way to do that in recent years on
> SME capable cpus.
> 
> Further there is Fimware/BIOS interaction that happens within those
> first 640K.
> 
> Furthermore the kdump kernel needs to be able to read all of the memory
> that the previous kernel could read.  Otherwise we can't get a crash
> dump.
> 
> So I do not think ignoring the first 640K is the correct resolution
> here.
> 
> > The log is too simple,  I know you did some other tries to fix this, but
> > the patch log does not show why you can not correctly copy the 640k in
> > current kdump code, in purgatory here.
> >
> > Also this patch seems works in your test, but still to see if other
> > people can comment and see if it is safe or not, if any other risks
> > other than waste the small chunk of memory.  If it is safe then kdump
> > can just drop the backup logic and use this in common code instead of
> > only do it for SME.
> 
> Exactly.
> 
> I think at best this avoids the symptoms, but does not give a reliable
> crash dump.

Sorry, didn't notice this comment at bottom.

From code, currently the first 640K area is needed in two places.
One is for 5-level trampoline during boot compressing stage, in
find_trampoline_placement(). 

The other is in reserve_real_mode(), as you mentioned, for application
CPU booting.

Only allow these two put data inside first 640K, then lock it done. It
should not impact crash dump and parsing. And these two's content
doesn't matter.

Thanks
Baoquan
