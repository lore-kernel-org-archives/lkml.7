Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BCAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEEB12171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evzUFNao"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732908AbfB1OZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:25:50 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42675 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbfB1OZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:25:50 -0500
Received: by mail-qk1-f196.google.com with SMTP id y140so12151267qkb.9;
        Thu, 28 Feb 2019 06:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/moDS2OpQE/nqH0aWZ6ItXxCv+7ncdyFsR0tyjCOKQE=;
        b=evzUFNaoPnyb643CWAEVh3M9dBsJgEMfbOp15s38H9yjTCOE3EEUwA9tM8a0uLRsU7
         0IndHBWAjAEWqWaDaoC3nVzlycUhT6B00PHv0DBiNqOvGzjF2cUEVFsWyBkr4UNWW8P7
         lZXFHjvBlLZCbWcRjM+KE6znpYKJhZpqaV4ry1gJDn+0rusiIyG+2UUdfixyL7y5bJfF
         LGtmg5RhrXPKkMXwyCxyH7iICN1j057bskawM0Via9r+kq/BTnU42dI5KpGT3szVzIAA
         m52jchH9MDftVS0izHhV0bLULEA0nz+z/+oeclClZQNpFspB3ucDYnA/cuinksbxrbb6
         lyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/moDS2OpQE/nqH0aWZ6ItXxCv+7ncdyFsR0tyjCOKQE=;
        b=SZVOqnIR5SrFdlhaUTUQeag24z4hALBO5K9DLD9j1TFJXEf8Rb3pDFAxc6VeRr2wKF
         x9mipmngic4xNKMWayqYgPrCDGXlBk7GrxD5DLFkbGrYVDKsVCjWlx1Yva0C8kVyuuys
         b9beg9wzE9ydz2/UW4VaN+hv8HYtlc91Gf2OjArFdNHfgQK4tM9BeDzYCLYC74nJXR5X
         uFp0VFlvAa5mbpB6+tc8qMYp9a4YJkdYJCVzht5jBXjh1jEq2VRdr26yKFd5CmVEGp3+
         44zrQ5QtnE34XYWdhCa2gG61eTjP0icKvikgf9rN6GdIZrRxCOErn+bnNly8i9EOtzO1
         17hw==
X-Gm-Message-State: APjAAAXZeH08iaTcbghtplv2zwOVusWah1erhrOUEvgwD7x+BplYZWam
        zcQTPee1qVpQQVVQtVy9a4M=
X-Google-Smtp-Source: AHgI3IYDqpQNLN5ARptEOsQ48stKn7/aVsf1dYgAK56ktP22cAUpcLSmmy1I3Y0oSGD/7qqidz5hPA==
X-Received: by 2002:a37:d4d7:: with SMTP id s84mr6912222qks.28.1551363948767;
        Thu, 28 Feb 2019 06:25:48 -0800 (PST)
Received: from renatolg ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id h58sm12931725qtb.89.2019.02.28.06.25.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 06:25:48 -0800 (PST)
Date:   Thu, 28 Feb 2019 11:25:43 -0300
From:   Renato Lui Geh <renatogeh@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        giuliano.belinassi@usp.br, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        devicetree@vger.kernel.org
Subject: [PATCH v4 7/9] staging: iio: ad7780: add new copyright holder
Message-ID: <0c2d36187b526c56b073185d1a9b7d99052ffbca.1551358569.git.renatogeh@gmail.com>
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

This patch adds a new copyright holder to the ad7780 driver.

Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
---
 drivers/staging/iio/adc/ad7780.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index b1d4909ba025..aa1ddd0c45ee 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -3,6 +3,7 @@
  * AD7170/AD7171 and AD7780/AD7781 SPI ADC driver
  *
  * Copyright 2011 Analog Devices Inc.
+ * Copyright 2019 Renato Lui Geh
  */
 
 #include <linux/interrupt.h>
-- 
2.21.0

