Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37377C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 08:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 063852087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 08:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HA5f+/Wo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730997AbfG3Ikx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 04:40:53 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33663 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbfG3Ikx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 04:40:53 -0400
Received: by mail-pg1-f193.google.com with SMTP id f20so20454950pgj.0;
        Tue, 30 Jul 2019 01:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oht354i7nlKO87/dRT8d2R9vughNR8TfvgXEqGm1tuc=;
        b=HA5f+/WosIJHoAnUdpExXjkFvcjZ8PqeonpPEaug0kxLT+HDAG5PFC8VSZbbPacAqB
         tnpBGfCnOIU2ghnvy5ooo05Pd/VcuiM6yCrMm66kbs5Kpa+7b72A8+vhG5O6584koEJc
         9xLpvRLXMwd5NzrkgiXErFub01sC9pr/2nmwONgOLu3Zyntyr0lTC1ZgBg8ack9FmeB/
         BCluqjV7XsJ0l+V7LNNXaj22P3I3FtMKvsu2L/r/TtsnZuIRb7T5VruDuj1lyHxBiEpN
         JlB5xbZ9TgWM2EXHUKZu+Wa9Ng3z4ULnBd9QWq5/wlGY7ODwLCxI0V9lxDiC5CaRGBYW
         O+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oht354i7nlKO87/dRT8d2R9vughNR8TfvgXEqGm1tuc=;
        b=CAGH/6LBykFXzr9PRi6tLLMhDAni1wE1k+ya8naf4h2NhaLcDIjNHn8uYzY+t+WJdG
         WxeBmblthucaBgHtQgjUbtRytHkI/iLWASdueHxcT3pjjOoWo6QjmrnuCE3GL89faBND
         W9FUgcndzEyNhWA7yMjd4kmAsEozY0jtpqY4+RjPya0C6+/nP1imQwMFDEKsh/sr57D0
         CsFkXtP8ReuGc+Ev8i+4zhYBtdkDvogweXY/sBMNRfzvOvPo8rYWOnaW4uLvy71i9WML
         HPVp+Va9nVch8QcCchXc8rhv/wFqrND47GaqMwnPjjnyYMyq2DwyHp01CwtYwp7sh+zL
         /Hbw==
X-Gm-Message-State: APjAAAWTFje4O3hfG/yksN3PW8VHEbncmBEU2+TA+yFiVPVISQlt5JY5
        DppxKaQjHJe7RiMxd/m1pqs=
X-Google-Smtp-Source: APXvYqwWh4taE6b552+xWeQnh2QXA/XQN0XAPxd0ucxcVOReiXhx0SNiyHXX5+T/cCyLrqStwDL1KA==
X-Received: by 2002:a63:ab08:: with SMTP id p8mr18894180pgf.340.1564476052524;
        Tue, 30 Jul 2019 01:40:52 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id m9sm108158454pgr.24.2019.07.30.01.40.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 01:40:51 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Adam Radford <aradford@gmail.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] scsi: 3w-sas: Fix unterminated strncpy
Date:   Tue, 30 Jul 2019 16:40:47 +0800
Message-Id: <20190730084047.26482-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncpy(dest, src, strlen(src)) leads to unterminated
dest, which is dangerous.
Here driver_version's len is 32 and TW_DRIVER_VERSION
is shorter than 32.
Therefore strcpy is OK.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/scsi/3w-sas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/3w-sas.c b/drivers/scsi/3w-sas.c
index dda6fa857709..96f529c613a6 100644
--- a/drivers/scsi/3w-sas.c
+++ b/drivers/scsi/3w-sas.c
@@ -1328,7 +1328,7 @@ static int twl_reset_sequence(TW_Device_Extension *tw_dev, int soft_reset)
 		}
 
 		/* Load rest of compatibility struct */
-		strncpy(tw_dev->tw_compat_info.driver_version, TW_DRIVER_VERSION, strlen(TW_DRIVER_VERSION));
+		strcpy(tw_dev->tw_compat_info.driver_version, TW_DRIVER_VERSION);
 		tw_dev->tw_compat_info.driver_srl_high = TW_CURRENT_DRIVER_SRL;
 		tw_dev->tw_compat_info.driver_branch_high = TW_CURRENT_DRIVER_BRANCH;
 		tw_dev->tw_compat_info.driver_build_high = TW_CURRENT_DRIVER_BUILD;
-- 
2.20.1

