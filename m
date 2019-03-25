Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75D7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7945A2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730205AbfCYJOr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 05:14:47 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:32913 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730029AbfCYJOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 05:14:46 -0400
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 8E06786A3761C0349CAB;
        Mon, 25 Mar 2019 09:14:45 +0000 (GMT)
Received: from LHREML524-MBB.china.huawei.com ([169.254.3.25]) by
 LHREML711-CAH.china.huawei.com ([10.201.108.34]) with mapi id 14.03.0415.000;
 Mon, 25 Mar 2019 09:14:36 +0000
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "vkilari@codeaurora.org" <vkilari@codeaurora.org>,
        "neil.m.leeder@gmail.com" <neil.m.leeder@gmail.com>,
        "jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>,
        "pabba@codeaurora.org" <pabba@codeaurora.org>,
        John Garry <john.garry@huawei.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rruigrok@codeaurora.org" <rruigrok@codeaurora.org>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v6 2/4] perf: add arm64 smmuv3 pmu driver
Thread-Topic: [PATCH v6 2/4] perf: add arm64 smmuv3 pmu driver
Thread-Index: AQHUvIOBbKShrQh1/06Kddta29tkOqYWdYCAgAXm7lA=
Date:   Mon, 25 Mar 2019 09:14:35 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA8393240BA@lhreml524-mbb.china.huawei.com>
References: <20190204121324.11460-1-shameerali.kolothum.thodi@huawei.com>
 <20190204121324.11460-3-shameerali.kolothum.thodi@huawei.com>
 <0213c2af-149b-c47b-97cc-263f2bfecc40@arm.com>
In-Reply-To: <0213c2af-149b-c47b-97cc-263f2bfecc40@arm.com>
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
> From: linux-arm-kernel [mailto:linux-arm-kernel-bounces@lists.infradead.org]
> On Behalf Of Robin Murphy
> Sent: 21 March 2019 15:04
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> lorenzo.pieralisi@arm.com
> Cc: mark.rutland@arm.com; vkilari@codeaurora.org;
> neil.m.leeder@gmail.com; jean-philippe.brucker@arm.com;
> pabba@codeaurora.org; John Garry <john.garry@huawei.com>;
> will.deacon@arm.com; rruigrok@codeaurora.org; Linuxarm
> <linuxarm@huawei.com>; linux-kernel@vger.kernel.org;
> linux-acpi@vger.kernel.org; Guohanjun (Hanjun Guo)
> <guohanjun@huawei.com>; andrew.murray@arm.com;
> linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH v6 2/4] perf: add arm64 smmuv3 pmu driver

[...]

> Ah, apologies for leading you wrong on this, but it has turned out to be
> bogus - perf_pmu_register() does things for which preemption should not
> be disabled, and it flares up particularly on PREEMPT_RT. For now, I
> think the best thing to do is to bring the put_cpu() call up here (or
> just use raw_smp_processor_id() instead) and accept that those
> vanishingly-unlikely-in-practice race conditions exist until someone can
> make the registration dance more robust in the perf core itself.
> 
> Beyond that, though, I'm trusting that everything I didn't comment on
> last time and doesn't appear at a glance to have changed is still good,
> so with the comments above addressed,
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> 
> FYI, both Will and Mark are out for a while, so whilst I expect v7
> should be good to merge, don't expect any maintainer final say for at
> least a couple of weeks yet.
> 

Thanks Robin. I will address the comments and sent out v7 soon.

Cheers,
Shameer
