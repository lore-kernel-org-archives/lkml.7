Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FC0C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F0862054F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="N4m03+pC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfFMPSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:18:01 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46175 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732170AbfFMNPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 09:15:02 -0400
Received: by mail-lf1-f67.google.com with SMTP id z15so12349747lfh.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 06:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IMHi2S1lxrVF5OO8+rdxLqeH/S1duFekzw5Tc0Z2mvY=;
        b=N4m03+pCMbu9cIv2a7fZuxt+riwezXCHBQP6t+cS21Wl5evRWUUURynTOleWnNYOkE
         dFh5/zk0/W1w5gUkw7QNUWfnuIG3VFrTzVuighoe0AliaSo/dojrdQiIGzIh4e8gMmA+
         q1svNoPQueufLPULap69GDUh55Tvk1tsO7+7yDzwUyFvZ0zuUCdw8FPXPzWlBvDypzyB
         3mHRZQ0gfA06yeWGWX4/6ki5lBx4ckZWjJuATAz5D5bIf+R3SwP1XZSGztwOoZYBjQNf
         lpWTthgmzLzVSEtDx3Zq73HzFBYtyVhmgtqZm0Q2b5h3a4TUHyaEVthAjKaqv1QIt0iX
         JG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IMHi2S1lxrVF5OO8+rdxLqeH/S1duFekzw5Tc0Z2mvY=;
        b=ORqO/TcyHY+MgKdyTg8R0d8alTnOej8vrhstS5vR07336l2OCdVOM1VDtGgOknjeT3
         T754O/w3YJD2WNzR1MIcFFEq+c//AZphokOuV+bFiI0otn9GXClnutrEmDEVq9doaVny
         WPMnhLXcseySrRba77i7DagOa9OF57ErYNIxnji5PDVSC/yQsZl+he6z9GmeY+a7ATIm
         uEZ4RiEXb59hXu3YTWHeMO9hpRz/TQzCbNsinPDiB+xrVuJcCwiZGIZ/tTw2N/M2uJ7T
         WC7SEMlJUJEcCU0lOwCCNWXxyaYf82bKBaO/SDH+OX9GlzdhIE9qYg1fhgcgwK7K30oD
         c9HA==
X-Gm-Message-State: APjAAAVcczv2AmkucacxIpdg3MAqWt9z3ujDrYy+7kbcqGqbtM+8WdzH
        qoXXYyC60HXQTGpetpKZ49glOmiiT1V/2A==
X-Google-Smtp-Source: APXvYqyUnN8Ootc1IkCIbrd0u7tOoLVkGMuoyGHMwUuFSr18enQTcXeLot9OSgv0O7hjR40xj2oipA==
X-Received: by 2002:ac2:5212:: with SMTP id a18mr38106861lfl.50.1560431699446;
        Thu, 13 Jun 2019 06:14:59 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id q4sm124563lje.99.2019.06.13.06.14.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 06:14:58 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
Subject: [PATCH] staging: kpc2000: remove dead code in core.c
Date:   Thu, 13 Jun 2019 15:14:51 +0200
Message-Id: <20190613131451.21661-1-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch warning: "Consider removing the code enclosed by
this #if 0 and its #endif".

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/kpc2000/core.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000/core.c b/drivers/staging/kpc2000/kpc2000/core.c
index 6a5999e8ff4e..610ea549d240 100644
--- a/drivers/staging/kpc2000/kpc2000/core.c
+++ b/drivers/staging/kpc2000/kpc2000/core.c
@@ -223,15 +223,9 @@ static void wait_and_read_ssid(struct kp2000_device *pcard)
 
 	dev_notice(&pcard->pdev->dev, "SSID didn't show up!\n");
 
-#if 0
-	// Timed out waiting for the SSID to show up, just use the DDNA instead?
-	read_val = readq(pcard->sysinfo_regs_base + REG_FPGA_DDNA);
-	pcard->ssid = read_val;
-#else
 	// Timed out waiting for the SSID to show up, stick all zeros in the
 	// value
 	pcard->ssid = 0;
-#endif
 }
 
 static int  read_system_regs(struct kp2000_device *pcard)
-- 
2.20.1

