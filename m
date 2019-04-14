Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFFFC10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 17:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E147A206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 17:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="y5DPwaXR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfDNRz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 13:55:57 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46075 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfDNRz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 13:55:57 -0400
Received: by mail-lj1-f196.google.com with SMTP id y6so13427425ljd.12
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 10:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VlqTvvjVrSjyP0q+bjGrO5hfsUPGP+Ex9rx1HImXFm4=;
        b=y5DPwaXRD5gfZwa9pC2WIw7SHydZKFqiY4hE2T9RMxSTBuvDs7x6t1enx0Ea9lDn2h
         caTA2Hqq5RMXgeK1gzbqbkpj+z87CTRs+KREYs1ISwXyu52+PyS51KWR/7T+C96fNl8Q
         +bsm4Z7OnsihlVv3YKWM4zlmEuH5ZrAR2Y8NSXAmnV27x5C1smhLPRHUSBVxmJsKUUG0
         y/Kc/XCGSCX8whjZGi4vlWGUS6CZ+VBMmHWK/kmdgXCfrtHtLK0I7TQsJizAGzIIv/sz
         QME5higUH4zetYy/ig/ZSk1CzNj5bkDoSdbILcVUY+LD7Zz3arw7wJSMnM4d7xvES2CG
         IbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=VlqTvvjVrSjyP0q+bjGrO5hfsUPGP+Ex9rx1HImXFm4=;
        b=iIH4Up4gYcxE15Sf0BIl4Uy4wtzl0Ewq7rlTsuj6bll+D1WM8aHKJRnbK/jENkIFk6
         uSw5b47zvMrOofpvRaqodxXhbpej+ywP6Lqo6aIPvLmeOZRQv3p0+Toit8GIkPsOVsoH
         HhurQn2zSx4/JdjplgUIDdzAs+gCbbwHyJrMqMmxPmEZJVhtzAtlQooB0xM2JKeAkKuI
         q/brcMLHJIcX+N2P3+78pfWTp1TpGdaOxLttY2niuFxpGRLwxdtg9TY7seTM3FQBRkMI
         0EmKyJ/iBQBpAXVU/6MFqie87I8U9wHUDJel1HPPh4tTfkbo0a0IV57Zt8nU9kSQhhCy
         6bmQ==
X-Gm-Message-State: APjAAAVkgnVMrP8vSrwqgtkJBuLlY0UVrNCMApwAO/ysHGVhSZlLQMqS
        1kc90Lw7TaSJcExSVLwzhYBFHl6LsMs=
X-Google-Smtp-Source: APXvYqyGw/KeMzzhRJs/i3MTfsvOlfdfCkbG8iaSB3T08p7wAJnIWGc6FEufG85F2gvYieMaDPi7kQ==
X-Received: by 2002:a2e:1257:: with SMTP id t84mr38626316lje.115.1555264555174;
        Sun, 14 Apr 2019 10:55:55 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.85.5])
        by smtp.gmail.com with ESMTPSA id p15sm9554630lfc.48.2019.04.14.10.55.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Apr 2019 10:55:54 -0700 (PDT)
Subject: Re: [PATCH v3 4/5] dt-bindings: mtd: Add bindings for TI's AM654
 HyperBus memory controller
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
 <20190412092923.24919-5-vigneshr@ti.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <6a69ce6f-66c0-3f7c-a326-d76ee717cacf@cogentembedded.com>
Date:   Sun, 14 Apr 2019 20:55:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190412092923.24919-5-vigneshr@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2019 12:29 PM, Vignesh Raghavendra wrote:

> Add binding documentation for TI's HyperBus memory controller present on
> AM654 SoC.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  .../devicetree/bindings/mtd/ti,am654-hbmc.txt | 31 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/ti,am654-hbmc.txt
> 
> diff --git a/Documentation/devicetree/bindings/mtd/ti,am654-hbmc.txt b/Documentation/devicetree/bindings/mtd/ti,am654-hbmc.txt
> new file mode 100644
> index 000000000000..00888482df25
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/ti,am654-hbmc.txt
> @@ -0,0 +1,31 @@
[...]
> +Optional properties:
> +- mux-controls: phandle to the multiplexer that controls selection of
> +		HBMC vs OSPI. Mux state of 1 indicates HBMC is selected.

   I thought this is usually done with the help of drivers/pinctrl/..

> +
> +Example:
> +	hbmc: hbmc@47034000 {
> +		compatible = "ti,am654-hbmc";
> +		reg = <0x0 0x47034000 0x0 0x100>,
> +			<0x5 0x00000000 0x1 0x0000000>;
> +		power-domains = <&k3_pds 55>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x0 0x5 0x00000000 0x4000000>, /* CS0 - 64MB */
> +			 <0x1 0x5 0x04000000 0x4000000>; /* CS1 - 64MB
> +
> +		/* Slave flash node */
> +		flash@0{

   Need space before {.

> +			compatible = "cypress,hyperflash";
> +			reg = <0x0 0x4000000>;
> +		};
> +	};
[...]

MBR, Sergei
