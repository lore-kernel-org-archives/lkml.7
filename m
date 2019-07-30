Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CF6C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25006216C8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dVuSDzML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387943AbfG3SQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:16:22 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35387 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbfG3SQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:16:12 -0400
Received: by mail-pg1-f193.google.com with SMTP id s1so24174646pgr.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 11:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pSxaD1cvDX0l0dBtzAMeJgIp940IH2B46uMy0iM1GB4=;
        b=dVuSDzMLTviKBGZ53KKiOY0XqYsOyAgG25J621ZBW6qyaxu0WMuC8HeQIxZkmWGKhh
         /EdV7NmqaIEZRNmikoQx4MADMjjEpHXudU1KTzY2LyXQu5ugIjzuQeTcWX5PgXyiVUEo
         4j3e25Qx8a+r6/FIMt2T10YU0KCfd/Gw/6R84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pSxaD1cvDX0l0dBtzAMeJgIp940IH2B46uMy0iM1GB4=;
        b=PGnUncN3jvZh2vQ7REGCt1MgiPlmKR6Xbz83naE6ZY7OoL4YEq7qJ6SjkZPyeNArIH
         LYTh8Rhoj8wnZNUi1cAWNwiWAU7LTmQmpD95kAINqdOmqBFkJEBxjUz7mzmc/dDE+yC6
         0FYYYkklFG+TJg08nPU4ZX4+XdWKLHGmtIhH7gDIgDyORIOfeRUYD0EHrGB/euw3cQ/K
         UIXoTv8fjr3/jJ+ViPlPATtFEl0GWyaHYPjJ5VErx/RUqrHfV/EK/hJaNzMOzmQvc02t
         VsfvHKi6Ika6henQ32r0rB4IwnirnbtvwA0P0oPfhbrY4D/pojFhBLChm7moEPBbPudj
         LVhw==
X-Gm-Message-State: APjAAAXO0VvWnbj343Zrre2DXvHTPMO6M4zWy3wkoKwD44C/8EcDno7p
        yZ7hyaGzEzU5QFA7B1MgGmyc0SEPNlE=
X-Google-Smtp-Source: APXvYqxSiEVJeXi09dB4/iinN17Ab01YAZHjh+BReb6f6qTSeScWj6ZV6UNPwu5NIoes1J0qimKkKA==
X-Received: by 2002:a62:1bd1:: with SMTP id b200mr42338409pfb.210.1564510571326;
        Tue, 30 Jul 2019 11:16:11 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g1sm106744083pgg.27.2019.07.30.11.16.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:16:10 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v6 14/57] fpga: Remove dev_err() usage after platform_get_irq()
Date:   Tue, 30 Jul 2019 11:15:14 -0700
Message-Id: <20190730181557.90391-15-swboyd@chromium.org>
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

Cc: Moritz Fischer <mdf@kernel.org>
Cc: linux-fpga@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please apply directly to subsystem trees

 drivers/fpga/zynq-fpga.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index 31ef38e38537..ee7765049607 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -578,10 +578,8 @@ static int zynq_fpga_probe(struct platform_device *pdev)
 	init_completion(&priv->dma_done);
 
 	priv->irq = platform_get_irq(pdev, 0);
-	if (priv->irq < 0) {
-		dev_err(dev, "No IRQ available\n");
+	if (priv->irq < 0)
 		return priv->irq;
-	}
 
 	priv->clk = devm_clk_get(dev, "ref_clk");
 	if (IS_ERR(priv->clk)) {
-- 
Sent by a computer through tubes

