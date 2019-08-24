Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E3EC3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 14:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 832C821670
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 14:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JYmdfYFt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfHXOPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 10:15:32 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54676 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbfHXOPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 10:15:31 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7OEFESG089947;
        Sat, 24 Aug 2019 09:15:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1566656114;
        bh=NWO1dJivia0EnGfMulUsccXLfXHlI53Biy5LNzeg6ps=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=JYmdfYFty6mcZvJcoI8mFdZ4BoWAFZ/cMMfkLhgm/v7RggkaRCwdg9IvG+r/6aCsj
         1LcA/WMMBixZ4AwkhhOAD/QL70xUghpmASasZwga99qnifeMj5FAKOkVVLYwHECHml
         vpiN+CnqofbexpCLdSQhQXh/L5qPrK+yvqrUyCYg=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7OEFEoW096395
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 24 Aug 2019 09:15:14 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Sat, 24
 Aug 2019 09:15:13 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Sat, 24 Aug 2019 09:15:14 -0500
Received: from [10.250.132.16] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7OEFBdw071127;
        Sat, 24 Aug 2019 09:15:12 -0500
Subject: Re: [PATCH] mtd: hyperbus: fix dependency and build error
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Randy Dunlap <rdunlap@infradead.org>
CC:     <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <9b1b4ab1-681f-0ef9-7b5c-b6545f7464d2@infradead.org>
 <20190824124807.393f125d@xps13>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <4626f8cb-0802-e154-d204-15d35081dd27@ti.com>
Date:   Sat, 24 Aug 2019 19:45:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190824124807.393f125d@xps13>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On 24-Aug-19 4:18 PM, Miquel Raynal wrote:
> Hi Vignesh,
> 
> Randy Dunlap <rdunlap@infradead.org> wrote on Tue, 13 Aug 2019 16:03:13
> -0700:
> 
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> lib/devres.c, which implements devm_ioremap_resource(), is only built
>> when CONFIG_HAS_IOMEM is set/enabled, so MTD_HYPERBUS should depend
>> on HAS_IOMEM.  Fixes a build error and a Kconfig warning (as seen on
>> UML builds):
>>
>> WARNING: unmet direct dependencies detected for MTD_COMPLEX_MAPPINGS
>>   Depends on [n]: MTD [=m] && HAS_IOMEM [=n]
>>   Selected by [m]:
>>   - MTD_HYPERBUS [=m] && MTD [=m]
>>
>> ERROR: "devm_ioremap_resource" [drivers/mtd/hyperbus/hyperbus-core.ko] undefined!
>>
>> Fixes: dcc7d3446a0f ("mtd: Add support for HyperBus memory devices")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Vignesh Raghavendra <vigneshr@ti.com>
>> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Cc: linux-mtd@lists.infradead.org
>> ---
> 
> This patch looks like a good candidate for fixes, shall I send a fixes
> PR next week with it? (Acked-by wished)
> 

Yes, that would be great. I was about to send across patch bundle myself.

Acked-by: Vignesh Raghavendra <vigneshr@ti.com>

Thanks
Vignesh
