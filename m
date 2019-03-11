Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F764C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7719E2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfCKLWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 07:22:10 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57124 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727250AbfCKLWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 07:22:09 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8D0C5B8C6C6F8FFD30DB;
        Mon, 11 Mar 2019 19:22:07 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Mon, 11 Mar 2019
 19:22:03 +0800
Date:   Mon, 11 Mar 2019 11:21:52 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Keith Busch <keith.busch@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-api@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        "Dave Hansen" <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCHv7 08/10] acpi/hmat: Register performance attributes
Message-ID: <20190311112152.0000639c@huawei.com>
In-Reply-To: <20190227225038.20438-9-keith.busch@intel.com>
References: <20190227225038.20438-1-keith.busch@intel.com>
        <20190227225038.20438-9-keith.busch@intel.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Feb 2019 15:50:36 -0700
Keith Busch <keith.busch@intel.com> wrote:

> Save the best performace access attributes and register these with the

performance

> memory's node if HMAT provides the locality table. While HMAT does make
> it possible to know performance for all possible initiator-target
> pairings, we export only the local pairings at this time.
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Keith Busch <keith.busch@intel.com>

Jonathan
> ---
>  drivers/acpi/hmat/Kconfig |  5 ++++-
>  drivers/acpi/hmat/hmat.c  | 10 +++++++++-
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/hmat/Kconfig b/drivers/acpi/hmat/Kconfig
> index 13cddd612a52..95a29964dbea 100644
> --- a/drivers/acpi/hmat/Kconfig
> +++ b/drivers/acpi/hmat/Kconfig
> @@ -2,7 +2,10 @@
>  config ACPI_HMAT
>  	bool "ACPI Heterogeneous Memory Attribute Table Support"
>  	depends on ACPI_NUMA
> +	select HMEM_REPORTING
>  	help
>  	 If set, this option has the kernel parse and report the
>  	 platform's ACPI HMAT (Heterogeneous Memory Attributes Table),
> -	 and register memory initiators with their targets.
> +	 register memory initiators with their targets, and export
> +	 performance attributes through the node's sysfs device if
> +	 provided.
> diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
> index bb6a11653729..5b469c98a454 100644
> --- a/drivers/acpi/hmat/hmat.c
> +++ b/drivers/acpi/hmat/hmat.c
> @@ -549,12 +549,20 @@ static __init void hmat_register_target_initiators(struct memory_target *target)
>  	}
>  }
>  
> +static __init void hmat_register_target_perf(struct memory_target *target)
> +{
> +	unsigned mem_nid = pxm_to_node(target->memory_pxm);
> +	node_set_perf_attrs(mem_nid, &target->hmem_attrs, 0);
> +}
> +
>  static __init void hmat_register_targets(void)
>  {
>  	struct memory_target *target;
>  
> -	list_for_each_entry(target, &targets, node)
> +	list_for_each_entry(target, &targets, node) {
>  		hmat_register_target_initiators(target);
> +		hmat_register_target_perf(target);
> +	}
>  }
>  
>  static __init void hmat_free_structures(void)


