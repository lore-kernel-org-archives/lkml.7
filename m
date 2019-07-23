Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F682C76190
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 03:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED67F21911
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 03:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uEMAOsdu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732241AbfGWDDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 23:03:10 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38251 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729393AbfGWDDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 23:03:10 -0400
Received: by mail-pf1-f196.google.com with SMTP id y15so18345605pfn.5;
        Mon, 22 Jul 2019 20:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r2PIc45fLOPPxRnw58ZdCNVPeGStUV8A+U5733nMGk0=;
        b=uEMAOsduwZ/lk+xiUkc3bCfdyXhIJJhmJt+0y3daxVnxtBiubasUHEjtlO7T7hSDtO
         x1QvM9sHxkB+PZlR2lsHwshX8jGuBHYux7hyzW3pyve9demlOHVlHdE7aiyEtTFdeu/N
         Gk3r5lMMAMqIWEN010UVnmQ4NrnfTPANJiopuOo876oG9AYbcxW7w8nmhfFAM2zFm4ZX
         /sl+dJx8+6PDo1rBbEnlcgGwhEUUmyluz9JUHyOPnMSOxB1HcvgRxP2NA+uTGyU+10GA
         /gMVaTc+ia6m2wGT7fSxLCnUJQi00lnSd005fdDcs4qK2Lhgqfgt+T43qcSQI3DulTZQ
         2Q6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r2PIc45fLOPPxRnw58ZdCNVPeGStUV8A+U5733nMGk0=;
        b=tG/iqxzrlP5dqZl0K7sj48ZW2CjlZ4pjtS68spxraAKPJIWgXiW9e+O0/LsAp7wxok
         K3AtfUEtriGhxJzwKwgygmlOhffJnlg6G5wNB8yaGvIa/7d8fl+yXDLBZY1WI/kTb+Lh
         FtcZ6V5BDz1bk0Q6XA4OxB/BtW2Y25Ozwr2KSDeFFH3CeMmH2ncWVNJrw3AI0UToHfor
         +ieIS70wgD0xgRgx3twW4lA2/8w4jdgUU/WbBZb13Aaa33WoA9+T5W18ubR39u3eXcKX
         Mvz+YjHFRPyVjHS5fIGHEe4CuUasUSWFFiDniaRyHsTjI/josTEWQ6Z7oeqsLq6pgApD
         PIjQ==
X-Gm-Message-State: APjAAAXNkiJzt530WoEBsXBXyvM4iF8RyD9rkQoY8GbxR4K4ZxrzMrP9
        jLFhsEJoy1+8rBr/wq6FS2U=
X-Google-Smtp-Source: APXvYqyIXC6ryEvwJINJQcXlKpL1beZ7lNtBfcqpTzWXWu5PdtQ9EmcTCFhYw06abQMnDOQN2jrazg==
X-Received: by 2002:a17:90a:2768:: with SMTP id o95mr79841919pje.37.1563850989964;
        Mon, 22 Jul 2019 20:03:09 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id e189sm11920930pgc.15.2019.07.22.20.03.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 20:03:09 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Peter Chen <Peter.Chen@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] usb: chipidea: msm: Use device-managed registration API
Date:   Tue, 23 Jul 2019 11:02:07 +0800
Message-Id: <20190723030206.2919-1-hslester96@gmail.com>
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
 drivers/usb/chipidea/ci_hdrc_msm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_msm.c b/drivers/usb/chipidea/ci_hdrc_msm.c
index bb4645a8ca46..067542e84aea 100644
--- a/drivers/usb/chipidea/ci_hdrc_msm.c
+++ b/drivers/usb/chipidea/ci_hdrc_msm.c
@@ -216,7 +216,7 @@ static int ci_hdrc_msm_probe(struct platform_device *pdev)
 	ci->rcdev.ops = &ci_hdrc_msm_reset_ops;
 	ci->rcdev.of_node = pdev->dev.of_node;
 	ci->rcdev.nr_resets = 2;
-	ret = reset_controller_register(&ci->rcdev);
+	ret = devm_reset_controller_register(&pdev->dev, &ci->rcdev);
 	if (ret)
 		return ret;
 
@@ -272,7 +272,6 @@ static int ci_hdrc_msm_probe(struct platform_device *pdev)
 err_iface:
 	clk_disable_unprepare(ci->core_clk);
 err_fs:
-	reset_controller_unregister(&ci->rcdev);
 	return ret;
 }
 
@@ -284,7 +283,6 @@ static int ci_hdrc_msm_remove(struct platform_device *pdev)
 	ci_hdrc_remove_device(ci->ci);
 	clk_disable_unprepare(ci->iface_clk);
 	clk_disable_unprepare(ci->core_clk);
-	reset_controller_unregister(&ci->rcdev);
 
 	return 0;
 }
-- 
2.20.1

