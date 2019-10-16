Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BB4ECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB3A920659
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="D0+TbLXK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfJPUL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 16:11:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46593 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbfJPUL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 16:11:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id o18so29428966wrv.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 13:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0edoD8qXLxIMb9lHusA8ctqCBdpgHnIWpnlud4IpS5A=;
        b=D0+TbLXKv4nLHH1PICBuG4OHzzfCNolpysA0NdqnggM3oNHvONZBsSdcdyYHeY9PTX
         BP6Q63iG+P0ZkFrmsMgZT2VJOejwCv/iBGW5e0FpACARXwR8xLRqsCvBYYKdlB1L+noa
         Lx/omyHvcnCfCbRtMo6vA/PY8I3hPfWaxFVsbLjbAfNU6LF/WG20V9YcGalaWYe7Hd0u
         EdO3lyIna8hymw4xsraJB5FfvRxQTbWl+aeoUziSGcsuQ2Edln+e7pMsaNFPqtxmKqEo
         p8/mYJAKLUed5W2eaIdkVXtkgFPBl/9U2+YXsjyAHA+8A0PaKzQC/8Q1eBg9jfscJ+Sz
         hVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0edoD8qXLxIMb9lHusA8ctqCBdpgHnIWpnlud4IpS5A=;
        b=rHVHc3+jDg+cdDcv6saOVkFVn1+ZtgfMcLWS+aM3CTqsuNfFAkKx3lwVcqNyvTeQyJ
         QT9Rw8VgKPLIjTp7BqgMU3Pa2tEnGFAjnHjfkWtIkdoFlHry+GG8ZFdKt/KqU5WltcK9
         ISYyxzdHAuXp4kquAHjhKkKEUnB4SYERY44PIyYrNNV633zfwyseOXNuJYKUmFpQt6ww
         NN8vLnJ1aF8tg8n1ZFZGwjUirLT9VMuMzqmVIlbAK7WFA1Ub/C2i0ZcZ+mmG1RC/vSHY
         35Mfk/u4TzSKgl41qDXNLaqk5IymMlNB2nmD6aoHWYUcYhpuJvotI5RWzpREtf8NZOMO
         6pbQ==
X-Gm-Message-State: APjAAAWGvtH2maiME3d+cwWzmDxwqF5qmiDjhS+J/jOpOs1Lm4/0lUYj
        Ga6uTldTl1cZYnc6bZ3fk+Y/+A==
X-Google-Smtp-Source: APXvYqw8vdKpG2sCTiy78c9P1m7wEQV56IyUIiYGlFpvMM6Z1PosXut/bgrU1zDYkR1e8mM7XnTE5A==
X-Received: by 2002:adf:ed49:: with SMTP id u9mr4127114wro.229.1571256716203;
        Wed, 16 Oct 2019 13:11:56 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id l18sm29539138wrc.18.2019.10.16.13.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 13:11:55 -0700 (PDT)
Date:   Wed, 16 Oct 2019 22:11:52 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au,
        khilman@baylibre.com, mark.rutland@arm.com, robh+dt@kernel.org,
        martin.blumenstingl@googlemail.com, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] crypto: amlogic: Add crypto accelerator for
 amlogic GXL
Message-ID: <20191016201152.GA31674@Red>
References: <1571031104-6880-1-git-send-email-clabbe@baylibre.com>
 <1571031104-6880-4-git-send-email-clabbe@baylibre.com>
 <8f9be4a8-ed6c-a2bd-f3ba-df22752e7172@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f9be4a8-ed6c-a2bd-f3ba-df22752e7172@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 13, 2019 at 10:41:06PM -0700, Randy Dunlap wrote:
> Hi,
> 
> On 10/13/19 10:31 PM, Corentin Labbe wrote:
> > diff --git a/drivers/crypto/amlogic/Kconfig b/drivers/crypto/amlogic/Kconfig
> > new file mode 100644
> > index 000000000000..9c4bf96afeb3
> > --- /dev/null
> > +++ b/drivers/crypto/amlogic/Kconfig
> > @@ -0,0 +1,24 @@
> > +config CRYPTO_DEV_AMLOGIC_GXL
> > +	tristate "Support for amlogic cryptographic offloader"
> > +	default y if ARCH_MESON
> > +	select CRYPTO_BLKCIPHER
> > +	select CRYPTO_ENGINE
> > +	select CRYPTO_ECB
> > +	select CRYPTO_CBC
> > +	select CRYPTO_AES
> > +	help
> > +	  Select y here for having support for the cryptographic offloader
> 
> 	                to have support for
> 
> > +	  availlable on Amlogic GXL SoC.
> 
> 	  available
> 
> > +	  This hardware handle AES ciphers in ECB/CBC mode.
> 
> 	                handles
> 
> > +
> > +	  To compile this driver as a module, choose M here: the module
> > +	  will be called amlogic-crypto.
> 
> That module name does not match the Makefile's name.
> 
> > +
> > +config CRYPTO_DEV_AMLOGIC_GXL_DEBUG
> > +	bool "Enabled amlogic stats"
> 
> 	      Enable
> 
> > +	depends on CRYPTO_DEV_AMLOGIC_GXL
> > +	depends on DEBUG_FS
> > +	help
> > +	  Say y to enabled amlogic-crypto debug stats.
> 
> 	           enable
> 
> > +	  This will create /sys/kernel/debug/gxl-crypto/stats for displaying
> > +	  the number of requests per flow and per algorithm.
> > diff --git a/drivers/crypto/amlogic/Makefile b/drivers/crypto/amlogic/Makefile
> > new file mode 100644
> > index 000000000000..39057e62c13e
> > --- /dev/null
> > +++ b/drivers/crypto/amlogic/Makefile
> > @@ -0,0 +1,2 @@
> > +obj-$(CONFIG_CRYPTO_DEV_AMLOGIC_GXL) += amlogic-gxl-crypto.o
> > +amlogic-gxl-crypto-y := amlogic-gxl-core.o amlogic-gxl-cipher.o
> 

Thanks, I fixed it

Regards
