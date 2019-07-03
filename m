Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243E1C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 18:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B6321882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 18:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="EbX/sgax"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfGCSOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 14:14:06 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45036 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfGCSOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 14:14:06 -0400
Received: by mail-lj1-f195.google.com with SMTP id k18so3442631ljc.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 11:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Chz7KpzfDvb4cnBPbwvegn1AV1XaBRdzu8IfAxBfQ5I=;
        b=EbX/sgaxxHFwsU8r1WEvx2OotnABVYExtQp10LvIyCVm9iETlGlR0qTT/HGyH4ncpI
         dsfpLRJ4yceh680j4RwwUkSvmS+FUTReqoSu8asLR3dTcJtGaT1Im4/p060H9dj7FZLf
         DTxBgsrXJ35tib7SreK4cIC0eJcI4vNdDroQnYoSiSllACf1Appfu5TuhnRPE6sU8Hn1
         HABwqoVCDdsOKcWWZJqxJC1q0QKulmoxO7nuuKcH11gVvjuHSH8z6ZtrmKfvzTkPu5s6
         WJ1st9bKhy0Yqtzx+khfGOGRRrcVDfN/Tp0BMnW5GdZ9FQ5piRaJyinPh7gWRrb+yXOK
         C7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Chz7KpzfDvb4cnBPbwvegn1AV1XaBRdzu8IfAxBfQ5I=;
        b=KDZEb/aiYW3UWvjAsko1LEMJZCllHPL0H9M2iR7LqW87jiIfA6cHoxDt5fUgsw18QA
         sr3zKa3sm1r/lLTqpVY/yyXro49mv1KTzJ2b3RtrbshaKnC9dj1ZnzCjhERa9N6ozE5m
         1Lkgrdw80jXJjpns+h6xwjRQh3LIYhMY12Uc8BGwIPvojWanTLMTRwlZcjOikWhuzSA0
         7UClV8hp31EM44pDcvlNvjQcEIByKzFJ7XPyNU/68L20gjCxcnargx/hL3jobhE/7sDV
         NP0Yvmb10dyTGFcpfPFeC30gn1AI1DI+Hry5fIlkLrUxlsP6sqMhqTI+ZI+zjJpdm9/t
         lCRg==
X-Gm-Message-State: APjAAAXpnmXLEWaCzVC4hRDlKVtmKcFWhJvsjj6jKukckp4gSLFYfHVn
        gbdPR6K1UK9w7ZmN3cYVYIbgcg==
X-Google-Smtp-Source: APXvYqyCTmvLLhwVshn+D5oXeVY+RnKmA+Y7RMGMyZofLc+vtv0Lv16PyM/ltRfxdVX7UHnCc08LNg==
X-Received: by 2002:a2e:9213:: with SMTP id k19mr22028028ljg.237.1562177644239;
        Wed, 03 Jul 2019 11:14:04 -0700 (PDT)
Received: from wasted.cogentembedded.com ([2a00:1fa0:4463:651e:e5a9:49e2:7053:81e9])
        by smtp.gmail.com with ESMTPSA id o11sm496196lfl.15.2019.07.03.11.14.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 11:14:03 -0700 (PDT)
Subject: Re: [PATCH v8 3/5] mtd: Add support for HyperBus memory devices
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        devicetree@vger.kernel.org, Mason Yang <masonccyang@mxic.com.tw>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tokunori Ikegami <ikegami.t@gmail.com>
References: <20190625075746.10439-1-vigneshr@ti.com>
 <20190625075746.10439-4-vigneshr@ti.com>
 <31657fd1-c1c9-7672-14c1-e6f67eee6ac1@cogentembedded.com>
 <5009c418-a051-a42a-f78a-360f7230dd2b@ti.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <8e870356-90ba-4762-b1fd-8a13ce6ebcc8@cogentembedded.com>
Date:   Wed, 3 Jul 2019 21:14:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <5009c418-a051-a42a-f78a-360f7230dd2b@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 07/03/2019 07:41 AM, Vignesh Raghavendra wrote:

