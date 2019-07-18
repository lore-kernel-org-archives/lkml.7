Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0933AC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 06:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C1F217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 06:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfGRGMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 02:12:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:47014 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725959AbfGRGMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 02:12:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DC940AFEC;
        Thu, 18 Jul 2019 06:12:35 +0000 (UTC)
Message-ID: <1563430353.3077.1.camel@suse.de>
Subject: Re: [PATCH 1/1] mm/memory_hotplug: Adds option to hot-add memory in
 ZONE_MOVABLE
From:   Oscar Salvador <osalvador@suse.de>
To:     Leonardo Bras <leonardo@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pasha Tatashin <Pavel.Tatashin@microsoft.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date:   Thu, 18 Jul 2019 08:12:33 +0200
In-Reply-To: <20190718024133.3873-1-leonardo@linux.ibm.com>
References: <20190718024133.3873-1-leonardo@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-17 at 23:41 -0300, Leonardo Bras wrote:
> Adds an option on kernel config to make hot-added memory online in
> ZONE_MOVABLE by default.
> 
> This would be great in systems with MEMORY_HOTPLUG_DEFAULT_ONLINE=y
> by
> allowing to choose which zone it will be auto-onlined

We do already have "movable_node" boot option, which exactly has that
effect.
Any hotplugged range will be placed in ZONE_MOVABLE.

Why do we need yet another option to achieve the same? Was not that
enough for your case?

> 
> Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
> ---
>  drivers/base/memory.c |  3 +++
>  mm/Kconfig            | 14 ++++++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index f180427e48f4..378b585785c1 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -670,6 +670,9 @@ static int init_memory_block(struct memory_block
> **memory,
>  	mem->state = state;
>  	start_pfn = section_nr_to_pfn(mem->start_section_nr);
>  	mem->phys_device = arch_get_memory_phys_device(start_pfn);
> +#ifdef CONFIG_MEMORY_HOTPLUG_MOVABLE
> +	mem->online_type = MMOP_ONLINE_MOVABLE;
> +#endif
>  
>  	ret = register_memory(mem);
>  
> diff --git a/mm/Kconfig b/mm/Kconfig
> index f0c76ba47695..74e793720f43 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -180,6 +180,20 @@ config MEMORY_HOTREMOVE
>  	depends on MEMORY_HOTPLUG && ARCH_ENABLE_MEMORY_HOTREMOVE
>  	depends on MIGRATION
>  
> +config MEMORY_HOTPLUG_MOVABLE
> +	bool "Enhance the likelihood of hot-remove"
> +	depends on MEMORY_HOTREMOVE
> +	help
> +	  This option sets the hot-added memory zone to MOVABLE
> which
> +	  drastically reduces the chance of a hot-remove to fail due
> to
> +	  unmovable memory segments. Kernel memory can't be
> allocated in
> +	  this zone.
> +
> +	  Say Y here if you want to have better chance to hot-remove 
> memory
> +	  that have been previously hot-added.
> +	  Say N here if you want to make all hot-added memory
> available to
> +	  kernel space.
> +
>  # Heavily threaded applications may benefit from splitting the mm-
> wide
>  # page_table_lock, so that faults on different parts of the user
> address
>  # space can be handled with less contention: split it at this
> NR_CPUS.
-- 
Oscar Salvador
SUSE L3
