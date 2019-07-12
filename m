Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B23C742A8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 04:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE38C2064B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 04:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vN1vs52G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbfGLEwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 00:52:30 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:59050 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfGLEw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 00:52:29 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x6C4q034077767;
        Thu, 11 Jul 2019 23:52:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1562907120;
        bh=/zwfLA/aP4uvUzim1nRtJcVVP6jnOalIb4INZTWdV9c=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=vN1vs52GkKEgvfv7yQ7vcysw/2VTq69Hque/iNAvbfkUWsi+xuFC4Sacptoc2PDWc
         OdJo2kS/1EZ2oJEclOb6Z7PcZ2dUXfvF9MJnvfPg3yoS9OSGDL3K6W2/axmWZCj87E
         b0Ff8Q4WX7dQklyOBxYlIiiGbxk82EuyecqYvbvw=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x6C4q03W020067
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Jul 2019 23:52:00 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 11
 Jul 2019 23:52:00 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 11 Jul 2019 23:52:00 -0500
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x6C4pu2t043488;
        Thu, 11 Jul 2019 23:51:57 -0500
Subject: Re: [PATCH v8 3/5] mtd: Add support for HyperBus memory devices
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        <devicetree@vger.kernel.org>, Mason Yang <masonccyang@mxic.com.tw>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tokunori Ikegami <ikegami.t@gmail.com>
References: <20190625075746.10439-1-vigneshr@ti.com>
 <20190625075746.10439-4-vigneshr@ti.com>
 <e5a7866d-bc34-887d-31d3-de4f745c8d65@cogentembedded.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <54c7ff30-ca8b-cf75-3914-cd5cad33c323@ti.com>
Date:   Fri, 12 Jul 2019 10:22:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <e5a7866d-bc34-887d-31d3-de4f745c8d65@cogentembedded.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/07/19 12:56 AM, Sergei Shtylyov wrote:
> Hello!
> 
> On 06/25/2019 10:57 AM, Vignesh Raghavendra wrote:
> 
>> Cypress' HyperBus is Low Signal Count, High Performance Double Data Rate
>> Bus interface between a host system master and one or more slave
>> interfaces. HyperBus is used to connect microprocessor, microcontroller,
>> or ASIC devices with random access NOR flash memory (called HyperFlash)
>> or self refresh DRAM (called HyperRAM).
>>
>> Its a 8-bit data bus (DQ[7:0]) with  Read-Write Data Strobe (RWDS)
>> signal and either Single-ended clock(3.0V parts) or Differential clock
>> (1.8V parts). It uses ChipSelect lines to select b/w multiple slaves.
>> At bus level, it follows a separate protocol described in HyperBus
>> specification[1].
>>
>> HyperFlash follows CFI AMD/Fujitsu Extended Command Set (0x0002) similar
>> to that of existing parallel NORs. Since HyperBus is x8 DDR bus,
>> its equivalent to x16 parallel NOR flash with respect to bits per clock
>> cycle. But HyperBus operates at >166MHz frequencies.
>> HyperRAM provides direct random read/write access to flash memory
>> array.
>>
>> But, HyperBus memory controllers seem to abstract implementation details
>> and expose a simple MMIO interface to access connected flash.
>>
>> Add support for registering HyperFlash devices with MTD framework. MTD
>> maps framework along with CFI chip support framework are used to support
>> communicating with flash.
>>
>> Framework is modelled along the lines of spi-nor framework. HyperBus
>> memory controller (HBMC) drivers calls hyperbus_register_device() to
>> register a single HyperFlash device. HyperFlash core parses MMIO access
>> information from DT, sets up the map_info struct, probes CFI flash and
>> registers it with MTD framework.
>>
>> Some HBMC masters need calibration/training sequence[3] to be carried
>> out, in order for DLL inside the controller to lock, by reading a known
>> string/pattern. This is done by repeatedly reading CFI Query
>> Identification String. Calibration needs to be done before trying to detect
>> flash as part of CFI flash probe.
>>
>> HyperRAM is not supported at the moment.
>>
>> HyperBus specification can be found at[1]
>> HyperFlash datasheet can be found at[2]
>>
>> [1] https://www.cypress.com/file/213356/download
>> [2] https://www.cypress.com/file/213346/download
>> [3] http://www.ti.com/lit/ug/spruid7b/spruid7b.pdf
>>     Table 12-5741. HyperFlash Access Sequence
>>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> [...]
> 
>> diff --git a/drivers/mtd/hyperbus/hyperbus-core.c b/drivers/mtd/hyperbus/hyperbus-core.c
>> new file mode 100644
>> index 000000000000..63a9e64895bc
>> --- /dev/null
>> +++ b/drivers/mtd/hyperbus/hyperbus-core.c
>> @@ -0,0 +1,154 @@
> [...]
>> +int hyperbus_register_device(struct hyperbus_device *hbdev)
>> +{
> [...]
>> +	map->name = dev_name(dev);
>> +	map->bankwidth = 2;
> 
>    I think this should really be 1, judging on the comment to that field (and on
> Cogent's own RPC-IF HF driver).
> 

I agree this setting is a bit confusing because DDR nature. What we have
with HyperFlash in DDR mode is equivalent to 16bit flash on a 8bit bus
and kind of equal to 2 bus cycles (in this case clock edges), therefore
bandwidth would turn out to be 2. Otherwise cfi_build_cmd() would
generate wrong addresses and simple map implmention of read/writes would
use wrong accessors.
Only way I see map->bankwidth = 1 working is if HF is used in SDR mode.
So is Cogent's HF in SDR mode? I thought HyperFlash is DDR only but I
may be wrong.

>> +	map->device_node = np;
> 
> [...]
> 
> MBR, Sergei
> 

-- 
Regards
Vignesh
