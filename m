Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EB2C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB6472089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G96811NZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729448AbfG3SUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:20:18 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36268 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728908AbfG3SQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:16:11 -0400
Received: by mail-pf1-f195.google.com with SMTP id r7so30265393pfl.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 11:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E+MiLS+xhjrkSb6B0r1a1/QGKNXodQxyYWlsCL6Y4A4=;
        b=G96811NZowBWx8RM/8lPqU0uWnzoV43lyEhEiNDC0B8Ntygzpg57aZQieTSTQPjbXc
         jwoQ8euvvqXmq+10x180vCL7O299Dl8mj60LA7ya5Zo4b/p6YLPXYGgk8b4PQbjxNGKy
         BB3zQ98TWq99wGSkt3z/iLzylpg7+dRw7u2NQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E+MiLS+xhjrkSb6B0r1a1/QGKNXodQxyYWlsCL6Y4A4=;
        b=Kt3bcMEKKVsy/mkC3tPVOYc1WsKF2nNGukGuHR8oHstzsvBoFx1EdIfWcqhimgKJ8H
         wg4JmFFiuagNJANwGSMC/Z5ewo/2wZUdH8y1NcwEPEQzTBuPAxvmumIiXUJozJZVOTz/
         rNhM/7DEAuR3iskqDZage8iNUZVJQkAtdRMqeGPLviJeWPG8WhSeUnWcUsg1hrUJoKQq
         1EmZjF3RlCkAZfok9Z4K1mM3SkW1m6BRUYmhOC6xPTyNLhXdK8meauUw4ZUzui/8qOBJ
         reW6ntBs64jOVia3eGri4kjeSrgWQWid+rsVDAoj3nu5kUHxDFG3f7fp9Eay0enb3umB
         ppWw==
X-Gm-Message-State: APjAAAWZKb3Fq4VEVRSBw6pY2qfvgc2TShG8z5funucV9uAfNvcKy6v0
        C/7g3KCUTwC6kstgr1ajxXAlCobE6ns=
X-Google-Smtp-Source: APXvYqzbrY/tkzXZgdp9CMLN1AYx+zVWfEtA8YA9y8O02ruiBFQxYiMzRzG8nCy5OiSmhBfC0UU7Cg==
X-Received: by 2002:a17:90a:9301:: with SMTP id p1mr117756399pjo.22.1564510570617;
        Tue, 30 Jul 2019 11:16:10 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g1sm106744083pgg.27.2019.07.30.11.16.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:16:09 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v6 13/57] firmware: Remove dev_err() usage after platform_get_irq()
Date:   Tue, 30 Jul 2019 11:15:13 -0700
Message-Id: <20190730181557.90391-14-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190730181557.90391-1-swboyd@chromium.org>
References: <20190730181557.90391-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need dev_err() messages when platform_get_irq() fails now that
platform_get_irq() prints an error message itself when something goes
wrong. Let's remove these prints with a simple semantic patch.

// <smpl>
@@
expression ret;
struct platform_device *E;
@@

ret =
(
platform_get_irq(E, ...)
|
platform_get_irq_byname(E, ...)
);

if ( \( ret < 0 \| ret <= 0 \) )
{
(
-if (ret != -EPROBE_DEFER)
-{ ...
-dev_err(...);
-... }
|
...
-dev_err(...);
)
...
}
// </smpl>

While we're here, remove braces on if statements that only have one
statement (manually).

Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please apply directly to subsystem trees

 drivers/firmware/tegra/bpmp-tegra210.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/tegra/bpmp-tegra210.c b/drivers/firmware/tegra/bpmp-tegra210.c
index ae15940a078e..890186abeac0 100644
--- a/drivers/firmware/tegra/bpmp-tegra210.c
+++ b/drivers/firmware/tegra/bpmp-tegra210.c
@@ -202,10 +202,8 @@ static int tegra210_bpmp_init(struct tegra_bpmp *bpmp)
 	}
 
 	err = platform_get_irq_byname(pdev, "tx");
-	if (err < 0) {
-		dev_err(&pdev->dev, "failed to get TX IRQ: %d\n", err);
+	if (err < 0)
 		return err;
-	}
 
 	priv->tx_irq_data = irq_get_irq_data(err);
 	if (!priv->tx_irq_data) {
@@ -214,10 +212,8 @@ static int tegra210_bpmp_init(struct tegra_bpmp *bpmp)
 	}
 
 	err = platform_get_irq_byname(pdev, "rx");
-	if (err < 0) {
-		dev_err(&pdev->dev, "failed to get rx IRQ: %d\n", err);
+	if (err < 0)
 		return err;
-	}
 
 	err = devm_request_irq(&pdev->dev, err, rx_irq,
 			       IRQF_NO_SUSPEND, dev_name(&pdev->dev), bpmp);
-- 
Sent by a computer through tubes

