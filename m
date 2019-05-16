Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CDAC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 15:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 172592087E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 15:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tmUl4rNa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfEPPkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 11:40:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55062 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfEPPkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 11:40:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PHR0hYYEwPULziU46CMKQKc5SNs9O4WaI8hYyRJBMJY=; b=tmUl4rNa0e8kPfHmpmAiiRHx9
        ps9QR8Gt8+nO7MO7sYMHwLW55WTc+VdHPlZ+LRyA1BWJ1riXwNU92+JHINbtKi2D69twAz2g5e+rR
        Uv8ts+rT6CMJ9etGQROToSbN5J52CipEuy4FI2bBfgebVRU4G+dyi5iwld2dOFD4vMScfS59smfuW
        THcVKoDjdW3iyJ8Sj52mDoRi/zM1QNJJ+h0ay07z7qz3YWT6oMjSpCycObIQImYBrBpZafTJg/F6S
        R+TukXMxw63UBohzqSeg+nwhn9Ev7S3vTibExMt4CWLx511oULO+eEwcrF32NMmVlHW6PkGOyfYTE
        VPg0uqBTA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hRIUA-0007tb-37; Thu, 16 May 2019 15:39:58 +0000
Subject: Re: [PATCH v3 3/3] fdt: add support for rng-seed
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Miles Chen <miles.chen@mediatek.com>,
        James Morse <james.morse@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Jun Yao <yaojun8558363@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Kees Cook <keescook@chromium.org>
References: <20190516102817.188519-1-hsinyi@chromium.org>
 <20190516102817.188519-3-hsinyi@chromium.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <932a02f2-a1d3-a8d7-c7a4-2891024d10a2@infradead.org>
Date:   Thu, 16 May 2019 08:39:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516102817.188519-3-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/19 3:28 AM, Hsin-Yi Wang wrote:
> Introducing a chosen node, rng-seed, which is an entropy that can be
> passed to kernel called very early to increase initial device
> randomness. Bootloader should provide this entropy and the value is
> read from /chosen/rng-seed in DT.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> change v2->v3:
> 1. use arch hook for fdt pgprot change
> 2. handle CONFIG_KEXEC
> ---
>  Documentation/devicetree/bindings/chosen.txt | 14 +++++
>  drivers/of/fdt.c                             | 55 ++++++++++++++++++++
>  2 files changed, 69 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/chosen.txt b/Documentation/devicetree/bindings/chosen.txt
> index 45e79172a646..fef5c82672dc 100644
> --- a/Documentation/devicetree/bindings/chosen.txt
> +++ b/Documentation/devicetree/bindings/chosen.txt
> @@ -28,6 +28,20 @@ mode) when EFI_RNG_PROTOCOL is supported, it will be overwritten by
>  the Linux EFI stub (which will populate the property itself, using
>  EFI_RNG_PROTOCOL).
>  
> +rng-seed
> +-----------
> +
> +This property served as an entropy to add device randomness. It is parsed

                 serves


> +as a byte array, e.g.
> +
> +/ {
> +	chosen {
> +		rng-seed = <0x31 0x95 0x1b 0x3c 0xc9 0xfa 0xb3 ...>;
> +	};
> +};
> +
> +This random value should be provided by bootloader.
> +
>  stdout-path
>  -----------
>  



-- 
~Randy
