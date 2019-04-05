Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68077C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 06:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34E28217D7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 06:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="G4gTunPO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbfDEGOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 02:14:45 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44788 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbfDEGOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 02:14:45 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x356ES2T115697;
        Fri, 5 Apr 2019 01:14:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554444868;
        bh=LTj1LetO+c5ltGBCKoLceIiy8U7vi1ZyaaYq75+Q6bg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=G4gTunPOk0Dk47B3adUXlQ0wNxriMaTO8uEnb8yKXFg1rN5WpLYSJ1xclfBR+08ZV
         xAUkfVuxIGBdDL51wc7uL+RJWajWGgbPZA63baNoLQ9WtGhoqTbQM9ZWV9OcZkM5+W
         Q2c0mpLx72qAyn9ORYg40YYUSdHmYJVtfeex4myY=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x356ES3E091615
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Apr 2019 01:14:28 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 5 Apr
 2019 01:14:28 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 5 Apr 2019 01:14:28 -0500
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x356EOtc109639;
        Fri, 5 Apr 2019 01:14:25 -0500
Subject: Re: [LINUX PATCH v2 3/3] spi: spi-mem: Add support for Zynq QSPI
 controller
To:     Naga Sureshkumar Relli <nagasure@xilinx.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "nagasuresh12@gmail.com" <nagasuresh12@gmail.com>
References: <1554105553-20207-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <c8f73eab-99eb-ddbc-9776-ea6b3a3ecf0f@ti.com>
 <MWHPR02MB2623EDDF4207C7CA8F97B5D4AF510@MWHPR02MB2623.namprd02.prod.outlook.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <1fd37417-eaa6-834e-8b0b-a2519cfc4979@ti.com>
Date:   Fri, 5 Apr 2019 11:45:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <MWHPR02MB2623EDDF4207C7CA8F97B5D4AF510@MWHPR02MB2623.namprd02.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/04/19 10:55 AM, Naga Sureshkumar Relli wrote:
> Hi Vignesh,
> 
> Thanks for the review.
> 
>> -----Original Message-----
>> From: Vignesh Raghavendra <vigneshr@ti.com>
>> Sent: Friday, April 5, 2019 10:14 AM
>> To: Naga Sureshkumar Relli <nagasure@xilinx.com>; broonie@kernel.org;
>> bbrezillon@kernel.org
>> Cc: linux-spi@vger.kernel.org; dwmw2@infradead.org; marek.vasut@gmail.com;
>> richard@nod.at; linux-mtd@lists.infradead.org; linux-kernel@vger.kernel.org; Michal Simek
>> <michals@xilinx.com>; nagasuresh12@gmail.com
>> Subject: Re: [LINUX PATCH v2 3/3] spi: spi-mem: Add support for Zynq QSPI controller
>>
>>
>>
>> On 01/04/19 1:29 PM, Naga Sureshkumar Relli wrote:
>>> +/**
>>> + * zynq_qspi_config_op - Configure QSPI controller for specified transfer
>>> + * @xqspi:	Pointer to the zynq_qspi structure
>>> + * @qspi:	Pointer to the spi_device structure
>>> + *
>>> + * Sets the operational mode of QSPI controller for the next QSPI
>>> +transfer and
>>> + * sets the requested clock frequency.
>>> + *
>>> + * Return:	0 on success and -EINVAL on invalid input parameter
>>> + *
>>> + * Note: If the requested frequency is not an exact match with what
>>> +can be
>>> + * obtained using the prescalar value, the driver sets the clock
>>> +frequency which
>>> + * is lower than the requested frequency (maximum lower) for the
>>> +transfer. If
>>> + * the requested frequency is higher or lower than that is supported
>>> +by the QSPI
>>> + * controller the driver will set the highest or lowest frequency
>>> +supported by
>>> + * controller.
>>> + */
>>> +static int zynq_qspi_config_op(struct zynq_qspi *xqspi, struct
>>> +spi_device *spi) {
>>> +	u32 config_reg, baud_rate_val = 0;
>>> +
>>> +	/*
>>> +	 * Set the clock frequency
>>> +	 * The baud rate divisor is not a direct mapping to the value written
>>> +	 * into the configuration register (config_reg[5:3])
>>> +	 * i.e. 000 - divide by 2
>>> +	 *      001 - divide by 4
>>> +	 *      ----------------
>>> +	 *      111 - divide by 256
>>> +	 */
>>> +	while ((baud_rate_val < ZYNQ_QSPI_BAUD_DIV_MAX)  &&
>>> +	       (clk_get_rate(xqspi->refclk) / (2 << baud_rate_val)) >
>>> +		spi->max_speed_hz)
>>> +		baud_rate_val++;
>>> +
>>
>> Instead use DIV_ROUND_UP, something like below should work(untested):
>>
>> 	unsigned long refclk_rate = clk_get_rate(xqspi->refclk);
>> 	u32 baud_rate_val = DIV_ROUND_UP(refclk_rate, spi->max_speed_hz) - 1;
>>

Oops, sorry, I had meant

	u32 baud_rate_val = DIV_ROUND_UP(refclk_rate, 2 * spi->max_speed_hz) - 1;

But please ignore my comment, I see that div values goes by power of 2 and not multiple of 2

Regards
Vignesh

> This is not just direct calculation.
> i.e. for example
> refclk_rate = 200MHz and max_speed_hx = 100MHz.
> then DIV_ROUND_UP gives a value of 2.
> But writing a value of 2 to config registers means, divide by 8. But we should write divide by 2 (value of zero).
> That’s why we implemented the above calculation.
> 
> 000: divide by 2.
> 001: divide by 4
> 010: divide by 8
> 011: divide by 16
> 100: divide by 32
> 101: divide by 64
> 110: divide by 128
> 111: divide by 256
> 



-- 
Regards
Vignesh
