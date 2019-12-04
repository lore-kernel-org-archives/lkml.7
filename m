Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F4BC3E8AD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 07:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3854920637
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 07:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vOASrEDn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfLDHZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 02:25:53 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34671 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfLDHZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 02:25:53 -0500
Received: by mail-pf1-f195.google.com with SMTP id n13so3195515pff.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 23:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zR+uj71pLrF+TYYen/2/kUtrnB5mPrIgI3pLhx/lk30=;
        b=vOASrEDnsGz5TKzN+imtDHh3hqQYpURnQe6UIFHeRWuv6ghVmWym6ek15gTR1/dtT3
         UjIiH5ElHrc0Raz+YxTKzwUuGiub8j/PxZIdsWXzI8x/4811vAMj8SMWnvplVb3P5kpI
         +WKszxQ6FUar5peGEJaIxzS8cHmw+IHJfGfvPODmRFUaeTI14VskLEei5bSf3p0sXwaw
         8F38vcHLrtSF2rK5gL2cniZoNjUw72S8ZTeWQjZimV0lWQ2bJUPvxuOyuYJmB09YBvFq
         wr1jnlmHGzi7/gKRFvGvuqBIfpmFGOFJMz4R1EFKR2u4dSRKyBKMIoEpRKqK5BK8yXUi
         l55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zR+uj71pLrF+TYYen/2/kUtrnB5mPrIgI3pLhx/lk30=;
        b=pMFdZP+aRsK8PUmS0yYrthdmtPnICP7kLophbBzjmoLRDttp6Bn8/fGq7PVGdO01T5
         UjzJHVKV+VaQqG6b7IcM8NsQ00D+r2K245D6s+yVGKUfbRSriJUp2xjvzOl7QDW8KnwT
         f9BNPLLlNgWMooqO+8uyChNU5Qv2QoqU8R3w6ao7GrYxBXYbMgFKo06oC74FR4JDhy6Y
         8c7z9+ILKNHHXqvr2Xf/MPPGeir2zGfwAnNhQXMU36N1GBF80m84X1xgptqiOtzvt2hq
         6Bm/3T5bsGX4H+MG5GnQAOxHzlT6pj3P5SCkf4/4rvsv+BWjz++b6Wq6Z9E8m3x6h0lU
         LzWA==
X-Gm-Message-State: APjAAAX/KEXIDWeQwZdWy0i2PmeeMAYFuOIdKs2H5P4FaJW2Y6kCXQvd
        8HW285IZkZ2sluwcjJC8PN/c8TZvH+M=
X-Google-Smtp-Source: APXvYqy8+V11CEePA8+sdZlLaDk/bbqQXTg5l6/Ygh5zsq7kuxLH0J/8QAlcLycCuJzrDXTMkByIuA==
X-Received: by 2002:a63:c250:: with SMTP id l16mr2000245pgg.38.1575444352407;
        Tue, 03 Dec 2019 23:25:52 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id e23sm5224651pjt.23.2019.12.03.23.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 23:25:51 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Roger Quadros <rogerq@ti.com>, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] phy: ti-pipe3: fix missed clk_disable_unprepare in remove
Date:   Wed,  4 Dec 2019 15:25:40 +0800
Message-Id: <20191204072540.1452-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver calls clk_prepare_enable in probe but forgets to call
clk_disable_unprepare in remove.
Add the missed call to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/phy/ti/phy-ti-pipe3.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/phy/ti/phy-ti-pipe3.c b/drivers/phy/ti/phy-ti-pipe3.c
index edd6859afba8..19fd1005a440 100644
--- a/drivers/phy/ti/phy-ti-pipe3.c
+++ b/drivers/phy/ti/phy-ti-pipe3.c
@@ -850,6 +850,12 @@ static int ti_pipe3_probe(struct platform_device *pdev)
 
 static int ti_pipe3_remove(struct platform_device *pdev)
 {
+	struct ti_pipe3 *phy = platform_get_drvdata(pdev);
+
+	if (phy->mode == PIPE3_MODE_SATA) {
+		clk_disable_unprepare(phy->refclk);
+		phy->sata_refclk_enabled = false;
+	}
 	pm_runtime_disable(&pdev->dev);
 
 	return 0;
-- 
2.24.0

