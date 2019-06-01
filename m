Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736C8C28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 18:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B54127799
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 18:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcAU09Ne"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfFASoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 14:44:24 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39960 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbfFASoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 14:44:22 -0400
Received: by mail-pf1-f196.google.com with SMTP id u17so8181332pfn.7
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2019 11:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1q8rxh449LQmVHRRd/tqt/iiw4IrNCg2hqu9B0pbY2M=;
        b=WcAU09NeDzTCvwIbOgN8kmpuBK9NbuzE70htRNKmgbHDxqPS6880Oh08b65j+oMbUt
         sqFmJyU1x2KAbZHTZOmTt2jR8yuOIj/DCDoDVq+2Ra1rO700rA8s5NKAzvrAifx/Dg6c
         M6F5LAaJ9HKHm7XQDZvGGsz2AcF5jKBcmrZmKq5vXOY1oGSJet2SBRiXXf6hdTL585LP
         FmNuireLQqqX8bCB8nvieSUw9tee3TEvwVXbX1y1rghnqlBJCC4d9uUyFNPhkv8E7szT
         PcKGokOg/nS/QvUCpRzHMEqLczVbjyO0vSxGQuf/vMmJma/QYqNc8ISonYqUcRRTJXJF
         t/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1q8rxh449LQmVHRRd/tqt/iiw4IrNCg2hqu9B0pbY2M=;
        b=ZZO0fi6RbYzgf0ie3x4K8FdRkYKOAw8KdGau7zpfHxxW6Z79Ulm7jTxNpE2VuAl24B
         vsUbtRz9pbbb6+Ogk2Vq57g8uu5QD/qv9JSB/hoEeaKMG1CKqlmhCEan/Gslm6G6/7eI
         dECcmJces2LmNXyx+FGQUKA1XomoubiLgPTh+fhx70d/IHgsHy7Tl0lyNLeiGR99Lziu
         ZuAnFUnLCw7bDq8YYCGF45gVFue4TdXWuGQsDOy1yUPwVdwMYPWONStUEv70O+6Dmxd4
         iWumxcyAWf7/WHj/MKJzDZxzeimpsbSytKGTv/G/IIXfACXWPia+QzCO7cgiDPZYzJ3s
         llbQ==
X-Gm-Message-State: APjAAAXP8potDWTE2KCOXJwsgneumN0fpvgVtg1uLqnVCsnchGov06SU
        LK25yRnGGEKPTQ8MH0rQoUUit5gH
X-Google-Smtp-Source: APXvYqyOaSTMYk9xBeI90rfI5dufKchd0mzJqzeBgrsqzejHY6OZmHmHEfhcia9SLpIrPiURABcslQ==
X-Received: by 2002:aa7:8b4d:: with SMTP id i13mr19782191pfd.233.1559414661314;
        Sat, 01 Jun 2019 11:44:21 -0700 (PDT)
Received: from localhost.localdomain ([117.192.16.207])
        by smtp.googlemail.com with ESMTPSA id w187sm13287950pfw.20.2019.06.01.11.44.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Jun 2019 11:44:20 -0700 (PDT)
From:   Deepak Mishra <linux.dkm@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com, linux.dkm@gmail.com,
        himadri18.07@gmail.com, straube.linux@gmail.com
Subject: [PATCH 7/8] staging: rtl8712: Fixed CamelCase in struct _adapter from drv_types.h
Date:   Sun,  2 Jun 2019 00:13:41 +0530
Message-Id: <7c9f64a8f74fe82a46908ef45516fa090ddb2ec8.1559412149.git.linux.dkm@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1559412149.git.linux.dkm@gmail.com>
References: <cover.1559412149.git.linux.dkm@gmail.com>
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

