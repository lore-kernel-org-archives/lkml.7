Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAAFC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174E0206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbfDDPrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:47:19 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34548 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727398AbfDDPrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 11:47:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8569A169E;
        Thu,  4 Apr 2019 08:47:18 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6FB43F59C;
        Thu,  4 Apr 2019 08:47:15 -0700 (PDT)
Date:   Thu, 4 Apr 2019 16:47:11 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc:     lorenzo.pieralisi@arm.com, robin.murphy@arm.com,
        andrew.murray@arm.com, jean-philippe.brucker@arm.com,
        mark.rutland@arm.com, guohanjun@huawei.com, john.garry@huawei.com,
        pabba@codeaurora.org, vkilari@codeaurora.org,
        rruigrok@codeaurora.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxarm@huawei.com, neil.m.leeder@gmail.com
Subject: Re: [PATCH v7 4/4] perf/smmuv3: Enable HiSilicon Erratum 162001800
 quirk
Message-ID: <20190404154711.GA27577@fuggles.cambridge.arm.com>
References: <20190326151753.19384-1-shameerali.kolothum.thodi@huawei.com>
 <20190326151753.19384-5-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326151753.19384-5-shameerali.kolothum.thodi@huawei.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 03:17:53PM +0000, Shameer Kolothum wrote:
> HiSilicon erratum 162001800 describes the limitation of
> SMMUv3 PMCG implementation on HiSilicon Hip08 platforms.
> 
> On these platforms, the PMCG event counter registers
> (SMMU_PMCG_EVCNTRn) are read only and as a result it
> is not possible to set the initial counter period value
> on event monitor start.
> 
> To work around this, the current value of the counter
> is read and used for delta calculations. OEM information
> from ACPI header is used to identify the affected hardware
> platforms.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/acpi/arm64/iort.c     | 16 ++++++++++++++-
>  drivers/perf/arm_smmuv3_pmu.c | 48 ++++++++++++++++++++++++++++++++++++-------
>  include/linux/acpi_iort.h     |  1 +
>  3 files changed, 57 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index e2c9b26..4dc68de 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -1366,9 +1366,23 @@ static void __init arm_smmu_v3_pmcg_init_resources(struct resource *res,
>  				       ACPI_EDGE_SENSITIVE, &res[2]);
>  }
>  
> +static struct acpi_platform_list pmcg_plat_info[] __initdata = {
> +	/* HiSilicon Hip08 Platform */
> +	{"HISI  ", "HIP08   ", 0, ACPI_SIG_IORT, greater_than_or_equal, 0,

Passing integer constant 0 for the reason feels wrong to me. I'm going to
change it to "Erratum #162001800" and also add an entry to
silicon-errata.txt.

Please shout if that's not ok.

Will
