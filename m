Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB54C76196
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 12:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF6221783
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 12:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="TZjOKys0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390181AbfGRMUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 08:20:00 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35965 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfGRMT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 08:19:59 -0400
Received: by mail-ed1-f66.google.com with SMTP id k21so30050462edq.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 05:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CCVHqVtcDr9kxRQz1YfpzaVckBtPbq59VjeQ1p3zOVc=;
        b=TZjOKys03SMFxMLBoi3A5eP5IIETYuLZHVfNo9Sr5/oPvhYZ0sb9eu01Cww8CLUsEd
         WPZF0Q9MGYDAvp2lkAO7a9++fepsHkgI/ajVgs70C0p5gEz5P7HanQfcIB6qVyuNqz9z
         iJo5Z2/SVIU8BaIXJRS/33G0P3lByvJnZg1uWKv6z7eFCAEI6bXWkrmS0YjHAq6oDLCP
         2E0AzCzK8vwAv6Y6HWbul7rfc//Qds6XVQOCwcWwrAQj7cQHoK0qXszAT1ErTmeHBDCo
         C+vJpLIuTeehs4DMEMSuV/71VgxMyynAKxeEUBkszIZI3fPE53lLKtfq+U319K1kPf9I
         JPbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CCVHqVtcDr9kxRQz1YfpzaVckBtPbq59VjeQ1p3zOVc=;
        b=ZuccUs2/4/55F03om9QpOo8gpyB+VxfaZBx6b9rwWxavBnarhj6ZXhqZQOCglpO8GS
         3aKgRok856Z8kCbwj1shbHKC73KOeFHK2790zsbWFJbT5mugOTRXhIZqWjUX5chIX22T
         1Qu6xcCjeoiTE0qDoyvdyibxeIGYBfiCRJK83ZJesbVPpckAKQ1UPFLw47OB1MMAiZQ5
         46XwcmtoUrJytxoHbgi++HZKm9NIiWngymz1mZPyOAQh8qwrmw1lwIJNXP7TMNAnIeMc
         Fs7j50g6O5yCluKmGND5HqMPzx8PUBdjYBII0brXiSe/y0JtlS4FO+IPK/n9MLPAU5q6
         XEKA==
X-Gm-Message-State: APjAAAWOPDyv6lMWLkesrOYC7WYBxwQQWnVkmmeT7v0CofsAIOtFLx6e
        m8R5YDwXVCV/NoSAAW8de+sOUVuSYNvj+UKOzYk=
X-Google-Smtp-Source: APXvYqzcA8/9pmEX4K9HZSZ6a8HBFZKEBUeGXpnUZGdqw3SL92Bxma0PiWv2EMFLoPf3cMiLE1hgkjSOYVvuQa/1ork=
X-Received: by 2002:a17:906:5409:: with SMTP id q9mr36460845ejo.209.1563452397474;
 Thu, 18 Jul 2019 05:19:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190718024133.3873-1-leonardo@linux.ibm.com>
In-Reply-To: <20190718024133.3873-1-leonardo@linux.ibm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 18 Jul 2019 08:19:46 -0400
Message-ID: <CA+CK2bBu7DnG73SaBDwf9cBceNvKnZDEqA-gBJmKC9K_rqgO+A@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/memory_hotplug: Adds option to hot-add memory in ZONE_MOVABLE
To:     Leonardo Bras <leonardo@linux.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pasha Tatashin <Pavel.Tatashin@microsoft.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 10:42 PM Leonardo Bras <leonardo@linux.ibm.com> wrote:
>
> Adds an option on kernel config to make hot-added memory online in
> ZONE_MOVABLE by default.
>
> This would be great in systems with MEMORY_HOTPLUG_DEFAULT_ONLINE=y by
> allowing to choose which zone it will be auto-onlined

This is a desired feature. From reading the code it looks to me that
auto-selection of online method type should be done in
memory_subsys_online().

When it is called from device online, mem->online_type should be -1:

if (mem->online_type < 0)
     mem->online_type = MMOP_ONLINE_KEEP;

Change it to:
if (mem->online_type < 0)
     mem->online_type = MMOP_DEFAULT_ONLINE_TYPE;

