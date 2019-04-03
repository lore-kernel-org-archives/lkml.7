Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC6EC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 665F52084A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8boMO/k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfDCDHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 23:07:19 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41365 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfDCDHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 23:07:18 -0400
Received: by mail-qk1-f195.google.com with SMTP id o129so9269519qke.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 20:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=ymadMwZvEEr5LBPD1He8IUIyOikvCUz7L1ddXnMtYUQ=;
        b=X8boMO/kAIG9TLBhy5S+24HZ6b8sVbaoIUfRjrmm3HmigsKl3jsu1f9ZkY9yyk3Wgt
         E7j4RSdQ2fyFPXXNkO7JXQtgLLOurg90eZZSTZcxlit7dc5QDgSnB3dTcfr9LDPJm3GM
         tGPOiAzjM5cNow7O2+pQmyFP6z8vCYguLFPmce8c6EOD7iWZbjqGJT6M/B3KjUs1guCp
         Wgv6M5KwZmYEm9VqsGgpG1J3P6YjOtOQ68hoP8wAUUza7F/QjGa/OQ37HsuJWTEd/lYS
         wm4S8ruzF2toNHGC3UWjVFwqupPUQtsjuL1yY/9wvr7xnXuWcK0L+29guib0OcXjAVi1
         87gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=ymadMwZvEEr5LBPD1He8IUIyOikvCUz7L1ddXnMtYUQ=;
        b=ccqawkpDkAnJwssfgXvpoePn+ykSjCRwBGhMUB+JFd/c9/S/DIVk38hqdwGWZwIabz
         cYsgsMdWviLBa4B8wVCiuwL6jS5zvSMwOFRykXlG1UIxUpZq+/Xumqs/A6Dfl2qaK8V9
         F++VBwPqXB3dKaR9PReyxM08joIBcxf4tHGRO+r/c6PwQtNIbX75tvq+lAA/NBkwfkFR
         j/Hx1Z9kAQsoso7Sop7XNBstI9pYejQIjSOaXryLskirfns3NJ2O7Vg4p3x3/yvHqeUa
         l4+mAfUgWg0i9Y+eiEvXclkOlvpnd++5mekefyZ0VBzhgsN1MJlLrWa8Egxs3NQVA6xp
         A/eg==
X-Gm-Message-State: APjAAAVsMschkAgLBaXWotW8qRnQrLUhdQyjrljPMDTUkescg101Hvod
        663fNBVqIUM2LW718OWkAgk=
X-Google-Smtp-Source: APXvYqzwZa5ZdnEa6twDRflTPqoH1sBw7D1JtyIk10BPZfuXDAU310JtszNDcDmVAF2+lzMM96Jisw==
X-Received: by 2002:a37:ac12:: with SMTP id e18mr56532266qkm.195.1554260837738;
        Tue, 02 Apr 2019 20:07:17 -0700 (PDT)
Received: from localhost.localdomain ([201.82.74.151])
        by smtp.gmail.com with ESMTPSA id i24sm8045007qtm.3.2019.04.02.20.07.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 20:07:16 -0700 (PDT)
From:   Mario Balan <mario.balan@gmail.com>
To:     eric@anholt.net, stefan.wahren@i2se.com,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org
Subject: [PATCH] staging: vchiq_arm: remove space after open '('
Date:   Wed,  3 Apr 2019 00:07:13 -0300
Message-Id: <20190403030713.19280-1-mario.balan@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch error "ERROR: space prohibited after that open
parenthesis '('" in vchiq_arm.c:563.

Signed-off-by: Mario Balan <mario.balan@gmail.com>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 6dad624d0e49..a3eb99664a1c 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -560,7 +560,7 @@ add_completion(VCHIQ_INSTANCE_T instance, VCHIQ_REASON_T reason,
 		vchiq_log_trace(vchiq_arm_log_level,
 			"%s - completion queue full", __func__);
 		DEBUG_COUNT(COMPLETION_QUEUE_FULL_COUNT);
-		if (wait_for_completion_killable( &instance->remove_event)) {
+		if (wait_for_completion_killable(&instance->remove_event)) {
 			vchiq_log_info(vchiq_arm_log_level,
 				"service_callback interrupted");
 			return VCHIQ_RETRY;
-- 
2.11.0

