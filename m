Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDABC282CE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 01:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65FF92070B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 01:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXFqqmAP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfFEBKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 21:10:09 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36231 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfFEBKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 21:10:06 -0400
Received: by mail-qt1-f195.google.com with SMTP id u12so16215829qth.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 18:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H1LWHNz2tpvITgQW+m/6Zu/Zck12SIWFRgPr0RVJKmg=;
        b=KXFqqmAPLvU/X75/zlyOX8S9dyGepiu2lkvFHbHdqbqzHd9aeNEWZmvdhd9eezH85f
         D2k778JJof2eNgIsOTIDrOUGdHymBRe3a7sR+uka9k2qO8ZW42u5h6lj/Z+yzVxgIKYr
         z+m6tI9BB2egfgPNftTv6CMd6T80GNcK+pjMN+nBwATcYugrrOl403YixUBh68KbNM2u
         PZiZNROZC7//yaP6JpwM1FbKPr4mhTi440MbVwSOFniBk+UbeEY+POJIxj4VzKQvNvly
         rEgVnHgcUSlK07mlNMBtZsd4hZ1UFXzUNy6M9umWp5a8kyI8uZzXklfxC4WNL+XWNZMQ
         ijgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H1LWHNz2tpvITgQW+m/6Zu/Zck12SIWFRgPr0RVJKmg=;
        b=AqcMSjBTltrBqD4QHHCrADHspVXa/XVEaStt/7Iv6SFbKVqWma48lB2dhJZUHL5NdT
         7ik0betfc2BDnsmNGPdS6mF9TzxV5dEr4JB+VmJ8Du8d/FiTJ76mJi/PUmAmogKAYd+8
         Ov3D7zYZXaTJZBl1NI+2z1/cB6+hRDqAQvHuNk+KryBH9zeG6cjHnwiLlqO/VM7BqhX5
         oRkAlOm81i5+xKuA3B+pTuXXlp/KKgMVpG08P5SUdddtyFrI0TpAYeafHO/5e9KKuE65
         dwGHTOrIi3tBWzL9cgk5YoyvGy5djEd+8tuDOh69SKApuqr93Nc61EvXx9c/Is7euZjh
         bYNg==
X-Gm-Message-State: APjAAAVs+IHaNJq+OuemX4x8S/MAq0VRdSurIY7jZROk4+RKpevtoNKu
        mC2xOefLeML+d00xab+XKkA=
X-Google-Smtp-Source: APXvYqym71iWdKBzmkz1HxFNM4iIV4QEJHsKlIOcVr3MBwSCvfF1DXU+OwfJN5IyT8elPz8jVP2mMQ==
X-Received: by 2002:a0c:b92f:: with SMTP id u47mr28957968qvf.94.1559697005648;
        Tue, 04 Jun 2019 18:10:05 -0700 (PDT)
Received: from arch-01.home (c-73-132-202-198.hsd1.md.comcast.net. [73.132.202.198])
        by smtp.gmail.com with ESMTPSA id v41sm7169401qta.78.2019.06.04.18.10.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 18:10:05 -0700 (PDT)
From:   Geordan Neukum <gneukum1@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Geordan Neukum <gneukum1@gmail.com>,
        Mao Wenan <maowenan@huawei.com>,
        Jeremy Sowden <jeremy@azazel.net>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] staging: kpc2000: kpc_spi: remove unnecessary struct member phys
Date:   Wed,  5 Jun 2019 01:09:08 +0000
Message-Id: <5e46b97ce02b84c801bc9e8b521c3cb78c599b91.1559696611.git.gneukum1@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559696611.git.gneukum1@gmail.com>
References: <cover.1559696611.git.gneukum1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The structure kp_spi_controller_state, defined in the kpc2000_spi
driver, contains a member named phys which is never used after
initialization. Therefore, it should be removed for simplicity's sake.

Signed-off-by: Geordan Neukum <gneukum1@gmail.com>
---
 drivers/staging/kpc2000/kpc2000_spi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index 32d3ec532e26..20c396bcd904 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -110,7 +110,6 @@ struct kp_spi {
 
 struct kp_spi_controller_state {
 	void __iomem   *base;
-	unsigned long   phys;
 	unsigned char   chip_select;
 	int             word_len;
 	s64             conf_cache;
@@ -270,7 +269,6 @@ kp_spi_setup(struct spi_device *spidev)
 			return -ENOMEM;
 		}
 		cs->base = kpspi->base;
-		cs->phys = kpspi->phys;
 		cs->chip_select = spidev->chip_select;
 		cs->word_len = spidev->bits_per_word;
 		cs->conf_cache = -1;
-- 
2.21.0

