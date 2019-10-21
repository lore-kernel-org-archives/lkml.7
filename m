Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAEECA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 20:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 738E12067B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 20:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C42Mueuz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730170AbfJUU0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 16:26:36 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:40858 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729388AbfJUU0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 16:26:35 -0400
Received: by mail-il1-f193.google.com with SMTP id d83so4808830ilk.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 13:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YUr4Z8AVtpytf5hqPhoEfjM2QU/haufjelcazFqZdDI=;
        b=C42MueuzIG0eurQVvyszFEh1vHQ5Bly/jv8jo9gXLNAv6nVgrF03IlqiBKOpXckont
         WNtrmzny+GW3nWjHQrtaZ8o6E4KDyBAlJ9DqrLMHPKmrExHB5hCSRG+SEYXnfxC2h/VK
         XARksHyat0EvVOGKoEBluIgw+fCDmRtCjs2poqSVU9Ngsswgc8jxnjQYiMosovj/SD5X
         MwzDwywkZLZTrxjrpaKNt7INgtPoRCfNJqTC+1A8l4AXL9mgZlT3Tsg8XfdqEDS5+RF4
         nCnMnXl76ofcGrZ+FQda6eZhnU7M3bvWGcy3GuN9iJSYIuj/RGkDQSOctYm+KX6BfdQC
         nz6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YUr4Z8AVtpytf5hqPhoEfjM2QU/haufjelcazFqZdDI=;
        b=WDSg7unx2OQQEVaWJxzYxDJzTSUnNOuD/y0nWd1t34xVQu8mHRADQWtZZNsIA+ig8x
         TnqVim7HUMWyQLjyEyray+JeaZWbgYElwG0ce/rmaTMXs1JBO0Gi/9Z9EyUvu5a+V44d
         joEQqxXpEbgZLubNVfULzQseBeAhp+jHf61or+SDUX18qvooU3D4ZxpaifY3Oo13hc8e
         7GdkB4brj4b/RKZSEbc5Cbr03V23c5uUOXK0iM23C6TKofOFZhW44H5ZxxL/XWyHGatY
         6FTjKdHuudrQZlE4QvZMUBTNRIL8tFWiF71NOnr/JmxqgXwABOYJIPE2CyfYTeLhFyFC
         4SRA==
X-Gm-Message-State: APjAAAW97sPKijwxmL2KwTJXywZcAgoLwx5j8EJuKEngpQGYMSCNGKs0
        MCrmRZbVqr7fC73EON3YJfE=
X-Google-Smtp-Source: APXvYqxOCcAymeW1sck45BJLBQJ3ERjWLB40X/2QKSPGwqNUoxKzUriQdnqYq3IloP/wdGgZ6UIWTQ==
X-Received: by 2002:a92:9198:: with SMTP id e24mr5368777ill.184.1571689594969;
        Mon, 21 Oct 2019 13:26:34 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id b3sm5941106iln.42.2019.10.21.13.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 13:26:34 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clocksource/drivers/davinci: Fix memory leak in davinci_timer_register
Date:   Mon, 21 Oct 2019 15:26:25 -0500
Message-Id: <20191021202626.5246-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the impelementation of davinci_timer_register() the allocated memory
for clockevent should be released if request_irq() fails.

Fixes: 721154f972aa ("clocksource/drivers/davinci: Add support for clockevents")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/clocksource/timer-davinci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/timer-davinci.c b/drivers/clocksource/timer-davinci.c
index 62745c962049..910d4d2f0d64 100644
--- a/drivers/clocksource/timer-davinci.c
+++ b/drivers/clocksource/timer-davinci.c
@@ -299,6 +299,7 @@ int __init davinci_timer_register(struct clk *clk,
 			 "clockevent/tim12", clockevent);
 	if (rv) {
 		pr_err("Unable to request the clockevent interrupt");
+		kfree(clockevent);
 		return rv;
 	}
 
-- 
2.17.1

