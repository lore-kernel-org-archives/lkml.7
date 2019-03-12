Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A99C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1E3D214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552378071;
	bh=Tvjet4ftyHbZxfuOm8lUk4sy6NygoiCOBU/oc/z3J0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ho/DyOGba7vR1k35rFC19id9yhWmmlxtf8pPofVVAGYN2WRpBZZYho68TdHN2LPhI
	 WKMu93T1OF9OwDPqMa/aCXqx15P4bmDaiX0dblcEEo6rhxKjO0d0+9pQx7Lsl1bk+6
	 BQo204FtZBsTswXXiTGDwxplYGjc1aVc+b8pVElQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfCLIHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 04:07:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:42968 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725906AbfCLIHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 04:07:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A97BEB609;
        Tue, 12 Mar 2019 08:07:47 +0000 (UTC)
Date:   Tue, 12 Mar 2019 09:07:46 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Minchan Kim <minchan@kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        Huang Ying <ying.huang@intel.com>, Tejun Heo <tj@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/swap: Avoid undefined behavior in __swapoffset
Message-ID: <20190312080746.GF5721@dhcp22.suse.cz>
References: <20190307094653.119425-1-pihsun@chromium.org>
 <20190307122313.GA30234@dhcp22.suse.cz>
 <CANdKZ0ez+y1rCEGszqzJp4Oz94dMpTF6NCR11yGVZaJyM1ZD4A@mail.gmail.com>
 <20190307132353.GB30234@dhcp22.suse.cz>
 <CANdKZ0fgLLPyY8CatjFHMFfwAwSq1T77=aGFc+-ZLEpVdm=hLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANdKZ0fgLLPyY8CatjFHMFfwAwSq1T77=aGFc+-ZLEpVdm=hLQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 12-03-19 15:02:38, Pi-Hsun Shih wrote:
> On Thu, Mar 7, 2019 at 9:23 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Thu 07-03-19 20:47:52, Pi-Hsun Shih wrote:
> > > On Thu, Mar 7, 2019 at 8:23 PM Michal Hocko <mhocko@kernel.org> wrote:
> > > >
> > > > On Thu 07-03-19 17:46:50, Pi-Hsun Shih wrote:
> > > > > Use offsetof to calculate offset of a field to avoid UBSAN warning like:
> > > > >
> > > > > ===================================================================
> > > > > UBSAN: Undefined behaviour in mm/swapfile.c:3010:38
> > > > > member access within null pointer of type 'union swap_header'
> > > > > CPU: 6 PID: 1833 Comm: swapon Tainted: G S                4.19.23 #43
> > > > > Call trace:
> > > > >  dump_backtrace+0x0/0x194
> > > > >  show_stack+0x20/0x2c
> > > > >  __dump_stack+0x20/0x28
> > > > >  dump_stack+0x70/0x94
> > > > >  ubsan_epilogue+0x14/0x44
> > > > >  ubsan_type_mismatch_common+0xf4/0xfc
> > > > >  __ubsan_handle_type_mismatch_v1+0x34/0x54
> > > > >  __se_sys_swapon+0x654/0x1084
> > > > >  __arm64_sys_swapon+0x1c/0x24
> > > > >  el0_svc_common+0xa8/0x150
> > > > >  el0_svc_compat_handler+0x2c/0x38
> > > > >  el0_svc_compat+0x8/0x18
> > > > > ==================================================================
> > > >
> > > > Could you be more specific about what exactly is undefined here and
> > > > why offsetof is any better. AFAIR it uses the same construct unless a
> > > > compiler defines a built in.
> > > >
> > > > I do not object the change itself because it is cleaner to use the
> > > > existing helper but I am wondering why this is fixing ubsan. Is ubsan
> > > > defining the compiler variant and consider it safe?
> > > >
> > >
> > > The undefined behavior is from trying to accessing a member of NULL,
> > > even not using it value but only use the address.
> >
> > Hmm, we've been using this trick for ages and I do not remember any
> > compiler to complain as there is no real access. I am not sure what the
> > C standard has to tell about that but I presume reasonable compilers
> > will not abuse the UB here.
> >
> 
> Some more testing shows that GCC optimize the
> ((size_t)&((type*)0)->member) to a constant in the result binary, and
> never emit any UBSAN checks on the statement.
> Clang doesn't optimize it to a constant in -O0, optimize it to a
> constant in -O1 or above, and always emit the
> __ubsan_handle_type_mismatch check when "-fsanitize=undefined" is
> given.
> So this UBSAN warning only happens when kernel is compiled by clang, not GCC.
> 
> From what I've found, it's a UB from C standard view point
> (https://software.intel.com/en-us/blogs/2015/04/20/null-pointer-dereferencing-causes-undefined-behavior),
> but I agree that probably no reasonable compilers would abuse the UB
> here.

I really do not want to go and lawyering about the standard here but
getting an address of an offset based on NULL ptr is not really
dereferencing of a NULL ptr. At least this was not the case for ages
and no compiler can afford to change it because there is quite a lot of
userspace to rely on this construct.

But as I've said using offseoff is nicer so I completely support a patch
that get's read of a custom redefinition of it or open code directly.
But calling it an UB is a bit of stretch.
-- 
Michal Hocko
SUSE Labs
