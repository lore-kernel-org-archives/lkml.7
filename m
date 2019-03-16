Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBCCC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 02:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2181A218D9
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 02:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJSk46+S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfCPCPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 22:15:33 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40827 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfCPCPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 22:15:33 -0400
Received: by mail-qt1-f194.google.com with SMTP id f11so12265441qti.7;
        Fri, 15 Mar 2019 19:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Eh+Z/o9WjtJXIcms4JIRAPXm9p+hCYRVJC9mwEl1kVc=;
        b=WJSk46+S5D4zyDQ5RTYjae2QI0kYg1/uuuZFVXkOzunF9IF5201ZyPcGSgtIdk7KO8
         fql3T7kvasotBuhALC/Bv9fLx4aob9VgUuzXI0S7zd+4GYcvQgT+S05HiH7K/5vHT4Eb
         LMJcUlO2y4i6DoUbs53+uojDn88u2Vbz2pZtbhb2IuMruqZayP/GLTHcbIp76WIlGOfS
         xJjjhxs86gRau7H4xd3KHdItQfKFKdCXSC2/juRjQ8Z23kPDQ4jAPS4o3fktJhUsjgDY
         xK9+S51hB8kePuZM39NHnDntNV9Skrc6rCtDWrbej9WPFhSIgX9iiGoGLHlW1tYb+DJ0
         3ohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Eh+Z/o9WjtJXIcms4JIRAPXm9p+hCYRVJC9mwEl1kVc=;
        b=qmG6uYesRdB+8KIaPf3jdjb5c4tbd4SegOqAoDkczYAby8mkfYF+x2zSRCPpJo1eZs
         C6K+njYMIKMAe0Xh9f1X5t/9d2xbxraWHNsrecC5jviwBXiVpPBmNyJrjW7A4QauR1bx
         z8iFoyVQRCS7Eozf3+y6yvt90OBIaTxwEmulZmOB2sfCi+i6xTnoU/hHhs9YljmS0H8s
         SfLiqLXZlRPZtZHmEc6AAEFAIji3zyeQGieSiI8b4gOAdBeEOpJH8YiKz02BSRr3Zcm0
         JQJ46SqVKinN1x4UsaLLO2VW4OYpLno6Mhp/yADh1uR0BVB6hLeHmFHHso86SPJUvkfo
         saxQ==
X-Gm-Message-State: APjAAAXAbctm1jogYqTTujd60gplYsFf1PZW4dyZrUIRtVOQccf0woxH
        5U9AlPGE8Ey77StZHI90yY4=
X-Google-Smtp-Source: APXvYqwBsBlG9dItbWdejfNVxwT63Ih7nGAZs5uYnC6MyJttlG5SsgmETsoc29jAX39mCqZ5/23eSQ==
X-Received: by 2002:a0c:f681:: with SMTP id p1mr4786101qvn.177.1552702531982;
        Fri, 15 Mar 2019 19:15:31 -0700 (PDT)
Received: from renatolg ([186.220.21.102])
        by smtp.gmail.com with ESMTPSA id l22sm1699994qkk.83.2019.03.15.19.15.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 19:15:31 -0700 (PDT)
Date:   Fri, 15 Mar 2019 23:15:26 -0300
From:   Renato Lui Geh <renatogeh@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        giuliano.belinassi@usp.br, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        devicetree@vger.kernel.org
Subject: [PATCH v5 09/11] staging: iio: ad7780: add new copyright holder
Message-ID: <7cfb577d4e07b00a820b35dc56c58809120f8f39.1552700652.git.renatogeh@gmail.com>
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

This patch adds a new copyright holder to the ad7780 driver.

Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
---
 drivers/staging/iio/adc/ad7780.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index ff61ffa0da9f..23b731a92e32 100644
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

