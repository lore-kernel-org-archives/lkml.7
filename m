Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD36FCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B060C21E6F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qMMI6qAG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbfKDO4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 09:56:00 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34822 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728287AbfKDOz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 09:55:57 -0500
Received: by mail-wr1-f66.google.com with SMTP id l10so17440608wrb.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 06:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YfzrifobDwqmPupmbBTkgex3i/62L95dETxEsNhCitc=;
        b=qMMI6qAGmWeIwjwHlDY7ackZJkBPQhNiRo5UG68ciwDpDnSN+MFctcz4FzCtFXv6qf
         KtbOPa0SrHG1RrQAtOOag07iyq9b08ZKs2hlVm8IUk76jFUylm6/Hu63QYkXS/Es0kdJ
         9AmMzxZjM4QK6YU2rAuOaY6OF1pUPZ2C/FxXFRjuHvYg2rvFkjlYDNb+JfexYSSE4rwB
         4kZoSqgPa3ITNfzn9VaMUNOAnDAf9oNi9zFS3fg4G4yIah1ZgW/9jLZsLQL3gQ6lotTz
         BsF+hBnxXwgPDbroNQ+Jxyp3f+2vD0/5PwLv+Y6a107c9HwNs8DjKlxllWDK7XjP8V3T
         CVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YfzrifobDwqmPupmbBTkgex3i/62L95dETxEsNhCitc=;
        b=mHB4P8zFlmms6M4TQSUqzDtP5no6dJyXpDzzheS75tmlP7CCUOlqTjb74NURvcfuSm
         7NmQAK8/o8GMwXS8WMAB/ruoBUmgHvf+BitZd49cuxNXWp05/0/ArHJU0ObM46WHTSMA
         73OYFLQNsx00ENlIjUHaqdVcXT0xMKu+bMflPUI1dvNQ/teC6s2lDpvfnSzeCodP8wL/
         pEwGelv8nn4GX2n6W1//osNxILf1KPk5MTdoa5eQ+MbBcq32WI4/VUFxLAKNTiOXzuuw
         B0BiwPbWUwcsYLExzLOWh9FTCnRHEkFbCHrW87m0wnz+LOVEaGZuPoHH9GEdtOJlIGbJ
         PzZg==
X-Gm-Message-State: APjAAAWY+ZAcD4CcbsIMVeNrVzuF6jrxYJYuXmYGU4qaXks3EgdPerER
        EMGsmQEUqZb0oNe4omEzMTBi8g==
X-Google-Smtp-Source: APXvYqwj83y3LHmKoOV2IanV7AkKgXzfK497Q/9GfVIrWkApB8LDhUeSZumVmJPLvYVbD/bOnsDj3A==
X-Received: by 2002:a5d:6947:: with SMTP id r7mr18393045wrw.129.1572879354640;
        Mon, 04 Nov 2019 06:55:54 -0800 (PST)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:58da:b044:f184:d281])
        by smtp.gmail.com with ESMTPSA id f143sm18490907wme.40.2019.11.04.06.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 06:55:53 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/2] clocksource/drivers/sh_mtu2: Do not loop using platform_get_irq_by_name()
Date:   Mon,  4 Nov 2019 15:55:43 +0100
Message-Id: <20191104145543.2523-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191104145543.2523-1-daniel.lezcano@linaro.org>
References: <2210d602-bdab-5256-57b4-6e499c4b7644@linaro.org>
 <20191104145543.2523-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

As platform_get_irq_by_name() now prints an error when the interrupt
does not exist, looping over possibly non-existing interrupts causes the
printing of scary messages like:

    sh_mtu2 fcff0000.timer: IRQ tgi1a not found
    sh_mtu2 fcff0000.timer: IRQ tgi2a not found

Fix this by using the platform_irq_count() helper, to avoid touching
non-existent interrupts.  Limit the returned number of interrupts to the
maximum number of channels currently supported by the driver in a
future-proof way, i.e. using ARRAY_SIZE() instead of a hardcoded number.

Fixes: 7723f4c5ecdb8d83 ("driver core: platform: Add an error message to platform_get_irq*()")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20191016143003.28561-1-geert+renesas@glider.be
---
 drivers/clocksource/sh_mtu2.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/sh_mtu2.c b/drivers/clocksource/sh_mtu2.c
index 354b27d14a19..62812f80b5cc 100644
--- a/drivers/clocksource/sh_mtu2.c
+++ b/drivers/clocksource/sh_mtu2.c
@@ -328,12 +328,13 @@ static int sh_mtu2_register(struct sh_mtu2_channel *ch, const char *name)
 	return 0;
 }
 
+static const unsigned int sh_mtu2_channel_offsets[] = {
+	0x300, 0x380, 0x000,
+};
+
 static int sh_mtu2_setup_channel(struct sh_mtu2_channel *ch, unsigned int index,
 				 struct sh_mtu2_device *mtu)
 {
-	static const unsigned int channel_offsets[] = {
-		0x300, 0x380, 0x000,
-	};
 	char name[6];
 	int irq;
 	int ret;
@@ -356,7 +357,7 @@ static int sh_mtu2_setup_channel(struct sh_mtu2_channel *ch, unsigned int index,
 		return ret;
 	}
 
-	ch->base = mtu->mapbase + channel_offsets[index];
+	ch->base = mtu->mapbase + sh_mtu2_channel_offsets[index];
 	ch->index = index;
 
 	return sh_mtu2_register(ch, dev_name(&mtu->pdev->dev));
@@ -408,7 +409,12 @@ static int sh_mtu2_setup(struct sh_mtu2_device *mtu,
 	}
 
 	/* Allocate and setup the channels. */
-	mtu->num_channels = 3;
+	ret = platform_irq_count(pdev);
+	if (ret < 0)
+		goto err_unmap;
+
+	mtu->num_channels = min_t(unsigned int, ret,
+				  ARRAY_SIZE(sh_mtu2_channel_offsets));
 
 	mtu->channels = kcalloc(mtu->num_channels, sizeof(*mtu->channels),
 				GFP_KERNEL);
-- 
2.17.1

