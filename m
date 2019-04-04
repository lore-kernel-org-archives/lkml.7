Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDDDC10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6512A206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbfDDQcG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 12:32:06 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:32918 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727053AbfDDQcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 12:32:04 -0400
Received: from LHREML712-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 6070DFF7FF970DE39579;
        Thu,  4 Apr 2019 17:32:03 +0100 (IST)
Received: from LHREML524-MBS.china.huawei.com ([169.254.2.229]) by
 LHREML712-CAH.china.huawei.com ([10.201.108.35]) with mapi id 14.03.0415.000;
 Thu, 4 Apr 2019 17:31:55 +0100
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Will Deacon <will.deacon@arm.com>
CC:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        "John Garry" <john.garry@huawei.com>,
        "pabba@codeaurora.org" <pabba@codeaurora.org>,
        "vkilari@codeaurora.org" <vkilari@codeaurora.org>,
        "rruigrok@codeaurora.org" <rruigrok@codeaurora.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>,
        "neil.m.leeder@gmail.com" <neil.m.leeder@gmail.com>
Subject: RE: [PATCH v7 4/4] perf/smmuv3: Enable HiSilicon Erratum 162001800
 quirk
Thread-Topic: [PATCH v7 4/4] perf/smmuv3: Enable HiSilicon Erratum 162001800
 quirk
Thread-Index: AQHU4+eNGDYznP+LJkGbBgcrT5VMl6YsIsKAgAAVvUA=
Date:   Thu, 4 Apr 2019 16:31:55 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA8393575FC@lhreml524-mbs.china.huawei.com>
References: <20190326151753.19384-1-shameerali.kolothum.thodi@huawei.com>
 <20190326151753.19384-5-shameerali.kolothum.thodi@huawei.com>
 <20190404154711.GA27577@fuggles.cambridge.arm.com>
In-Reply-To: <20190404154711.GA27577@fuggles.cambridge.arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.237]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Will Deacon [mailto:will.deacon@arm.com]
> Sent: 04 April 2019 16:47
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: lorenzo.pieralisi@arm.com; robin.murphy@arm.com;
> andrew.murray@arm.com; jean-philippe.brucker@arm.com;
> mark.rutland@arm.com; Guohanjun (Hanjun Guo) <guohanjun@huawei.com>;
> John Garry <john.garry@huawei.com>; pabba@codeaurora.org;
> vkilari@codeaurora.org; rruigrok@codeaurora.org; linux-acpi@vger.kernel.org;
> linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Linuxarm
> <linuxarm@huawei.com>; neil.m.leeder@gmail.com
> Subject: Re: [PATCH v7 4/4] perf/smmuv3: Enable HiSilicon Erratum 162001800
> quirk
> 
> On Tue, Mar 26, 2019 at 03:17:53PM +0000, Shameer Kolothum wrote:
> > HiSilicon erratum 162001800 describes the limitation of
> > SMMUv3 PMCG implementation on HiSilicon Hip08 platforms.
> >
> > On these platforms, the PMCG event counter registers
> > (SMMU_PMCG_EVCNTRn) are read only and as a result it
> > is not possible to set the initial counter period value
> > on event monitor start.
> >
> > To work around this, the current value of the counter
> > is read and used for delta calculations. OEM information
> > from ACPI header is used to identify the affected hardware
> > platforms.
> >
> > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
> > Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> > ---
> >  drivers/acpi/arm64/iort.c     | 16 ++++++++++++++-
> >  drivers/perf/arm_smmuv3_pmu.c | 48
> ++++++++++++++++++++++++++++++++++++-------
> >  include/linux/acpi_iort.h     |  1 +
> >  3 files changed, 57 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> > index e2c9b26..4dc68de 100644
> > --- a/drivers/acpi/arm64/iort.c
> > +++ b/drivers/acpi/arm64/iort.c
> > @@ -1366,9 +1366,23 @@ static void __init
> arm_smmu_v3_pmcg_init_resources(struct resource *res,
> >  				       ACPI_EDGE_SENSITIVE, &res[2]);
> >  }
> >
> > +static struct acpi_platform_list pmcg_plat_info[] __initdata = {
> > +	/* HiSilicon Hip08 Platform */
> > +	{"HISI  ", "HIP08   ", 0, ACPI_SIG_IORT, greater_than_or_equal, 0,
> 
> Passing integer constant 0 for the reason feels wrong to me. I'm going to
> change it to "Erratum #162001800" and also add an entry to
> silicon-errata.txt.
> 
> Please shout if that's not ok.

Thanks Will for taking a look at this series. The proposed changes are fine to me.

Shameer
