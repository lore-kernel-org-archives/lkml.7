Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EF6C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 12:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8AE021902
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 12:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pKRE65fZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfCWMx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 08:53:59 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37637 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfCWMx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 08:53:59 -0400
Received: by mail-wr1-f65.google.com with SMTP id w10so5170319wrm.4;
        Sat, 23 Mar 2019 05:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FJUzo17mizqgSIFXopeV0NTSnrdioOo9EKUBALEoNaY=;
        b=pKRE65fZFWLovROK6GzwPILO1mNbZsll4oiTc389+zOUUeXS0scSCfLCy7n0M9VKnd
         /hfXsCJL6TI2sPuBUBlDJR6AMkcQQa5Z8FVU8uaMrUTVRj5XkiG7SkDadTB8lU+fOL72
         WLjVbiSXGlbRLqClLuga26dvK3sDSaLrS2SG+nDj6XWcPI9rEGoRjeP1ZChx//nuG75x
         g47BcOcoQp8KiE46+OQ9YM1j25iN1fwqWp0eKhsQA3p58cKqggNrIW9KMkkR6ySLGVyT
         VIhGlaXCuHXy1Drn9Cv8qmtojwSLXM2+IEvq08FNKPRCruno0GPHBiAN1/oGN5W9v6Ap
         xeHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FJUzo17mizqgSIFXopeV0NTSnrdioOo9EKUBALEoNaY=;
        b=rSu7MMwLUp/bp3ipSf0bar1Lwxa8TBfm1osM2b7ZeDWEt+IfydBijF3k5vs81NSU/z
         xIS0nTmu/OI1zIebTfOnlPZFWNTmlLYtcaqzNgyTZdm3SbKwaOkcuSZ7XiCp6fUlEeEC
         wjeI5QQ8ViGNdqhkcxKtjwD9XOMBrq38HONTAR+cB2Lkj4SaNz2b4587HYTcVXmNxQp2
         1C8ykj7OD7U7rORX/HR43B5OfwjVYYiWIFxOEUTQ/r7R/ZoTCkGhQA1qLr0YY6rfY86+
         FqskRFE4xfiFGBBpYIUxJQSIJVFsU4uoSdWyHCO0z1PTE+bQTYeOVzI50mqvC5zajaPm
         NJcw==
X-Gm-Message-State: APjAAAVrx5qX7HHi+xpgyESHa5YwMTnn22JjZr8hGtIVDN8dc95O7tl/
        VBwIncA2ngFQLaR5/U3U/QE=
X-Google-Smtp-Source: APXvYqyEN7BJ9yOtXcyEntLiNh4D8QYOqCznnb1GvyzHd0+9dSCTWtIxQknxPxerGvUvriWJC9/p9A==
X-Received: by 2002:adf:ea88:: with SMTP id s8mr9849399wrm.300.1553345637113;
        Sat, 23 Mar 2019 05:53:57 -0700 (PDT)
Received: from peano ([87.19.116.42])
        by smtp.gmail.com with ESMTPSA id k9sm9989017wru.55.2019.03.23.05.53.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 05:53:56 -0700 (PDT)
Date:   Sat, 23 Mar 2019 13:53:55 +0100
From:   Cristian Sicilia <sicilia.cristian@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] staging: iio: adc: Avoid precedence issues in macro
Message-ID: <e57e377b86436d4c15ee7c1e6142acd0fded703d.1553335775.git.sicilia.cristian@gmail.com>
References: <cover.1553335775.git.sicilia.cristian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1553335775.git.sicilia.cristian@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enclosing parameter with parenthesis due to avoid
possible precedence issue.

Signed-off-by: Cristian Sicilia <sicilia.cristian@gmail.com>
---
 drivers/staging/iio/adc/ad7280a.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 55b5879..d81a5bd 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -97,9 +97,10 @@
 #define AD7280A_NUM_CH			(AD7280A_AUX_ADC_6 - \
 					AD7280A_CELL_VOLTAGE_1 + 1)
 
-#define AD7280A_CALC_VOLTAGE_CHAN_NUM(d, c) ((d * AD7280A_CELLS_PER_DEV) + c)
-#define AD7280A_CALC_TEMP_CHAN_NUM(d, c)    ((d * AD7280A_CELLS_PER_DEV) + \
-					     c - AD7280A_CELLS_PER_DEV)
+#define AD7280A_CALC_VOLTAGE_CHAN_NUM(d, c) (((d) * AD7280A_CELLS_PER_DEV) + \
+					     (c))
+#define AD7280A_CALC_TEMP_CHAN_NUM(d, c)    (((d) * AD7280A_CELLS_PER_DEV) + \
+					     (c) - AD7280A_CELLS_PER_DEV)
 
 #define AD7280A_DEVADDR_MASTER		0
 #define AD7280A_DEVADDR_ALL		0x1F
-- 
2.7.4

