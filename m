Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C9FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 965CB214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bKAe8+DL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfCLHDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 03:03:17 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46294 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfCLHDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 03:03:17 -0400
Received: by mail-ed1-f67.google.com with SMTP id n17so1291836edt.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 00:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VtNK87TX7bSkrrAwYjvU3nK8TW2M2MqixTSikcn74+E=;
        b=bKAe8+DLs7u151ppsAAmzRyy+tSlM1yZBfV1z0/4SPBllZkO0lcXKE80nUEqzhD6XP
         cU1efPVKrXUyAcO52wOmUkaT7xQN/dw/Ua7Vq69nse4CRHjWenL5yGXH5vvv9uqjzFUK
         1IBaN944XiI2OVLh1d8iFekLY7t4dkdjZAwuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VtNK87TX7bSkrrAwYjvU3nK8TW2M2MqixTSikcn74+E=;
        b=UyJUD9ge6+BI18V8o17atz8foTpFjQeACfqsNE2RY6ZekKo8YRHBSihVn8/h+bsgWd
         S22BiXYOnAjupcjbbLxcxXxD61eUOu/iy8onXgqvoy75qHOppQRp3ERdeox73HNwxClo
         GST+e2LI9wgvpztI91RSR/S9iPCLU3VBYRdV+z4KbD5dCdiThUJp/auWfIA0BfP8gBH/
         a/bU7a39f8E9DOOFX1s/HgpRuUnSA9d0HVrzBemoDhIweAIxOXLzfPY08FZFThX+zw3F
         qbpml5THi/PfqOIxS70dPTOiraXTZ5UVef5vvpHat5v7W6lIi6VUGg4F/Khr//o4RWu6
         A79Q==
X-Gm-Message-State: APjAAAUWzP37iANt4JOzp2Hg0CXcUrW3CMmuIzfb6DtlTHYs2MH4/vFO
        DF7H5azncGqeK2yLR/ib15T+etX//OJOov7TyTYTrg==
X-Google-Smtp-Source: APXvYqxA/3/WNxFfOyKUuAK0dGNx0JQqL9fcpfLveVq/sS2P/u9AEp7HCaaK65V9IRzr+l+w/bPceRCHRrw/PitKUIE=
X-Received: by 2002:a50:bb21:: with SMTP id y30mr2102599ede.156.1552374194791;
 Tue, 12 Mar 2019 00:03:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190307094653.119425-1-pihsun@chromium.org> <20190307122313.GA30234@dhcp22.suse.cz>
 <CANdKZ0ez+y1rCEGszqzJp4Oz94dMpTF6NCR11yGVZaJyM1ZD4A@mail.gmail.com> <20190307132353.GB30234@dhcp22.suse.cz>
In-Reply-To: <20190307132353.GB30234@dhcp22.suse.cz>
From:   Pi-Hsun Shih <pihsun@chromium.org>
Date:   Tue, 12 Mar 2019 15:02:38 +0800
Message-ID: <CANdKZ0fgLLPyY8CatjFHMFfwAwSq1T77=aGFc+-ZLEpVdm=hLQ@mail.gmail.com>
Subject: Re: [PATCH] mm/swap: Avoid undefined behavior in __swapoffset
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Minchan Kim <minchan@kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        Huang Ying <ying.huang@intel.com>, Tejun Heo <tj@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 9:23 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Thu 07-03-19 20:47:52, Pi-Hsun Shih wrote:
> > On Thu, Mar 7, 2019 at 8:23 PM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Thu 07-03-19 17:46:50, Pi-Hsun Shih wrote:
> > > > Use offsetof to calculate offset of a field to avoid UBSAN warning like:
> > > >
> > > > ===================================================================
> > > > UBSAN: Undefined behaviour in mm/swapfile.c:3010:38
> > > > member access within null pointer of type 'union swap_header'
> > > > CPU: 6 PID: 1833 Comm: swapon Tainted: G S                4.19.23 #43
> > > > Call trace:
> > > >  dump_backtrace+0x0/0x194
> > > >  show_stack+0x20/0x2c
> > > >  __dump_stack+0x20/0x28
> > > >  dump_stack+0x70/0x94
> > > >  ubsan_epilogue+0x14/0x44
> > > >  ubsan_type_mismatch_common+0xf4/0xfc
> > > >  __ubsan_handle_type_mismatch_v1+0x34/0x54
> > > >  __se_sys_swapon+0x654/0x1084
> > > >  __arm64_sys_swapon+0x1c/0x24
> > > >  el0_svc_common+0xa8/0x150
> > > >  el0_svc_compat_handler+0x2c/0x38
> > > >  el0_svc_compat+0x8/0x18
> > > > ==================================================================
> > >
> > > Could you be more specific about what exactly is undefined here and
> > > why offsetof is any better. AFAIR it uses the same construct unless a
> > > compiler defines a built in.
> > >
> > > I do not object the change itself because it is cleaner to use the
> > > existing helper but I am wondering why this is fixing ubsan. Is ubsan
> > > defining the compiler variant and consider it safe?
> > >
> >
> > The undefined behavior is from trying to accessing a member of NULL,
> > even not using it value but only use the address.
>
> Hmm, we've been using this trick for ages and I do not remember any
> compiler to complain as there is no real access. I am not sure what the
> C standard has to tell about that but I presume reasonable compilers
> will not abuse the UB here.
>

Some more testing shows that GCC optimize the
((size_t)&((type*)0)->member) to a constant in the result binary, and
never emit any UBSAN checks on the statement.
Clang doesn't optimize it to a constant in -O0, optimize it to a
constant in -O1 or above, and always emit the
__ubsan_handle_type_mismatch check when "-fsanitize=undefined" is
given.
So this UBSAN warning only happens when kernel is compiled by clang, not GCC.

From what I've found, it's a UB from C standard view point
(https://software.intel.com/en-us/blogs/2015/04/20/null-pointer-dereferencing-causes-undefined-behavior),
but I agree that probably no reasonable compilers would abuse the UB
here.

> > Since the compiler variant for offsetof is used for recent compiler
> > (GCC >= 4 has support for it), ubsan would not warn if the compiler
> > variant is used. For old compiler, I guess ubsan would complain on all
> > offsetof uses.
>
> Is this the case for all compilers? If yes then we might want to drop
> the non-compiler part. Btw.
> $ git grep "#define offsetof"
> drivers/gpu/drm/radeon/mkregtable.c:#define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)
> drivers/infiniband/core/uverbs_cmd.c:#define offsetof_after(_struct, _member)                                       \
> include/linux/stddef.h:#define offsetof(TYPE, MEMBER)   __compiler_offsetof(TYPE, MEMBER)
> include/linux/stddef.h:#define offsetof(TYPE, MEMBER)   ((size_t)&((TYPE *)0)->MEMBER)
> include/linux/stddef.h:#define offsetofend(TYPE, MEMBER) \
> samples/bpf/cookie_uid_helper_example.c:#define offsetof(type, member)  __builtin_offsetof(type, member)
> scripts/kconfig/list.h:#define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)
> tools/include/linux/kernel.h:#define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)
> tools/testing/selftests/bpf/test_select_reuseport_kern.c:#define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)
> tools/usb/usbip/libsrc/list.h:#define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)
>
> so there is much more to take care of. Not to mention any open coded
> variants.

Did a "git grep '(0|NULL)\)->'" and there are about 25 of them that
can be changed to use offsetof.

> --
> Michal Hocko
> SUSE Labs
