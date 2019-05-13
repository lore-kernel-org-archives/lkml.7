Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA50C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B10A21019
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xtpCY5Ls"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbfEMKap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 06:30:45 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33082 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbfEMKaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 06:30:11 -0400
Received: by mail-wm1-f65.google.com with SMTP id c66so5806666wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 03:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wJ/OTTzXkpFYyCPQfFmBGF9g9r7JKprAJcxNABvYugk=;
        b=xtpCY5LsYPDsHS0aQCf3Xs367A7e/JZ4MUxHD3yChdm5d5/d6cWgO0DgGd0Am/gJg9
         tdqFHUW/+rdS2nzakkntj61aw8YL31HhsFeekfYFEbXiomu+/h0A/lmkMCuUzA5AXtIT
         YUr//hEHu6lVOI8OCOoxYWiQGYhitb9o95p22sGpZmJ7vWNLEvDx+U7SLXNm/ekwDR9U
         HsJPZRh+4YzjMhGb1aoJznB2VHK4XrVuYuURPlWBbyWxt/7j9o0qNxNp54nMFkezKnYN
         2MZYU0L+RAYvIxscoVd5Pi9VQGLw0yTluQ60aX3zY9Qxpydj/1W3KMVfT0mPHd8VRI0x
         4QJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wJ/OTTzXkpFYyCPQfFmBGF9g9r7JKprAJcxNABvYugk=;
        b=ItlHAjCvv7D0L+NUn3hEAGWIos4qlnyI7TpeqGoEto3x0vtTwGpn9jmaZbKFZU4UlZ
         vv0CQkT53H1oAG5KQ+uRifkTkHKMASuFzN+IhSV4GU5XugL/GHEh8BjMNmlt0tZesaMp
         a7fs3XWfh2ZhMyHCN1GjXjl3hNZj+LLEMXePceU6etut5d2c4yuxGMByVM7GVYc91lSv
         DPFacJhPxtxOW08dol33WDKCfhmiqIRd1m1R6uitUNF4hU96BWjBo5aXoPYTb12T4ht6
         8/9c1Nju3TP5xSlaL2rf7tHaJilMJ+tFBesxUl8hAzzPSvTXdPi6tC9D7Z0VzyoHksj6
         cnTg==
X-Gm-Message-State: APjAAAWf66p7x1509Y8t8R/jfhD7xrJQnP4C2yy4cMkV8mUr4hSH7Ag9
        0saWaAomeUvEGj2azRWELS1ylg==
X-Google-Smtp-Source: APXvYqwRje32oVCrQ0KCh4j13YzwrZdUzzxr+G5RY0NhhKH2Pkd6tgaAWHmWI7GugGQnUzyTzEsopw==
X-Received: by 2002:a1c:a684:: with SMTP id p126mr10382552wme.101.1557743408653;
        Mon, 13 May 2019 03:30:08 -0700 (PDT)
Received: from clegane.local (205.29.129.77.rev.sfr.net. [77.129.29.205])
        by smtp.gmail.com with ESMTPSA id v192sm13645238wme.24.2019.05.13.03.30.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 03:30:08 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] genirq/timings: Use the min kernel macro
Date:   Mon, 13 May 2019 12:29:48 +0200
Message-Id: <20190513102953.16424-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513102953.16424-1-daniel.lezcano@linaro.org>
References: <20190513102953.16424-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The' min' is available as a kernel macro. Use it instead of writing
the same code.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 kernel/irq/timings.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/irq/timings.c b/kernel/irq/timings.c
index 06bde5253a7d..8928601b4b42 100644
--- a/kernel/irq/timings.c
+++ b/kernel/irq/timings.c
@@ -406,8 +406,7 @@ static u64 __irq_timings_next_event(struct irqt_stat *irqs, int irq, u64 now)
 	/*
 	 * 'count' will depends if the circular buffer wrapped or not
 	 */
-	count = irqs->count < IRQ_TIMINGS_SIZE ?
-		irqs->count : IRQ_TIMINGS_SIZE;
+	count = min_t(int, irqs->count,  IRQ_TIMINGS_SIZE);
 
 	start = irqs->count < IRQ_TIMINGS_SIZE ?
 		0 : (irqs->count & IRQ_TIMINGS_MASK);
-- 
2.17.1

