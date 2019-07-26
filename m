Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDDFC76194
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 02:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3D39218B8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 02:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCb6Tjmp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbfGZC2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 22:28:46 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37037 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfGZC2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 22:28:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id i70so13240615pgd.4;
        Thu, 25 Jul 2019 19:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QitlWR7BGQe2SM+KQlNBxgo0bredzcf0/IeR1JG76NY=;
        b=jCb6TjmpyLLSeXQ3MUagGykwdMFRUMv6VhkyzjoaZeG4GTwVb9VlEthMegMngag0KB
         ppB5u9zJZ2y1s//sRqXo5X1Sd5WW1kdrkZb1krqeG6+fGsbQiYyROaB+Y2k4hi51NIFD
         Sb8BxtOo0THaAwZaK7F0GXCu68REQo+IpHhfxeN55TEPSkzdp4g+FI3MLAwoBeheEij+
         FJYjxVALGhWNWLJjmgUpUnMYUXrsA9caycFYg9TzzBB2VM5h1uoYm6FHvfqouW143eSq
         dTTR1n6Whx6IM/LNOjrf/JR1gxGEa6E10GopHhswqa3PFSIsbkm24h+92qEi9B5mSTlw
         pr5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QitlWR7BGQe2SM+KQlNBxgo0bredzcf0/IeR1JG76NY=;
        b=kyxTZlnY5Zerva//Sfw7AgfgtCU4EPAa532U+Ni9Z7pm26gBIog8HK3qEHtjOLzn3i
         KFYu+Bf5wad1+szL0f9b6Mf4BD6DdCeIqEGOzXl+5CsPhUwukfJpqeK4afawrlDuKleq
         5OJiyEKgDvJMrFd/iYv0z9n/lSd5x8NPKcqr438my2D1rF7eL9CNYxzSCBBDcSURr0ng
         w+/BSKDDFdIyENS1x874K7VNAF62W+lEPD5HI2kEdu7PTPCDdnmSy+LrsUJ1ZyI0kDaN
         V4JOXGjW8MzXGuARLQ6eGKSZgtGbPbm58amkDQyrHxzKJvmUiLxUvXsyFZUxVrMCrSbi
         ACRA==
X-Gm-Message-State: APjAAAXroZWV20N/f5TdGIVh13eSoglRhvpDToRMd+3aUAssfXZ1RZ9B
        Nbq/YFqQN0P1BfPv/rokSVE=
X-Google-Smtp-Source: APXvYqy9WzH87WvMloDOGW7Qa6aZclXzMBuMrmKiS002ptHQxAspDYr8nkqPDFew3Bg+Tr3qZW6blw==
X-Received: by 2002:a17:90a:dac3:: with SMTP id g3mr95331902pjx.45.1564108125770;
        Thu, 25 Jul 2019 19:28:45 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id t11sm58170506pgb.33.2019.07.25.19.28.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 19:28:44 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Patrick Havelange <patrick.havelange@essensium.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v2] counter/ftm-quaddec: Use device-managed registration API
Date:   Fri, 26 Jul 2019 10:28:36 +0800
Message-Id: <20190726022836.7182-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of devm_counter_register.
Then we can remove redundant unregistration API
usage to make code simpler.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v2:
  - Use devm_add_action_or_reset to keep
    resource release order.
  - _remove() function is redundant now,
    delete it.

 drivers/counter/ftm-quaddec.c | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
index 68a9b7393457..76c70a6c3593 100644
--- a/drivers/counter/ftm-quaddec.c
+++ b/drivers/counter/ftm-quaddec.c
@@ -100,16 +100,17 @@ static void ftm_quaddec_init(struct ftm_quaddec *ftm)
 	ftm_set_write_protection(ftm);
 }
 
-static void ftm_quaddec_disable(struct ftm_quaddec *ftm)
+static void ftm_quaddec_disable(void *ftm)
 {
-	ftm_clear_write_protection(ftm);
-	ftm_write(ftm, FTM_MODE, 0);
-	ftm_write(ftm, FTM_QDCTRL, 0);
+	struct ftm_quaddec *ftm_qua = ftm;

+	ftm_clear_write_protection(ftm_qua);
+	ftm_write(ftm_qua, FTM_MODE, 0);
+	ftm_write(ftm_qua, FTM_QDCTRL, 0);
 	/*
 	 * This is enough to disable the counter. No clock has been
 	 * selected by writing to FTM_SC in init()
 	 */
-	ftm_set_write_protection(ftm);
+	ftm_set_write_protection(ftm_qua);
 }
 
 static int ftm_quaddec_get_prescaler(struct counter_device *counter,
@@ -316,22 +317,13 @@ static int ftm_quaddec_probe(struct platform_device *pdev)
 	mutex_init(&ftm->ftm_quaddec_mutex);
 
 	ftm_quaddec_init(ftm);
-
-	ret = counter_register(&ftm->counter);
+	ret = devm_add_action_or_reset(&pdev->dev, ftm_quaddec_disable, ftm);
 	if (ret)
-		ftm_quaddec_disable(ftm);
-
-	return ret;
-}
-
-static int ftm_quaddec_remove(struct platform_device *pdev)
-{
-	struct ftm_quaddec *ftm = platform_get_drvdata(pdev);
-
-	counter_unregister(&ftm->counter);
-
-	ftm_quaddec_disable(ftm);
+		return ret;
 
+	ret = devm_counter_register(&pdev->dev, &ftm->counter);
+	if (ret)
+		return ret;
 	return 0;
 }
 
@@ -346,7 +338,6 @@ static struct platform_driver ftm_quaddec_driver = {
 		.of_match_table = ftm_quaddec_match,
 	},
 	.probe = ftm_quaddec_probe,
-	.remove = ftm_quaddec_remove,
 };
 
 module_platform_driver(ftm_quaddec_driver);
-- 
2.20.1

