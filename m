Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E05C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2151B206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="CepSTDzt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730618AbfCYKCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:02:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34945 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730594AbfCYKCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 06:02:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id w1so9374902wrp.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 03:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ZESaBp9NpftZA4uZ0kHsrucdZgVgPNyX7p82BbH1GIE=;
        b=CepSTDztojzeMepDgTaZa3965hZn4wd7KWTkC6jR3Rzu+6L933axPSJ76Fjr8Y7F8C
         ONY1f7UagYrNAyr7aYdsXPAwdaCoMK8qu3vWtkZ9OYADUxdM4R3AgDDv7PL0ZQHoXHYE
         zcbA+7vZ7Uu7pQeAIsEFA3vKfyA71dGms9gnuLXeyqKYH1XXL/4BvPlIJbJR7zMdtM7n
         DTuG/2KV8Z99msyonvCz9rDWKENRvPcKEtDX1Snif1X0jxWnJ7l7tKkK84W0WIZ5ogrd
         gUsOKxsnOd2udDBrQPsCDbImvLAcXxhWaUV8aHJ2C9Dzvv/MuKT9r1SRIrzbRyAVi9Tz
         wI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ZESaBp9NpftZA4uZ0kHsrucdZgVgPNyX7p82BbH1GIE=;
        b=QxoEdpbixGjrl7r2xeEB143hClhlBEFKQlj7z+Sa43F13yCDcRcif7BVjonrlFn6A3
         MKIrEM+y5FeECP0/0u2AzM8RoE1vg/MfLCzka8t6k7NSP9TreSpAwmU/Gyqiifn96Nau
         YieAqojTxQb1YjSV4SczstrVHI2uz+ySCaZFdq6SbhjEY6iHc7HIrp9oiFoQhOCOgBg2
         8pYtzcsAOGoP17pF1NN3SRYc1hm03AIDxF0bjGT6xx39ombAJt38/iYGq5wdNKUVHIu2
         aiCT9sSnmqvV5PWEvCRsM3nyAXtNAC2+6+D2BkC8SfVEqfF9P7VkA4O5HSlNOyUf5a6h
         wGWQ==
X-Gm-Message-State: APjAAAVxMOq40JuhuAomZHOF4YIYKydWT/tQFXMxtfsbAeP4na2Y329J
        w10LjsHWRKyNnOG1mHwQeINllw==
X-Google-Smtp-Source: APXvYqwfSXXy1j6IVYlenJpfG0pNEIsFQiM52nteZBH/vDSiaCErR6sTlfuyxvmFFMWiYPcfyKfpfg==
X-Received: by 2002:a5d:6883:: with SMTP id h3mr14684000wru.215.1553508120486;
        Mon, 25 Mar 2019 03:02:00 -0700 (PDT)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id z19sm9122061wml.44.2019.03.25.03.01.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 25 Mar 2019 03:01:59 -0700 (PDT)
Message-ID: <39732b0ea1d10bd91423ca80b61abf5545965dda.camel@baylibre.com>
Subject: Re: [PATCH v2 0/2] clk: meson8b: add the video decoder clocks
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        narmstrong@baylibre.com, linux-amlogic@lists.infradead.org,
        mjourdan@baylibre.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 25 Mar 2019 11:01:57 +0100
In-Reply-To: <20190324151423.19063-1-martin.blumenstingl@googlemail.com>
References: <20190324151423.19063-1-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-03-24 at 16:14 +0100, Martin Blumenstingl wrote:
> This adds the video decoder clocks for Meson8, Meson8b and Meson8m2.
> 
> The clock tree on Meson8 differs from the one one Meson8b and Meson8m2.
> Details can be found in patch #2.
> 
> There are some checkpatch warnings in patch #2:
>   WARNING: please, no space before tabs
> I decided to still send the patch because we have the same inconsistency
> with all other clk_hw_onecell_data table entries. Please let me know if
> I should come up with a follow-up patch to clean them all up.

A cleanup patch is always appreciated :) Before or after your changes, I don't
really mind. Up to you.

Acked-by: Jerome Brunet <jbrunet@baylibre.com>

> 
> Testing:
> I have not tested this with Maxime's video decoder driver yet.
> However, I manually enabled and set various frequencies for the HCODEC
> clock and verified that clkmsr reports the correct rate.
> 
> Dependencies:
> This is meant to be applied on top of my other series from [0]:
>   clk: meson8b: add the VPU clock tree
> 
> Changes since v1 at [1]:
> - collected Neil's and Maxime's Reviewed-by (thank you!)
> 
> 
> [0] https://patchwork.kernel.org/cover/10860401/
> [1] https://patchwork.kernel.org/cover/10860513/
> 
> 
> Martin Blumenstingl (2):
>   dt-bindings: clock: meson8b: export the video decoder clocks
>   clk: meson: meson8b: add the video decoder clock trees
> 
>  drivers/clk/meson/meson8b.c              | 312 +++++++++++++++++++++++
>  drivers/clk/meson/meson8b.h              |  17 +-
>  include/dt-bindings/clock/meson8b-clkc.h |   4 +
>  3 files changed, 332 insertions(+), 1 deletion(-)
> 


