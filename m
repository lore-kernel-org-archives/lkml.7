Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9272DC2D0C6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 19:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E6F220838
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 19:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzU+fMIs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfL1SyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 13:54:12 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35502 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfL1SyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 13:54:12 -0500
Received: by mail-pf1-f194.google.com with SMTP id i23so10923142pfo.2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Dec 2019 10:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=588nZdPWSQouHjrbTQFmmqqGhpH/jdEr/402TOJdIJc=;
        b=KzU+fMIscpUWow82dmtcE1NqW4BtUv9qlJ/V66IIlkZOW1slFsk8PIok3Yt6Y1Xohd
         O7rBugj37TUVCItVg94RKD7rHZNospOTzMhKAcuEKkwZetrwVTxS1TAf4zTj9ec0wxZ4
         hn2kYpoHyoLA3YvCETC8a3ghKsA4SWv5bCq3lU1ZggIf1PKZVO9iMqZP2XXMa6rxemHB
         lRUsNUPtrn4bWrL3RwTAev+KCtNaKRPR7RriLMkRIJqs1AGBj5ZWhveSLBPCT2k28NKF
         60vsaswEps2QEApSLKcau8AyvC6kp4uWs1QxSu8j370Fz0BlLRes/qnOZC4QIxN6k1r0
         05Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=588nZdPWSQouHjrbTQFmmqqGhpH/jdEr/402TOJdIJc=;
        b=Fi+HjoO5d2AYQ2KDAtOdOb+h68Yovl4z/NZiBvHTODxRYm2GgaaQiF8NS3GXfvuD9G
         tj2Gk1apVQl8CBfweq7Eoaza5FwTUxfEmiNs0F7s27OzVMqqkjkgIGj9eOSU9q3L1UFc
         scfkqH1k/v73DcmR+QJoz6HoIoh8cyD2Ii6uwDPfcvp0fDT2ome9LZPeOmhpsLfwvgdj
         d8UMXDUKgP/yYGKPDxrPhhwf/JPk7tsEjdia+rPM/HNH+U8nenUFbkslUsgN0W/i/RIK
         PHq1eORAzSiGm2dhw+A7pG53McRK3e1MORfVWCbpmE5lhjfugokst7zy0UHe/+rCGygU
         IQLA==
X-Gm-Message-State: APjAAAUX/YaZxCHVMXCG8aNF/PSnqJjzTaLG/2z57+QTYYYic428Uin+
        KM+J79d4kr4zgxkSN5w2I3U=
X-Google-Smtp-Source: APXvYqyMHrB05SJ3/Gp0VgA5qfEvy9nXYHMD8qUa30Vtq3e4UjI6m5ninFt+t5uVVWIN4TnGLFJqyQ==
X-Received: by 2002:a62:4d87:: with SMTP id a129mr61018157pfb.116.1577559251648;
        Sat, 28 Dec 2019 10:54:11 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id j125sm44497385pfg.160.2019.12.28.10.54.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 28 Dec 2019 10:54:11 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     vitor.soares@synopsys.com, bbrezillon@kernel.org, pgaj@cadence.com
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 1/2] i3c: dw: convert to devm_platform_ioremap_resource
Date:   Sat, 28 Dec 2019 18:54:05 +0000
Message-Id: <20191228185406.26551-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/i3c/master/dw-i3c-master.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index b0ff0e12d84c..7b941e93337f 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -1100,15 +1100,13 @@ static const struct i3c_master_controller_ops dw_mipi_i3c_ops = {
 static int dw_i3c_probe(struct platform_device *pdev)
 {
 	struct dw_i3c_master *master;
-	struct resource *res;
 	int ret, irq;
 
 	master = devm_kzalloc(&pdev->dev, sizeof(*master), GFP_KERNEL);
 	if (!master)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	master->regs = devm_ioremap_resource(&pdev->dev, res);
+	master->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(master->regs))
 		return PTR_ERR(master->regs);
 
-- 
2.17.1

