Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7F7C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC97F20684
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k5rddsSa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbfCGMsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 07:48:05 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41214 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfCGMsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 07:48:05 -0500
Received: by mail-ed1-f68.google.com with SMTP id x7so13333096eds.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 04:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dOtWjFZq01U/8PDkXc5mo9dz58CkJjmkXbnJTRTwgVk=;
        b=k5rddsSai+sjEyMsVU1uPaFRfRdsxKnB6OGFgRdic/TUo6aMhSjZujbZ1XwYWr3Qi0
         dXgxone6DBfzBwm8S5UfE8DSxkweWcRNsGfuTDgo0uUBog9Po1UsfwJxEUKk/pCYMA0m
         WtvSKJAilggzab6VYXyxNnclToAsTEEGk0T9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dOtWjFZq01U/8PDkXc5mo9dz58CkJjmkXbnJTRTwgVk=;
        b=A6vEV42kH8ARwU/NMaNOB25ow11ZjKLdRWQNKpE/IY72A/kBR4a2hpp7jvKODo1VVl
         cMHRFUQ02FKOyBa2qfsvVsWX7oWRLmrdU+uDHBGD0XDtz3SaFHs3rTRde/G9IZvWp1NH
         ZwYA+eFz71wS7TYhaGnDDB5DmbCIMn0m+Vd4smZrik9NLKW1BKZ73z3x1BbDhK+O9nHO
         B3J2G1GOQRvPO5RDJhM7dS+aCNlX486SOtr7q9aAuFoDgbqbBqwmBDkjnpXxEEsakn+n
         +/NyWSQBrkXqRkRJp6yHueENyD/bEQdryA7nVqw0T1env/ubIDTTGAR9LylffIsgUZJi
         cQOg==
X-Gm-Message-State: APjAAAX/cLieuFSSiZsAkpoSqWQDXChAi/12WmrVnckuBv5uBlh6Sozz
        PUjW5sDhQNYWBiCdpTw5ln8HHMDxiimxtluU4KinKw==
X-Google-Smtp-Source: APXvYqwyS3ijBJkCX7oOdaCtUYG2fOKABkJe6do9K6cKwWdRr4M+e2o+gJsxfQ2/gHFHGAe9FtjBL6ilqtuyPgbH4Uw=
X-Received: by 2002:a50:bb21:: with SMTP id y30mr27058696ede.156.1551962883220;
 Thu, 07 Mar 2019 04:48:03 -0800 (PST)
MIME-Version: 1.0
References: <20190307094653.119425-1-pihsun@chromium.org> <20190307122313.GA30234@dhcp22.suse.cz>
In-Reply-To: <20190307122313.GA30234@dhcp22.suse.cz>
From:   Pi-Hsun Shih <pihsun@chromium.org>
Date:   Thu, 7 Mar 2019 20:47:52 +0800
Message-ID: <CANdKZ0ez+y1rCEGszqzJp4Oz94dMpTF6NCR11yGVZaJyM1ZD4A@mail.gmail.com>
Subject: Re: [PATCH] mm/swap: Avoid undefined behavior in __swapoffset
To:     Michal Hocko <mhocko@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 8:23 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Thu 07-03-19 17:46:50, Pi-Hsun Shih wrote:
> > Use offsetof to calculate offset of a field to avoid UBSAN warning like:
> >
> > ===================================================================
> > UBSAN: Undefined behaviour in mm/swapfile.c:3010:38
> > member access within null pointer of type 'union swap_header'
> > CPU: 6 PID: 1833 Comm: swapon Tainted: G S                4.19.23 #43
> > Call trace:
> >  dump_backtrace+0x0/0x194
> >  show_stack+0x20/0x2c
> >  __dump_stack+0x20/0x28
> >  dump_stack+0x70/0x94
> >  ubsan_epilogue+0x14/0x44
> >  ubsan_type_mismatch_common+0xf4/0xfc
> >  __ubsan_handle_type_mismatch_v1+0x34/0x54
> >  __se_sys_swapon+0x654/0x1084
> >  __arm64_sys_swapon+0x1c/0x24
> >  el0_svc_common+0xa8/0x150
> >  el0_svc_compat_handler+0x2c/0x38
> >  el0_svc_compat+0x8/0x18
> > ==================================================================
>
> Could you be more specific about what exactly is undefined here and
> why offsetof is any better. AFAIR it uses the same construct unless a
> compiler defines a built in.
>
> I do not object the change itself because it is cleaner to use the
> existing helper but I am wondering why this is fixing ubsan. Is ubsan
> defining the compiler variant and consider it safe?
>

The undefined behavior is from trying to accessing a member of NULL,
even not using it value but only use the address.

Since the compiler variant for offsetof is used for recent compiler
(GCC >= 4 has support for it), ubsan would not warn if the compiler
variant is used. For old compiler, I guess ubsan would complain on all
offsetof uses.
