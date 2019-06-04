Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA18C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 04:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB7324F01
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 04:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="syhAi71I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfFDEWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 00:22:12 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42030 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfFDEWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 00:22:10 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so1644105pff.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 21:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D3kQL1r2zp6sBTv5pff2+Q6QbH2XGHYt9yhid3mUcus=;
        b=syhAi71IwNs+OTvhm18JnsNKT/Z8XCCGGpHDsV9D1mlPpY3CTzaCnWyru983dJi+dT
         B1IdFmkoAKqThBXOS2A1cTub9Gq4dMIyPSlhXxAaa0dDjYz2HHpJLIrv/ScSUtR1k89J
         zJn0BgNHAtyDHffEkqT1+U8e6FTEf8lHkAhE32nRJ9JAwh+i3or+qWp8uHmZ1TpjRvwZ
         EWJUD47HL/QAZa4wRYA9ztmo50b7yRs5DB+jSbiwLlE283265pLx+3SR0PegztXkoP9B
         jS7oMzeFDeEW+f2hYj16fpo2sOasRKmEeC3SPkFveo894gDHpawjLKF1RtduJdZEqkNZ
         eKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D3kQL1r2zp6sBTv5pff2+Q6QbH2XGHYt9yhid3mUcus=;
        b=prGrDcOXj1+qo7pw1FalVtqh/ndZ0tFDr7uj7m1aIcStFx2sgaY9yrTgnwDAYTmORI
         tBXGMk/UktwPstCaHHV4gPdy04cvjQLL0bebgyuzD1YY6s7tg04RV0WPBYFvqCV4GaNB
         ztL5g/jyCKhmCtqrugROZnjXFX/5L1Qms79YaBlMXuRQi4oYcI09QMRp3f4iLi2+RKZ/
         2MhphNOPXuWG/g4uRzLQXYolCC9GG+lBqs/8CB8oLGgraTFT+jNCpitgTzAZnPxJ1cB2
         cQGsiWt8v+2ekFnKDxRc8N27fa8Yf35HHK+0cNiNiPGyz0yAmNBd+0QikUsPEb65s/8E
         JKIw==
X-Gm-Message-State: APjAAAX0BCuaKcbKtBVJrwLnZq6r9dOTIUe1/AjUcawYoHpHCGyq6lcL
        YBHUwNTn2Pm6Ew7Txj9RclPUYMDx
X-Google-Smtp-Source: APXvYqyrTy9Yke/mTuE5keF1FQb8bverPzDJYyusRUGV2iAiYt07XeoaPBub+Z+YHA+6hPGycj4BCg==
X-Received: by 2002:a63:e358:: with SMTP id o24mr2630202pgj.78.1559622129872;
        Mon, 03 Jun 2019 21:22:09 -0700 (PDT)
Received: from localhost.localdomain ([117.192.17.118])
        by smtp.googlemail.com with ESMTPSA id q3sm14382390pgv.21.2019.06.03.21.22.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 21:22:09 -0700 (PDT)
From:   Deepak Mishra <linux.dkm@gmail.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     joe@perches.com, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com, linux.dkm@gmail.com
Subject: [PATCH v3 2/4] staging: rtl8712: Fixed CamelCase cmdThread rename to cmd_thread
Date:   Tue,  4 Jun 2019 09:51:34 +0530
Message-Id: <2fd1b5a477158e8f308c5a74e0b432389d1a9491.1559615579.git.linux.dkm@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1559615579.git.linux.dkm@gmail.com>
References: <cover.1559615579.git.linux.dkm@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch renames CamelCase cmdThread to cmd_thread in struct _adapter and related
files drv_types.h,os_intfs.c
CHECK: Avoid CamelCase: <cmdThread>

Signed-off-by: Deepak Mishra <linux.dkm@gmail.com>
---
 drivers/staging/rtl8712/drv_types.h | 2 +-
 drivers/staging/rtl8712/os_intfs.c  | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8712/drv_types.h b/drivers/staging/rtl8712/drv_types.h
index 9fbd19f03ca9..0c722e9c2410 100644
--- a/drivers/staging/rtl8712/drv_types.h
+++ b/drivers/staging/rtl8712/drv_types.h
@@ -151,7 +151,7 @@ struct _adapter {
 	u32	IsrContent;
 	u8	eeprom_address_size;
 	u8	hw_init_completed;
-	struct task_struct *cmdThread;
+	struct task_struct *cmd_thread;
 	pid_t evtThread;
 	struct task_struct *xmitThread;
 	pid_t recvThread;
diff --git a/drivers/staging/rtl8712/os_intfs.c b/drivers/staging/rtl8712/os_intfs.c
index c962696c9822..1653b36c4bfd 100644
--- a/drivers/staging/rtl8712/os_intfs.c
+++ b/drivers/staging/rtl8712/os_intfs.c
@@ -221,9 +221,9 @@ struct net_device *r8712_init_netdev(void)
 
 static u32 start_drv_threads(struct _adapter *padapter)
 {
-	padapter->cmdThread = kthread_run(r8712_cmd_thread, padapter, "%s",
+	padapter->cmd_thread = kthread_run(r8712_cmd_thread, padapter, "%s",
 					  padapter->pnetdev->name);
-	if (IS_ERR(padapter->cmdThread))
+	if (IS_ERR(padapter->cmd_thread))
 		return _FAIL;
 	return _SUCCESS;
 }
@@ -235,7 +235,7 @@ void r8712_stop_drv_threads(struct _adapter *padapter)
 
 	/*Below is to terminate r8712_cmd_thread & event_thread...*/
 	complete(&padapter->cmdpriv.cmd_queue_comp);
-	if (padapter->cmdThread)
+	if (padapter->cmd_thread)
 		wait_for_completion_interruptible(completion);
 	padapter->cmdpriv.cmd_seq = 1;
 }
-- 
2.19.1

