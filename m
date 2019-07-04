Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81F7C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 18:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70A7C21670
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 18:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RiGaM3sZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfGDSga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 14:36:30 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:54826 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfGDSg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 14:36:29 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x64Ia5PO086916;
        Thu, 4 Jul 2019 13:36:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1562265365;
        bh=4JPL9pnm+iB2iTUZQC/vFrSNpJCZTCAhwh/sCW9W0hg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=RiGaM3sZYABJcMlEOQsoFKMXW95tlVPvdN9xHnN3UWdFVEiueQnnJMoFd+jd87Tj7
         KBQQ3EjQwQD46s54gHhKfLow4caRNZZDTSXqdDjvaCNP4RqOfB/OMRWbu+mlTEFI4M
         bWU0Tfg37Z2drLzHzo5m4xnA6TOUQHBqFm2tBa9k=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x64Ia51u127311
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 Jul 2019 13:36:05 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 4 Jul
 2019 13:36:04 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 4 Jul 2019 13:36:04 -0500
Received: from [10.250.132.195] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x64IZwM5127168;
        Thu, 4 Jul 2019 13:35:59 -0500
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
 <31657fd1-c1c9-7672-14c1-e6f67eee6ac1@cogentembedded.com>
 <5009c418-a051-a42a-f78a-360f7230dd2b@ti.com>
 <8e870356-90ba-4762-b1fd-8a13ce6ebcc8@cogentembedded.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <45f0beda-08a6-5db7-a8f1-a63b6e879b81@ti.com>
Date:   Fri, 5 Jul 2019 00:05:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <8e870356-90ba-4762-b1fd-8a13ce6ebcc8@cogentembedded.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03-Jul-19 11:44 PM, Sergei Shtylyov wrote:
> Hello!
> 
> On 07/03/2019 07:41 AM, Vignesh Raghavendra wrote:
> 
>>>> Cypress' HyperBus is Low Signal Count, High Performance Double Data Rate
>>>> Bus interface between a host system master and one or more slave
>>>> interfaces. HyperBus is used to connect microprocessor, microcontroller,
>>>> or ASIC devices with random access NOR flash memory (called HyperFlash)
>>>> or self refresh DRAM (called HyperRAM).
>>>>
>>>> Its a 8-bit data bus (DQ[7:0]) with  Read-Write Data Strobe (RWDS)
>>>> signal and either Single-ended clock(3.0V parts) or Differential clock
>>>> (1.8V parts). It uses ChipSelect lines to select b/w multiple slaves.
>>>> At bus level, it follows a separate protocol described in HyperBus
>>>> specification[1].
>>>>
>>>> HyperFlash follows CFI AMD/Fujitsu Extended Command Set (0x0002) similar
>>>> to that of existing parallel NORs. Since HyperBus is x8 DDR bus,
>>>> its equivalent to x16 parallel NOR flash with respect to bits per clock
>>>> cycle. But HyperBus operates at >166MHz frequencies.
>>>> HyperRAM provides direct random read/write access to flash memory
>>>> array.
>>>>
>>>> But, HyperBus memory controllers seem to abstract implementation details
>>>> and expose a simple MMIO interface to access connected flash.
>>>>
>>>> Add support for registering HyperFlash devices with MTD framework. MTD
>>>> maps framework along with CFI chip support framework are used to support
>>>> communicating with flash.
>>>>
>>>> Framework is modelled along the lines of spi-nor framework. HyperBus
>>>> memory controller (HBMC) drivers calls hyperbus_register_device() to
>>>> register a single HyperFlash device. HyperFlash core parses MMIO access
>>>> information from DT, sets up the map_info struct, probes CFI flash and
>>>> registers it with MTD framework.
>>>>
>>>> Some HBMC masters need calibration/training sequence[3] to be carried
>>>> out, in order for DLL inside the controller to lock, by reading a known
>>>> string/pattern. This is done by repeatedly reading CFI Query
>>>> Identification String. Calibration needs to be done before trying to detect
>>>> flash as part of CFI flash probe.
>>>>
>>>> HyperRAM is not supported at the moment.
>>>>
>>>> HyperBus specification can be found at[1]
>>>> HyperFlash datasheet can be found at[2]
>>>>
>>>> [1] https://www.cypress.com/file/213356/download
>>>> [2] https://www.cypress.com/file/213346/download
>>>> [3] http://www.ti.com/lit/ug/spruid7b/spruid7b.pdf
>>>>     Table 12-5741. HyperFlash Access Sequence
>>>>
>>>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>>> [...]
>>>
>>>    I have at least created my HyperBus driver and unfortunately I'm having serious
> 
>    At last. :-)
> 

