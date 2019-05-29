Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF034C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 21:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1AEC241C8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 21:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGarFcfC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfE2VBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 17:01:34 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35441 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbfE2VBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 17:01:33 -0400
Received: by mail-qt1-f196.google.com with SMTP id w1so4391102qts.2;
        Wed, 29 May 2019 14:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=IqFTu1LTscqVcgDNBc6n7nyvkiZAcoSFBwufVwMCfYA=;
        b=eGarFcfCrXvNTDu5JN2TfWGZ3WiqhLAJLXCMADnnuIqD4K/GX2/VyfTo2QclV37Sl1
         uZol26oPFrEH42Dy4su9z9wTBH9a1EQnsp69Xgp9rK6f5glScC7QJfekJEmJYfgALxbl
         t4XWucS0p8oeTVOSOl/rAbZ2Qcc5ypgCdgLevdQ4w6rSSLe5NjcBluTYDrRd8NXy3AZu
         uHz6V/hKNwSKZVpCWbF6z49cCc+ArS7s8eNN5vGvkHpWskaHGVoSudALVfEAdXg537Ar
         5F6ckyV5PPqc/3FrJb4UQjEPmDGnIX/NxPbURGxXeHTkJjG8PpXVZ/DyOs/2fR6ycm3g
         pQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=IqFTu1LTscqVcgDNBc6n7nyvkiZAcoSFBwufVwMCfYA=;
        b=abN59aVJLymp/ZUU0J5EkPncM7K6HHFezzlTYaWf/xx6nz9lVRxN+RkEv9migLAb32
         wd1QPissbU4t37MveVr1/a3c6rQV8u5dRwaQUeP/zaJzcmvCAPzaJkgOQ3Lj25O9oSIz
         hzQydS9Ydhv4TIXwut7pxEucuyKyi6nZbosE7teOCg618LKl7QB2Ghjw5h7wqPf22Gii
         1V+ohTOAJwAd8dhunTE2Ll+fmMkIFOlQXVjbxPJZKZod0X/Rt6oU0QZnvGPe5oHmh4bo
         a71L7iSJ7ZPxNh+fbLnht1GbebEJQ0DTZnNdgyoYeClNDAXmjRg/HTcihrLemTEHjRAQ
         fyow==
X-Gm-Message-State: APjAAAUbdGnm3R4LgXhDQgS+Uggh5ezxOBxopffwD7MrzMI/B4ts/Q2x
        Tr2fz5gtI4YYy6CWPXgluMUm1umN
X-Google-Smtp-Source: APXvYqy2FlZ7mbHoYCLu7hVom5grdbupVpBdf4SCgnveLJ/g5oAGABAjfqRJ4vryMr0T5KUols07dA==
X-Received: by 2002:a0c:d604:: with SMTP id c4mr74851qvj.27.1559163692354;
        Wed, 29 May 2019 14:01:32 -0700 (PDT)
Received: from ?IPv6:2001:470:1d:7b6::245? (dragonstone.xogium.me. [2001:470:1d:7b6::245])
        by smtp.googlemail.com with ESMTPSA id y18sm320524qtc.90.2019.05.29.14.01.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 14:01:31 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: armada-3720-espressobin: correct spi node
To:     Tomasz Maciej Nowak <tmn505@gmail.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190527111614.3694-1-tmn505@gmail.com>
From:   Ellie Reeves <ellierevves@gmail.com>
Message-ID: <ee0c69a8-d4fe-7a13-f193-0703dab543d1@gmail.com>
Date:   Wed, 29 May 2019 17:01:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <20190527111614.3694-1-tmn505@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
yes, I agree on this personally. I meant to correct this myself or at 
least try to, but I didn't have time, as I was the one that found out 
how they did their partition layout previously, this used to be good so 
I asked Uwe Kleine-König if he could get this patch upstreamed, but as 
it is I myself upgraded U-Boot and cannot make use of it anymore.
Thanks

Tomasz Maciej Nowak a écrit :
> The manufacturer of this board, ships it with various SPI NOR chips and
> increments U-Boot bootloader version along the time. There is no way to
> tell which is placed on the board since no revision bump takes place.
> This creates two issues.
> 
> The first, cosmetic. Since the NOR chip may differ, there's message on
> boot stating that kernel expected w25q32dw and found different one. To
> correct this, remove optional device-specific compatible string. Being
> here lets replace bogus "spi-flash" compatible string with proper one.
> 
> The second is linked to partitions layout, it changed after commit:
> 81e7251252 ("arm64: mvebu: config: move env to the end of the 4MB boot
> device") in Marvells downstream U-Boot fork [1], shifting environment
> location to the end of boot device. Since the new boards will have U-Boot
> with this change, it'll lead to improper results writing or reading from
> these partitions. We can't tell if users will update bootloader to recent
> version provided on manufacturer website, so lets drop partitons layout.
> 
> 1. https://github.com/MarvellEmbeddedProcessors/u-boot-marvell.git
> 
> Signed-off-by: Tomasz Maciej Nowak <tmn505@gmail.com>
> ---
>   .../dts/marvell/armada-3720-espressobin.dts    | 18 +-----------------
>   1 file changed, 1 insertion(+), 17 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> index 6be019e1888e..fbcf03f86c96 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> @@ -95,25 +95,9 @@
>   
>   	flash@0 {
>   		reg = <0>;
> -		compatible = "winbond,w25q32dw", "jedec,spi-flash";
> +		compatible = "jedec,spi-nor";
>   		spi-max-frequency = <104000000>;
>   		m25p,fast-read;
> -
> -		partitions {
> -			compatible = "fixed-partitions";
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -
> -			partition@0 {
> -				label = "uboot";
> -				reg = <0 0x180000>;
> -			};
> -
> -			partition@180000 {
> -				label = "ubootenv";
> -				reg = <0x180000 0x10000>;
> -			};
> -		};
>   	};
>   };
>   
> 
