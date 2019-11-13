Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F5EC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 06:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49634222C6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 06:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4LjTSfE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfKMGid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 01:38:33 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43387 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfKMGic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 01:38:32 -0500
Received: by mail-pg1-f195.google.com with SMTP id l24so716232pgh.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 22:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yXikumjy+JcdsMguaz7purxBZ6df2n0Pz7z+WJDAYNc=;
        b=P4LjTSfEMQHW293vKti2IkTAd0W1xhJ+X+xNzCRKIoBrvjSkWTETRgGVIn3naIzkO4
         awJ4PynJ4LBaOuqbL8WcWi7FrkYtgm40DkT81Q5u7IwerC58SO/R1MOulDzw+bxrGCJZ
         63JgQ18IdCrfEHnBvIPjW697A9d3LgzR0DxuTCMAir0bzBl2ODkybx14IRNwKb8QlIZ2
         j+0nnm8gXfNDl726+IFSGX8rynqlvGFCrLgXJtz0tNjrbedEZEW11X7KFJKccbZyNe0L
         c25ZUldKo/ZIRF5jhmNZNFAR40tloz432S5uEUeiHmugoctaL09i1z+yD8Uo1org2IHo
         LmIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yXikumjy+JcdsMguaz7purxBZ6df2n0Pz7z+WJDAYNc=;
        b=nxaSXdXtQ2Q2fw8yaCVfqXlRdPPetgYY5PtHtGCxuIETzXv7BxjwvEZB6ifm6QQ7IJ
         qQFxIH0GyRi91qmLf3Iabu/rtYbJvBl2kEft2wlvpNsCVCOQt/2Td4+wRJIzIPnLxV8e
         guVbhN9QkKtYQNgEAk9zvrSGbxUKfvuy5CZF8hqq3L4RFW6A5UNhCqrNUwgXtqcoupXP
         GomZLDNoTe9cv3kdaxedAIbggjyApynbwn2kUEL5HSZOSbQYSLY1rcFi323xhb4Wrd+D
         m3kU60kwGTksteI+/LYklbwzdCFYP+/AYoP08vkECzuNiVT8SAs7+uDHde+guIsiZJKa
         GRGg==
X-Gm-Message-State: APjAAAXBwMcoU0UWmctfCHjVV85opde8oS47ZY2XUiFTZ51Ez/nl/DHq
        tRQbrv4DMPkRb2uaVxfhnH69XO05vYs=
X-Google-Smtp-Source: APXvYqyHpZwVMfJcRsEvVNWM5VOmGVUEh2pf9ITlcZ7UQkokZ9oXJ/IexYowtmg5g+BHBj3FliZiIQ==
X-Received: by 2002:a65:49c7:: with SMTP id t7mr1835081pgs.431.1573627111642;
        Tue, 12 Nov 2019 22:38:31 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id n23sm1054844pff.137.2019.11.12.22.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 22:38:31 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] platform/chrome: cros_usbpd_logger: add missed destroy_workqueue in remove
Date:   Wed, 13 Nov 2019 14:38:21 +0800
Message-Id: <20191113063821.8896-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver forgets to destroy workqueue in remove.
Add the missed call to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/platform/chrome/cros_usbpd_logger.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/chrome/cros_usbpd_logger.c b/drivers/platform/chrome/cros_usbpd_logger.c
index 2430e8b82810..374cdd1e868a 100644
--- a/drivers/platform/chrome/cros_usbpd_logger.c
+++ b/drivers/platform/chrome/cros_usbpd_logger.c
@@ -224,6 +224,7 @@ static int cros_usbpd_logger_remove(struct platform_device *pd)
 	struct logger_data *logger = platform_get_drvdata(pd);
 
 	cancel_delayed_work_sync(&logger->log_work);
+	destroy_workqueue(logger->log_workqueue);
 
 	return 0;
 }
-- 
2.23.0

