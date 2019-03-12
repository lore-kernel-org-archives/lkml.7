Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646E5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 352882147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dTy8c44Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfCLIMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 04:12:39 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44120 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbfCLIMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 04:12:38 -0400
Received: by mail-ed1-f65.google.com with SMTP id b20so1437387edw.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 01:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R0mZsImqR53Kxxc9BQBRXlQ0nDhqA80yLbSd4EnNMSA=;
        b=dTy8c44YfGvEllrv3/Z69NO6ez+TCw4MCLIeGwuroytkoenZl6fk80U6qpeNtn36CX
         4+qzaBE9RYyhfSAizT2/JjOo1ZrW2dslLs5VMyAiTqTNVGtfJQC4BTXXG3arlw9vANaV
         f0lGkr6zO3AfMlI12TryuOpWgxOtCG5BQQuus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R0mZsImqR53Kxxc9BQBRXlQ0nDhqA80yLbSd4EnNMSA=;
        b=Dm4UPsDKSUtxGrXa+K6Z9xG8GlPy37yVqHmJB77Nu1hh+rq7wH4BqCfnDs2Vfp4OyV
         lyblUPyrbR5/EWsrbCH/9sCICyJnC2ofPJ0AEY9gliZYcYBKCDmNVwvdOp/YMs2Wvv1N
         o6kAZEn7bDO+cV6Fhreb4zZ31JIfKB9j4/hjhe/jgCW8NgbIT211hxp98Uz0Y/yxwT9M
         q0JTqJprMOUEkd23MyyyaMIhRvd5fHCpA4xVsftO7elOTi+QldN8VwQiJcCxuyA8tVkt
         vUU+2A8+EeMlJU8q5vo7hpXzYxQlYvrnId68pgR2lWY9QozL6yAbkKiO6E0bP/QP+L+u
         0E8g==
X-Gm-Message-State: APjAAAXieVmhbAG2oX4PV4F31K9d0SZywJUgQ1Ag2iKwiw++CS6Gadok
        03feUrrpxpteOlLXfNPDS85uJiXFHKmL+us2wTGmQg==
X-Google-Smtp-Source: APXvYqzMY1U7rdAtGCZ6nf6oUfHrZUQwIq7q5ROL23PAePBW8o2Qd9ZuHCqRaZsiLNG9vGcsh5lNu7DU5myS94L7i9A=
X-Received: by 2002:a50:97b3:: with SMTP id e48mr2393733edb.159.1552378356029;
 Tue, 12 Mar 2019 01:12:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190307094653.119425-1-pihsun@chromium.org> <20190307122313.GA30234@dhcp22.suse.cz>
 <CANdKZ0ez+y1rCEGszqzJp4Oz94dMpTF6NCR11yGVZaJyM1ZD4A@mail.gmail.com>
 <20190307132353.GB30234@dhcp22.suse.cz> <CANdKZ0fgLLPyY8CatjFHMFfwAwSq1T77=aGFc+-ZLEpVdm=hLQ@mail.gmail.com>
 <20190312080746.GF5721@dhcp22.suse.cz>
In-Reply-To: <20190312080746.GF5721@dhcp22.suse.cz>
From:   Pi-Hsun Shih <pihsun@chromium.org>
Date:   Tue, 12 Mar 2019 16:12:00 +0800
Message-ID: <CANdKZ0fYqvP=QF-f42MNbKnvVzX6GQy+1QsDrdAnxvMcmAq1Tg@mail.gmail.com>
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

On Tue, Mar 12, 2019 at 4:07 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Tue 12-03-19 15:02:38, Pi-Hsun Shih wrote:
> > On Thu, Mar 7, 2019 at 9:23 PM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Thu 07-03-19 20:47:52, Pi-Hsun Shih wrote:
> > > > On Thu, Mar 7, 2019 at 8:23 PM Michal Hocko <mhocko@kernel.org> wrote:
> > > > >
> > > > > On Thu 07-03-19 17:46:50, Pi-Hsun Shih wrote:
> > > > > > Use offsetof to calculate offset of a field to avoid UBSAN warning like:
> > > > > >
> > > > > > ===================================================================
> > > > > > UBSAN: Undefined behaviour in mm/swapfile.c:3010:38
> > > > > > member access within null pointer of type 'union swap_header'
> > > > > > CPU: 6 PID: 1833 Comm: swapon Tainted: G S                4.19.23 #43
> > > > > > Call trace:
> > > > > >  dump_backtrace+0x0/0x194
> > > > > >  show_stack+0x20/0x2c
> > > > > >  __dump_stack+0x20/0x28
> > > > > >  dump_stack+0x70/0x94
> > > > > >  ubsan_epilogue+0x14/0x44
> > > > > >  ubsan_type_mismatch_common+0xf4/0xfc
> > > > > >  __ubsan_handle_type_mismatch_v1+0x34/0x54
> > > > > >  __se_sys_swapon+0x654/0x1084
> > > > > >  __arm64_sys_swapon+0x1c/0x24
> > > > > >  el0_svc_common+0xa8/0x150
> > > > > >  el0_svc_compat_handler+0x2c/0x38
> > > > > >  el0_svc_compat+0x8/0x18
> > > > > > ==================================================================
> > > > >
> > > > > Could you be more specific about what exactly is undefined here and
> > > > > why offsetof is any better. AFAIR it uses the same construct unless a
> > > > > compiler defines a built in.
> > > > >
> > > > > I do not object the change itself because it is cleaner to use the
> > > > > existing helper but I am wondering why this is fixing ubsan. Is ubsan
> > > > > defining the compiler variant and consider it safe?
> > > > >
> > > >
> > > > The undefined behavior is from trying to accessing a member of NULL,
> > > > even not using it value but only use the address.
> > >
> > > Hmm, we've been using this trick for ages and I do not remember any
> > > compiler to complain as there is no real access. I am not sure what the
> > > C standard has to tell about that but I presume reasonable compilers
> > > will not abuse the UB here.
> > >
> >
> > Some more testing shows that GCC optimize the
> > ((size_t)&((type*)0)->member) to a constant in the result binary, and
> > never emit any UBSAN checks on the statement.
> > Clang doesn't optimize it to a constant in -O0, optimize it to a
> > constant in -O1 or above, and always emit the
> > __ubsan_handle_type_mismatch check when "-fsanitize=undefined" is
> > given.
> > So this UBSAN warning only happens when kernel is compiled by clang, not GCC.
> >
> > From what I've found, it's a UB from C standard view point
> > (https://software.intel.com/en-us/blogs/2015/04/20/null-pointer-dereferencing-causes-undefined-behavior),
> > but I agree that probably no reasonable compilers would abuse the UB
> > here.
>
> I really do not want to go and lawyering about the standard here but
> getting an address of an offset based on NULL ptr is not really
> dereferencing of a NULL ptr. At least this was not the case for ages
> and no compiler can afford to change it because there is quite a lot of
> userspace to rely on this construct.
>
> But as I've said using offseoff is nicer so I completely support a patch
> that get's read of a custom redefinition of it or open code directly.
> But calling it an UB is a bit of stretch.

Ok I'll send a v2 with a better commit title / message.

> --
> Michal Hocko
> SUSE Labs
