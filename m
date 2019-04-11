Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF0FC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 14:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20A2321850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 14:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554993779;
	bh=Gokb2CWQpNw9Yv8hl7LKzoV9ol8iog8Q5lkS6SK5gzo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=STyNIu4Z7Qfgbb/XSzdOSOqOkFUdctDx3VJhDV1PonEa5Lr1wxtFDFJBfX+aDDIa7
	 RkAQC5+kjOwdezpYHHBjbuqAjMhUrEeFvucyzZzcnxcl9Ke/P1xsTCzRVEyeJQKb4H
	 PFFSOnQqe2IDH3SE5z7U5pnnsiKDz+8nZRISwdTg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfDKOm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 10:42:58 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38848 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfDKOm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 10:42:57 -0400
Received: by mail-oi1-f195.google.com with SMTP id a6so5102441oie.5;
        Thu, 11 Apr 2019 07:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=crbSSw9RRq2gqjnga1aijJ75H8zXaneGIClC4ImS2/0=;
        b=LrsHmxcBXNx/dVoNen4xM2AyLXLcPTWSCFw99vZwD3ILxoXgK6dJ4Q7IjQO3nNy99d
         r3Uj9q9LHY9vAFVSgUNsjEQQizbai7OaL53BoSUOuf3rUWARseaiZ6js4cB1n7eZUvtc
         d2bxFUD2bzc1vFatWaG/aXkfh77WQiSt7EfrOrtwySw6YeIvfJPLAx6AmC4k5vH6vF67
         /RTc2d+1zeUTnfrb4Y3iWmhWsV8aTxIr3mKzf26mL4motwsDe0tEJuqvWP9cimWoTHu+
         BVl5uaexRxMwHGklRoPHaHQetxP/a26kEdwmW5kXnrVmXIdvCQ4426Rb2ISuz7UxBAAB
         xc1A==
X-Gm-Message-State: APjAAAUwoG37ZJwIGpXkjlPDDaeVIDDIvloAVIfN1fURZ3ur/GhI7krG
        nwAuJdgLnmEiwNHgpf3G5u+6vsLz2sbSnYi0kMY=
X-Google-Smtp-Source: APXvYqzFQAIrlFxpwlyEWoq6CpQY9y7nONO4rSZruvAoVkbHDac1JeCFyyQ2POUfLRzzHqsFQ84OyxDxuZpXgiMC5Vs=
X-Received: by 2002:aca:eb93:: with SMTP id j141mr6329300oih.178.1554993776444;
 Thu, 11 Apr 2019 07:42:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190409214415.3722-1-keith.busch@intel.com>
