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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F832C10F00
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 02:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6726206DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 02:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGlXCbvP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfCPCOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 22:14:20 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:35805 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfCPCOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 22:14:20 -0400
Received: by mail-yw1-f65.google.com with SMTP id s204so8798753ywg.2;
        Fri, 15 Mar 2019 19:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K7rpJweAAGHYDLxUgHuYBBCV1Z5B+8lu4Xx1IvGDggs=;
        b=KGlXCbvPZi+107ZGogED0LEqNuaW+UAg2H5EZke83UAJ8TNJUEFOnwKKHmBZIkg39k
         QTsshGnSSWe7z9sEBT0NmCmwSP9JdKQDf/Q4/Lwavuy95l9WeIoy87oKxIbwDyUCFdhc
         2X3eXLgRj0UCoJpUUrnOMLZnWFQljg3G4mcT8rusgSfb05wYgSHeyhBSiqRiki+97389
         G7fFxjnbV9temwIV1HLkCIvyv4tkG04ZYYYj1ABGBfPetLAvRoZ0qKP2xMypXEIkh3Kg
         /ZRlqZ+pSaosSQlfc0G+750b/TQA2DxywpoZYH745pFvdoZWofYtbqTml9/kSEE4DW2v
         db5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K7rpJweAAGHYDLxUgHuYBBCV1Z5B+8lu4Xx1IvGDggs=;
        b=en/wLu/6zjiO8WhKjL18M5x4oGEscvwWzusfDaSA5CLo7bVxgVUt5Y/jwLRbJv4Xi7
         dYHoS425uzGFMMmb/Mag0hOfPea7swYsjLvmUVJm6GYYWhEvCIjXdZVTHdOHG8OMBhP7
         NJges59QIxu0tN9WWIQMV4hqhA9yB1wBeXuCO/kB85Uz4pW4FFsSaqdjJBTJ03ZxWXP1
         Nhm3RJwo3P44GZBi3ZtD2QkmIua3rHBQXidB47CpviF6CXHTLmUzpifyymiJh1R6jTTS
         Pu7NE/uH5riWqd99SOyZshOAiyVIxjfZubz73jxuqwGzXNL0CnSX/cbDzmi+ROcBTP1T
         BTkQ==
X-Gm-Message-State: APjAAAUZRzebLFC1q/Z/l8Kotun/EoafHn4a6rbuaO87wh8xoJThPHnK
        Nt6ZRl/OXYEXdZV4d586ChQ=
X-Google-Smtp-Source: APXvYqyxkJTKkuAzUuKSAJY0rRqbSq1G/Xg+v3bSSLxqB5kHX9E9ea92Ki/rh6YQ/O+Hw8ibKSwwyA==
X-Received: by 2002:a0d:fe84:: with SMTP id o126mr5296386ywf.203.1552702459260;
        Fri, 15 Mar 2019 19:14:19 -0700 (PDT)
Received: from renatolg ([186.220.21.102])
        by smtp.gmail.com with ESMTPSA id l143sm1307100ywc.50.2019.03.15.19.14.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 19:14:18 -0700 (PDT)
Date:   Fri, 15 Mar 2019 23:14:14 -0300
From:   Renato Lui Geh <renatogeh@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        giuliano.belinassi@usp.br, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        devicetree@vger.kernel.org
Subject: [PATCH v5 05/11] staging: iio: ad7780: set pattern values and masks
 directly
Message-ID: <ecfec5163339a3ffa8958876b97c08c601e5cadc.1552700652.git.renatogeh@gmail.com>
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

The AD7780 driver contains status pattern bits designed for checking
whether serial transfers have been correctly performed. Pattern macros
were previously generated through bit fields. This patch sets good
pattern values directly and masks through GENMASK.

Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
---
 drivers/staging/iio/adc/ad7780.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index 8ff74427d975..94cb60c327d0 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -17,6 +17,7 @@
 #include <linux/sched.h>
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
+#include <linux/bits.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -28,16 +29,13 @@
 #define AD7780_ID1		BIT(4)
 #define AD7780_ID0		BIT(3)
 #define AD7780_GAIN		BIT(2)
-#define AD7780_PAT1		BIT(1)
-#define AD7780_PAT0		BIT(0)
 
-#define AD7780_PATTERN		(AD7780_PAT0)
-#define AD7780_PATTERN_MASK	(AD7780_PAT0 | AD7780_PAT1)
 
-#define AD7170_PAT2		BIT(2)
+#define AD7780_PATTERN_GOOD	1
+#define AD7780_PATTERN_MASK	GENMASK(1, 0)
 
-#define AD7170_PATTERN		(AD7780_PAT0 | AD7170_PAT2)
-#define AD7170_PATTERN_MASK	(AD7780_PAT0 | AD7780_PAT1 | AD7170_PAT2)
+#define AD7170_PATTERN_GOOD	5
+#define AD7170_PATTERN_MASK	GENMASK(2, 0)
 
 #define AD7780_GAIN_MIDPOINT	64
 #define AD7780_FILTER_MIDPOINT	13350
@@ -209,25 +207,25 @@ static const struct ad_sigma_delta_info ad7780_sigma_delta_info = {
 static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
 	[ID_AD7170] = {
 		.channel = AD7170_CHANNEL(12, 24),
-		.pattern = AD7170_PATTERN,
+		.pattern = AD7170_PATTERN_GOOD,
 		.pattern_mask = AD7170_PATTERN_MASK,
 		.is_ad778x = false,
 	},
 	[ID_AD7171] = {
 		.channel = AD7170_CHANNEL(16, 24),
-		.pattern = AD7170_PATTERN,
+		.pattern = AD7170_PATTERN_GOOD,
 		.pattern_mask = AD7170_PATTERN_MASK,
 		.is_ad778x = false,
 	},
 	[ID_AD7780] = {
 		.channel = AD7780_CHANNEL(24, 32),
-		.pattern = AD7780_PATTERN,
+		.pattern = AD7780_PATTERN_GOOD,
 		.pattern_mask = AD7780_PATTERN_MASK,
 		.is_ad778x = true,
 	},
 	[ID_AD7781] = {
 		.channel = AD7780_CHANNEL(20, 32),
-		.pattern = AD7780_PATTERN,
+		.pattern = AD7780_PATTERN_GOOD,
 		.pattern_mask = AD7780_PATTERN_MASK,
 		.is_ad778x = true,
 	},
-- 
2.21.0

