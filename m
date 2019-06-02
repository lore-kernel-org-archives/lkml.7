Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E9AC282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 10:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 883B2278CC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 10:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkBO/HGB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfFBK0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 06:26:54 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36383 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbfFBK0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 06:26:51 -0400
Received: by mail-pl1-f195.google.com with SMTP id d21so5813543plr.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 03:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1q8rxh449LQmVHRRd/tqt/iiw4IrNCg2hqu9B0pbY2M=;
        b=MkBO/HGB4ucjukkVuknWSkmBU6FPgCyzs46CiDfgssoHm/q/8CfLJAXukxC9bFXO/t
         a+3rRYs575II6dyZoZNr0QhfZRkM/peAZxHADxDKbPfEo39cYRVkXliKXXxulh2ch996
         9N2v7yyVRlQc5x3rb85uqY63DRwT5ndGalXxAjjlqSJFAcDWusA145Q3mcHOVlZudf7F
         4WkPBIXD124CzCgKnMdLPaRM+gCRYq6QdeLv/berW/xJ8PgitIOmo96y2AGKXHmF4IR7
         BSPG/uWPxu8khkA5l/L0qGsh5xyDvVaovWj/cXzYqLEyNq1WMp+VPEpXoVecATaHBpR4
         FmfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1q8rxh449LQmVHRRd/tqt/iiw4IrNCg2hqu9B0pbY2M=;
        b=HC9jbvtJ0VvV3TJXaXvdhTsPbx6xGP6rp7ZxO3RKcsV3kF/ufCqeAki4uelc2IEZi/
         iZFLkbNHMe51rJ6cE5LJRaGOBk2Dj2P13nYPHAfwAgE4KAAy9aBeBE1S2D7H+Tq8gIGN
         B697EnCMQBZ+GJlQ0cgNSwSNyAuhLoDMma7tkPuigBQ7pLbVtsK+HdICHnhTYZU0zjVV
         nOSoLymHaS+kkPQZJ5FJ/CAbJI/LXQ9KOk85FipijtE2qBQU3lZNJVUEPc+JxqhRU+2e
         iv7ScCnoxyr2Jw9ATJ6yQWeich00Qzyka3zWl0Mt1Rxa+uH2SDG6B3ZTN6axuMTpyvf8
         wRgA==
X-Gm-Message-State: APjAAAWvPkj6HUUQm084Vt4EwXC/pTZ24twZm3l6FIEZ+rpqusEi3392
        6riiUtoAzmyveac9fbPKrInNZNJa
X-Google-Smtp-Source: APXvYqyI+B6UDIQxMWsrQhItRigP4E2h7oaxGYrGe18sHKcUjkmg8pkbFkF4Des8YtwRzymUuYuolg==
X-Received: by 2002:a17:902:ba82:: with SMTP id k2mr12454698pls.323.1559471210896;
        Sun, 02 Jun 2019 03:26:50 -0700 (PDT)
Received: from localhost.localdomain ([117.192.23.157])
        by smtp.googlemail.com with ESMTPSA id j13sm12221099pfh.13.2019.06.02.03.26.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Jun 2019 03:26:50 -0700 (PDT)
From:   Deepak Mishra <linux.dkm@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, joe@perches.com, wlanfae@realtek.com,
        Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux.dkm@gmail.com, himadri18.07@gmail.com,
        straube.linux@gmail.com
Subject: [PATCH v2 7/9] staging: rtl8712: Fixed CamelCase wkFilterRxFF0 to wk_filter_rx_ff0 in
Date:   Sun,  2 Jun 2019 15:55:36 +0530
Message-Id: <b24dc1f4deaa7b681363adade74cbcbb69359157.1559470738.git.linux.dkm@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1559470737.git.linux.dkm@gmail.com>
References: <cover.1559470737.git.linux.dkm@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch renames CamelCase variable wkFilterRxFF0 to wk_filter_rx_ff0
in drv_types.h and related files rtl871x_xmit.c and xmit_linux.c as
reported by checkpatch.pl

Signed-off-by: Deepak Mishra <linux.dkm@gmail.com>
---
 drivers/staging/rtl8712/drv_types.h    | 2 +-
 drivers/staging/rtl8712/rtl871x_xmit.c | 2 +-
 drivers/staging/rtl8712/xmit_linux.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8712/drv_types.h b/drivers/staging/rtl8712/drv_types.h
index 1f8aa0358b77..ddab6514a549 100644
--- a/drivers/staging/rtl8712/drv_types.h
+++ b/drivers/staging/rtl8712/drv_types.h
@@ -163,7 +163,7 @@ struct _adapter {
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

