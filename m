Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F17C2D0CB
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 13:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F12772467D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 13:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GweBf684"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfLONxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 08:53:19 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36225 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfLONxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 08:53:19 -0500
Received: by mail-pg1-f194.google.com with SMTP id k3so2156378pgc.3;
        Sun, 15 Dec 2019 05:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=F+7PYqMmtcZUrcYIJM/i90K58GWESr+2/oVNmo6E2TM=;
        b=GweBf684G0VM3rBai6Cr2ab3OMQJwlkinQuGIWtcWn/srhjrmrA/slPrMrg1+EiBy4
         Rmn1eMVfS5LEKL+G0W4GEAKhAXl3hSOkWhlUAeZDNMQnMp2TsPyXD/Glq/xykBeugbEw
         nvCEi0dqz5FwIAZ4AIV7EAZC00Y+IkUIqXcPYsR/iK4pykrpk0WDli1j7IuxDtUJIppv
         N97Ohd8T4r3+yzzlEBemMbyLbQ19ZM63TA+U+vJqQ1K6yqBsBN1JwIoFfRMshd/GshNK
         RH4/4N1OSuq+5DOolt+LJS5G8K0LmOXdoLjH/BN2kyvaig0H8MBuKZZKrC6j7GUDWHaa
         tEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=F+7PYqMmtcZUrcYIJM/i90K58GWESr+2/oVNmo6E2TM=;
        b=Mm6CcFujJmo35GlhyNF/TuH7nJvbSyCuhs1SlUIhDIfEhEoCHR8H4Y2GpcVoGPj5KO
         NeLhTOhPkxxZYY/2Ch2DO5cE/3SJOpLBrBRNzW6ABvLbuQeTHC8LrKr252FJLjYo39FN
         Q7Eh7BT+LpO7meg2ieOeJPMCalxsUIOECV8tAvH2R/L8w2FlvKHOguQJgosiz9A0C6ze
         +x909SJt6Io3JX+WKaYSMXwkXyyxogn02nQh6ZAQkh5JKSY+g6KvLeDrzHL49yNUO+vJ
         oB3wF+ifiCKFiaqk2GCyDQQ/JKbEpJ2pgFSdfl+TXgT8szzVEuWLoPgx/CW0iDFJ3hJJ
         6MAw==
X-Gm-Message-State: APjAAAXf31ofP2qHPQA7es2zt/KIV11hyt3eWVB2PKpAVhNt4mt8gxMI
        6MPVq4o6RBcdFBqmKv7EQnU=
X-Google-Smtp-Source: APXvYqxXJkAsV8yHg1GoZBKuVsSVXvzUxrMPybKz+apkWNWpA09kgmFG+igs8TzNO6i+vyRPtp+h7w==
X-Received: by 2002:aa7:9839:: with SMTP id q25mr11101715pfl.161.1576417998524;
        Sun, 15 Dec 2019 05:53:18 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id a10sm18291446pfc.35.2019.12.15.05.53.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Dec 2019 05:53:17 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, heiko@sntech.de
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] PM / devfreq: rockchip-dfi: convert to devm_platform_ioremap_resource
Date:   Sun, 15 Dec 2019 13:53:15 +0000
Message-Id: <20191215135315.30656-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/devfreq/event/rockchip-dfi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index 5d1042188727..cc5d4c01af0b 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -177,7 +177,6 @@ static int rockchip_dfi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct rockchip_dfi *data;
-	struct resource *res;
 	struct devfreq_event_desc *desc;
 	struct device_node *np = pdev->dev.of_node, *node;
 
@@ -185,8 +184,7 @@ static int rockchip_dfi_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	data->regs = devm_ioremap_resource(&pdev->dev, res);
+	data->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(data->regs))
 		return PTR_ERR(data->regs);
 
-- 
2.17.1

