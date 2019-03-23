Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF6AC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 17:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0680820879
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 17:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="0WytAG4W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbfCWRVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 13:21:42 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33904 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727364AbfCWRVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 13:21:42 -0400
Received: by mail-ot1-f68.google.com with SMTP id k21so3257333otf.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 10:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eeq8w5UoZqtPwtYCuvSGobWdwSJ7TL9pAZbFIGCz8uc=;
        b=0WytAG4Wk5Oi/5ukZGTkMMCTVXUHPt5wKd8CN4IlVakyDUknYU9gO2o6YmgrDc0Gh2
         tFh8Q2WR+/Zv1avHHPlkNOvZXziHzve4udgLrND2cPRcYjN5Bz77mTSPku6TGZkiOGiP
         6fdnK7E5tPWQjgNTaaAo+qd9hXJnKNbTPXdb7niW9u0Gc66Qo8YQdrsyLvzTloD35bCz
         Wojma7Mf9Ou1KeogCH0lqVyOvWMPNmzT4YVID4HGYCoU0GAWQVFHvTJlpRIBgyTyLaVh
         ktFFHNrQzSkhMUkFxzcOpb3g3/7CWDRXpFfCSDA2Go9IS5uDo6mFzp+pn66Qv4in6Ums
         Yg6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eeq8w5UoZqtPwtYCuvSGobWdwSJ7TL9pAZbFIGCz8uc=;
        b=Z6zVqSfdM73uIInrfPpG3bw54cJdyk3aYvJ7mKPQKBApC1uFzBDlxs055PbjoaEiEJ
         YUU1YgQZ1rOrydG3dJ7Q9lJlTBla6QpMrOh0/ZFCFrCnYiBny/n6KFsz5PogAIMQgZ1z
         mcbf1fnLnSOF00mREmHG9tB7XO6HP4CtM+h4fjdXdZBG5mhRx8PzCAx2n2xFMLOm7Eup
         TLTpthjp257dJfVSxb/iB8p/cGPLm4rxKmPh1V6K4nKIAAG15eovpIAx+GXI3L+WSL2G
         GbeK6PyrRExadMVnazRzp5xo0IA98beCy/ooSxjn2NBtzj7lJbHJ/KuzunJIgjMH+cXr
         xzfg==
X-Gm-Message-State: APjAAAV0F/Qlpi1VOKACWnxbmhO2gZu6UkI5nhwlkrNJQNwvtW5LK2ud
        East1X11lzsFJZlqNajmBGVTGerK5Rkz5wNJ0gK8VA==
X-Google-Smtp-Source: APXvYqxI/TyfpdbcSgqn9sKIr9VnkGP9ptLAdKMEHZOdln61IUI0xQz7xzNTofy2+O4N3EPhoLjKRqdzP1P/Ka5palk=
X-Received: by 2002:a9d:6a4f:: with SMTP id h15mr1290088otn.353.1553361701390;
 Sat, 23 Mar 2019 10:21:41 -0700 (PDT)
MIME-Version: 1.0
References: <1553316275-21985-1-git-send-email-yang.shi@linux.alibaba.com> <1553316275-21985-2-git-send-email-yang.shi@linux.alibaba.com>
In-Reply-To: <1553316275-21985-2-git-send-email-yang.shi@linux.alibaba.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 23 Mar 2019 10:21:30 -0700
Message-ID: <CAPcyv4g5RoHhXhkKQaYkqYLN1y3KavbGeM1zVus-3fY5Q+JdxA@mail.gmail.com>
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 9:45 PM Yang Shi <yang.shi@linux.alibaba.com> wrote:
>
> When running applications on the machine with NVDIMM as NUMA node, the
> memory allocation may end up on NVDIMM node.  This may result in silent
> performance degradation and regression due to the difference of hardware
> property.
>
> DRAM first should be obeyed to prevent from surprising regression.  Any
> non-DRAM nodes should be excluded from default allocation.  Use nodemask
> to control the memory placement.  Introduce def_alloc_nodemask which has
> DRAM nodes set only.  Any non-DRAM allocation should be specified by
> NUMA policy explicitly.
>
> In the future we may be able to extract the memory charasteristics from
> HMAT or other source to build up the default allocation nodemask.
> However, just distinguish DRAM and PMEM (non-DRAM) nodes by SRAT flag
> for the time being.
>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> ---
>  arch/x86/mm/numa.c     |  1 +
>  drivers/acpi/numa.c    |  8 ++++++++
>  include/linux/mmzone.h |  3 +++
>  mm/page_alloc.c        | 18 ++++++++++++++++--
>  4 files changed, 28 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index dfb6c4d..d9e0ca4 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -626,6 +626,7 @@ static int __init numa_init(int (*init_func)(void))
>         nodes_clear(numa_nodes_parsed);
>         nodes_clear(node_possible_map);
>         nodes_clear(node_online_map);
> +       nodes_clear(def_alloc_nodemask);
>         memset(&numa_meminfo, 0, sizeof(numa_meminfo));
>         WARN_ON(memblock_set_node(0, ULLONG_MAX, &memblock.memory,
>                                   MAX_NUMNODES));
> diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
> index 867f6e3..79dfedf 100644
> --- a/drivers/acpi/numa.c
> +++ b/drivers/acpi/numa.c
> @@ -296,6 +296,14 @@ void __init acpi_numa_slit_init(struct acpi_table_slit *slit)
>                 goto out_err_bad_srat;
>         }
>
> +       /*
> +        * Non volatile memory is excluded from zonelist by default.
> +        * Only regular DRAM nodes are set in default allocation node
> +        * mask.
> +        */
> +       if (!(ma->flags & ACPI_SRAT_MEM_NON_VOLATILE))
> +               node_set(node, def_alloc_nodemask);

Hmm, no, I don't think we should do this. Especially considering
current generation NVDIMMs are energy backed DRAM there is no
performance difference that should be assumed by the non-volatile
flag.

Why isn't default SLIT distance sufficient for ensuring a DRAM-first
default policy?
