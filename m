Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436F1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 051EE2184C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="D0jFPgrd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730238AbfC2VPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 17:15:16 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40948 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729926AbfC2VPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 17:15:15 -0400
Received: by mail-ot1-f66.google.com with SMTP id t8so3317424otp.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 14:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fr4m467rBB5Oh9X9hIyfmtCEuwGt8t/C6nshHo6m7qI=;
        b=D0jFPgrdoX/w7QKQrtXXVxhEJBNKAm4MGQcDwHmWaOi3yAC04/LaXOTOWbdEcNw31h
         XuqsqgjuOspa16mZmBg9jWGtICjW9TUg8B6+bgE5ICgkEQjm+stpkTRlY+vP+3jhe0jq
         FCixCURzko0lKDjKYZPQfZu3tU9wdbEuNoTZFO60FN5gtx6E36ufLwG92MVhuvC/ZAm6
         xQxSFO3jukm+v47JMLmDQmRiMf+ekT2wO+4jPie1kQLoYi5gFMDgJ4frSBj6gApjf78H
         5zUKCnJQQ/zxD6p31gDPqTlTC2l+mKdcM9boUrX4L4m2dxkoW9ec8kOLyfVmqkGsudMH
         q37w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fr4m467rBB5Oh9X9hIyfmtCEuwGt8t/C6nshHo6m7qI=;
        b=RzXIovBLGIE+XM336bNDLhm6ZT0dPDPRoTR9p1BRPy8lOeB+w3EiVI+zpDjLlDr3tl
         aeRG/EsF4cd2Iq+6Alq68UxWbGVvNfcVViM2J9T7o8NjPA9lgUPAgnNXAyoNuyPKiAZ7
         A2WWaoFTxCL6Jguz3cJ9mmKA4iAWnRFFGwChFq9VzvLm/SS+RsIz4ixoNerXGYXcjShZ
         BWOAySOHlXuJKivIHmLcIpt9qi9gRhB0R636n9GWqtvNfxmTs59CnRNl7/vep2xueGDp
         zEhF1LtYmS/5NszGZ6ixiAsSR++TbfHvpNsb1yBYbBEWg2KATdLziPGwcifZ9CzZZM9S
         wnWA==
X-Gm-Message-State: APjAAAUCYEtlonqzz8tVFnhOcaOKhIFqQlhFeC2sQ4t1QLy9G+wrv15P
        NoqHINdn4vnTM8uB5ue9EMvNkSZ8RNHAYBW++dDNZA==
X-Google-Smtp-Source: APXvYqygoTKjZ45FfFhTEE8Yxqw9f4CDP9yNPRjO5bWzq9gcMdknY3cWGKUkOooR3w8qGo75vLXsinSJHaRvK93E5Ic=
X-Received: by 2002:a9d:27e3:: with SMTP id c90mr11192297otb.214.1553894114951;
 Fri, 29 Mar 2019 14:15:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190311205606.11228-1-keith.busch@intel.com> <20190311205606.11228-8-keith.busch@intel.com>
In-Reply-To: <20190311205606.11228-8-keith.busch@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 29 Mar 2019 14:15:03 -0700
Message-ID: <CAPcyv4j5bLiUtmjdnjt7KNOtNm4sRHWp=5T3m1bWD=U1zBXeqQ@mail.gmail.com>
Subject: Re: [PATCHv8 07/10] acpi/hmat: Register processor domain to its memory
To:     Keith Busch <keith.busch@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Brice Goglin <Brice.Goglin@inria.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 1:55 PM Keith Busch <keith.busch@intel.com> wrote:
>
> If the HMAT Subsystem Address Range provides a valid processor proximity
> domain for a memory domain, or a processor domain matches the performance
> access of the valid processor proximity domain, register the memory
> target with that initiator so this relationship will be visible under
> the node's sysfs directory.
>
> Since HMAT requires valid address ranges have an equivalent SRAT entry,
> verify each memory target satisfies this requirement.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/acpi/hmat/Kconfig |   3 +-
>  drivers/acpi/hmat/hmat.c  | 392 +++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 393 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/hmat/Kconfig b/drivers/acpi/hmat/Kconfig
> index 2f7111b7af62..13cddd612a52 100644
> --- a/drivers/acpi/hmat/Kconfig
> +++ b/drivers/acpi/hmat/Kconfig
> @@ -4,4 +4,5 @@ config ACPI_HMAT
>         depends on ACPI_NUMA
>         help
>          If set, this option has the kernel parse and report the
> -        platform's ACPI HMAT (Heterogeneous Memory Attributes Table).
> +        platform's ACPI HMAT (Heterogeneous Memory Attributes Table),
> +        and register memory initiators with their targets.
> diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
> index 4758beb3b2c1..01a6eddac6f7 100644
> --- a/drivers/acpi/hmat/hmat.c
> +++ b/drivers/acpi/hmat/hmat.c
> @@ -13,11 +13,105 @@
>  #include <linux/device.h>
>  #include <linux/init.h>
>  #include <linux/list.h>
> +#include <linux/list_sort.h>
>  #include <linux/node.h>
>  #include <linux/sysfs.h>
>
>  static __initdata u8 hmat_revision;
>
> +static __initdata LIST_HEAD(targets);
> +static __initdata LIST_HEAD(initiators);
> +static __initdata LIST_HEAD(localities);
> +
> +/*
> + * The defined enum order is used to prioritize attributes to break ties when
> + * selecting the best performing node.
> + */
> +enum locality_types {
> +       WRITE_LATENCY,
> +       READ_LATENCY,
> +       WRITE_BANDWIDTH,
> +       READ_BANDWIDTH,
> +};
> +
> +static struct memory_locality *localities_types[4];
> +
> +struct memory_target {
> +       struct list_head node;
> +       unsigned int memory_pxm;
> +       unsigned int processor_pxm;
> +       struct node_hmem_attrs hmem_attrs;
> +};
> +
> +struct memory_initiator {
> +       struct list_head node;
> +       unsigned int processor_pxm;
> +};
> +
> +struct memory_locality {
> +       struct list_head node;
> +       struct acpi_hmat_locality *hmat_loc;
> +};
> +
> +static __init struct memory_initiator *find_mem_initiator(unsigned int cpu_pxm)
> +{
> +       struct memory_initiator *initiator;
> +
> +       list_for_each_entry(initiator, &initiators, node)
> +               if (initiator->processor_pxm == cpu_pxm)
> +                       return initiator;
> +       return NULL;
> +}
> +
> +static __init struct memory_target *find_mem_target(unsigned int mem_pxm)
> +{
> +       struct memory_target *target;
> +
> +       list_for_each_entry(target, &targets, node)
> +               if (target->memory_pxm == mem_pxm)
> +                       return target;
> +       return NULL;

The above implementation assumes that every SRAT entry has a unique
@mem_pxm. I don't think that's valid if the memory map is sparse,
right?
