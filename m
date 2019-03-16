Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47175C4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 02:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 156E4218D4
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 02:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cet6jNR+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfCPCPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 22:15:19 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37612 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfCPCPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 22:15:18 -0400
Received: by mail-yw1-f67.google.com with SMTP id w66so8793620ywd.4;
        Fri, 15 Mar 2019 19:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YABxWF8N5gKqZyrr+QQvSqXEL3zrKIE1jEQuPoWCy1Q=;
        b=cet6jNR+ipeGlcnATcbW0MeDv4xaNeXSalsdWVj9sf2YnfbkEFLZdRY+rNss7G+pt0
         Mz91Xeb6+yQor28767Ghc5jM02rkxsEGQmH2oBh+1ws/0xSkvzp+NhJgzfWMCpxasfXR
         JKDayQHrNrv4BNeRlL7c7ZrGMb2ZJdX02v9jTjswXK5Epa1nBSm+zgjoSH16GNEhm8Iq
         K+TAoXJSEAViWHBdAXaR7RP5+q264tVVS3/3ftzjXmkAh/zZZR/JfqRgEiae3u4PJORb
         3MsObXw+E1v1HUfsUuM/8oYJ5cc9PRbegD2O2aLY6/U6p0RaeiTXaYOMMQwfcLigWp4L
         iazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YABxWF8N5gKqZyrr+QQvSqXEL3zrKIE1jEQuPoWCy1Q=;
        b=Ve32Migz+N/v/MUFU/i8czYjdq5gHh7RO0caW5hyCbfhvE00t2eWC8+7PZbVQN9Rk9
         yjDFMUyYjI6v20ZgbJ9V59hro2Jr8qtEU/q+IyM87uu0K9YVvPWtcExSuJmBIbAqCXa8
         qJwQMDIOjewt9vh6Wwn5ZynMxrCNh26B+sfLJxGda6Mt9hQV/YxGtiF2mY1roMAj7VsN
         rRjfwwLhXj5PNJn+XeZI+iceyBUL6omssdyoLE0k2/eBxb99MScHShyMDbn2dOVXZAyE
         5lu0D5fGiOlyarkrIYjgJiWD8GdyjtpB1H0zr/hmYg4kmk7o8ufgFC/zSe/NlK40COKY
         TQmg==
X-Gm-Message-State: APjAAAV/YTpuMLDkl7yZzaeN4tO/3AJpbqpeabWYo9tv6SZqLk0lA5q1
        dsfrvs2TqLc+tyZailF54p8=
X-Google-Smtp-Source: APXvYqz7yVcv04KxXw6i/E21J7YxLbo6ulOycTUIK6nr82TVf26O7FeInGiLG9lmXMlVS726PvB0yA==
X-Received: by 2002:a81:47c1:: with SMTP id u184mr5582507ywa.406.1552702517766;
        Fri, 15 Mar 2019 19:15:17 -0700 (PDT)
Received: from renatolg ([186.220.21.102])
        by smtp.gmail.com with ESMTPSA id 136sm1323995ywl.109.2019.03.15.19.15.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 19:15:17 -0700 (PDT)
Date:   Fri, 15 Mar 2019 23:15:13 -0300
From:   Renato Lui Geh <renatogeh@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        giuliano.belinassi@usp.br, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        devicetree@vger.kernel.org
Subject: [PATCH v5 08/11] staging: iio: ad7780: add SPDX identifier
Message-ID: <4344b002e730538b737e576b7d262687ab62473c.1552700652.git.renatogeh@gmail.com>
References: <cover.1552700652.git.renatogeh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <cover.1552700652.git.renatogeh@gmail.com>
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
index 568c5b4472ff..ff61ffa0da9f 100644
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

