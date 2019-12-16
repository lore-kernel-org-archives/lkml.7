Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C11C2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 16:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 799DD206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 16:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="uozs0YlK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfLPQl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 11:41:56 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39254 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfLPQl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 11:41:56 -0500
Received: by mail-wr1-f65.google.com with SMTP id y11so8090523wrt.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 08:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=isTIfaObzhS1/5bZonYRWbDD+hRSQ6mFmU4grStSX44=;
        b=uozs0YlKTOQBirSM7sw8e/WETIDrutVulM/suq0+cDyGRDLQU+yXN5MW7ODJpSgLEa
         JgT/IJugM1jeUrdQEcYdQ5ozzniscEtR5PrOgTJC3I39nsdR5NEDcOuj1aO28ZMoSmjd
         iHDek34x08dFp2AK/UPBxJK4SOLKLPbURUa216fGayYkDu4NjQLVE1eRp7nlRAk/lrLi
         FEg/Pf+YE7NWOtqjd0RO9Ke/+L96/IndRdO//yTNOGkAlMBkD2FUBV76CrA18VyZX0NP
         MsPCObeKdeKSj1cUrxxUJnSGefgwRU8/B0UC+Z3gEZlCv/kFt2ddj96F7deU0Isekdw6
         CNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=isTIfaObzhS1/5bZonYRWbDD+hRSQ6mFmU4grStSX44=;
        b=CttD8OZSNXSnkAwIr7Oky7y4owFBWVC5TQdJv45fl3+FcmpPMbqv75ZJfSumLjwl4W
         IsR4Tt0t4WGtSSE1e2DqPDnug/yUntA4iIwcKHmW0O2B6H8K7RAMg0M6SK6iA3qBla7V
         KAWf8UgFiu80evxYSRq3VJWdyeoAOMTu6wQKPIwoB4z/Cp2z+pfZeWozxAB+8BG5ECaH
         7UpRtBC/yaRw13d+bnS22gm5h+36mFyauMYsNG2VWsDg06gspXuqrfAj8asRne8s6/WI
         cPc/NICm3XjElJ0Jci3WRsrDnkxmT84gjVYhhhE2kvXfEvagGQtGMFONhDNuVcnDspXv
         AfCg==
X-Gm-Message-State: APjAAAVQ2UnZkacGs3TOpaWx2Rg5ZuRkEJ/Jd3ftwFqq6r0gicYkNL9A
        gc/1w0SiQdvpcD7I+ot1A209hQ==
X-Google-Smtp-Source: APXvYqyMeAydqVtRFg2OSOzFrexgRBfWLknXsxIu0N8FlQXDXw5IlLvaM/xwEUGZk7OGH+HJ0c6yPQ==
X-Received: by 2002:adf:ebc3:: with SMTP id v3mr30920505wrn.280.1576514513950;
        Mon, 16 Dec 2019 08:41:53 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id s10sm22295442wrw.12.2019.12.16.08.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 08:41:53 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] gpio: mockup: fix coding style
Date:   Mon, 16 Dec 2019 17:41:49 +0100
Message-Id: <20191216164149.5376-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

I have missed two indentation issues in commit 64e7112ee307 ("gpio:
mockup: add set_config to support pull up/down"). This commit fixes them.

Fixes: 64e7112ee307 ("gpio: mockup: add set_config to support pull up/down")
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-mockup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index c4fdc192ea4e..94b8d3ae27bc 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -156,7 +156,7 @@ static int gpio_mockup_apply_pull(struct gpio_mockup_chip *chip,
 	mutex_lock(&chip->lock);
 
 	if (test_bit(FLAG_REQUESTED, &desc->flags) &&
-		!test_bit(FLAG_IS_OUT, &desc->flags)) {
+	    !test_bit(FLAG_IS_OUT, &desc->flags)) {
 		curr = __gpio_mockup_get(chip, offset);
 		if (curr == value)
 			goto out;
@@ -165,7 +165,7 @@ static int gpio_mockup_apply_pull(struct gpio_mockup_chip *chip,
 		irq_type = irq_get_trigger_type(irq);
 
 		if ((value == 1 && (irq_type & IRQ_TYPE_EDGE_RISING)) ||
-			(value == 0 && (irq_type & IRQ_TYPE_EDGE_FALLING)))
+		    (value == 0 && (irq_type & IRQ_TYPE_EDGE_FALLING)))
 			irq_sim_fire(sim, offset);
 	}
 
-- 
2.23.0

