Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D571ACA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC946222C1
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S3i2Q4fX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbfKDOXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 09:23:14 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40583 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbfKDOXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 09:23:14 -0500
Received: by mail-wm1-f66.google.com with SMTP id f3so5153534wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 06:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AYQmjw1hml4PgLOeoBhVnK0KUzQgdFHYdam43/ukq0I=;
        b=S3i2Q4fX6BY/vftXH45Bc99xDs+PhLN+rFNVjkaSXNvPIOcaObXh98ZRLk6FuLNIt7
         QHpDzSO+OT5ZzIZB6HH/sBpt1DJEDSZtedrQ6Xw8LhRJxD2YpByzTNoVAhjcB94JeR51
         1Phyh+Y4Y0B/4KMf2HtXwwEnPE10dQDBPPDUAUqW6w1utmcOCu3qsfyuNBQAmnqXv4UM
         74VYY7PNPjuKQcXphTytfOFelwan4Ftgq8A2pyy96Syt5JPYiqdMiNEU9A5X7N0mpvns
         0Cqw/TnrQDbAi6b825YLN8CER7MTbIFlEobifc2R9BH/FDDEE6zIKIf+4savGyYhzMQY
         QHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AYQmjw1hml4PgLOeoBhVnK0KUzQgdFHYdam43/ukq0I=;
        b=Y1pFwhpmzoKhthfzmATTeS8itODXRyY3i5tpznXffb0UrwVwdnyibvlMaBmIUcp7AT
         h72KpZHGsXY1fxPIHC3EVB1MJ25poZSWFwtQjqvZHUQoAokoBBfOcXVFNSS3rdOnt39J
         Jw7NDwW7gb6iMXs+lPRzpCjDInYyIxAcCZ0rEAj0qmBDzv3YFsozuF/yR/chCDSkNEZl
         v5Hy6s0hoLWDe379lMchUlXTN1e6gIM4aqN+WC8V9HfdYcQbOKwSgIiCflGoCcKsHYdL
         93RfD6yOLweSACFruKSsFKVTH5z0VGX7jchxF1D6ib67urlaXoZl5jfCnxCz2wfIpuQt
         uvsg==
X-Gm-Message-State: APjAAAWkDf3i9ur8O3O9BXlHVVKIOStu6Zi+foKWWROKYb726XW07uqL
        aDtXCJFpufBmS18wgWSVlvmfsQ==
X-Google-Smtp-Source: APXvYqysDnjNMqtZRR0LnbmVw+0QQ1+o1ZGZ3H11i2R/+zTcehu/up0AONd8fB9lZJ3a80BKl/o+rA==
X-Received: by 2002:a7b:c444:: with SMTP id l4mr22376340wmi.21.1572877390929;
        Mon, 04 Nov 2019 06:23:10 -0800 (PST)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:58da:b044:f184:d281])
        by smtp.gmail.com with ESMTPSA id l18sm21692446wrn.48.2019.11.04.06.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 06:23:10 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/5] clocksource/drivers/timer-of: Convert last full_name to %pOF
Date:   Mon,  4 Nov 2019 15:22:53 +0100
Message-Id: <20191104142257.30029-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <6fd4d800-b1f8-d757-458e-23742d20884c@linaro.org>
References: <6fd4d800-b1f8-d757-458e-23742d20884c@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Commit 469869d18a886e04 ("clocksource: Convert to using %pOF instead of
full_name") converted all but the one just added before by commit
32f2fea6e77e64cd ("clocksource/drivers/timer-of: Handle
of_irq_get_byname() result correctly").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20191016144747.29538-2-geert+renesas@glider.be
---
 drivers/clocksource/timer-of.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-of.c b/drivers/clocksource/timer-of.c
index d8c2bd4391d0..384394205a12 100644
--- a/drivers/clocksource/timer-of.c
+++ b/drivers/clocksource/timer-of.c
@@ -55,8 +55,8 @@ static __init int timer_of_irq_init(struct device_node *np,
 	if (of_irq->name) {
 		of_irq->irq = ret = of_irq_get_byname(np, of_irq->name);
 		if (ret < 0) {
-			pr_err("Failed to get interrupt %s for %s\n",
-			       of_irq->name, np->full_name);
+			pr_err("Failed to get interrupt %s for %pOF\n",
+			       of_irq->name, np);
 			return ret;
 		}
 	} else	{
-- 
2.17.1

