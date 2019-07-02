Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8D0C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 17:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FFEA2082F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 17:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="AjJ3nxm/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfGBRxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 13:53:07 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45939 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbfGBRxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 13:53:06 -0400
Received: by mail-lj1-f195.google.com with SMTP id m23so17801002lje.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 10:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:references:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cMEn3za16fAfd/FKzUgXJWhBF6QU4UvnxjnbeEXsMGQ=;
        b=AjJ3nxm/0ds+e2hRRivY37RuUEa4V59EPE1atiQr2SXEYP2cvI8PWEN+FZ9oVOntUT
         XehNOna7XdSk5ef3/jinBVRzP0Zgoq2nXWU3UGYsYB9ehUh1D+3vpTcj0OvQA+seZDU3
         JCrKct+QFMpmJzw4R3IcICYfPlRQ1z1j0MHz+N34dj9P+l1gqNZyUktAudZ07GKlOlak
         joM3F9dzbJiwS1J8pbV/0g+ni/mDtPKuRtxDgvKK6H4TmP8PVNY8odrp5u1fzRFWaBUi
         Kev+nrvUBH6P4kht+SWadQWqeUZhn9Drib2vk3mjXbi89a1I0olyW75z856NBQ1TpbAj
         6QMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=cMEn3za16fAfd/FKzUgXJWhBF6QU4UvnxjnbeEXsMGQ=;
        b=odlDmh53t2E8LDExp0YoIzVXXhmY3qdhOwH6rZI0RFFsa+2dNbX6u/edYlOuihyQQF
         mltXYF1F1Oqb3SHfeUazQjg/a+ZVqqB4J/fZZnldECR+vdPMHBqlMGFl/DRrlPBvKej1
         +43AyvVyQawvmvmQlG4hEvXzAqzu6199oEVibeIzlXonNzPMrmEp5GRuin+Pf8eCusuF
         BYBw5X584bs1Nr38HIYOFiHy6r1sfZ2Ahkx+yVXZ13fbqA3rOSgsdSRd4Oee8Kvg8BnR
         4fjMraIkfuK2BPmSegxoveoflD6GbF4JK7T5n/d79IkWaqLr1lyHaljuL6Bq/DXsyk6V
         9TCw==
X-Gm-Message-State: APjAAAWf37bfzv0WKuFW6rRXGEGz12a9AkqSiDWCh8KBUesvo2XmWl8x
        TyPFC7n3378qEGfFXwPs9xB4qg==
X-Google-Smtp-Source: APXvYqyHA/Ov/gzsKWtHLKt+DUZw1yLzTQf05oQbnhdSu9EIi9OqdKbPqDmV3siOLcwZvcf9+6nKTA==
X-Received: by 2002:a2e:93cc:: with SMTP id p12mr18387950ljh.11.1562089983427;
        Tue, 02 Jul 2019 10:53:03 -0700 (PDT)
Received: from wasted.cogentembedded.com ([2a00:1fa0:48c7:f2be:45b6:c800:b809:e0f2])
        by smtp.gmail.com with ESMTPSA id g76sm3954000lje.43.2019.07.02.10.53.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 10:53:02 -0700 (PDT)
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
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
Organization: Cogent Embedded
Message-ID: <31657fd1-c1c9-7672-14c1-e6f67eee6ac1@cogentembedded.com>
Date:   Tue, 2 Jul 2019 20:53:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190625075746.10439-4-vigneshr@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 06/25/2019 10:57 AM, Vignesh Raghavendra wrote:

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
> its equivalent to x16 parallel NOR flash with respect to bits per clock
> cycle. But HyperBus operates at >166MHz frequencies.
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

   I have at least created my HyperBus driver and unfortunately I'm having serious
issues with the design of the support core (see below)...

[...]
> diff --git a/drivers/mtd/hyperbus/hyperbus-core.c b/drivers/mtd/hyperbus/hyperbus-core.c
> new file mode 100644
> index 000000000000..63a9e64895bc
> --- /dev/null
> +++ b/drivers/mtd/hyperbus/hyperbus-core.c
> @@ -0,0 +1,154 @@
[...]
> +int hyperbus_register_device(struct hyperbus_device *hbdev)
> +{
> +	const struct hyperbus_ops *ops;
> +	struct hyperbus_ctlr *ctlr;
> +	struct device_node *np;
> +	struct map_info *map;
> +	struct resource res;
> +	struct device *dev;
> +	int ret;
> +
> +	if (!hbdev || !hbdev->np || !hbdev->ctlr || !hbdev->ctlr->dev) {
> +		pr_err("hyperbus: please fill all the necessary fields!\n");
> +		return -EINVAL;
> +	}
> +
> +	np = hbdev->np;
> +	ctlr = hbdev->ctlr;
> +	if (!of_device_is_compatible(np, "cypress,hyperflash"))
> +		return -ENODEV;
> +
> +	hbdev->memtype = HYPERFLASH;
> +
> +	ret = of_address_to_resource(np, 0, &res);

   Hm, I doubt that the HB devices are wholly mapped into memory space, that seems
like a property of the HB controller. In my case, the flash device in the DT has
only single-cell "reg" prop (equal to the chip select #). Then this function returns 
-EINVAL and the registration fails. Also, in my case such mapping is R/O, not R/W.

> +	if (ret)
> +		return ret;
> +
> +	dev = ctlr->dev;
> +	map = &hbdev->map;
> +	map->size = resource_size(&res);
> +	map->virt = devm_ioremap_resource(dev, &res);
> +	if (IS_ERR(map->virt))
> +		return PTR_ERR(map->virt);

   Again, I doubt that this should be done here, and not in the HB controller driver...

[...]

MBR, Sergei
