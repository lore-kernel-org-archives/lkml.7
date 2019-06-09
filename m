Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52927C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 12:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2311E2145D
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 12:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q1vptwk8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbfFIMcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 08:32:20 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38659 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728680AbfFIMcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 08:32:16 -0400
Received: by mail-pl1-f194.google.com with SMTP id f97so2561806plb.5
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 05:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W01kyQuiomJSdOGk6Hwr4295vjRVUbIxGvLBRS4IPUU=;
        b=q1vptwk8MTimQ92Ok3kp0FMbqKJ4FfErLz/KijdUOn26YQFYT2m+L+VrwrBTrI9o/i
         a6BMn3NV09prPhAh4xlP2rBXk4ONmza5wLyFvmWQ1wVNSLXMWn2XIdiDV2X/3id9Ay8P
         HYi/LE+pHN52Wq8jT7HDomQd04bNnrlI5KduN49KLs3Re3Av1/GME54vQiTrYgmwPEwu
         n0ZF+aw6CPVSF6RUeMwiD0is8JirX8Y5nbIie+ar0ykZwvhvx7C6w0MOK/+1dmf5MUpv
         StH6MNYPZc8L3qlUzrdGB30AUju2TK2VtT8/O3/Lmr4h9lrnDh+I7sRLQ5nrXMUfu9bI
         RWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W01kyQuiomJSdOGk6Hwr4295vjRVUbIxGvLBRS4IPUU=;
        b=F6bHN5VDzpKEJXUsUMrss2fg1uI4A6omSpn0Gj509Mdv6vZg4O7cEmJrDIej/3sGue
         eaFa1o+3qBZTFyrrWGoXQeGorZ0p06ApWvagOUY5OxyY31lopkDf5aHzBf8NV6Vv43rE
         ldMX07Xqe5POoXfQGvN1HUr8ZYavIfkSQZ2F3HCtFNN+AlnbDZSle/HWXuYefn7Ofwrq
         ynEtszrL1mIrUpM+kZXmGBoK+OmaGP28Gj/5r0+vf0loHz7du0FVbIgLrbF0amFKLcBG
         Rq0iwDwWTuGzYSVNtkMHArdWcTJphBkd4z2SklFY3xI/W3kNkuOecUWbi/bUdoSgUhYn
         8H6A==
X-Gm-Message-State: APjAAAUyFtgRVnmfgQITrTUyR55P2FHO6WF3pujyBLVy8gRFf4TSQ4hF
        TsiBb1N6TneuR00kO84N6XSzwSBG
X-Google-Smtp-Source: APXvYqxwal9/QZYEIkxBJX0V6smGITkKhZxyaP7LySCRRNztvUKrI/8n2YyRnNjrt7SP5RRBdAZw3g==
X-Received: by 2002:a17:902:6ac6:: with SMTP id i6mr51581984plt.233.1560083535531;
        Sun, 09 Jun 2019 05:32:15 -0700 (PDT)
Received: from localhost.localdomain ([117.192.26.87])
        by smtp.googlemail.com with ESMTPSA id c142sm10209982pfb.171.2019.06.09.05.32.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 09 Jun 2019 05:32:15 -0700 (PDT)
From:   Deepak Mishra <linux.dkm@gmail.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux.dkm@gmail.com, straube.linux@gmail.com
Subject: [PATCH v5 6/6] staging: rtl8712: Renamed CamelCase lockRxFF0Filter to lock_rx_ff0_filter
Date:   Sun,  9 Jun 2019 18:01:45 +0530
Message-Id: <2122d23efa51d35a0f4e4682061170751e0bb10d.1560081972.git.linux.dkm@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1560081971.git.linux.dkm@gmail.com>
References: <cover.1560081971.git.linux.dkm@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch renames CamelCase variable lockRxFF0Filter to
lock_rx_ff0_filter in drv_types.h, usb_intf.c and xmit_linux.c

This was reported by checkpatch.pl

Signed-off-by: Deepak Mishra <linux.dkm@gmail.com>
---
 drivers/staging/rtl8712/drv_types.h  | 2 +-
 drivers/staging/rtl8712/usb_intf.c   | 2 +-
 drivers/staging/rtl8712/xmit_linux.c | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8712/drv_types.h b/drivers/staging/rtl8712/drv_types.h
index 7838c945d622..0c4325073c63 100644
--- a/drivers/staging/rtl8712/drv_types.h
+++ b/drivers/staging/rtl8712/drv_types.h
@@ -160,7 +160,7 @@ struct _adapter {
 	int pid; /*process id from UI*/
 	struct work_struct wk_filter_rx_ff0;
 	u8 blnEnableRxFF0Filter;
-	spinlock_t lockRxFF0Filter;
+	spinlock_t lock_rx_ff0_filter;
 	const struct firmware *fw;
 	struct usb_interface *pusb_intf;
 	struct mutex mutex_start;
diff --git a/drivers/staging/rtl8712/usb_intf.c b/drivers/staging/rtl8712/usb_intf.c
index 200a271c28e1..d0daae0b8299 100644
--- a/drivers/staging/rtl8712/usb_intf.c
+++ b/drivers/staging/rtl8712/usb_intf.c
@@ -571,7 +571,7 @@ static int r871xu_drv_init(struct usb_interface *pusb_intf,
 	/* step 6. Load the firmware asynchronously */
 	if (rtl871x_load_fw(padapter))
 		goto error;
-	spin_lock_init(&padapter->lockRxFF0Filter);
+	spin_lock_init(&padapter->lock_rx_ff0_filter);
 	mutex_init(&padapter->mutex_start);
 	return 0;
 error:
diff --git a/drivers/staging/rtl8712/xmit_linux.c b/drivers/staging/rtl8712/xmit_linux.c
index e65a51c7f372..71100613aeb3 100644
--- a/drivers/staging/rtl8712/xmit_linux.c
+++ b/drivers/staging/rtl8712/xmit_linux.c
@@ -102,9 +102,9 @@ void r8712_SetFilter(struct work_struct *work)
 	newvalue = oldvalue & 0xfe;
 	r8712_write8(padapter, 0x117, newvalue);
 
-	spin_lock_irqsave(&padapter->lockRxFF0Filter, irqL);
+	spin_lock_irqsave(&padapter->lock_rx_ff0_filter, irqL);
 	padapter->blnEnableRxFF0Filter = 1;
-	spin_unlock_irqrestore(&padapter->lockRxFF0Filter, irqL);
+	spin_unlock_irqrestore(&padapter->lock_rx_ff0_filter, irqL);
 	do {
 		msleep(100);
 	} while (padapter->blnEnableRxFF0Filter == 1);
-- 
2.19.1

