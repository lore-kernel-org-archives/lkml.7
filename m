Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882EBC10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 17:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F0F220850
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 17:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="Sdjw4js9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfDNRvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 13:51:47 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35412 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfDNRvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 13:51:46 -0400
Received: by mail-lj1-f195.google.com with SMTP id t4so4942604ljc.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 10:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wDNbZFDfSFvMJbXwJGZWBP1FDY9RU5MYw0B/pPJFyO0=;
        b=Sdjw4js9kmZSBFAG+UQLVlJZJkpwtmFwxNY4QmvRZNZNewfETQxj8U3l4vSuo4Rr+M
         CPoLwCNW1piJq3tiQuSk6kmEsctA7L5w4eLtXXW240sQYuGkGBpcpPhWpQagS+14i2ZD
         po3TKPou6mDg64FZDp5beAQ4UVFBbRYC2d9+LSieBbJETXgUvvkpPX7nG8701k+aNm5x
         dGbkkfFyIwePxvwyKdd7btdbAPy3EfeG3QnNH+LHNcUH34j0KtlopLMR1ykOrcmO3GwP
         wEnzPOWeqhKrms2E6/VStkS18TcTvjttpT8dJkd032fEfq+pDhQzFIHJjHKkbHfWvsGU
         Btrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=wDNbZFDfSFvMJbXwJGZWBP1FDY9RU5MYw0B/pPJFyO0=;
        b=VwMT5KmNEkpUTY7VkpvC+z/pvwquQxgihMgEw3NYRVVcCM8+SLYHO5fw4XJ0qjtmic
         9Ao7PVMFySGez3OyxATaQ7ce1LE5VtYegKUfADedzYj6Yo15Mo+XjD/ob1gIyAVWakx6
         5yoFPbqK+8YdWcuwsKiaWjDb3COJvXZti0YeiY5AiShwy+lza5O10Fm0aCJnW5q1RUgH
         mVWs9L2nBy+spZEoqhdSIaCQhlsKKFwA1TkeqgR2VzWsVZwoARaDgp55J2TTZZX7jZWS
         shaFQs/+q/u1J+G6zu71ZY0Dz1AwSmDFf1a8ve1pzmiK1K0upwlEaxg7NvOKW4xNZIQs
         4TGw==
X-Gm-Message-State: APjAAAXiFfEdxIwKCwvT6CZQkmGRA18rXmNqE4D0p8fllj7aXpgz3i+C
        5an7K701WqJAEuX/aMnPyaP7bBQiZJw=
X-Google-Smtp-Source: APXvYqx3R7LxyfpMUiIghvwGgEAAYM7RH/OvrfwCicN56t9hKHm34CxmmG8+DDut7lMASCdrqnJ4rQ==
X-Received: by 2002:a2e:9194:: with SMTP id f20mr37118089ljg.10.1555264303718;
        Sun, 14 Apr 2019 10:51:43 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.85.5])
        by smtp.gmail.com with ESMTPSA id r19sm8644245lja.83.2019.04.14.10.51.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Apr 2019 10:51:42 -0700 (PDT)
Subject: Re: [PATCH v3 3/5] mtd: Add support for HyperBus memory devices
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-mtd@lists.infradead.org,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        devicetree@vger.kernel.org, Mason Yang <masonccyang@mxic.com.tw>,
        linux-arm-kernel@lists.infradead.org, nsekhar@ti.com,
        linux-kernel@vger.kernel.org
References: <20190412092923.24919-1-vigneshr@ti.com>
 <20190412092923.24919-4-vigneshr@ti.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <53a92396-2535-ace7-3a31-1daf719ff323@cogentembedded.com>
Date:   Sun, 14 Apr 2019 20:51:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190412092923.24919-4-vigneshr@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 04/12/2019 12:29 PM, Vignesh Raghavendra wrote:

