Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007A5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B59AB20850
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553251018;
	bh=1+S/Y74V3xWXdAbttqB98Sh/b86rHJi5t0OByIqzOJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sgQ+HqbV1yDesGvjJa7v34gEidgiGYUqFkS9I4lRPN9JEktSB5huWSh5/ayccxO7z
	 ZtCrG87yfN3nsnXpVx6UilyrpxZuvGjVR+ZzfjnHKHJNH0It5RSMjWwrFTiVmL1P3e
	 /4fzzJBXDckPRkBcUWII+wyzzYL+j/b7f4ZGUFak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbfCVKg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 06:36:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:40998 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726667AbfCVKg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 06:36:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A7385AEC2;
        Fri, 22 Mar 2019 10:36:55 +0000 (UTC)
Date:   Fri, 22 Mar 2019 11:36:54 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     syzbot <syzbot+b70f2aabc707c69c9239@syzkaller.appspotmail.com>,
        chanho.min@lge.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, pavel@ucw.cz,
        rafael.j.wysocki@intel.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, Ingo Molnar <mingo@elte.hu>
Subject: Re: WARNING: syz-executor still has locks held!
Message-ID: <20190322103654.GG32418@dhcp22.suse.cz>
References: <0000000000004cdec6058485b2ce@google.com>
 <20190320131655.GA8696@dhcp22.suse.cz>
 <20190320132410.GB21673@redhat.com>
 <20190320132936.GB8696@dhcp22.suse.cz>
 <20190320150053.GD21673@redhat.com>
 <20190320151242.GC8696@dhcp22.suse.cz>
 <20190320173041.GE21673@redhat.com>
 <20190320194512.GD8696@dhcp22.suse.cz>
 <20190320203216.GF8696@dhcp22.suse.cz>
 <20190321172833.GB12297@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321172833.GB12297@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 21-03-19 18:28:33, Oleg Nesterov wrote:
> On 03/20, Michal Hocko wrote:
> >
> > So we need
> > freezable_schedule_unsafe unsafe here to workaround the original problem
> > and do not trigger the warning.
> 
> Yes, but note the comment above freezable_schedule_unsafe() ;)
> 
> that is why I didn't even try to suggest to use _unsafe() instead of reverting.

Maybe I have misunderstood the discussion back then but we _knew_ that
the lock is held and considered that an acceptable compromise to
workaround the issue. And that is where the freezable_schedule_unsafe
can be used AFAIU.
 
> And to remind, until we solve the problem with cred_guard_mutex the freezer
> can fail anyway although much less likely.

Sure but this seems much less likely as the original patch seemed to
resolve the failing suspend.

So unless there is something to really handle cred_guard_mutex now, can
we get back to the workaround and silence the lockdep splat and move on
please?
-- 
Michal Hocko
SUSE Labs
