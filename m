Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC98C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 19:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B0120718
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 19:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rc+K5XAh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfKQT03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 14:26:29 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52109 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfKQT02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 14:26:28 -0500
Received: by mail-wm1-f65.google.com with SMTP id q70so15109872wme.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 11:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ciA8VjN+XWwJPDzCYEEJcx6IZUx7vZEOqQ4xz1ZDhS4=;
        b=Rc+K5XAhhs7t7hUsSS6TWGtq71RUcsSLI+RoGlVaWw81w9WqMiIm9IMoix07YxNdvW
         QVjEmogatxFF+ZO55pvnpx6o5Jk7WYXos1TvVWtXhF+C0dYLaE5W7XKAWF4Lm6Mo8b6L
         ky9fVhNxSD14t8+TvKtbCsTHOnd5DUXlWqJNxD7G1MHDAdt1EKtMN3NqtRBaGhzxqdmN
         Iv9C5rEE5NLAF8AHf0sN2E1SB5IL+3vJ8HB2cS18Z1R/rOEYZzWAFEsfZ11zClVvg4Bw
         g4Y0b1ovR9tHLTLl6fBG81Js6bZU/sfSbpbAqSr8TlS9kgnzr5Gt4P/ocSCLIBM9XPrw
         w0+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ciA8VjN+XWwJPDzCYEEJcx6IZUx7vZEOqQ4xz1ZDhS4=;
        b=txdwraYtPRxCncVwUC8t6TIIfSnVgbzgBg/aQo/hHZ/jAk3axFLkEPWn9Pj2Ea3+SV
         2C47NiK0k9c3sh7qgbmwHxYTZ5WWzUXIsrZVNKanjllFZAvhSOUesdaLPpDrtpGjJZZy
         yQypcmJPotuc2ZCNPoah7RjDlFX+nblfvrvibjkpXecYKZBOVqPPyuBviFqXOAtxfcfJ
         mfNSZq6QF031zn6RM1+YzSkmAmVyFIubD3v9cpkezVi/7BvJCIcPNUj1732S13ZW5cfB
         09N/PcynArcHzAlExBagNqHVcsouVR7PPrk/CkrIEEDeNKgiFfmiuq8S+yoqKh/72S92
         CZag==
X-Gm-Message-State: APjAAAUC3h4ZZ/FTR0o111ItWwSCUEI4xyjMbCBI+qbTaPT8DheWv+TF
        P/41aSjT0sle5JS5A1ld6FvLX2j4lcY=
X-Google-Smtp-Source: APXvYqxY4SaYO4G7Z+hC87fSAbzSf4FL7CMgaIvUT1wHPg92QeZPqVN8yRucXrwoGTPC3LW+X9XBGw==
X-Received: by 2002:a7b:c776:: with SMTP id x22mr24420222wmk.144.1574018785218;
        Sun, 17 Nov 2019 11:26:25 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id j3sm19671024wrs.70.2019.11.17.11.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 11:26:24 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 2/2] habanalabs: flush EQ workers in hard reset
Date:   Sun, 17 Nov 2019 21:26:20 +0200
Message-Id: <20191117192620.27639-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191117192620.27639-1-oded.gabbay@gmail.com>
References: <20191117192620.27639-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During hard-reset, there can be multiple events received from the H/W. For
each event, the driver opens a worker thread to handle it. For some of the
events, the driver will read/write registers in the code that handles the
event.

In case of hard-reset, we must prevent reads/writes to the registers during
the reset operation because the device might get stuck if that happens.

Therefore, flush the EQ workers before resetting the device (in hard-reset
only). Additional events won't arrive as we synced and disabled the
interrupts.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
Reviewed-by: Tomer Tayar <ttayar@habana.ai>
---
 drivers/misc/habanalabs/device.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index 80205d8584ce..b155e9549076 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -887,13 +887,19 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
 	/* Go over all the queues, release all CS and their jobs */
 	hl_cs_rollback_all(hdev);
 
-	/* Kill processes here after CS rollback. This is because the process
-	 * can't really exit until all its CSs are done, which is what we
-	 * do in cs rollback
-	 */
-	if (hard_reset)
+	if (hard_reset) {
+		/* Kill processes here after CS rollback. This is because the
+		 * process can't really exit until all its CSs are done, which
+		 * is what we do in cs rollback
+		 */
 		device_kill_open_processes(hdev);
 
+		/* Flush the Event queue workers to make sure no other thread is
+		 * reading or writing to registers during the reset
+		 */
+		flush_workqueue(hdev->eq_wq);
+	}
+
 	/* Release kernel context */
 	if ((hard_reset) && (hl_ctx_put(hdev->kernel_ctx) == 1))
 		hdev->kernel_ctx = NULL;
-- 
2.17.1

