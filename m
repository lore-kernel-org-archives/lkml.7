Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892C4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59727218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qF8e/poW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732894AbfB1OZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:25:33 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45207 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbfB1OZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:25:30 -0500
Received: by mail-qt1-f193.google.com with SMTP id d18so23585453qtg.12;
        Thu, 28 Feb 2019 06:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N+SXRHRLZhhPwlRAxJVBPVqgau/fj3ODE0mnJv33yTA=;
        b=qF8e/poWGsMA1PpBoZQeiLQHP7yctDWZTilZXpqf8PpmnSgW8DabvzcO6zdTvl0Hj/
         JFFR3Z6uhj9c45RQ5YoDz3S2NWTrlBXwsZHU5iiDqivRKRjCy9Au/jC3tol4iVZ6rgAe
         sHhbBrJzyvbm5Y75SLfAs2M5nKNE9MDpoaXthVX4WMyhJ6LYBWoKo90129Ff6czW5x82
         0/wXiompMmrIe5fNeGu4qb2eKZ99XTwkCdlQRkN+Jm39zf5//OoHt8jPOmScn/fLxCAD
         Rt4S8Z2XIKKM3bxapnEtmwrxdUUnHa1QzEX4Q4yzr8Thd0v3NswNQNwGwH1w0wB8hDbu
         4GsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N+SXRHRLZhhPwlRAxJVBPVqgau/fj3ODE0mnJv33yTA=;
        b=FvftYNOCtqglF8LQbaY5egfpmx4CTNog74mVRoV0PFJ6mxL5ULfAvqfmHg4JjCy62c
         OoyWa9ByNdo/ZPN38zGIy/twHPzC0IFYgAyAX2KolioW4xTP/u+jaVNgiBvWlXBH2gU6
         n1DaS37mIx5ElddDH7m1NtqAcrddK13T2f+hPFCHAKNtCjynbeCdwGKHhH/1tYRQ4toy
         wOpjtJiFgSEhfihXoid6omCWl/2z0Z6T9g1/miJvOD4VjFD1sjUB07TzfE/HXyXRnGJi
         PiRT+3V89W/0/dz/OnR6X2huGJxvBYELwnt027r79R6RGYJ8RxRvD1cOXNKB8WCohTx9
         R+aw==
X-Gm-Message-State: APjAAAUgytZPLECNSLT5+KERMr6r+RFR/B4BjNCrEcO8EiLR1vdnLDVA
        IapDpTekL6bU4aHMKD9frxc=
X-Google-Smtp-Source: AHgI3IbFHFvGCVLn4niuhpQHVVOposQgM6MbDRhhE9Kcb6B7nLcSlrvpVAnFU+A4v7UmFiTrcuIRbg==
X-Received: by 2002:ac8:3f3b:: with SMTP id c56mr6257277qtk.81.1551363929683;
        Thu, 28 Feb 2019 06:25:29 -0800 (PST)
Received: from renatolg ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id o26sm10219525qkk.51.2019.02.28.06.25.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 06:25:29 -0800 (PST)
Date:   Thu, 28 Feb 2019 11:25:23 -0300
From:   Renato Lui Geh <renatogeh@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        giuliano.belinassi@usp.br, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        devicetree@vger.kernel.org
Subject: [PATCH v4 6/9] staging: iio: ad7780: add SPDX identifier
Message-ID: <907e3a63a16dbf5d98c027d528f12cb12577a7bd.1551358569.git.renatogeh@gmail.com>
References: <cover.1551358569.git.renatogeh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <cover.1551358569.git.renatogeh@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SPDX identifier (GPL-2.0) to the AD7780 driver.

Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
---
 drivers/staging/iio/adc/ad7780.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index 12aef0f101bc..b1d4909ba025 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * AD7170/AD7171 and AD7780/AD7781 SPI ADC driver
  *
  * Copyright 2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
  */
 
 #include <linux/interrupt.h>
-- 
2.21.0

