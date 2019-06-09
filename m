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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0304C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 12:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 961DC2145D
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 12:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="seTjb8WN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbfFIMcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 08:32:15 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42178 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728680AbfFIMcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 08:32:13 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so3696814pff.9
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 05:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hpm2KKbG+H0yHKo7J/P509av/gZtLqRIjvhgzXmVR8g=;
        b=seTjb8WNtP6yjZQHGEBGXf4hFxvpVy7v9Vq6yxKy2DiAXgk+hAkWN5qzKv1NeirteL
         K+HjnVtAlB9HMGbs9k4EK84aGC5DXC2OMIYU0/87MSS6+YzjE4HJuYC/E9t9xfMjGpnG
         emNqgwwMyTfwn7Tdm9flLpmE5TIBoYLiwr6ZdvUi7I9uZ31FcFF7p/rH5xqtxpR+lOM1
         eXwxdPOQ/ImxOH/NT3mkJPYYaazNFTaJfT+K986d6SzeOjP0iJFPT3NTKXALItwyg2Tp
         NvbcEgsNZcO/D0f+x0dTowvIgNcqFAmHvqThB+6zFGTGohT8uTr/YUfPe2Su01QjqU73
         xnWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hpm2KKbG+H0yHKo7J/P509av/gZtLqRIjvhgzXmVR8g=;
        b=evjsU2a5z9joQxjL5cHKeRNJMxHwneVCY9rPahwcGPKg81G65Czw7i3qipUKD7E0oa
         FUWoSDBgW3AXi6mM6dfqGsrAO2m4XnJR2f1TGTn7McgRib06h7hHx8EGTzU0JRtMOsqC
         rf0mget0HMGCodee3UXL8C3eQVtUl5rpQUr8GipclgXsHsElpdJUr08Sez0EtrNNfVMv
         ZJfURCiV8l79AD45qgUE05pwG7+EhHK7NR174qzwNKCE93KS47j3OqWoGZkNKdHcWy3P
         rsVEJCxcT6sMVHIVtU7MOCI278EUZqJ6GoTwan3qwMTsE5V/wvUR1D3nUbW9a0zLh/2M
         yRhw==
X-Gm-Message-State: APjAAAW0zE4KMHPHYRxtxXkTj93hGFVL/7pugwLORlC82RZbPU9SJ5M/
        6oWhw6HIWfGB2+Qy+pAMxpvg+yG4
X-Google-Smtp-Source: APXvYqyG6shNLUl90eNFS+OcaittYsrpAJpn0p2Vu2wU5XYBuGh6wwSWaTvO1+raUlI6bK70zYTwCw==
X-Received: by 2002:a63:a34c:: with SMTP id v12mr11056681pgn.198.1560083532942;
        Sun, 09 Jun 2019 05:32:12 -0700 (PDT)
Received: from localhost.localdomain ([117.192.26.87])
        by smtp.googlemail.com with ESMTPSA id c142sm10209982pfb.171.2019.06.09.05.32.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 09 Jun 2019 05:32:12 -0700 (PDT)
From:   Deepak Mishra <linux.dkm@gmail.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux.dkm@gmail.com, straube.linux@gmail.com
Subject: [PATCH v5 5/6] staging: rtl8712: Renamed CamelCase wkFilterRxFF0 to wk_filter_rx_ff0
Date:   Sun,  9 Jun 2019 18:01:44 +0530
Message-Id: <565142f388450d86b9457e4d40ca8dac9051d4b6.1560081972.git.linux.dkm@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1560081971.git.linux.dkm@gmail.com>
References: <cover.1560081971.git.linux.dkm@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch renames CamelCase variable wkFilterRxFF0 to wk_filter_rx_ff0 in
drv_types.h, rtl871x_xmit.c and xmit_linux.c

This was reported by checkpatch.pl

Signed-off-by: Deepak Mishra <linux.dkm@gmail.com>
---
 drivers/staging/rtl8712/drv_types.h    | 2 +-
 drivers/staging/rtl8712/rtl871x_xmit.c | 2 +-
 drivers/staging/rtl8712/xmit_linux.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8712/drv_types.h b/drivers/staging/rtl8712/drv_types.h
index c36a5ef3ee5d..7838c945d622 100644
--- a/drivers/staging/rtl8712/drv_types.h
+++ b/drivers/staging/rtl8712/drv_types.h
@@ -158,7 +158,7 @@ struct _adapter {
 	struct net_device_stats stats;
 	struct iw_statistics iwstats;
 	int pid; /*process id from UI*/
-	struct work_struct wkFilterRxFF0;
+	struct work_struct wk_filter_rx_ff0;
 	u8 blnEnableRxFF0Filter;
 	spinlock_t lockRxFF0Filter;
 	const struct firmware *fw;
diff --git a/drivers/staging/rtl8712/rtl871x_xmit.c b/drivers/staging/rtl8712/rtl871x_xmit.c
index bfd5538a4652..5d63d2721eb6 100644
--- a/drivers/staging/rtl8712/rtl871x_xmit.c
+++ b/drivers/staging/rtl8712/rtl871x_xmit.c
@@ -139,7 +139,7 @@ sint _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
 		pxmitbuf++;
 	}
 	pxmitpriv->free_xmitbuf_cnt = NR_XMITBUFF;
-	INIT_WORK(&padapter->wkFilterRxFF0, r8712_SetFilter);
+	INIT_WORK(&padapter->wk_filter_rx_ff0, r8712_SetFilter);
 	alloc_hwxmits(padapter);
 	init_hwxmits(pxmitpriv->hwxmits, pxmitpriv->hwxmit_entry);
 	tasklet_init(&pxmitpriv->xmit_tasklet,
diff --git a/drivers/staging/rtl8712/xmit_linux.c b/drivers/staging/rtl8712/xmit_linux.c
index 8bcb0775411f..e65a51c7f372 100644
--- a/drivers/staging/rtl8712/xmit_linux.c
+++ b/drivers/staging/rtl8712/xmit_linux.c
@@ -94,7 +94,7 @@ void r8712_set_qos(struct pkt_file *ppktfile, struct pkt_attrib *pattrib)
 void r8712_SetFilter(struct work_struct *work)
 {
 	struct _adapter *padapter = container_of(work, struct _adapter,
-						wkFilterRxFF0);
+						wk_filter_rx_ff0);
 	u8  oldvalue = 0x00, newvalue = 0x00;
 	unsigned long irqL;
 
-- 
2.19.1

