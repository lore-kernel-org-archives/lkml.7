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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4AAC282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 10:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0CA5278C3
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 10:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxpOo2a+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfFBK0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 06:26:41 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45387 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfFBK0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 06:26:39 -0400
Received: by mail-pg1-f196.google.com with SMTP id w34so6543325pga.12
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 03:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cn/02pRULQN1C+RrPVokHf7vG5PSRqDMX3dkUYRHGtE=;
        b=DxpOo2a+ySBu2WW5wsQEtCucyYPQ+s2ETm9jvQRje17u5GAL9E2rTktp/LE6YEBRIn
         Dw6gv1+VjOp/gmS4beIS4ByleAgujTOY83tNmRcN1KD/m3KpozkKo9QYQbjPtWiiiNZ+
         nZ7S52s+mCKjFQSbcCHkJhuXUUD7olFhRD4K+84Pypn4Ya/YkL+vPHsLSs/gbSyn2iav
         Hy0E2CMnMA01KgRADh/X7VoHYUTqHNW0majL7TUgJd4eEZJri6p0LoNbxp3yi90l9br1
         hUMzrXTOb586Coo82r6x4PM9Kg6E1+MgrIDrOe7ozPUJzTfqKN4VdRcD4i8B+L9AIIOQ
         RqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cn/02pRULQN1C+RrPVokHf7vG5PSRqDMX3dkUYRHGtE=;
        b=cwFJPs4jShJwETNS2+hHA5e9+ViGn6J3OJTBqi2f8ND75fVNOPR+Vz8uVS24Po02Ox
         D/O9OeY3LWrch9fQp0LX6zpopjfVrzUyF6nfDobTJifnS6zLeQ1qcjDdsCX60DgSbd75
         UkQKhtr+mNCQelfjCZK83GWkX+rC6as2lIbTD7cJ3OBsYCdhaygcdI5BZH+wJlE1pZR/
         5UoYwxmxMxek5Qohwuqk6fa2MUUs1SR3Rk2XicyHmdBUBJvTlMNF5fQIAePk14eeNzCw
         xzcwnCFxV8ALHnxk7nUUlhloJ5aMZNnUYLF63l9M9k0iICjH3oC/GAY/tmH9VLtiuDt/
         LG5g==
X-Gm-Message-State: APjAAAUtCrvqGRl0rAXX+kIHde/fttCPSgxbRNvbO8TuqewdpBowGPsP
        NACmMNzCjCZO5Tkv2L4o0Vnv2jSN
X-Google-Smtp-Source: APXvYqwv5sNyN638DfFJzXaBRr3+cz+2KVn9Ej8WR9wH/vi2AG2TZmuILoEUs34XPSpA7rAh5ZYzvA==
X-Received: by 2002:aa7:824b:: with SMTP id e11mr21413003pfn.33.1559471198220;
        Sun, 02 Jun 2019 03:26:38 -0700 (PDT)
Received: from localhost.localdomain ([117.192.23.157])
        by smtp.googlemail.com with ESMTPSA id j13sm12221099pfh.13.2019.06.02.03.26.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Jun 2019 03:26:37 -0700 (PDT)
From:   Deepak Mishra <linux.dkm@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, joe@perches.com, wlanfae@realtek.com,
        Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux.dkm@gmail.com, himadri18.07@gmail.com,
        straube.linux@gmail.com
Subject: [PATCH v2 3/9] staging: rtl8712: Fixed CamelCase cmdThread rename to cmd_thread
Date:   Sun,  2 Jun 2019 15:55:32 +0530
Message-Id: <587e87c58b6820a2c6d067ce271290054000a318.1559470738.git.linux.dkm@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1559470737.git.linux.dkm@gmail.com>
References: <cover.1559470737.git.linux.dkm@gmail.com>
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
index 7d1178278ecc..c6faafb13bdf 100644
--- a/drivers/staging/rtl8712/drv_types.h
+++ b/drivers/staging/rtl8712/drv_types.h
@@ -152,7 +152,7 @@ struct _adapter {
 	u32	imr_content;
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

