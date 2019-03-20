Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FB0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C55FE213F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553088581;
	bh=r5CcAPwZR0UU8uWco8mxXvnypDrWuxeTVLrwSeqAlR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mJkG2r4SQ660tPX8bShXP5s+UM/eZn7LGdQhwGD8bNcsQGGhSizOFsGgEubgKCAWB
	 6dD1nZixPAuGGxOLiOtvex5m0lZujRku/WqlDh+/pcEnxknclqFwFOdEXcX9BRBYP8
	 ysxxVKHjGI+Ircjp4ZtZFAL1BkVaOdo5IMKowH/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfCTN3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:29:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:52056 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726644AbfCTN3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:29:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 75CD9AF1F;
        Wed, 20 Mar 2019 13:29:37 +0000 (UTC)
Date:   Wed, 20 Mar 2019 14:29:36 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     syzbot <syzbot+b70f2aabc707c69c9239@syzkaller.appspotmail.com>,
        chanho.min@lge.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, pavel@ucw.cz,
        rafael.j.wysocki@intel.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Subject: Re: WARNING: syz-executor still has locks held!
Message-ID: <20190320132936.GB8696@dhcp22.suse.cz>
References: <0000000000000e4a41057b6c9792@google.com>
 <0000000000004cdec6058485b2ce@google.com>
 <20190320131655.GA8696@dhcp22.suse.cz>
 <20190320132410.GB21673@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320132410.GB21673@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 20-03-19 14:24:11, Oleg Nesterov wrote:
> On 03/20, Michal Hocko wrote:
> >
> > Yes we do hold the cgred mutex while calling freezable_schedule but why
> > are we getting a warning is not really clear to me. The task should be
> > hidden from the freezer so why do we warn at all?
> 
> try_to_freeze() calls debug_check_no_locks_held() and this makes sense.

Yes it does. But it already ignores PF_NOFREEZE tasks and I fail to see
why is PF_FREEZER_SKIP any different. Yes we know we are holding the
lock and we have discussed that left and right before the patch was
merged but it seems that skipping the task was the only viable option
to fix suspend issues as removing the cgred is way way too complicated.

That being said, I was arguing against the patch initially because it
was a hack but sometimes that is the only way viable path short term.
-- 
Michal Hocko
SUSE Labs
