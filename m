Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDCDC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 04:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61CD206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 04:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+q5Ponb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbfFLEwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 00:52:00 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36877 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730250AbfFLEv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 00:51:58 -0400
Received: by mail-pg1-f196.google.com with SMTP id 20so8220358pgr.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 21:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v+JWaUxbtjRzXit+v7ZqV4BZlFkN3z5Hn0KGUg7tn/4=;
        b=O+q5Ponb7YP2fi+zUTQ0tbatfcUy42jyVwepU0u0jFpKefITvnoCDHZkQUlzW9YkTK
         aP0rqQyy4ed0TaoCvZWZI/OlgkaQ1v4KLgUlenPnFRB55aUX7tALItK7VHIrcfJoxKtU
         cds729H+2dR1UBYE/1nErP69CIv5dRkXp7NGSfSX20WnnUpSTFLKNnbX6VcOP6OyuXrM
         1Jj1mdMnB77+GmCwNFLZEdijrp6kwYMkWTlexaQ0STaFLlYElZzRDzMgV3diNDchtfmw
         94GSGxNBQrTSL7bDoX+PPiabbZuLc+DOd7bLuc03JaVxlHHlG56opS+KPnIuzGLybe1Y
         SuQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v+JWaUxbtjRzXit+v7ZqV4BZlFkN3z5Hn0KGUg7tn/4=;
        b=NaFLFv2ntTkPJnW4fsujFoj67DUe30+KzORKLEKHXa5nk0y3IrGCNpQ6eWxyBK4TMj
         6lKMkIZbeOxKAeYdCqVihRwR5FstHaCh5y9g57U+y6xrsByRlfVsz/Z3RIp+Mzq/dJ19
         5IAWsMZVNpJKxmh+u38/S6dzYMUM8Ro32U0x7IuYrvYrnTGUoOHgD8tnqSt0ga735UXB
         wcA++X3oetsWWvnh9t8TginzCgqs7B8x4dkKl1Ki7jZMzH+4begOliYRD2/ivP0kOkWW
         iaDPN4avYNb66tY3nfRBiVkA6oodQVQpfwAds7GO0uzVa+uKEkDH/m63yJ9YLPShSwgF
         p3dg==
X-Gm-Message-State: APjAAAXYWLggtgMX0zCJpqu06yxRxDv/fFdV+RGwX82odeXuxHiBaYb7
        tvyuuXiczCKQyejhWW/bg5NQon3u
X-Google-Smtp-Source: APXvYqxpE8PrwipTauB5UXM82HdIrMOLc3vzHPXZbpb0vSM4JdSGHD4W9KXHJcJ1MutjInE7uBi6ww==
X-Received: by 2002:a17:90a:24ac:: with SMTP id i41mr8515560pje.124.1560315117186;
        Tue, 11 Jun 2019 21:51:57 -0700 (PDT)
Received: from localhost.localdomain ([117.192.27.213])
        by smtp.googlemail.com with ESMTPSA id t184sm1072719pgt.88.2019.06.11.21.51.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 21:51:56 -0700 (PDT)
From:   Deepak Mishra <linux.dkm@gmail.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux.dkm@gmail.com, straube.linux@gmail.com
Subject: [PATCH 2/2] staging: rtl8712: Fixed CamelCase wkFilterRxFF0 renamed to wk_filter_rx_ff0
Date:   Wed, 12 Jun 2019 10:21:31 +0530
Message-Id: <87edf4da96fbefb058f1e71f201c6c76a4480185.1560314282.git.linux.dkm@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1560314282.git.linux.dkm@gmail.com>
References: <cover.1560314282.git.linux.dkm@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In process of cleaning up struct _adapter in drv_types.h, wkFilterRxFF0
     is renamed to to wk_filter_rx_ff0 to fix a checkpatch reported issue.

Signed-off-by: Deepak Mishra <linux.dkm@gmail.com>
---
 drivers/staging/rtl8712/drv_types.h    | 2 +-
 drivers/staging/rtl8712/rtl871x_xmit.c | 2 +-
 drivers/staging/rtl8712/xmit_linux.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8712/drv_types.h b/drivers/staging/rtl8712/drv_types.h
index 79d10b6fbfda..0c4325073c63 100644
--- a/drivers/staging/rtl8712/drv_types.h
+++ b/drivers/staging/rtl8712/drv_types.h
@@ -158,7 +158,7 @@ struct _adapter {
 	struct net_device_stats stats;
 	struct iw_statistics iwstats;
 	int pid; /*process id from UI*/
-	struct work_struct wkFilterRxFF0;
+	struct work_struct wk_filter_rx_ff0;
 	u8 blnEnableRxFF0Filter;
 	spinlock_t lock_rx_ff0_filter;
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
index d8307bcc63f5..dc03f0d0c85d 100644
--- a/drivers/staging/rtl8712/xmit_linux.c
+++ b/drivers/staging/rtl8712/xmit_linux.c
@@ -94,7 +94,7 @@ void r8712_set_qos(struct pkt_file *ppktfile, struct pkt_attrib *pattrib)
 void r8712_SetFilter(struct work_struct *work)
 {
 	struct _adapter *adapter = container_of(work, struct _adapter,
-						wkFilterRxFF0);
+						wk_filter_rx_ff0);
 	u8  oldvalue = 0x00, newvalue = 0x00;
 	unsigned long irqL;
 
-- 
2.19.1

