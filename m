Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADECFA372C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 12:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30635214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 12:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UW+6NMZI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388412AbfKGMZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 07:25:37 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46334 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbfKGMZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 07:25:37 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xA7CPAai081212;
        Thu, 7 Nov 2019 06:25:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573129510;
        bh=E4MS55kwaW5g/5KMrdjN4z1SWbBuXuTiMq2j/PcjEiY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=UW+6NMZI2DNcg8/Yc8M2AkH9YUhIjG0ug6zMpSF8759STfMnQIXvG15KKYOZAgo98
         va4Aooa7y2zRrtfb1gpbKTaiyzGKmaUyAAewm0RR+d6N0Q1IJ5hL9uzN+uqqMCbNdy
         RhjwN1TNyhG3OWeWQSVS9D3FIK/DfoxqTx5ovUFo=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xA7CPAqU108742
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Nov 2019 06:25:10 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 7 Nov
 2019 06:24:55 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 7 Nov 2019 06:24:55 -0600
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xA7CP57p097478;
        Thu, 7 Nov 2019 06:25:06 -0600
Subject: Re: [PATCH 1/2] mtd: mtk-quadspi: add support for memory-mapped flash
 reading
To:     Chuanhong Guo <gch981213@gmail.com>
CC:     <linux-mtd@lists.infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20191106140748.13100-1-gch981213@gmail.com>
 <20191106140748.13100-2-gch981213@gmail.com>
 <bc917a56-e688-d701-2279-87df460d6055@ti.com>
 <CAJsYDVJgUNxLhcO9iLKwRZHPQ9FT8XuKQq8ru_djD2nryT5o9A@mail.gmail.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <efd471a6-daad-a191-5528-62313dd4e4a4@ti.com>
Date:   Thu, 7 Nov 2019 17:55:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAJsYDVJgUNxLhcO9iLKwRZHPQ9FT8XuKQq8ru_djD2nryT5o9A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/11/19 3:01 PM, Chuanhong Guo wrote:
> Hi!
> 
> On Thu, Nov 7, 2019 at 2:05 PM Vignesh Raghavendra <vigneshr@ti.com> wrote:
>>> @@ -272,6 +273,11 @@ static ssize_t mtk_nor_read(struct spi_nor *nor, loff_t from, size_t length,
>>>       mtk_nor_set_read_mode(mtk_nor);
>>>       mtk_nor_set_addr(mtk_nor, addr);
>>>
>>> +     if (mtk_nor->flash_base) {
>>> +             memcpy_fromio(buffer, mtk_nor->flash_base + from, length);
>>> +             return length;
>>> +     }
>>> +
>>
>> Don't you need to check if access is still within valid memory mapped
>> window?
> 
> The mapped area is 256MB and I don't quite believe there will be such
> a big NOR flash.
> I'll add a check here in the next version.
>


There are 256MB (2GiB) NORs out there in market already. So, pretty
soon, 256MB window won't be big enough :)

>>
>>>       for (i = 0; i < length; i++) {
>>>               ret = mtk_nor_execute_cmd(mtk_nor, MTK_NOR_PIO_READ_CMD);
>>>               if (ret < 0)
>>> @@ -475,6 +481,11 @@ static int mtk_nor_drv_probe(struct platform_device *pdev)
>>>       if (IS_ERR(mtk_nor->base))
>>>               return PTR_ERR(mtk_nor->base);
>>>
>>> +     res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>>> +     mtk_nor->flash_base = devm_ioremap_resource(&pdev->dev, res);
>>
>> There is a single API now: devm_platform_ioremap_resource().
> 
> Cool. I'll change it.
> Should I add another patch to change the same mapping operation right
> above this piece of code?
> 

That would be nice to do too, please send a separate patch.

-- 
Regards
Vignesh
