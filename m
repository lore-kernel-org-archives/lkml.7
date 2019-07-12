Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8475C742A8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 07:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD08E20863
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 07:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrtWikF6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfGLH0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 03:26:42 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36099 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfGLH0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 03:26:42 -0400
Received: by mail-pf1-f193.google.com with SMTP id r7so3927952pfl.3;
        Fri, 12 Jul 2019 00:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GM4E4omai6eUpjjddeuGvkdyjfxAyCJ8u0HfjV4CSgM=;
        b=VrtWikF60K5u7Np2ZPQAb5qhwb8APG0QWk6xD8wZVT5sAbatel/6WvweQLuiu+jOmH
         d8ghD9oVVCeD801BozuxJaAZ3yD4sP6hoI9FaM14Doig8m4cuxdIZOXu4MywMZQ1nl2Z
         cCVsAusIYq24+cD9r4BKrBhVvZF6Aawil78oZM3DAyUemEleBVmwKp/W88B8iEWpz5eP
         TzOcDvTe1KlxOkA5k1oOh5d5NplC0ltF3MPBIB8i7eFwiMD/WcrgKLtt4QkX4nzB5T6e
         8wZQUQIV+0r/n3QVKHmJbWI7Ae+6MP4VhxdNwEe6/7IO7h38mFSHU+2x/27Dj1fctS5K
         twjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GM4E4omai6eUpjjddeuGvkdyjfxAyCJ8u0HfjV4CSgM=;
        b=GHyiLBfseuPCMT3aFPBS5wopkrAfV/4/h7tGUkvvR25Cbc81dEkpyaBWwacFdf2Bvu
         UVsBPSB5hEkkTplM586jf1bwoYRTlyUHC21u+X0jeLH8/eVo4K/QxZbYH+5vY5sN3wgl
         TC7qi+euSPYhBhQRQtFkHJKRlUkZNscQorOaqkPiiF3PEgnuoH9kbMhBNZQKdwqNsHL9
         g7JRdrDtpEEkWuqOUW3EayDYjTWRvQTBjS3cpK5Bfch0uoIJRjm/tbzawm7nL7Xoajae
         bxyhVxS2r/1LDeSm3WjoSOaJxWXsUUehtsdWzE5/5Njho+BGd/uosxi0ZHTbXutw/Tgj
         m1LQ==
X-Gm-Message-State: APjAAAUL9yHp+2xSf0OTiyS8os1Gdg9mosjR57L0t1EWz3hAmzqBMvHW
        IWuEHh8vK5gPKEeukD/GWoE9ipeZseE=
X-Google-Smtp-Source: APXvYqztXegq2ZsLM8aK1h6VgHcW+DGB0dnrXVu7KE6Td9QrRPf+FzaxubdlwNmmHl3Unq6C2BXJEQ==
X-Received: by 2002:a17:90a:5806:: with SMTP id h6mr9638201pji.126.1562916400651;
        Fri, 12 Jul 2019 00:26:40 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id c8sm13795725pjq.2.2019.07.12.00.26.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 00:26:40 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] usb: dwc3: Use devres to get clocks
Date:   Fri, 12 Jul 2019 00:26:33 -0700
Message-Id: <20190712072634.3107-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devres to get clocks and drop explicit clock freeing. No
functional change intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/usb/dwc3/core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index c9bb93a2c81e..768023a2553c 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1436,7 +1436,7 @@ static int dwc3_probe(struct platform_device *pdev)
 	if (dev->of_node) {
 		dwc->num_clks = ARRAY_SIZE(dwc3_core_clks);
 
-		ret = clk_bulk_get(dev, dwc->num_clks, dwc->clks);
+		ret = devm_clk_bulk_get(dev, dwc->num_clks, dwc->clks);
 		if (ret == -EPROBE_DEFER)
 			return ret;
 		/*
@@ -1449,7 +1449,7 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	ret = reset_control_deassert(dwc->reset);
 	if (ret)
-		goto put_clks;
+		return ret;
 
 	ret = clk_bulk_prepare(dwc->num_clks, dwc->clks);
 	if (ret)
@@ -1536,8 +1536,6 @@ static int dwc3_probe(struct platform_device *pdev)
 	clk_bulk_unprepare(dwc->num_clks, dwc->clks);
 assert_reset:
 	reset_control_assert(dwc->reset);
-put_clks:
-	clk_bulk_put(dwc->num_clks, dwc->clks);
 
 	return ret;
 }
@@ -1560,7 +1558,6 @@ static int dwc3_remove(struct platform_device *pdev)
 
 	dwc3_free_event_buffers(dwc);
 	dwc3_free_scratch_buffers(dwc);
-	clk_bulk_put(dwc->num_clks, dwc->clks);
 
 	return 0;
 }
-- 
2.21.0

