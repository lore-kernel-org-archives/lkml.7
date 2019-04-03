Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDA7C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 19:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDF312084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 19:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="d5QVtuIA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbfDCTbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 15:31:08 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55945 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfDCTbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 15:31:08 -0400
Received: by mail-wm1-f65.google.com with SMTP id o25so112875wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 12:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aZ6nhP8EEvRrGgjeId6P3h0pAV4TUVp+Qlnq4Pegj+s=;
        b=d5QVtuIA+GDJ3XsaxVBikq5dk0IPw6gI6R2qT4aM0jkXbwsMblfgSxgZmIiECgguzt
         dHRUS2WrP4RDodZ6+pP4RBAZzt3oICrqrtZPq/57AQJJFAuis2x6DpOJbaH+DdgDE2ye
         uanm40AccvGVRV03faSGfdwcPwhoo2qWiZCJFN3pEAH9u8hGYIKFW4AkzHpRe1WCTOmq
         yrfr6AKg5fd04B7/CbOwPcJe3z3ZrtNdm9GOM3wCSmI0mngtBZtyKpeGwpAdPNI3A/ut
         BQg+vxGzXrP18zFPkeqaSGFfapJhza4eEmg1xzMPfDcmUyfkMdAA2gMRb+GpbkWcDF5s
         2+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aZ6nhP8EEvRrGgjeId6P3h0pAV4TUVp+Qlnq4Pegj+s=;
        b=StpmL7G0Yi7OJeCWJCNRVzNBwL216/8M0NePyoh14XTPIvEPmWF847NtV9Fh/yAhQF
         P/6yLYRiuzj1VO1bL7vL5xyi9DaD2MTKLz1EB6VP+/QSA4aASLjjPc+PWM+sWRCkTHC/
         m+DElNSvK/ymWTvl4I/OVmeP7Q+Fjjh3y917joSRoYUcNQRWkkVkGf3HNsBbt7JGpf6y
         PUmQUglasU3a0RkC1HTn0369QenM4ux6S1Gq9OHqvwwh63C285it12tpw7YkUYStC1RE
         5MjIHSQBVYBVZbDdviFTj4QZCH2OQb+8E/6JonBiJBGn05oq1XLklkuVVagt2iHd+iKw
         ie1w==
X-Gm-Message-State: APjAAAU5DfDhvjZupna4bFViCvfmVPg4VVzWxhu4tfAhQpDY348hbbnB
        MHdOMcVSpLN/59cJrjFe38WT0w==
X-Google-Smtp-Source: APXvYqye6yDqe1YdY5P4GgbBa58ZS+KYbCU4R+pk7DijykRBBYVPQvCXhDXtfPAX1fwcPBD9Idhn+A==
X-Received: by 2002:a7b:cb04:: with SMTP id u4mr1302892wmj.0.1554319866395;
        Wed, 03 Apr 2019 12:31:06 -0700 (PDT)
Received: from localhost.localdomain (cag06-8-78-203-165-84.fbx.proxad.net. [78.203.165.84])
        by smtp.gmail.com with ESMTPSA id t74sm672463wmt.3.2019.04.03.12.31.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 12:31:05 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     ulf.hansson@linaro.org, matthias.bgg@gmail.com,
        yingjoe.chen@mediatek.com
Cc:     chaotian.jing@mediatek.com, ryder.lee@mediatek.com,
        jjian.zhou@mediatek.com, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH v2] mmc: mtk-sd: check for valid optional memory resource
Date:   Wed,  3 Apr 2019 21:30:50 +0200
Message-Id: <20190403193050.22180-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'top_base' memory region is optional. Check that the resource is valid
before using it. This avoid getting a "invalid resource" error message
printed by the kernel.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---

V2:
	Fix invalid condition: check against 'res' variable instead of 'ret'.

---
 drivers/mmc/host/mtk-sd.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 833ef0590af8..61bf8704491c 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -2123,9 +2123,11 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	host->top_base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(host->top_base))
-		host->top_base = NULL;
+	if (res) {
+		host->top_base = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(host->top_base))
+			host->top_base = NULL;
+	}
 
 	ret = mmc_regulator_get_supply(mmc);
 	if (ret)
-- 
2.20.1

