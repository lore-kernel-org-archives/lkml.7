Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5CEC2D0C9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4DB9206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghqqpu4Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfLJJPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 04:15:06 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37491 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfLJJPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 04:15:03 -0500
Received: by mail-pf1-f193.google.com with SMTP id s18so8747834pfm.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 01:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TDhjwwUSHDyACk0EiHiTW5gF5LNK8IJFMEdCdOncrPE=;
        b=ghqqpu4Y3uy6hum+ewIVbOYchj5qEMKjfUftHMyfeRmiSE9NmCDJ9vZXizcVLViGxF
         Uc8K92FzayQgL8W6g/GF5S3scqlogON5s9nQVQ9fJw5fqPwqnmDkJszXcT01LQWAeOSR
         z41gcw7az9DzaMG+mPFKEBA3Xf+E8ZyUk/EB/kw9B9KdACbunaXvQ2lNNkC6fnG0Z6Yv
         xUj/45p9resd1DifbIk76ZqlqRb7VIWA0Rgv0/q+pmGLxtwBPtB+plQ6EMPpYGpu0SJK
         aerFxhbP2AAvZn83JYDGqKsyUGALkIkgL54ICylCzQlj1FHWYUAnukNAedykQv7WYMsx
         uZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TDhjwwUSHDyACk0EiHiTW5gF5LNK8IJFMEdCdOncrPE=;
        b=VlkVDTFmaoIKIIwEuVAGLVqrXPezipOFZL0dC20bvng7xCJ0lrHW6gnwPDzlE94bV8
         qNYQIQy4hmFJxmpKgJclSl/8bELtTNo8njc+AesRGqaOeoN7QovnQLCRk99pVDUnW6Nq
         +S12iMkXCPqoPCcb9E2eqVY/y22l4ZEARi0+jBuAkV1XSwECxN/UlVPy24NHqiZST+JT
         7zMKkiERZQjdUE1gboJLojnSs3E7ZrqSE+bwPHCNRifsfc7nJL+wlc8i1trm01I6ntu1
         YZ283XpEN8m8fYrLmd/JfsJmnBUcKiWhp+2Tyjcb7h7OBZ/yH+XvrKdLCq9k+I+aG0cY
         dRZg==
X-Gm-Message-State: APjAAAVdPnkjPuaJ5TEsGDl7tTyX7Gea6MgNNgq6ynYLx+xV7uWh2O+s
        S8Y0GORg7Zx05JJe7qAez15RsFxJ
X-Google-Smtp-Source: APXvYqyXCRbKsNc5R0fJgcZtH0Jj0+LMgA/z2G4Rzo1eZ2DpoBJB/lpl1vKKqc6LG9ozYEpt2/nn2w==
X-Received: by 2002:a65:66c4:: with SMTP id c4mr23827702pgw.429.1575969302412;
        Tue, 10 Dec 2019 01:15:02 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id 143sm2478287pfz.67.2019.12.10.01.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 01:15:01 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Cheah Kok Cheong <thrust73@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] staging: comedi: comedi_test: return error when comedi_test_init fails
Date:   Tue, 10 Dec 2019 17:14:51 +0800
Message-Id: <20191210091451.23505-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

comedi_test_init() forgets to return error when it fails.
Modify the return value to fix it.

Fixes: 9ff7400bd38c ("Staging: comedi: drivers: comedi_test: Add auto-configuration capability")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/staging/comedi/drivers/comedi_test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/comedi/drivers/comedi_test.c b/drivers/staging/comedi/drivers/comedi_test.c
index ef4c7c8a2b71..133ed99a89f1 100644
--- a/drivers/staging/comedi/drivers/comedi_test.c
+++ b/drivers/staging/comedi/drivers/comedi_test.c
@@ -799,12 +799,14 @@ static int __init comedi_test_init(void)
 	if (!config_mode) {
 		ctcls = class_create(THIS_MODULE, CLASS_NAME);
 		if (IS_ERR(ctcls)) {
+			ret = PTR_ERR(ctcls);
 			pr_warn("comedi_test: unable to create class\n");
 			goto clean3;
 		}
 
 		ctdev = device_create(ctcls, NULL, MKDEV(0, 0), NULL, DEV_NAME);
 		if (IS_ERR(ctdev)) {
+			ret = PTR_ERR(ctdev);
 			pr_warn("comedi_test: unable to create device\n");
 			goto clean2;
 		}
@@ -826,7 +828,7 @@ static int __init comedi_test_init(void)
 clean3:
 	ctcls = NULL;
 
-	return 0;
+	return ret;
 }
 module_init(comedi_test_init);
 
-- 
2.24.0

