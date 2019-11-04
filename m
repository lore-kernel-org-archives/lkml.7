Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76ED5CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DBB221D7F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P6v8/SKz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbfKDOXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 09:23:20 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37911 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728630AbfKDOXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 09:23:18 -0500
Received: by mail-wm1-f68.google.com with SMTP id z19so12099910wmk.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 06:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o012SHvPj5zgU3QBeDKlShRnobqJxcJuQYC3/1lC2yI=;
        b=P6v8/SKz37UVfswKof2UASy8k/JJK8EJbfOp9D8iXlt7Orgu1ThjaodbG9fslrMQnO
         zVVgmQvVkolxffNUUqOeFea48ZDitteEuJhG3qqC3ivv0Bb/Nm7ueV+tCL2kh7xugyE+
         Pz/84pvIkRFpVBikcM3KyEr0cBtdEUVxg+8fY2zharmNIJNt/6aPH3BW+bYaaBJeABj7
         8xfSmSyNswgjhaytWeLRpc/CYXqkN03SrAUkPoXkrVeKpLoIgk08VNp1jqJI7RuyX9AS
         DhVi7LBxLRaK+iyyZ6we6XAANJBMKO0Gyu6gvpAOfp6UIDMYcwSyvFii9vNgL6BGeW5J
         DjIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o012SHvPj5zgU3QBeDKlShRnobqJxcJuQYC3/1lC2yI=;
        b=TmP3NatUd2QY2j3kjCNgL95mJJQUAYKqBJDeZNFpydFlY2tBfNpJz4SDfelYfhwBCw
         gm3Cyd3Omk6o4/4Ypht6Vauj76UAgZEu9nXA9UroQtRX/NFB37a6ko/tO/ZqKephwky6
         Lz4AoEwigOX71Ck+epscxm+gll1Qxni74SYbhVgpZQsVHyWskqh0XwbcHFLkvIAO1qZa
         gbND1NYTt+dz85Qzjjsqs5mawVX+SXTG3aJNiw3Sq3BV2bxuGFZ887aMVk0QsWUfcsKM
         k6sqBgIIygS2ceKFuq0Nw/Vs3iIFsoLaaA5OeyJlNg2BXV4AM80KcUxIgT6xvfrq8hNB
         UOpg==
X-Gm-Message-State: APjAAAXtmAajWLdZ4gh7Db365uMx3kFfuVPm6dXmEywxyW/nCRR3Wl4X
        gm1t9oyemGqDqJAVH4LsHrddPA==
X-Google-Smtp-Source: APXvYqyrE0PahE7BJdzQhjXsmzpcsoQsDkpiKHbZ7i0j25iI9g/HQbtekIWYckHAegQ7R0mrbPuQQg==
X-Received: by 2002:a7b:cc86:: with SMTP id p6mr23222709wma.116.1572877395942;
        Mon, 04 Nov 2019 06:23:15 -0800 (PST)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:58da:b044:f184:d281])
        by smtp.gmail.com with ESMTPSA id l18sm21692446wrn.48.2019.11.04.06.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 06:23:15 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH 5/5] clocksource/drivers/asm9260: Add a check for of_clk_get
Date:   Mon,  4 Nov 2019 15:22:57 +0100
Message-Id: <20191104142257.30029-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191104142257.30029-1-daniel.lezcano@linaro.org>
References: <6fd4d800-b1f8-d757-458e-23742d20884c@linaro.org>
 <20191104142257.30029-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>

asm9260_timer_init misses a check for of_clk_get.
Add a check for it and print errors like other clocksource drivers.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20191016124330.22211-1-hslester96@gmail.com
---
 drivers/clocksource/asm9260_timer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clocksource/asm9260_timer.c b/drivers/clocksource/asm9260_timer.c
index 9f09a59161e7..5b39d3701fa3 100644
--- a/drivers/clocksource/asm9260_timer.c
+++ b/drivers/clocksource/asm9260_timer.c
@@ -194,6 +194,10 @@ static int __init asm9260_timer_init(struct device_node *np)
 	}
 
 	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk)) {
+		pr_err("Failed to get clk!\n");
+		return PTR_ERR(clk);
+	}
 
 	ret = clk_prepare_enable(clk);
 	if (ret) {
-- 
2.17.1