So, I guess driver works for limited memory size?

>>> issues with the design of the support core (see below)...
>>>
>>> [...]
>>>> diff --git a/drivers/mtd/hyperbus/hyperbus-core.c b/drivers/mtd/hyperbus/hyperbus-core.c
>>>> new file mode 100644
>>>> index 000000000000..63a9e64895bc
>>>> --- /dev/null
>>>> +++ b/drivers/mtd/hyperbus/hyperbus-core.c
>>>> @@ -0,0 +1,154 @@
>>> [...]
>>>> +int hyperbus_register_device(struct hyperbus_device *hbdev)
>>>> +{
>>>> +	const struct hyperbus_ops *ops;
>>>> +	struct hyperbus_ctlr *ctlr;
>>>> +	struct device_node *np;
>>>> +	struct map_info *map;
>>>> +	struct resource res;
>>>> +	struct device *dev;
>>>> +	int ret;
>>>> +
>>>> +	if (!hbdev || !hbdev->np || !hbdev->ctlr || !hbdev->ctlr->dev) {
>>>> +		pr_err("hyperbus: please fill all the necessary fields!\n");
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	np = hbdev->np;
>>>> +	ctlr = hbdev->ctlr;
>>>> +	if (!of_device_is_compatible(np, "cypress,hyperflash"))
>>>> +		return -ENODEV;
>>>> +
>>>> +	hbdev->memtype = HYPERFLASH;
>>>> +
>>>> +	ret = of_address_to_resource(np, 0, &res);
>>>
>>>    Hm, I doubt that the HB devices are wholly mapped into memory space, that seems
>>> like a property of the HB controller. In my case, the flash device in the DT has
>>> only single-cell "reg" prop (equal to the chip select #). Then this function returns 
>>> -EINVAL and the registration fails. Also, in my case such mapping is R/O, not R/W.
>>>
>>
>> You could declare R/O MMIO region in controla and set up a translation using ranges
>> from slave's reg CS based reg mapping like:
> 
>    No, not all HB controllers work the same (simple) way as yours. In case of RPC-IF,
> the direct read map is a 64 MiB window into a possibly larger flash chip, it has a
> register supplying address bits 25:31...

Okay, this limitation was not made clear earlier. I thought RPC-IF also
supported MMIO accesses for all reads

I will look into changes needed to support HB controllers that don't
have MMIO interface next week.

Regards
Vignesh

> 
>> +	hbmc: hyperbus@47034000 {
>> +		compatible = "ti,am654-hbmc";
>> +		reg = <0x0 0x47034000 0x0 0x100>,
>> +			<0x5 0x00000000 0x1 0x0000000>;
>> +		#address-cells = <2>;
>> +		#size-cells = <1>;
>> +		ranges = <0x0 0x0 0x5 0x00000000 0x4000000>, /* CS0 - 64MB */
>> +			 <0x1 0x0 0x5 0x04000000 0x4000000>; /* CS1 - 64MB */
>> +
>> +		/* Slave flash node */
>> +		flash@0,0 {
>> +			compatible = "cypress,hyperflash", "cfi-flash";
>> +			reg = <0x0 0x0 0x4000000>;
>> +		};
>> +	};
>>
>> If you use just CS# how would you handle CS to MMIO region mapping? 
>> Does both CS use the same MMIO base for reads?
> 
>    The RPC-IF HF mode only has a single CS signal.
> 

I see...

> [...]
> 
> MBR, Sergei
> 

Regards
Vignesh