In-Reply-To: <20190409214415.3722-1-keith.busch@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 11 Apr 2019 16:42:45 +0200
Message-ID: <CAJZ5v0gOuHSoMd6dnGKN5fW1xKF89b2ak0F4mo+07FBpFUCP6A@mail.gmail.com>
Subject: Re: [PATCH] hmat: Register attributes for memory hot add
To:     Keith Busch <keith.busch@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Brice Goglin <Brice.Goglin@inria.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 11:42 PM Keith Busch <keith.busch@intel.com> wrote:
>
> Some types of memory nodes that HMAT describes may not be online at the
> time we initially parse their nodes' tables. If the node should be set
> to online later, as can happen when using PMEM as RAM after boot, the
> node's attributes will be missing their initiator links and performance.
>
> Regsiter a memory notifier callback and set the memory attributes when
> a node is initially brought online with hot added memory, and don't try
> to register node attributes if the node is not online during initial
> scanning.
>
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/acpi/hmat/hmat.c | 63 ++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 50 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
> index b275016ff648..cf24b885feb5 100644
> --- a/drivers/acpi/hmat/hmat.c
> +++ b/drivers/acpi/hmat/hmat.c
> @@ -14,14 +14,15 @@
>  #include <linux/init.h>
>  #include <linux/list.h>
>  #include <linux/list_sort.h>
> +#include <linux/memory.h>
>  #include <linux/node.h>
>  #include <linux/sysfs.h>
>
> -static __initdata u8 hmat_revision;
> +static u8 hmat_revision;
>
> -static __initdata LIST_HEAD(targets);
> -static __initdata LIST_HEAD(initiators);
> -static __initdata LIST_HEAD(localities);
> +static LIST_HEAD(targets);
> +static LIST_HEAD(initiators);
> +static LIST_HEAD(localities);
>
>  /*
>   * The defined enum order is used to prioritize attributes to break ties when
> @@ -41,6 +42,7 @@ struct memory_target {
>         unsigned int memory_pxm;
>         unsigned int processor_pxm;
>         struct node_hmem_attrs hmem_attrs;
> +       bool registered;
>  };
>
>  struct memory_initiator {
> @@ -53,7 +55,7 @@ struct memory_locality {
>         struct acpi_hmat_locality *hmat_loc;
>  };
>
> -static __init struct memory_initiator *find_mem_initiator(unsigned int cpu_pxm)
> +static struct memory_initiator *find_mem_initiator(unsigned int cpu_pxm)
>  {
>         struct memory_initiator *initiator;
>
> @@ -63,7 +65,7 @@ static __init struct memory_initiator *find_mem_initiator(unsigned int cpu_pxm)
>         return NULL;
>  }
>
> -static __init struct memory_target *find_mem_target(unsigned int mem_pxm)
> +static struct memory_target *find_mem_target(unsigned int mem_pxm)
>  {
>         struct memory_target *target;
>
> @@ -148,7 +150,7 @@ static __init const char *hmat_data_type_suffix(u8 type)
>         }
>  }
>
> -static __init u32 hmat_normalize(u16 entry, u64 base, u8 type)
> +static u32 hmat_normalize(u16 entry, u64 base, u8 type)
>  {
>         u32 value;
>
> @@ -183,7 +185,7 @@ static __init u32 hmat_normalize(u16 entry, u64 base, u8 type)
>         return value;
>  }
>
> -static __init void hmat_update_target_access(struct memory_target *target,
> +static void hmat_update_target_access(struct memory_target *target,
>                                              u8 type, u32 value)
>  {
>         switch (type) {
> @@ -435,7 +437,7 @@ static __init int srat_parse_mem_affinity(union acpi_subtable_headers *header,
>         return 0;
>  }
>
> -static __init u32 hmat_initiator_perf(struct memory_target *target,
> +static u32 hmat_initiator_perf(struct memory_target *target,
>                                struct memory_initiator *initiator,
>                                struct acpi_hmat_locality *hmat_loc)
>  {
> @@ -473,7 +475,7 @@ static __init u32 hmat_initiator_perf(struct memory_target *target,
>                               hmat_loc->data_type);
>  }
>
> -static __init bool hmat_update_best(u8 type, u32 value, u32 *best)
> +static bool hmat_update_best(u8 type, u32 value, u32 *best)
>  {
>         bool updated = false;
>
> @@ -517,7 +519,7 @@ static int initiator_cmp(void *priv, struct list_head *a, struct list_head *b)
>         return ia->processor_pxm - ib->processor_pxm;
>  }
>
> -static __init void hmat_register_target_initiators(struct memory_target *target)
> +static void hmat_register_target_initiators(struct memory_target *target)
>  {
>         static DECLARE_BITMAP(p_nodes, MAX_NUMNODES);
>         struct memory_initiator *initiator;
> @@ -577,22 +579,53 @@ static __init void hmat_register_target_initiators(struct memory_target *target)
>         }
>  }
>
> -static __init void hmat_register_target_perf(struct memory_target *target)
> +static void hmat_register_target_perf(struct memory_target *target)
>  {
>         unsigned mem_nid = pxm_to_node(target->memory_pxm);
>         node_set_perf_attrs(mem_nid, &target->hmem_attrs, 0);
>  }
>
> -static __init void hmat_register_targets(void)
> +static void hmat_register_targets(void)
>  {
>         struct memory_target *target;
>
>         list_for_each_entry(target, &targets, node) {
> +               if (!node_online(pxm_to_node(target->memory_pxm)))
> +                       continue;
> +
>                 hmat_register_target_initiators(target);
>                 hmat_register_target_perf(target);
> +               target->registered = true;
>         }
>  }
>
> +static int hmat_callback(struct notifier_block *self,
> +                        unsigned long action, void *arg)
> +{
> +       struct memory_notify *mnb = arg;
> +       int pxm, nid = mnb->status_change_nid;
> +       struct memory_target *target;
> +
> +       if (nid == NUMA_NO_NODE || action != MEM_ONLINE)
> +               return NOTIFY_OK;
> +
> +       pxm = node_to_pxm(nid);
> +       target = find_mem_target(pxm);
> +       if (!target || target->registered)
> +               return NOTIFY_OK;
> +
> +       hmat_register_target_initiators(target);
> +       hmat_register_target_perf(target);
> +       target->registered = true;
> +
> +       return NOTIFY_OK;
> +}

This appears to assume that there will never be any races between the
two functions above.

It this guaranteed to be the case?

> +
> +static struct notifier_block hmat_callback_nb = {
> +       .notifier_call = hmat_callback,
> +       .priority = 2,
> +};
> +
>  static __init void hmat_free_structures(void)
>  {
>         struct memory_target *target, *tnext;
> @@ -658,6 +691,10 @@ static __init int hmat_init(void)
>                 }
>         }
>         hmat_register_targets();
> +
> +       /* Keep the table and structures if the notifier may use them */
> +       if (!register_hotmemory_notifier(&hmat_callback_nb))
> +               return 0;
>  out_put:
>         hmat_free_structures();
>         acpi_put_table(tbl);
> --