And in "linux/memory_hotplug.h"
#ifdef CONFIG_MEMORY_HOTPLUG_MOVABLE
#define MMOP_DEFAULT_ONLINE_TYPE MMOP_ONLINE_MOVABLE
#else
#define MMOP_DEFAULT_ONLINE_TYPE MMOP_ONLINE_KEEP
#endif

Could be expanded to support MMOP_ONLINE_KERNEL as well.

Pasha

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
> @@ -670,6 +670,9 @@ static int init_memory_block(struct memory_block **memory,
>         mem->state = state;
>         start_pfn = section_nr_to_pfn(mem->start_section_nr);
>         mem->phys_device = arch_get_memory_phys_device(start_pfn);
> +#ifdef CONFIG_MEMORY_HOTPLUG_MOVABLE
> +       mem->online_type = MMOP_ONLINE_MOVABLE;
> +#endif
>
>         ret = register_memory(mem);
>
> diff --git a/mm/Kconfig b/mm/Kconfig
> index f0c76ba47695..74e793720f43 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -180,6 +180,20 @@ config MEMORY_HOTREMOVE
>         depends on MEMORY_HOTPLUG && ARCH_ENABLE_MEMORY_HOTREMOVE
>         depends on MIGRATION
>
> +config MEMORY_HOTPLUG_MOVABLE
> +       bool "Enhance the likelihood of hot-remove"
> +       depends on MEMORY_HOTREMOVE
> +       help
> +         This option sets the hot-added memory zone to MOVABLE which
> +         drastically reduces the chance of a hot-remove to fail due to
> +         unmovable memory segments. Kernel memory can't be allocated in
> +         this zone.
> +
> +         Say Y here if you want to have better chance to hot-remove memory
> +         that have been previously hot-added.
> +         Say N here if you want to make all hot-added memory available to
> +         kernel space.
> +
>  # Heavily threaded applications may benefit from splitting the mm-wide
>  # page_table_lock, so that faults on different parts of the user address
>  # space can be handled with less contention: split it at this NR_CPUS.
> --
> 2.20.1
>

On Wed, Jul 17, 2019 at 10:42 PM Leonardo Bras <leonardo@linux.ibm.com> wrote:
>
> Adds an option on kernel config to make hot-added memory online in
> ZONE_MOVABLE by default.
>
> This would be great in systems with MEMORY_HOTPLUG_DEFAULT_ONLINE=y by
> allowing to choose which zone it will be auto-onlined
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
> @@ -670,6 +670,9 @@ static int init_memory_block(struct memory_block **memory,
>         mem->state = state;
>         start_pfn = section_nr_to_pfn(mem->start_section_nr);
>         mem->phys_device = arch_get_memory_phys_device(start_pfn);
> +#ifdef CONFIG_MEMORY_HOTPLUG_MOVABLE
> +       mem->online_type = MMOP_ONLINE_MOVABLE;
> +#endif
>
>         ret = register_memory(mem);
>
> diff --git a/mm/Kconfig b/mm/Kconfig
> index f0c76ba47695..74e793720f43 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -180,6 +180,20 @@ config MEMORY_HOTREMOVE
>         depends on MEMORY_HOTPLUG && ARCH_ENABLE_MEMORY_HOTREMOVE
>         depends on MIGRATION
>
> +config MEMORY_HOTPLUG_MOVABLE
> +       bool "Enhance the likelihood of hot-remove"
> +       depends on MEMORY_HOTREMOVE
> +       help
> +         This option sets the hot-added memory zone to MOVABLE which
> +         drastically reduces the chance of a hot-remove to fail due to
> +         unmovable memory segments. Kernel memory can't be allocated in
> +         this zone.
> +
> +         Say Y here if you want to have better chance to hot-remove memory
> +         that have been previously hot-added.
> +         Say N here if you want to make all hot-added memory available to
> +         kernel space.
> +
>  # Heavily threaded applications may benefit from splitting the mm-wide
>  # page_table_lock, so that faults on different parts of the user address
>  # space can be handled with less contention: split it at this NR_CPUS.
> --
> 2.20.1
>
