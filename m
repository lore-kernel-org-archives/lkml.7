Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F67C28CC3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 04:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB5224BD4
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 04:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhBZMgyp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfFDEWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 00:22:18 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42712 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfFDEWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 00:22:16 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6so8287347pgd.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 21:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=07eHCHIkVCpNAi1lwSCjoekXyO/hTDvxCiJQyOPspUs=;
        b=XhBZMgypOBuCkGJlcB8ahZBvFCc1d3ADwfI5cVfz+Jf/L55U9v2sPZ86BqU5ntFYY1
         sCCjozdBp9XerdwdYSjRksgnZ/3X4xoGxF3e9xQuUdWpLLx76Lt77OYOvk6fZ8NDIC44
         FCsxigXIj9rsAiS2QJEqLwZcu0GBzT/iM+MKGJeBXCbz964xt5B0Pz/NTcajeNXy7zMY
         jxEt8XDT2pU1EB7mK+Q53KQjr4udx2JP1vajRxa6UaRIU9SxAb+cJffQawkvIlGl5o5X
         A6yZDw9LWi37AvQdipOr1nR/Kutfk4rL1lPaUFyhkiGJPO5xRK/0miT/1rDwOwF0MT6P
         /nmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=07eHCHIkVCpNAi1lwSCjoekXyO/hTDvxCiJQyOPspUs=;
        b=LGze16CqJU8x6QnlmZfk0RwHNKvgvIxe+BTdLvG6Haik6Ob/0X9i21V1QiQWHEpD03
         I5qhj9GNN+qIdDt8zxFgSypk30DZVHwuAErez9k+fKh3bYznoZcqKPJpD8MQqRVUxb9f
         aT7S6rOhq/49AgnAqu6ncOphDtMA5X7knkaf6IO1mqW2IuQurPoun9ovrd0la2Kpa0nq
         U3R/sejaDhHt0UBwuUq1mlKinT/wun1Zkw/9/Zes7OKm+XSU6nUQJ974CwFHJCd8+RRY
         Es2THZpvF2y731XfMKjDhOCZhNYV6fzLxhwu9COimR654gXESkZf0CCDFXo5Tpdo1FT2
         Y1Iw==
X-Gm-Message-State: APjAAAW3NcJMq8ibg/wlxdE+KGizL3xbvM9zEdecvLlZc202XkwJsATG
        aLwfbcSDD21zxfJt6LnHMxijLHko
X-Google-Smtp-Source: APXvYqyGnwzBfKi5wN5HhGyQMSWfzz2o3+mKoKiGQEHfSdU1pStVnYLymfT0/WDjAfzfY9CWcxJZYw==
X-Received: by 2002:a63:dc15:: with SMTP id s21mr19692267pgg.215.1559622135157;
        Mon, 03 Jun 2019 21:22:15 -0700 (PDT)
Received: from localhost.localdomain ([117.192.17.118])
        by smtp.googlemail.com with ESMTPSA id q3sm14382390pgv.21.2019.06.03.21.22.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 21:22:14 -0700 (PDT)
From:   Deepak Mishra <linux.dkm@gmail.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     joe@perches.com, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com, linux.dkm@gmail.com
Subject: [PATCH v3 4/4] staging: rtl8712: Fixed CamelCase wkFilterRxFF0 and lockRxFF0Filter
Date:   Tue,  4 Jun 2019 09:51:36 +0530
Message-Id: <da04945b71fd7909fb03edd2c4d188588cb172fe.1559615579.git.linux.dkm@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1559615579.git.linux.dkm@gmail.com>
References: <cover.1559615579.git.linux.dkm@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch renames CamelCase variable wkFilterRxFF0 to wk_filter_rx_ff0
in drv_types.h and related files rtl871x_xmit.c and xmit_linux.c as
reported by checkpatch.pl

This patch renames CamelCase variable lockRxFF0Filter to lock_rx_ff0_filter
in drv_types.h and related files usb_intf.c and xmit_linux.c as
reported by checkpatch.pl

Signed-off-by: Deepak Mishra <linux.dkm@gmail.com>
---
 drivers/staging/rtl8712/drv_types.h    | 2 +-
 drivers/staging/rtl8712/rtl871x_xmit.c | 2 +-
 drivers/staging/rtl8712/usb_intf.c     | 2 +-
 drivers/staging/rtl8712/xmit_linux.c   | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

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
index 8bcb0775411f..71100613aeb3 100644
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