>>> Cypress' HyperBus is Low Signal Count, High Performance Double Data Rate
>>> Bus interface between a host system master and one or more slave
>>> interfaces. HyperBus is used to connect microprocessor, microcontroller,
>>> or ASIC devices with random access NOR flash memory (called HyperFlash)
>>> or self refresh DRAM (called HyperRAM).
>>>
>>> Its a 8-bit data bus (DQ[7:0]) with  Read-Write Data Strobe (RWDS)
>>> signal and either Single-ended clock(3.0V parts) or Differential clock
>>> (1.8V parts). It uses ChipSelect lines to select b/w multiple slaves.
>>> At bus level, it follows a separate protocol described in HyperBus
>>> specification[1].
>>>
>>> HyperFlash follows CFI AMD/Fujitsu Extended Command Set (0x0002) similar
>>> to that of existing parallel NORs. Since HyperBus is x8 DDR bus,
>>> its equivalent to x16 parallel NOR flash with respect to bits per clock
>>> cycle. But HyperBus operates at >166MHz frequencies.
>>> HyperRAM provides direct random read/write access to flash memory
>>> array.
>>>
>>> But, HyperBus memory controllers seem to abstract implementation details
>>> and expose a simple MMIO interface to access connected flash.
>>>
>>> Add support for registering HyperFlash devices with MTD framework. MTD
>>> maps framework along with CFI chip support framework are used to support
>>> communicating with flash.
>>>
>>> Framework is modelled along the lines of spi-nor framework. HyperBus
>>> memory controller (HBMC) drivers calls hyperbus_register_device() to
>>> register a single HyperFlash device. HyperFlash core parses MMIO access
>>> information from DT, sets up the map_info struct, probes CFI flash and
>>> registers it with MTD framework.
>>>
>>> Some HBMC masters need calibration/training sequence[3] to be carried
>>> out, in order for DLL inside the controller to lock, by reading a known
>>> string/pattern. This is done by repeatedly reading CFI Query
>>> Identification String. Calibration needs to be done before trying to detect
>>> flash as part of CFI flash probe.
>>>
>>> HyperRAM is not supported at the moment.
>>>
>>> HyperBus specification can be found at[1]
>>> HyperFlash datasheet can be found at[2]
>>>
>>> [1] https://www.cypress.com/file/213356/download
>>> [2] https://www.cypress.com/file/213346/download
>>> [3] http://www.ti.com/lit/ug/spruid7b/spruid7b.pdf
>>>     Table 12-5741. HyperFlash Access Sequence
>>>
>>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> [...]
>>
>>    I have at least created my HyperBus driver and unfortunately I'm having serious

   At last. :-)

>> issues with the design of the support core (see below)...
>>
>> [...]
>>> diff --git a/drivers/mtd/hyperbus/hyperbus-core.c b/drivers/mtd/hyperbus/hyperbus-core.c
>>> new file mode 100644
>>> index 000000000000..63a9e64895bc
>>> --- /dev/null
>>> +++ b/drivers/mtd/hyperbus/hyperbus-core.c
>>> @@ -0,0 +1,154 @@
>> [...]
>>> +int hyperbus_register_device(struct hyperbus_device *hbdev)
>>> +{
>>> +	const struct hyperbus_ops *ops;
>>> +	struct hyperbus_ctlr *ctlr;
>>> +	struct device_node *np;
>>> +	struct map_info *map;
>>> +	struct resource res;
>>> +	struct device *dev;
>>> +	int ret;
>>> +
>>> +	if (!hbdev || !hbdev->np || !hbdev->ctlr || !hbdev->ctlr->dev) {
>>> +		pr_err("hyperbus: please fill all the necessary fields!\n");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	np = hbdev->np;
>>> +	ctlr = hbdev->ctlr;
>>> +	if (!of_device_is_compatible(np, "cypress,hyperflash"))
>>> +		return -ENODEV;
>>> +
>>> +	hbdev->memtype = HYPERFLASH;
>>> +
>>> +	ret = of_address_to_resource(np, 0, &res);
>>
>>    Hm, I doubt that the HB devices are wholly mapped into memory space, that seems
>> like a property of the HB controller. In my case, the flash device in the DT has
>> only single-cell "reg" prop (equal to the chip select #). Then this function returns 
>> -EINVAL and the registration fails. Also, in my case such mapping is R/O, not R/W.
>>
> 
> You could declare R/O MMIO region in controla and set up a translation using ranges
> from slave's reg CS based reg mapping like:

   No, not all HB controllers work the same (simple) way as yours. In case of RPC-IF,
the direct read map is a 64 MiB window into a possibly larger flash chip, it has a
register supplying address bits 25:31...

> +	hbmc: hyperbus@47034000 {
> +		compatible = "ti,am654-hbmc";
> +		reg = <0x0 0x47034000 0x0 0x100>,
> +			<0x5 0x00000000 0x1 0x0000000>;
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		ranges = <0x0 0x0 0x5 0x00000000 0x4000000>, /* CS0 - 64MB */
> +			 <0x1 0x0 0x5 0x04000000 0x4000000>; /* CS1 - 64MB */
> +
> +		/* Slave flash node */
> +		flash@0,0 {
> +			compatible = "cypress,hyperflash", "cfi-flash";
> +			reg = <0x0 0x0 0x4000000>;
> +		};
> +	};
> 
> If you use just CS# how would you handle CS to MMIO region mapping? 
> Does both CS use the same MMIO base for reads?

   The RPC-IF HF mode only has a single CS signal.

[...]

MBR, Sergei
