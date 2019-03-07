Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B282AC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 13:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8664D20684
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 13:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551965040;
	bh=ilyNTjSi0mBYdi2D8tTI9r+Wj9kb9qxZfXcbzzMjqmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JoYLHhgRy14zREOM3MKCUoa6+yKlNWl6Hhvr+eSTNTWyIV/6hk0UIRQM5F/fAbNVi
	 /VzhHH9bXVaoxdyE3+k30Z0rjlsPVHUOj/6jxzovCGbn21a1hPamF8hxv0NDCUm8Gi
	 gccUj0ba23QuB9h8fhB+5gjw6Q9ddTdZOCjJi+Jk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfCGNX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 08:23:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:55864 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726269AbfCGNX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 08:23:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0B34DAAAE;
        Thu,  7 Mar 2019 13:23:54 +0000 (UTC)
Date:   Thu, 7 Mar 2019 14:23:53 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Minchan Kim <minchan@kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        Huang Ying <ying.huang@intel.com>,
        Aaron Lu <aaron.lu@intel.com>, Tejun Heo <tj@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/swap: Avoid undefined behavior in __swapoffset
Message-ID: <20190307132353.GB30234@dhcp22.suse.cz>
References: <20190307094653.119425-1-pihsun@chromium.org>
 <20190307122313.GA30234@dhcp22.suse.cz>
 <CANdKZ0ez+y1rCEGszqzJp4Oz94dMpTF6NCR11yGVZaJyM1ZD4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANdKZ0ez+y1rCEGszqzJp4Oz94dMpTF6NCR11yGVZaJyM1ZD4A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 07-03-19 20:47:52, Pi-Hsun Shih wrote:
> On Thu, Mar 7, 2019 at 8:23 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Thu 07-03-19 17:46:50, Pi-Hsun Shih wrote:
> > > Use offsetof to calculate offset of a field to avoid UBSAN warning like:
> > >
> > > ===================================================================
> > > UBSAN: Undefined behaviour in mm/swapfile.c:3010:38
> > > member access within null pointer of type 'union swap_header'
> > > CPU: 6 PID: 1833 Comm: swapon Tainted: G S                4.19.23 #43
> > > Call trace:
> > >  dump_backtrace+0x0/0x194
> > >  show_stack+0x20/0x2c
> > >  __dump_stack+0x20/0x28
> > >  dump_stack+0x70/0x94
> > >  ubsan_epilogue+0x14/0x44
> > >  ubsan_type_mismatch_common+0xf4/0xfc
> > >  __ubsan_handle_type_mismatch_v1+0x34/0x54
> > >  __se_sys_swapon+0x654/0x1084
> > >  __arm64_sys_swapon+0x1c/0x24
> > >  el0_svc_common+0xa8/0x150
> > >  el0_svc_compat_handler+0x2c/0x38
> > >  el0_svc_compat+0x8/0x18
> > > ==================================================================
> >
> > Could you be more specific about what exactly is undefined here and
> > why offsetof is any better. AFAIR it uses the same construct unless a
> > compiler defines a built in.
> >
> > I do not object the change itself because it is cleaner to use the
> > existing helper but I am wondering why this is fixing ubsan. Is ubsan
> > defining the compiler variant and consider it safe?
> >
> 
> The undefined behavior is from trying to accessing a member of NULL,
> even not using it value but only use the address.

Hmm, we've been using this trick for ages and I do not remember any
compiler to complain as there is no real access. I am not sure what the
C standard has to tell about that but I presume reasonable compilers
will not abuse the UB here.

> Since the compiler variant for offsetof is used for recent compiler
> (GCC >= 4 has support for it), ubsan would not warn if the compiler
> variant is used. For old compiler, I guess ubsan would complain on all
> offsetof uses.

Is this the case for all compilers? If yes then we might want to drop
the non-compiler part. Btw. 
$ git grep "#define offsetof"
drivers/gpu/drm/radeon/mkregtable.c:#define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)
drivers/infiniband/core/uverbs_cmd.c:#define offsetof_after(_struct, _member)                                       \
include/linux/stddef.h:#define offsetof(TYPE, MEMBER)   __compiler_offsetof(TYPE, MEMBER)
include/linux/stddef.h:#define offsetof(TYPE, MEMBER)   ((size_t)&((TYPE *)0)->MEMBER)
include/linux/stddef.h:#define offsetofend(TYPE, MEMBER) \
samples/bpf/cookie_uid_helper_example.c:#define offsetof(type, member)  __builtin_offsetof(type, member)
scripts/kconfig/list.h:#define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)
tools/include/linux/kernel.h:#define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)
tools/testing/selftests/bpf/test_select_reuseport_kern.c:#define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)
tools/usb/usbip/libsrc/list.h:#define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)

so there is much more to take care of. Not to mention any open coded
variants.
-- 
Michal Hocko
SUSE Labs
