Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA58C10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B5C620848
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="bmWmtlOA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbfCYXSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 19:18:17 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45432 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbfCYXSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 19:18:17 -0400
Received: by mail-ot1-f68.google.com with SMTP id e5so9709302otk.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 16:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BDLk+jh0wm55D8ztyKQQjdMiusc96JMbtw9zCEj3y6A=;
        b=bmWmtlOAfTKBgIkAV4K73DnNnvKLXfnnZaIk5Csh5dgshTgCKm/M1xryTKHq9HRx+9
         dhfR0DJy4SFcZfYzPjzPO1tzxGr8+/UqlIdiLnFC4QxVfnB2Zboaw9Po9hneBmzjsojy
         09UJ+4jx2az1c121Hp4cjizVAdaTIimVGF34xvc1vHZnfd79kxZJl7peyySjd17HEFzJ
         M5jpsWKZEjrkYQu6gVasCkWeZPtpUR5rZXHi+uByOGwSYMEGb1EPOGw119GsMJ4WqjDd
         Q4AJrkeVaRNCtcEndaloOGysrz1p2xFiifiUH1ZzTZOFMqykD97ylfpbTFs3oSmM+27Z
         K+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BDLk+jh0wm55D8ztyKQQjdMiusc96JMbtw9zCEj3y6A=;
        b=OsOXAc4tarJW1DaqwvEu4FRcZRES8RtRj8nTf4aZaqD0FD6tl/mjIOgeKOIuN5i0mN
         2m4varp4PPVAe3YFhzg8PwEChPs1XJivK3fSNQwf1y0IR2azl4ZdSy8a2GGyz2zKdhbk
         eJq1/SDPLQGjcjQVQup7yI5pw4nr3DbMO3eb+gfHb/iEhRezapNwj3XCT4Y3AHmVd9tA
         mYbGzsl9DzesTorCw4e+fsXo961Jx8owlNYteon9I2ZU2kDh/L1iL8mNw1pqFNTBW7Zx
         whF3oOq3EI5/8SgjiWsPzN6fwx0+idaGT23nmL7e8HEZ2le7c0TOpqE2khqjK02/arCe
         W0Kg==
X-Gm-Message-State: APjAAAUuE3uhlTnUCTT8/Zq0hmfsZTjMPfqT0ZQkvUxLms9r3OlBsSFw
        VN3Omn78NPhVYuuYvtG/Tvy7vk/WcqwBCZ7GQ4YlBg==
X-Google-Smtp-Source: APXvYqxsQkP9wLF6Yl5w1yQJ8nJBIcMw0TELYRMa6MegAkNnD+70dwmUNmfysSws+BWUu5Xm2PiqA2KHF8fLGkQux1k=
X-Received: by 2002:a9d:224a:: with SMTP id o68mr20779320ota.214.1553555896212;
 Mon, 25 Mar 2019 16:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <1553316275-21985-1-git-send-email-yang.shi@linux.alibaba.com>
 <1553316275-21985-2-git-send-email-yang.shi@linux.alibaba.com>
 <CAPcyv4g5RoHhXhkKQaYkqYLN1y3KavbGeM1zVus-3fY5Q+JdxA@mail.gmail.com> <688dffbc-2adc-005d-223e-fe488be8c5fc@linux.alibaba.com>
In-Reply-To: <688dffbc-2adc-005d-223e-fe488be8c5fc@linux.alibaba.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 25 Mar 2019 16:18:04 -0700
Message-ID: <CAPcyv4g3xzuS8hP9jOX_BXWyFEH32YfCEDs3a_K_VRODfATc=Q@mail.gmail.com>
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

