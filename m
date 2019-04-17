Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFAAC10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 06:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF2922173C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 06:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mEuO7uEl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730832AbfDQGmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 02:42:33 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:45358 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfDQGmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 02:42:33 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3H6fmWr129340;
        Wed, 17 Apr 2019 01:41:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555483308;
        bh=CX9Mf15Q/kbm2U2c86PfEHE3UxyfDhg/x1yJYZHq8IE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=mEuO7uElMsrcedYvrbIoLcsrVX3dxJLNsG5L00nZt3KlFG++VD7IW/kXwJhJDM47M
         ulUnSp6oiE6TLtloSKFfLq6U/GI/Q6Y1U4OtadzdQuCZhl0X3TQRsvvYJpQWkVpr8k
         W/Z99KaBx5qSxevNz//aSrExAjAPqc49acOgGPjw=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3H6fm87010190
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 17 Apr 2019 01:41:48 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 17
 Apr 2019 01:41:47 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 17 Apr 2019 01:41:47 -0500
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3H6fg96060951;
        Wed, 17 Apr 2019 01:41:43 -0500
Subject: Re: [PATCH v3 3/5] mtd: Add support for HyperBus memory devices
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-mtd@lists.infradead.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        <devicetree@vger.kernel.org>, Mason Yang <masonccyang@mxic.com.tw>,
        <linux-arm-kernel@lists.infradead.org>, <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>
References: <20190412092923.24919-1-vigneshr@ti.com>
 <20190412092923.24919-4-vigneshr@ti.com>
 <53a92396-2535-ace7-3a31-1daf719ff323@cogentembedded.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <f4ca7582-bfec-06fc-0b1c-e1eaad6ecebf@ti.com>
Date:   Wed, 17 Apr 2019 12:12:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <53a92396-2535-ace7-3a31-1daf719ff323@cogentembedded.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 14/04/19 11:21 PM, Sergei Shtylyov wrote:
> Hello!
> 
> On 04/12/2019 12:29 PM, Vignesh Raghavendra wrote:
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
>> its equivalent to x16 parallel NOR flash wrt bits per clock cycle. But
>> HyperBus operates at >166MHz frequencies.
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
>> diff --git a/drivers/mtd/hyperbus/Kconfig b/drivers/mtd/hyperbus/Kconfig
>> new file mode 100644
>> index 000000000000..98147e28caa0
>> --- /dev/null
>> +++ b/drivers/mtd/hyperbus/Kconfig
>> @@ -0,0 +1,11 @@
>> +menuconfig MTD_HYPERBUS
>> +	tristate "HyperBus support"
>> +	select MTD_CFI
>> +	select MTD_MAP_BANK_WIDTH_2
>> +	select MTD_CFI_AMDSTD
>> +	select MTD_COMPLEX_MAPPINGS
>> +	help
>> +	  This is the framework for the HyperBus which can be used by
>> +	  the HyperBus Controller driver to communicate with
>> +	  HyperFlash. See Cypress HyperBus specification for more
>> +	  details
>> diff --git a/drivers/mtd/hyperbus/Makefile b/drivers/mtd/hyperbus/Makefile
>> new file mode 100644
>> index 000000000000..ca61dedd730d
>> --- /dev/null
>> +++ b/drivers/mtd/hyperbus/Makefile
>> @@ -0,0 +1,3 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +obj-$(CONFIG_MTD_HYPERBUS)	+= hyperbus-core.o
>> diff --git a/drivers/mtd/hyperbus/hyperbus-core.c b/drivers/mtd/hyperbus/hyperbus-core.c
>> new file mode 100644
>> index 000000000000..49aeb59742c6
>> --- /dev/null
>> +++ b/drivers/mtd/hyperbus/hyperbus-core.c
>> @@ -0,0 +1,192 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +//
>> +// Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
>> +// Author: Vignesh Raghavendra <vigneshr@ti.com>
> [...]
>> +/* Default calibration routine for use by HyperBus controller.
>> + * Controller is calibrated by repeatedly reading known pattern ("QRY"
>> + * string from CFI space)
>> + * Lets ensure "QRY" string is read correctly at least 5 times to ensure
>> + * stability of the DLL lock.
>> + */
>> +int hyperbus_calibrate(struct hyperbus_device *hbdev)
>> +{
>> +	struct map_info *map = &hbdev->map;
>> +	struct cfi_private cfi;
>> +	int count = HYPERBUS_CALIB_COUNT;
>> +	int pass_count = 0;
>> +	int ret;
>> +
>> +	cfi.interleave = 1;
>> +	cfi.device_type = CFI_DEVICETYPE_X16;
>> +	cfi_send_gen_cmd(0xF0, 0, 0, map, &cfi, cfi.device_type, NULL);
>> +	cfi_send_gen_cmd(0x98, 0x55, 0, map, &cfi, cfi.device_type, NULL);
>> +
>> +	while (count--) {
>> +		cfi_qry_present(map, 0, &cfi);
>> +		ret = cfi_qry_present(map, 0, &cfi);
> 
>    Why call it twice in a row?
> 

Oops, will fix in v2

>> +		if (ret)
>> +			pass_count++;
>> +		else
>> +			pass_count = 0;
>> +		if (pass_count == 5)
>> +			break;
>> +	}
>> +
>> +	cfi_qry_mode_off(0, map, &cfi);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(hyperbus_calibrate);
> [...]
>> diff --git a/include/linux/mtd/hyperbus.h b/include/linux/mtd/hyperbus.h
>> new file mode 100644
>> index 000000000000..19340cc56aa4
>> --- /dev/null
>> +++ b/include/linux/mtd/hyperbus.h
>> @@ -0,0 +1,91 @@
> [...]
>> +/**
>> + * hb_unregister_device - deregister HyperBus slave memory device
> 
>    You forgot to update the function name in the kernel-doc. :-)
> 

Indeed, thanks for catching this!

>> + * @hbdev: hyperbus_device to be unregistered
>> + *
>> + * Return: 0 for success, others for failure.
>> + */
>> +int hyperbus_unregister_device(struct hyperbus_device *hbdev);
>> +
>> +#endif /* __LINUX_MTD_HYPERBUS_H__ */
> 
> MBR, Sergei
> 

-- 
Regards
Vignesh
