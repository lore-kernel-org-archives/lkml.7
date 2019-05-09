Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B7BC46470
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 11:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98CBD21744
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 11:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N1bOovgD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfEILLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 07:11:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46206 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbfEILLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 07:11:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id r7so1824456wrr.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 04:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4vJDMe7+EQ4+NOcbJfE9TymlnXHgYOUGu64vsRLBkac=;
        b=N1bOovgDjxCRyHOozwBdr42aE3KEoSM4ABOm+YSUuvTxYz3N728+NYFaeNVTcHhB0w
         3+Tx/HAv1FP50LvgicZ8laxj3XvtiordKj+YJLDEBoqokxdbTbzTAalpDNk/2vC+e58q
         WAdIzJT6dybx3AOR3ifdPuxguzLh13XNSoJOXnb/Kdl6QYsFH4ZD6GAfs9kPjkHmOPoK
         fZjoUPBluexqvw1CE0LavuhSczNnGnjhgFrwb6lq5V/tecgYmqreqn1pj2jgZsGOOcgV
         AVhkLr4yOErKM1I90wdvH2P6ZggUA8OUIohUGVPqOIar4GlqY1tqXNvAeDtfA68nre1g
         p3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4vJDMe7+EQ4+NOcbJfE9TymlnXHgYOUGu64vsRLBkac=;
        b=pVagcJ3/+1CXxviQ2FY+XHLlQ4Sxxxyl1PvMeEOdLiuwWibdMOswddsShn6vOK7QuT
         mT/tMai4dreO9VxVm6xneAxT7oUxpj5JjP/EMon/N8CixGgIChb4RVUEGYnegbMyc4oZ
         v7AiY7RPX0pB+hex8NC62N9XRGGKBkFJVCMCdPbUhZzlt41j4p+B/O+j4zB8JxI5RNxd
         z5AuNwhbWZAe5GC5ZvU8SNLBcSmsVZ2uU0aIvOY8wCbwcOBNfyKyBtU+Y5PgBvXIPNa7
         95JwRJje4PWyw9kG7M3qwbAIZKcA5ew8VN0bOYyGJp1pKJmcfCGJqJtLhgdQfanNu8Yk
         hbqQ==
X-Gm-Message-State: APjAAAXrnL27M4ALktYdzIBgvcwnKQ/Hse0BZHc461Y1tYbldapX26q4
        5sPfrjlZgCNfM3XGk1KjI8eSTQ==
X-Google-Smtp-Source: APXvYqyznM88ESRAs+LX3rzCPuecwtfM5D1R3IAEYLE5GOnO4E4PyptKT1HZIjfQ8cevLhVUeuZ26Q==
X-Received: by 2002:a5d:4a44:: with SMTP id v4mr2574684wrs.84.1557400304781;
        Thu, 09 May 2019 04:11:44 -0700 (PDT)
Received: from mai.irit.fr ([141.115.39.235])
        by smtp.gmail.com with ESMTPSA id z7sm2299778wme.26.2019.05.09.04.11.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 04:11:44 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip
        (AT91) SoC support)
Subject: [PATCH 14/15] clocksource/drivers/timer-atmel-tcb: Convert tc_clksrc_suspend|resume() to static
Date:   Thu,  9 May 2019 13:10:47 +0200
Message-Id: <20190509111048.11151-14-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509111048.11151-1-daniel.lezcano@linaro.org>
References: <7e786ba3-a664-8fd9-dd17-6a5be996a712@linaro.org>
 <20190509111048.11151-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kbuild test robot <lkp@intel.com>

Statisticize tc_clksrc_suspend and tc_clksrc_resume.

Signed-off-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-atmel-tcb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-atmel-tcb.c b/drivers/clocksource/timer-atmel-tcb.c
index 9de8c10ab546..6ed31f9def7e 100644
--- a/drivers/clocksource/timer-atmel-tcb.c
+++ b/drivers/clocksource/timer-atmel-tcb.c
@@ -66,7 +66,7 @@ static u64 tc_get_cycles32(struct clocksource *cs)
 	return readl_relaxed(tcaddr + ATMEL_TC_REG(0, CV));
 }
 
-void tc_clksrc_suspend(struct clocksource *cs)
+static void tc_clksrc_suspend(struct clocksource *cs)
 {
 	int i;
 
@@ -81,7 +81,7 @@ void tc_clksrc_suspend(struct clocksource *cs)
 	bmr_cache = readl(tcaddr + ATMEL_TC_BMR);
 }
 
-void tc_clksrc_resume(struct clocksource *cs)
+static void tc_clksrc_resume(struct clocksource *cs)
 {
 	int i;
 
-- 
2.17.1

