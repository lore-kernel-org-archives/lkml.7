Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89C1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A304F20848
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="pfdpTNH3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbfCYXmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 19:42:13 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38978 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfCYXmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 19:42:13 -0400
Received: by mail-ot1-f65.google.com with SMTP id f10so9779783otb.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 16:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=brbNukUZJqv8C4b8aKpAXrJlBkgotqWH0iKEU/UDCkc=;
        b=pfdpTNH3kMtoL8jz01jwkZ8HTaSp6GdZcMydIuMPWTRr7qH8mqJiOhi04rVWFjHfI2
         i1J4MxrfKqoydzGIQTP0YUs5lSrZqClnJLTW4PdCJduTEWcQw/cTVlL+kDn0QtVlUCw2
         5LdAVRJV15QUklVMWeWQ4erbA/D0cak87OIZ2xc+oWPb7XsJgXjL9v5lD4r6dGhjCfIs
         abnPCXt2NYePh+o/9L1zR0QbKjXAsGu+4MunONZAeezqBUhDxbSiyeftp+8E36O+8yPB
         lJbjC62zGS1t0qCUz569etjL+B2dZUSKuNtp8oYj4wLGYYZTLoVoSH535daHwu8i7fXR
         Ygng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=brbNukUZJqv8C4b8aKpAXrJlBkgotqWH0iKEU/UDCkc=;
        b=XfEE5PROBJeEjKhZXen7Y2E3FhOthZKeXXGLgBNVlPLqJk53n0xTTGVOUJImxJ/9wR
         pA/FYzhtChKflLTeze/vljk1kxvghxWJ+JSPs1Vfi7qZUrduhCut1Dd/Fnp9NQetUA8I
         H6Ra43GvCEbGCqbmh4hhClowclPI2ZaK/nabjNljItmkZE9Y1Nd+MssBRU1cvjbwu2Ox
         MjpDUeTwc8HxiIIbfZ+8Wlz20LcT45bhxvVgDWLY4uK4bfC4h9PZQiifM1L3SRu+npUL
         12bcaCP3epLy1cwQGBNq43AYrAALAR7FjnuC9Fek/WXYfoTfGeNq2280ZyxmeQf9Xuu4
         NIFg==
X-Gm-Message-State: APjAAAXxYkeh3jFyd2eC6Fz885qKOJiNnIDNmaJmOeDDgtg6k6BnoAoH
        WC7sO5sYh+aJHToKUsnteq+6yfatnZ3B4/UNNNI01g==
X-Google-Smtp-Source: APXvYqyg8lWmRXsXdSMNbDrwiKoh3GF/oAwMMkgZ0rAcnw8htq21c8WLRwG+lDz+A4nlb93mvhOClYHlgNMmOjj0Qbo=
X-Received: by 2002:a9d:4d0b:: with SMTP id n11mr18663296otf.98.1553557332317;
 Mon, 25 Mar 2019 16:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <1553316275-21985-1-git-send-email-yang.shi@linux.alibaba.com>
 <1553316275-21985-2-git-send-email-yang.shi@linux.alibaba.com>
 <CAPcyv4g5RoHhXhkKQaYkqYLN1y3KavbGeM1zVus-3fY5Q+JdxA@mail.gmail.com>
 <688dffbc-2adc-005d-223e-fe488be8c5fc@linux.alibaba.com> <CAPcyv4g3xzuS8hP9jOX_BXWyFEH32YfCEDs3a_K_VRODfATc=Q@mail.gmail.com>
 <406a78f6-9bac-b0f8-9acc-b72540a72a11@linux.alibaba.com>
In-Reply-To: <406a78f6-9bac-b0f8-9acc-b72540a72a11@linux.alibaba.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 25 Mar 2019 16:42:01 -0700
Message-ID: <CAPcyv4iH72ppy+=c3BitJ=qxJAFvpNza6Y5yz01Rt1Tky=MZNA@mail.gmail.com>
Subject: Re: [PATCH 01/10] mm: control memory placement by nodemask for two
 tier main memory
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        "Du, Fan" <fan.du@intel.com>, "Huang, Ying" <ying.huang@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 4:36 PM Yang Shi <yang.shi@linux.alibaba.com> wrote:
[..]
> >>> Hmm, no, I don't think we should do this. Especially considering
> >>> current generation NVDIMMs are energy backed DRAM there is no
> >>> performance difference that should be assumed by the non-volatile
> >>> flag.
> >> Actually, here I would like to initialize a node mask for default
> >> allocation. Memory allocation should not end up on any nodes excluded by
> >> this node mask unless they are specified by mempolicy.
> >>
> >> We may have a few different ways or criteria to initialize the node
> >> mask, for example, we can read from HMAT (when HMAT is ready in the
> >> future), and we definitely could have non-DRAM nodes set if they have no
> >> performance difference (I'm supposed you mean NVDIMM-F  or HBM).
> >>
> >> As long as there are different tiers, distinguished by performance, for
> >> main memory, IMHO, there should be a defined default allocation node
> >> mask to control the memory placement no matter where we get the information.
> > I understand the intent, but I don't think the kernel should have such
> > a hardline policy by default. However, it would be worthwhile
> > mechanism and policy to consider for the dax-hotplug userspace
> > tooling. I.e. arrange for a given device-dax instance to be onlined,
> > but set the policy to require explicit opt-in by numa binding for it
> > to be an allocation / migration option.
> >
> > I added Vishal to the cc who is looking into such policy tooling.
>
> We may assume the nodes returned by cpu_to_node() would be treated as
> the default allocation nodes from the kernel point of view.
>
> So, the below code may do the job:
>
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index d9e0ca4..a3e07da 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -764,6 +764,8 @@ void __init init_cpu_to_node(void)
>                          init_memory_less_node(node);
>
>                  numa_set_node(cpu, node);
> +
> +              node_set(node, def_alloc_nodemask);
>          }
>   }
>
> Actually, the kernel should not care too much what kind of memory is
> used, any node could be used for memory allocation. But it may be better
> to restrict to some default nodes due to the performance disparity, for
> example, default to regular DRAM only. Here kernel assumes the nodes
> associated with CPUs would be DRAM nodes.
>
> The node mask could be exported to user space to be override by
> userspace tool or sysfs or kernel commandline.

Yes, sounds good.

> But I still think kernel does need a default node mask.

Yes, just depends on what is less surprising for userspace to contend
with by default. I would expect an unaware userspace to be confused by
the fact that the system has free memory, but it's unusable. So,
usable by default sounds a safer option, and special cases to forbid
default usage of given nodes is an administrator / application opt-in
mechanism.
