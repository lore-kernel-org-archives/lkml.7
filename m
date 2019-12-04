Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AE3C2BD09
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 12:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9068420674
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 12:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="e6TfccCf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbfLDMzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 07:55:48 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:44210 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfLDMzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 07:55:48 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB4CtLla021288;
        Wed, 4 Dec 2019 06:55:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575464121;
        bh=75OBmJFI3hpuZ4Q6xPCszXW82HOFGTHmHSHourpUJo0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=e6TfccCfOlRHdE4aRiwj/c6mLAfsJvVI9jtvB241LwZYg12Kb3nKITmZXXAim2ENg
         mW4d9tz8/BHbqG9JyHgltecYvf8lGeGhYvn9gFVZQc8708HiuZU95x8HqXVPQd0Czd
         vr1tYpTKdDAeilTspVpALfyteFa87pBEN0Os9fPI=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB4CtLqc057283;
        Wed, 4 Dec 2019 06:55:21 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 4 Dec
 2019 06:55:21 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 4 Dec 2019 06:55:21 -0600
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB4CtHYT006688;
        Wed, 4 Dec 2019 06:55:18 -0600
Subject: Re: [PATCH v5 4/4] mtd: Add driver for concatenating devices
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-mtd@lists.infradead.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Bernhard Frauendienst <kernel@nospam.obeliks.de>
References: <20191127105522.31445-1-miquel.raynal@bootlin.com>
 <20191127105522.31445-5-miquel.raynal@bootlin.com>
 <690065a2-619d-3f97-30c6-5dea76896d78@ti.com> <20191204111751.5383b426@xps13>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <431e7345-ee60-6d79-7a0c-9396da93029c@ti.com>
Date:   Wed, 4 Dec 2019 18:25:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191204111751.5383b426@xps13>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/12/19 3:47 pm, Miquel Raynal wrote:
> Hi Vignesh,
> 
> Vignesh Raghavendra <vigneshr@ti.com> wrote on Wed, 4 Dec 2019 15:28:46
> +0530:
> 
[...]
>> IIUC flash0 and flash1 are subnodes of a SPI master node?
>> And I believe flash0 node's compatible is "jedec,spi-nor"?
> 
> Indeed this is one possibility (probably the most common) but in theory
> this should work for any kind of MTD device, hence I voluntarily
> dropped the hardware-specific properties to focus on the partitions
> description here.
> 

Ah, make sense...

>>
>>
>>>
>>>         flash1 {
>>>                 partitions {
>>>                         compatible = "fixed-partitions";
>>>
>>> 			flash0_part1: part1@0 {  
>>
>> s/flash0_part1/flash1_part0?
> 
> Right!
> 
>>
>>> 				label = "part1_0";
>>> 				reg = <0x0 0x800000>;
>>> 			};
>>>
>>> 			part0@800000 {
>>> 				label = "part1_1";
>>> 				reg = <0x800000 0x800000>;
>>> 			};
>>>                 };
>>>         };
>>>   
>>
>> For my understanding, how many /dev/mtdX entries would this create?
> 
> If the master is retained (Kconfig option) and thanks to the common
> partitioning scheme, we would have:
> * flash0 (mtd0)
> *   part0_0 (mtd1)
> *   part0_1 (mtd2)
> * flash1 (mtd3)
> *   part1_0 (mtd4)
> *   part1_1 (mtd5)
> 
> If we enable this driver, we would also get an additional device:
> * mtd2-mtd4-concat (or part0_1-part1_0-concat, I don't recall the exact
>   name) being mtd6.

Ok, thanks for the clarification!


-- 
Regards
Vignesh
