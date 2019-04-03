Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BBCC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6657A2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rC07FCy8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfDCKJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 06:09:07 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42055 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfDCKJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 06:09:06 -0400
Received: by mail-pg1-f193.google.com with SMTP id p6so8063942pgh.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 03:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Pt08u+qgVaJIOskSRhQGw1Bt62Ds9fDTXx3KQLjZb3Y=;
        b=rC07FCy8J032unPAnpDT9Q+GdIy1UpOk8rfav0n0rjfMsqWfU/M7oDdyAFTfWRXRxH
         eHXCqcJWWNZDZfpiI6rNJPlrjlnSAOvwv9a9fDVRoIga8yWjsiKNzlcEToZWmGTy/mnT
         nghqntYVvfJD81pOFsW3aPgUhXxF2/Dm5/wg0IfUzv+tPypA6Uz0b8JXlVoEmNyx2UPl
         XgvthJsNKrLjRQW0BM20VWo9ZxAWLm3hA/S7kVaCi1o0BZ04vI34c1jJlVXKp2TQQSrf
         fWjgSqDe2Yc7WbpS2RM5ODPU6quIkgq/WMquc0T7qRj8w9AlW5OqQvEax5XW+Hq38CIz
         ac9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Pt08u+qgVaJIOskSRhQGw1Bt62Ds9fDTXx3KQLjZb3Y=;
        b=mmVWSdZtBTBpHnXU71TkzzNSK0Sx/hed8lpOIGC0HoF+krgBEXZLCJ6bchyt+vYlci
         0XylI+kYW9w4nVU/aaXJl1AFEDfRyVLM7xClwLaTyrKMxoiESR0bOGaHEHw8QOPe7G3F
         wRf0LxJ3alefTL/VCkZCdXl/SbcsaJGlvk4A42OirlS1PmGBpMCjceg+p5qCF+Nop3l/
         me1gwolyifvNUl4auwC3LdOZ079JOkFxBGmq1ZkvIzTHMl2ItxruE7e1dnEvUW49zXyY
         5eXjDPwxQBpHbTL3DbnvXjs81ZoJW/RVLJK7moypKE3JoELLHmWxCATxhHtR5GBzkiML
         hhzQ==
X-Gm-Message-State: APjAAAWhAtpqO6oSCW/hRJY7fZnBkJF9Ve8YkbRoeIQGPeJvG71g4D08
        oJ893yTvjH2tD9aLM0vE5loUYA==
X-Google-Smtp-Source: APXvYqx/e2wy8045fbET+eDWS0nuppPJ8sZahZ0XctSUbEPMdxDHfeUMs/B0SQ5Eu1pPC6panCQeiA==
X-Received: by 2002:a63:6142:: with SMTP id v63mr71898331pgb.342.1554286146122;
        Wed, 03 Apr 2019 03:09:06 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id k131sm30077509pfc.183.2019.04.03.03.09.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 03:09:05 -0700 (PDT)
Date:   Wed, 3 Apr 2019 11:08:58 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Tudor.Ambarus@microchip.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, bbrezillon@kernel.org,
        marek.vasut@gmail.com, richard@nod.at, miquel.raynal@bootlin.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH 09/11] mfd: syscon: atmel: switch to SPDX license
 identifiers
Message-ID: <20190403100858.GM11301@dell>
References: <20190213085930.31578-1-tudor.ambarus@microchip.com>
 <20190213085930.31578-10-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190213085930.31578-10-tudor.ambarus@microchip.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2019, Tudor.Ambarus@microchip.com wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Adopt the SPDX license identifiers to ease license compliance
> management.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  include/linux/mfd/syscon/atmel-matrix.h | 6 +-----
>  include/linux/mfd/syscon/atmel-mc.h     | 6 +-----
>  include/linux/mfd/syscon/atmel-smc.h    | 5 +----
>  include/linux/mfd/syscon/atmel-st.h     | 6 +-----
>  4 files changed, 4 insertions(+), 19 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