On Mon, Mar 25, 2019 at 12:28 PM Yang Shi <yang.shi@linux.alibaba.com> wrote:
>
>
>
> On 3/23/19 10:21 AM, Dan Williams wrote:
> > On Fri, Mar 22, 2019 at 9:45 PM Yang Shi <yang.shi@linux.alibaba.com> wrote:
> >> When running applications on the machine with NVDIMM as NUMA node, the
> >> memory allocation may end up on NVDIMM node.  This may result in silent
> >> performance degradation and regression due to the difference of hardware
> >> property.
> >>
> >> DRAM first should be obeyed to prevent from surprising regression.  Any
> >> non-DRAM nodes should be excluded from default allocation.  Use nodemask
> >> to control the memory placement.  Introduce def_alloc_nodemask which has
> >> DRAM nodes set only.  Any non-DRAM allocation should be specified by
> >> NUMA policy explicitly.
> >>
> >> In the future we may be able to extract the memory charasteristics from
> >> HMAT or other source to build up the default allocation nodemask.
> >> However, just distinguish DRAM and PMEM (non-DRAM) nodes by SRAT flag
> >> for the time being.
> >>
> >> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> >> ---
> >>   arch/x86/mm/numa.c     |  1 +
> >>   drivers/acpi/numa.c    |  8 ++++++++
> >>   include/linux/mmzone.h |  3 +++
> >>   mm/page_alloc.c        | 18 ++++++++++++++++--
> >>   4 files changed, 28 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> >> index dfb6c4d..d9e0ca4 100644
> >> --- a/arch/x86/mm/numa.c
> >> +++ b/arch/x86/mm/numa.c
> >> @@ -626,6 +626,7 @@ static int __init numa_init(int (*init_func)(void))
> >>          nodes_clear(numa_nodes_parsed);
> >>          nodes_clear(node_possible_map);
> >>          nodes_clear(node_online_map);
> >> +       nodes_clear(def_alloc_nodemask);
> >>          memset(&numa_meminfo, 0, sizeof(numa_meminfo));
> >>          WARN_ON(memblock_set_node(0, ULLONG_MAX, &memblock.memory,
> >>                                    MAX_NUMNODES));
> >> diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
> >> index 867f6e3..79dfedf 100644
> >> --- a/drivers/acpi/numa.c
> >> +++ b/drivers/acpi/numa.c
> >> @@ -296,6 +296,14 @@ void __init acpi_numa_slit_init(struct acpi_table_slit *slit)
> >>                  goto out_err_bad_srat;
> >>          }
> >>
> >> +       /*
> >> +        * Non volatile memory is excluded from zonelist by default.
> >> +        * Only regular DRAM nodes are set in default allocation node
> >> +        * mask.
> >> +        */
> >> +       if (!(ma->flags & ACPI_SRAT_MEM_NON_VOLATILE))
> >> +               node_set(node, def_alloc_nodemask);
> > Hmm, no, I don't think we should do this. Especially considering
> > current generation NVDIMMs are energy backed DRAM there is no
> > performance difference that should be assumed by the non-volatile
> > flag.
>
> Actually, here I would like to initialize a node mask for default
> allocation. Memory allocation should not end up on any nodes excluded by
> this node mask unless they are specified by mempolicy.
>
> We may have a few different ways or criteria to initialize the node
> mask, for example, we can read from HMAT (when HMAT is ready in the
> future), and we definitely could have non-DRAM nodes set if they have no
> performance difference (I'm supposed you mean NVDIMM-F  or HBM).
>
> As long as there are different tiers, distinguished by performance, for
> main memory, IMHO, there should be a defined default allocation node
> mask to control the memory placement no matter where we get the information.

I understand the intent, but I don't think the kernel should have such
a hardline policy by default. However, it would be worthwhile
mechanism and policy to consider for the dax-hotplug userspace
tooling. I.e. arrange for a given device-dax instance to be onlined,
but set the policy to require explicit opt-in by numa binding for it
to be an allocation / migration option.

I added Vishal to the cc who is looking into such policy tooling.

> But, for now we haven't had such information ready for such use yet, so
> the SRAT flag might be a choice.
>
> >
> > Why isn't default SLIT distance sufficient for ensuring a DRAM-first
> > default policy?
>
> "DRAM-first" may sound ambiguous, actually I mean "DRAM only by
> default". SLIT should just can tell us what node is local what node is
> remote, but can't tell us the performance difference.

I think it's a useful semantic, but let's leave the selection of that
policy to an explicit userspace decision.
