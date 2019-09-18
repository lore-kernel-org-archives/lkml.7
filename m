Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30DAC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 10:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91AAC21907
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 10:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aN54ur3K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfIRKv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 06:51:26 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53768 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfIRKv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 06:51:26 -0400
Received: by mail-wm1-f68.google.com with SMTP id i16so2040001wmd.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 03:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=JVv4hk+4LU2vJDNGx2vhcqczhQQUoh+G5X8X8U4GwqU=;
        b=aN54ur3KkGtiC4fj7yimPdv3HMIqVFRGOoft8l/i5fSPRMHOl6JF75HJ+lIa5ZziJ8
         RpsbkaIIBtKmy61Qdqb6kOnPGvn7aOa+mA80690Va+YRVEJEpeSHxAs1QitJbyILr0Wq
         Dogw/YfoTbqr2t49fLFqf+op6bbImPUmhB56ApM56rYzYjcbjYrbKcOwe63HQ49fNOX9
         v2eBs6gzhjqPk4MC/v9S6LNHPtmhCOgrr7pagTSIiN+jCTSo6cqRGUVI+3dSMabL6QqG
         3/ED38tescn9RMzor1s4ww0BTPBVP0DFqwO0LCJUxOaSAN+LGlt0zUahPjSwQTjq92hz
         4LvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=JVv4hk+4LU2vJDNGx2vhcqczhQQUoh+G5X8X8U4GwqU=;
        b=HPJc9/58YwAgmbFPwWvaQtLa6KCe4vP+KwWd/YjT5f6fAfuPOWK7Dp0GItS/E/v2lb
         LrIGseRx7znZYTSVGBAY2yxwPaXC27RNvUnMYFJy0CWsQPSCvwxbJKTS5GgEzs7g4yi6
         q3oZ35gdGdyiblqyXkyM5mC5zC5eqp/bxmFyRP2TaVxGD3iA7RcyJfDxvNYLgX0Q1b+m
         xCXYbBtK7OHCCpATXPyq//oolxWSyWpdZ86et9OaVFq93kzAFM/Y65Q/bRb3Ndhn9IOG
         i6CBY0a8gvn6qhMZf7vWR4SDoN7hDnPSAQGemioMTFpxzgkt1bo34sjYpWCybBDhJvNV
         2f1Q==
X-Gm-Message-State: APjAAAXFiMg72JlNtciz15rzE3xFRrGwqoxBB3tS/bEDqQKE4PV4hmG9
        2CrWTX3Mlet+ZDRECang8BI3Kw==
X-Google-Smtp-Source: APXvYqynJXkScyO65ZwXnbjbsK5K7mcXL60yrXfJxXtICcR1O2he7LJfJ7TjzExD6/kawj+vRoCG2w==
X-Received: by 2002:a7b:c398:: with SMTP id s24mr2381161wmj.78.1568803883055;
        Wed, 18 Sep 2019 03:51:23 -0700 (PDT)
Received: from dell ([2.27.167.122])
        by smtp.gmail.com with ESMTPSA id j1sm8055902wrg.24.2019.09.18.03.51.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Sep 2019 03:51:22 -0700 (PDT)
Date:   Wed, 18 Sep 2019 11:51:21 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com
Subject: Re: [PATCH] mfd: mt6360: add pmic mt6360 driver
Message-ID: <20190918105121.GB5016@dell>
References: <1568801744-21380-1-git-send-email-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1568801744-21380-1-git-send-email-gene.chen.richtek@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Sep 2019, Gene Chen wrote:

> From: Gene Chen <gene_chen@richtek.com>
> 
> Add mfd driver for mt6360 pmic chip include
> Battery Charger/USB_PD/Flash LED/RGB LED/LDO/Buck
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com
> ---

This looks different from the one you sent before, but I don't see a
version bump or any changelog in this space.  Please re-submit with
the differences noted.

>  drivers/mfd/Kconfig                |  12 +
>  drivers/mfd/Makefile               |   1 +
>  drivers/mfd/mt6360-core.c          | 463 +++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/mt6360-private.h | 279 ++++++++++++++++++++++
>  include/linux/mfd/mt6360.h         |  33 +++
>  5 files changed, 788 insertions(+)
>  create mode 100644 drivers/mfd/mt6360-core.c
>  create mode 100644 include/linux/mfd/mt6360-private.h
>  create mode 100644 include/linux/mfd/mt6360.h

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