> Cypress' HyperBus is Low Signal Count, High Performance Double Data Rate
> Bus interface between a host system master and one or more slave
> interfaces. HyperBus is used to connect microprocessor, microcontroller,
> or ASIC devices with random access NOR flash memory (called HyperFlash)
> or self refresh DRAM (called HyperRAM).
> 
> Its a 8-bit data bus (DQ[7:0]) with  Read-Write Data Strobe (RWDS)
> signal and either Single-ended clock(3.0V parts) or Differential clock
> (1.8V parts). It uses ChipSelect lines to select b/w multiple slaves.
> At bus level, it follows a separate protocol described in HyperBus
> specification[1].
> 
> HyperFlash follows CFI AMD/Fujitsu Extended Command Set (0x0002) similar
> to that of existing parallel NORs. Since HyperBus is x8 DDR bus,
> its equivalent to x16 parallel NOR flash wrt bits per clock cycle. But
> HyperBus operates at >166MHz frequencies.
> HyperRAM provides direct random read/write access to flash memory
> array.
> 
> But, HyperBus memory controllers seem to abstract implementation details
> and expose a simple MMIO interface to access connected flash.
> 
> Add support for registering HyperFlash devices with MTD framework. MTD
> maps framework along with CFI chip support framework are used to support
> communicating with flash.
> 
> Framework is modelled along the lines of spi-nor framework. HyperBus
> memory controller (HBMC) drivers calls hyperbus_register_device() to
> register a single HyperFlash device. HyperFlash core parses MMIO access
> information from DT, sets up the map_info struct, probes CFI flash and
> registers it with MTD framework.
> 
> Some HBMC masters need calibration/training sequence[3] to be carried
> out, in order for DLL inside the controller to lock, by reading a known
> string/pattern. This is done by repeatedly reading CFI Query
> Identification String. Calibration needs to be done before trying to detect
> flash as part of CFI flash probe.
> 
> HyperRAM is not supported at the moment.
> 
> HyperBus specification can be found at[1]
> HyperFlash datasheet can be found at[2]
> 
> [1] https://www.cypress.com/file/213356/download
> [2] https://www.cypress.com/file/213346/download
> [3] http://www.ti.com/lit/ug/spruid7b/spruid7b.pdf
>     Table 12-5741. HyperFlash Access Sequence
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
[...]
> diff --git a/drivers/mtd/hyperbus/Kconfig b/drivers/mtd/hyperbus/Kconfig
> new file mode 100644
> index 000000000000..98147e28caa0
> --- /dev/null
> +++ b/drivers/mtd/hyperbus/Kconfig
> @@ -0,0 +1,11 @@
> +menuconfig MTD_HYPERBUS
> +	tristate "HyperBus support"
> +	select MTD_CFI
> +	select MTD_MAP_BANK_WIDTH_2
> +	select MTD_CFI_AMDSTD
> +	select MTD_COMPLEX_MAPPINGS
> +	help
> +	  This is the framework for the HyperBus which can be used by
> +	  the HyperBus Controller driver to communicate with
> +	  HyperFlash. See Cypress HyperBus specification for more
> +	  details
> diff --git a/drivers/mtd/hyperbus/Makefile b/drivers/mtd/hyperbus/Makefile
> new file mode 100644
> index 000000000000..ca61dedd730d
> --- /dev/null
> +++ b/drivers/mtd/hyperbus/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_MTD_HYPERBUS)	+= hyperbus-core.o
> diff --git a/drivers/mtd/hyperbus/hyperbus-core.c b/drivers/mtd/hyperbus/hyperbus-core.c
> new file mode 100644
> index 000000000000..49aeb59742c6
> --- /dev/null
> +++ b/drivers/mtd/hyperbus/hyperbus-core.c
> @@ -0,0 +1,192 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
> +// Author: Vignesh Raghavendra <vigneshr@ti.com>
[...]
> +/* Default calibration routine for use by HyperBus controller.
> + * Controller is calibrated by repeatedly reading known pattern ("QRY"
> + * string from CFI space)
> + * Lets ensure "QRY" string is read correctly at least 5 times to ensure
> + * stability of the DLL lock.
> + */
> +int hyperbus_calibrate(struct hyperbus_device *hbdev)
> +{
> +	struct map_info *map = &hbdev->map;
> +	struct cfi_private cfi;
> +	int count = HYPERBUS_CALIB_COUNT;
> +	int pass_count = 0;
> +	int ret;
> +
> +	cfi.interleave = 1;
> +	cfi.device_type = CFI_DEVICETYPE_X16;
> +	cfi_send_gen_cmd(0xF0, 0, 0, map, &cfi, cfi.device_type, NULL);
> +	cfi_send_gen_cmd(0x98, 0x55, 0, map, &cfi, cfi.device_type, NULL);
> +
> +	while (count--) {
> +		cfi_qry_present(map, 0, &cfi);
> +		ret = cfi_qry_present(map, 0, &cfi);

   Why call it twice in a row?

> +		if (ret)
> +			pass_count++;
> +		else
> +			pass_count = 0;
> +		if (pass_count == 5)
> +			break;
> +	}
> +
> +	cfi_qry_mode_off(0, map, &cfi);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(hyperbus_calibrate);
[...]
> diff --git a/include/linux/mtd/hyperbus.h b/include/linux/mtd/hyperbus.h
> new file mode 100644
> index 000000000000..19340cc56aa4
> --- /dev/null
> +++ b/include/linux/mtd/hyperbus.h
> @@ -0,0 +1,91 @@
[...]
> +/**
> + * hb_unregister_device - deregister HyperBus slave memory device

   You forgot to update the function name in the kernel-doc. :-)

> + * @hbdev: hyperbus_device to be unregistered
> + *
> + * Return: 0 for success, others for failure.
> + */
> +int hyperbus_unregister_device(struct hyperbus_device *hbdev);
> +
> +#endif /* __LINUX_MTD_HYPERBUS_H__ */

MBR, Sergei
