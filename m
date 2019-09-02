Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6416DC3A5A4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 01:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33763217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 01:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p333U1Ax"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbfIBBnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 21:43:42 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:47086 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728836AbfIBBnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 21:43:42 -0400
Received: by mail-pg1-f195.google.com with SMTP id m3so6530131pgv.13;
        Sun, 01 Sep 2019 18:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0aUX42n6MYpZAPtnUnOXwuIjIyDjbmoPgpeoVT5TRsM=;
        b=p333U1AxmvdAk0pBEpP1oUYFNfDEyJJpbB3soBeqQfWNat0kerjEGi//Fxvue3hYPY
         buUksIH2xTNak380SSpalrxwuhFOZctc6CbMczDD3ljiFUD+v1wiLN3YPxlUGyjXofx/
         DgH3NeLssLiwOc8q84ubf+I/pTJe/QX5PVr018jrJPl190L345tqeuoOYlfaDMVVDPOP
         ByqawH3vp+4hxdepsteaFFmKolB5ZbXXayS5yjR9yJ8gDZcCQ1NzE7YiGYDpzVfpd7pG
         aBvs5YrmJBJmvjI1p4EejEd/cysBYfowozXx70wj9KLZFvtJTVJEBSXVH/gMDzcBxdRM
         vL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0aUX42n6MYpZAPtnUnOXwuIjIyDjbmoPgpeoVT5TRsM=;
        b=WCBLVvJvsnA8eMSr2Q06SO6F386ITooWZ9eWCQ3dLNSA2+o1lYQyTeef0Gp1+3XDZh
         m4QSccZ/144MFtvvtxDkbrvUNgQbP/ucsPdPyhJRjUpXnR21So35e3OGyt4C/vKBka+7
         sKHzblkQ1pPZzYeXfnA6PSQam/yhNTdkhyvzzVSDf0rHLFeoh68YWHXTkwzIo5POioLI
         YIdDRGxi/zekk7fj7cFIRQp/EkxF6ndCcggFSNto7ajdDaT5klxAkt92y0azpwbo2Jgj
         pLSzbhhHcXeB5FXmMc0k84asXhPsciwjnLKGExCpR+tqPM3Cju9BTU5gKbkqcFZiJwLG
         db5g==
X-Gm-Message-State: APjAAAUsTmdvILZ0QILRiVwqLC9NMnVeLm+A16QKVapwndX2yaJiiE45
        8ThTgMK4oi2A4mtfdF44+CU=
X-Google-Smtp-Source: APXvYqxRRnD9aoVuiRxCQfHDMdbSmWABTkgvfz+jWmckOoqf0XOlMx9k2pfgrfkq2Y368CgWLdanoA==
X-Received: by 2002:a65:621a:: with SMTP id d26mr16676175pgv.153.1567388621595;
        Sun, 01 Sep 2019 18:43:41 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id n24sm12746268pjq.21.2019.09.01.18.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2019 18:43:40 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Peter Chen <Peter.Chen@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v2] usb: chipidea: msm: Use device-managed registration API
Date:   Mon,  2 Sep 2019 09:43:23 +0800
Message-Id: <20190902014323.27588-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_reset_controller_register to get rid
of manual unregistration.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v2:
  - Remove not needed err_fs.

 drivers/usb/chipidea/ci_hdrc_msm.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_msm.c b/drivers/usb/chipidea/ci_hdrc_msm.c
index bb4645a8ca46..af648ba6544d 100644
--- a/drivers/usb/chipidea/ci_hdrc_msm.c
+++ b/drivers/usb/chipidea/ci_hdrc_msm.c
@@ -216,13 +216,13 @@ static int ci_hdrc_msm_probe(struct platform_device *pdev)
 	ci->rcdev.ops = &ci_hdrc_msm_reset_ops;
 	ci->rcdev.of_node = pdev->dev.of_node;
 	ci->rcdev.nr_resets = 2;
-	ret = reset_controller_register(&ci->rcdev);
+	ret = devm_reset_controller_register(&pdev->dev, &ci->rcdev);
 	if (ret)
 		return ret;
 
 	ret = clk_prepare_enable(ci->fs_clk);
 	if (ret)
-		goto err_fs;
+		return ret;
 
 	reset_control_assert(reset);
 	usleep_range(10000, 12000);
@@ -232,7 +232,7 @@ static int ci_hdrc_msm_probe(struct platform_device *pdev)
 
 	ret = clk_prepare_enable(ci->core_clk);
 	if (ret)
-		goto err_fs;
+		return ret;
 
 	ret = clk_prepare_enable(ci->iface_clk);
 	if (ret)
@@ -271,8 +271,6 @@ static int ci_hdrc_msm_probe(struct platform_device *pdev)
 	clk_disable_unprepare(ci->iface_clk);
 err_iface:
 	clk_disable_unprepare(ci->core_clk);
-err_fs:
-	reset_controller_unregister(&ci->rcdev);
 	return ret;
 }
 
@@ -284,7 +282,6 @@ static int ci_hdrc_msm_remove(struct platform_device *pdev)
 	ci_hdrc_remove_device(ci->ci);
 	clk_disable_unprepare(ci->iface_clk);
 	clk_disable_unprepare(ci->core_clk);
-	reset_controller_unregister(&ci->rcdev);
 
 	return 0;
 }
-- 
2.20.1

