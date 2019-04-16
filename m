Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5376DC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 12:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FAED205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 12:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PK1cKNoN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbfDPMrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 08:47:00 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36932 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729041AbfDPMqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 08:46:52 -0400
Received: by mail-wm1-f66.google.com with SMTP id v14so25265773wmf.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 05:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KINNwFG/iIOr+44tFPkVT2Gr4tEIy3ljx/6ulQdSFwc=;
        b=PK1cKNoNOC1SksVgIDu+870gB3TvUFca/U2d83NkOYPFVtl0P4SqqcbevFtUS+q1Nk
         M1bIVnL9aicMFFlDE+1ZcyzkyqxNxK0CM68jZ+SasnMfjWdEMCapZKcTZbJr3lhuN+5K
         UxbrpjEXvVtIyE1Y7ZuB2TnnIb1wFE2ZXP+wYDf1CAhTZffRcI1eYNm3F4+FpScnUk8Z
         WKgzMM0xseDsA1Qq8UD4wat54oDj9etePoKOgNzEAhK9xam7SwTKlX4vaKYWml5yan/q
         IpFdKVT1lnvbHawNbbFDdTdUg6hS+cBFiFy5HyQgd1LP+ZB5nx7SNXkTe0uwielFgzE4
         qK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KINNwFG/iIOr+44tFPkVT2Gr4tEIy3ljx/6ulQdSFwc=;
        b=kJTuPmGZDKmXz+zOLkmdE9lnVZc6DVY+bkUxKS2q16k3FXKAhGgksXOH0TWdRgN3Oh
         NlkgG1wP4nDgvrh2zuG9QQyUxMvQy7XHlwt+Fqv1dxHAieF6Grr3q7eIHzJwn6vk/jV2
         kF+YYZtMBrwYEKibnR6HsjKi2YEC+G2s2Fg70xAsG7d+lLMrUHsg9kUp5nNjQGMhy3jU
         bleOCg3pbNg48pT7FNlE1OElA3CPDzHLJOF89Z2DFYzTcYYuWV4NDH0yrgMboqHPyIBx
         X87P1UxRusb9g3mLGchKxxcaf1uXP1GlgAcQj7lom5skU/q3Xggz5Rny0kQKtZkK1OJg
         gufA==
X-Gm-Message-State: APjAAAUUem1j6zUHAJeNlghNSVxmLvE8+8iVGtxA+br2WvY1yH2BlPWl
        DQoy7JWB2BfXYLgPj1oaoL1Fuw==
X-Google-Smtp-Source: APXvYqwQ4Wg/kWlIQ2GZdMVpYhRuIFtZYXlaGEe8yW8ZljhPM32ws1+skqMhu6VBK5/ZTOEir2VakA==
X-Received: by 2002:a1c:eb07:: with SMTP id j7mr25481124wmh.138.1555418810253;
        Tue, 16 Apr 2019 05:46:50 -0700 (PDT)
Received: from mai.imgcgcw.net (50.251.95.92.rev.sfr.net. [92.95.251.50])
        by smtp.gmail.com with ESMTPSA id p6sm42823732wrs.6.2019.04.16.05.46.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 05:46:49 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Daniel Golle <daniel@makrotopia.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/OXNAS platform
        support),
        linux-oxnas@groups.io (moderated list:ARM/OXNAS platform support)
Subject: [PATCH 3/4] clocksource/drivers/oxnas: Fix OX820 compatible
Date:   Tue, 16 Apr 2019 14:46:39 +0200
Message-Id: <20190416124640.20058-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190416124640.20058-1-daniel.lezcano@linaro.org>
References: <92427592-507b-e280-01bf-763d795c8a2f@linaro.org>
 <20190416124640.20058-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neil Armstrong <narmstrong@baylibre.com>

The OX820 compatible is wrong is the driver, fix it.

Fixes: 2ea3401e2a84 ("clocksource/drivers/oxnas: Add OX820 compatible")
Reported-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-oxnas-rps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-oxnas-rps.c b/drivers/clocksource/timer-oxnas-rps.c
index eed6feff8b5f..30c6f4ce672b 100644
--- a/drivers/clocksource/timer-oxnas-rps.c
+++ b/drivers/clocksource/timer-oxnas-rps.c
@@ -296,4 +296,4 @@ static int __init oxnas_rps_timer_init(struct device_node *np)
 TIMER_OF_DECLARE(ox810se_rps,
 		       "oxsemi,ox810se-rps-timer", oxnas_rps_timer_init);
 TIMER_OF_DECLARE(ox820_rps,
-		       "oxsemi,ox820se-rps-timer", oxnas_rps_timer_init);
+		       "oxsemi,ox820-rps-timer", oxnas_rps_timer_init);
-- 
2.17.1

