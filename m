Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE12C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E5320896
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="srMzDC+m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbfCYQ45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:56:57 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37777 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfCYQ44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:56:56 -0400
Received: by mail-qt1-f196.google.com with SMTP id z16so11144741qtn.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 09:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hdrToB2TSv1yp4eb70QIvwrlSIW2W5jFyB226wrDD0Q=;
        b=srMzDC+ms5YQVqrvZwEGDX/E/ckzFQVhFOG1bMHwhic4SroBbCVHANYL/SW7vm3dcp
         avpmvQxnZulEN13hnbtVkEInZPvG6TPTYzdDrz+/SKsrOhPEA9oiiF754eehdWTs2lLD
         Gm7FtbqtzbumYo/P3bUaAQK0CG5bPTt/s9ZE4Xqrz46K+vzzbO3DuYepBASZG0TS4WLX
         nliN3mXxhSN40Ia6QSqWfU9+lMq2AO9rAOlFtskjaIc+pmLucpgXw6v4ByzXWNa2jc7l
         toVmuhIDkJ9VSAsPKdzbegy/3sLS/c7VmTttjV+bhDJF9mZUrMjXI6G474lIcbTt1PeZ
         rgAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hdrToB2TSv1yp4eb70QIvwrlSIW2W5jFyB226wrDD0Q=;
        b=YrShlpm650Xf4Bu8sqicrL7n2kHF3qT2l83U/ar5YCAa/ntTnjlP/co8tUd4qCUMMZ
         Lm+e85IjUAkBsTCOZc5KY0All0H5KEA5Jh5MeMQAcdBAkXyN6qBFLG40Qgt6V/XTJeWN
         WB3PvvwsR7RSqFR9xAQ0Z4nne737N+a/ojSj9xZ2xV3Rl4dQt8nhiOoyxp5kL2/Y7ty3
         vb2WP9m3eT6xCHR7PG9uDvU+WOvHMss+XJFb7S0MiRwboxEJV1sIgCFoml6fx72iF1Yq
         xE3At1P1AWTmdYQqKjUGXRThHflzYFJ8ecSL/jjdZdrbmMUX9ZiyA/EXsQtnVRQZOA74
         jSxA==
X-Gm-Message-State: APjAAAXM9Nk8wWu0YN0WoxPqY38LXQLL8fh5d8UBxnRRgmI4Vm35kLKD
        bksDcwmJUBmThLtb1JTYxiuVDj+rOyQGIhk5xosyxw==
X-Google-Smtp-Source: APXvYqy5O1uj8uqWIybnhXlb2Rx+YIOdNrjiO8M6dBrKRM6Bjpvp5sf0FW3DMqU3p8w8Fpikdd4u7Clq96P0hl/KHRU=
X-Received: by 2002:ac8:32fb:: with SMTP id a56mr21951184qtb.338.1553533015773;
 Mon, 25 Mar 2019 09:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <1553316275-21985-1-git-send-email-yang.shi@linux.alibaba.com> <cc6f44e2-48b5-067f-9685-99d8ae470b50@inria.fr>
In-Reply-To: <cc6f44e2-48b5-067f-9685-99d8ae470b50@inria.fr>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 25 Mar 2019 09:56:44 -0700
Message-ID: <CAPcyv4it1w7SdDVBV24cRCVHtLb3s1pVB5+SDM02Uw4RbahKiA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/10] Another Approach to Use PMEM as NUMA Node
To:     Brice Goglin <Brice.Goglin@inria.fr>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>,
        Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        "Du, Fan" <fan.du@intel.com>, "Huang, Ying" <ying.huang@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 9:15 AM Brice Goglin <Brice.Goglin@inria.fr> wrote:
>
>
> Le 23/03/2019 =C3=A0 05:44, Yang Shi a =C3=A9crit :
> > With Dave Hansen's patches merged into Linus's tree
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Dc221c0b0308fd01d9fb33a16f64d2fd95f8830a4
> >
> > PMEM could be hot plugged as NUMA node now. But, how to use PMEM as NUM=
A node
> > effectively and efficiently is still a question.
> >
> > There have been a couple of proposals posted on the mailing list [1] [2=
].
> >
> > The patchset is aimed to try a different approach from this proposal [1=
]
> > to use PMEM as NUMA nodes.
> >
> > The approach is designed to follow the below principles:
> >
> > 1. Use PMEM as normal NUMA node, no special gfp flag, zone, zonelist, e=
tc.
> >
> > 2. DRAM first/by default. No surprise to existing applications and defa=
ult
> > running. PMEM will not be allocated unless its node is specified explic=
itly
> > by NUMA policy. Some applications may be not very sensitive to memory l=
atency,
> > so they could be placed on PMEM nodes then have hot pages promote to DR=
AM
> > gradually.
>
>
> I am not against the approach for some workloads. However, many HPC
> people would rather do this manually. But there's currently no easy way
> to find out from userspace whether a given NUMA node is DDR or PMEM*. We
> have to assume HMAT is available (and correct) and look at performance
> attributes. When talking to humans, it would be better to say "I
> allocated on the local DDR NUMA node" rather than "I allocated on the
> fastest node according to HMAT latency".
>
> Also, when we'll have HBM+DDR, some applications may want to use DDR by
> default, which means they want the *slowest* node according to HMAT (by
> the way, will your hybrid policy work if we ever have HBM+DDR+PMEM?).
> Performance attributes could help, but how does user-space know for sure
> that X>Y will still mean HBM>DDR and not DDR>PMEM in 5 years?
>
> It seems to me that exporting a flag in sysfs saying whether a node is
> PMEM could be convenient. Patch series [1] exported a "type" in sysfs
> node directories ("pmem" or "dram"). I don't know how if there's an easy
> way to define what HBM is and expose that type too.

I'm generally against the concept that a "pmem" or "type" flag should
indicate anything about the expected performance of the address range.
The kernel should explicitly look to the HMAT for performance data and
not otherwise make type-based performance assumptions.
