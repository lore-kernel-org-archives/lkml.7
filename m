Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E49C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 10:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C90C1212F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 10:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="usCeCtr9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfFHK5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 06:57:49 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40565 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfFHK5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 06:57:47 -0400
Received: by mail-pl1-f193.google.com with SMTP id a93so1795231pla.7
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 03:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hpm2KKbG+H0yHKo7J/P509av/gZtLqRIjvhgzXmVR8g=;
        b=usCeCtr9QHSoYysG/3NUNoA1yWTSwEjcySPAKWMa1f4vi3bK5fmFBf2Uq2D5YheHXE
         MGHdAZxg0YxzOz7spAtVu0MO1MSC//CVlw7WIPqADS6NynPUuYOjYNUR54dy8FKHUyXy
         7lHhBC0lODDpODVFWyL2flcZjmZbe0RbQBjUdiwjjYKQ3mdPGC+8hG8x0Luw4wwjNL9b
         TSktp/j3gur6HaANx0bvAPY/Zm2sIRnHKV7BI8zYyfPZBCC3KoyZP6kZmVAZaQCoAZ0X
         Dg+L3o4eaQWl5MwqeieswP94sXACKuvoeiJJ1Qa8bipLkjost1KPOLoDV0dy+iPtvola
         GhBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hpm2KKbG+H0yHKo7J/P509av/gZtLqRIjvhgzXmVR8g=;
        b=Atx+bB4QSbXGnjTl6rwIHvl9vc00SUF+cRclqp/Q8mRWro6XhRm9ANO/Y2jRuMF/6o
         BdtmJc1hkTa4rwa6NsOtA2UKnSki5u0LpsOHUnIFFp846LX2UCeGIcGza+qU/rW3UB+V
         EuLTeSNoEbk/DmBn86fQa+VosltwE5bQokjBCA0JGkRfJ2uAWFnBl0vd09LqEFRgfuXM
         X6obvCLVhXCUiDJyh1rWgChgtnqyT6UgjCn7SjNEwkFdOUT1IydB5g2wF5156RoMGuSz
         BoIArFlfq1Ml6Cy5VZHroqa1jras2+xVkjzLf7ggzEVprABOB9+h9Wo8xj0F8Iqyn7ke
         jaGA==
X-Gm-Message-State: APjAAAX+tu4y7rGJGNimubKuJ5Wx1WdrCUGsjYkRtzI8cGWXtQziGaHn
        VS/pMaiw66SU7LOsY8M12s8AxhAp
X-Google-Smtp-Source: APXvYqwZSI/pdAo8mCqeFS9hnEbt+rGEL7KQSEeWVVHE+Hh64D68ZUQZx3O4xyoNC7VIBexvdSB7tw==
X-Received: by 2002:a17:902:9682:: with SMTP id n2mr54254610plp.95.1559991466602;
        Sat, 08 Jun 2019 03:57:46 -0700 (PDT)
Received: from localhost.localdomain ([117.192.25.72])
        by smtp.googlemail.com with ESMTPSA id s24sm5021384pfh.133.2019.06.08.03.57.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 08 Jun 2019 03:57:46 -0700 (PDT)
From:   Deepak Mishra <linux.dkm@gmail.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux.dkm@gmail.com, straube.linux@gmail.com
Subject: [PATCH v4 5/6] staging: rtl8712: Renamed CamelCase wkFilterRxFF0 to wk_filter_rx_ff0
Date:   Sat,  8 Jun 2019 16:27:00 +0530
Message-Id: <565142f388450d86b9457e4d40ca8dac9051d4b6.1559990697.git.linux.dkm@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1559990697.git.linux.dkm@gmail.com>
References: <cover.1559990697.git.linux.dkm@gmail.com>
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

