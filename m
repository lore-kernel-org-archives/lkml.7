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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EC7C468BC
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 10:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A49B212F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 10:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOvsvnbY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfFHK5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 06:57:37 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46165 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbfFHK5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 06:57:36 -0400
Received: by mail-pg1-f193.google.com with SMTP id v9so781160pgr.13
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 03:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/jhlTAOCr2cATKgTKP2X5yBcXY2hwT21U0WFbUJTCmU=;
        b=TOvsvnbYAFQAgOey2Md3zoScWrppLuDa08Ss1wPG37UZ0cwGDs1tAi8pHkCCkQfZxd
         58c2RqqnwMNwMF/1/8Iq9XCANLe0WP9JUf/6hlqEWN9N7FZCtjUr2mB2TG4Y35QPJmeM
         BkERSw4iExV4icHb5U7kXsPUZkl3F1NiFnSb+v6DPPNCnbaHJNfO1uSnyi83lvkBoZMg
         GRM0YxzCZocfVx5o0LsbQnDeOsSeYVaMBtZKmBjbcnYfYCl9efaIJ/Vev7YGSEOOkn0X
         r1BkdTA+3Iv9yJImracc7AOyM/99nb8ozFrSHgrong7SySSXifV6G1dZywkHvpzldAoy
         yYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/jhlTAOCr2cATKgTKP2X5yBcXY2hwT21U0WFbUJTCmU=;
        b=pjfZQGNdifyhmj0Icwec7JuZ5A9gXnz8WvMtJAoztLUB4b9DTtMyXo80eiJpAY/3kO
         e4JKasGl8ZUaRCL8efIlfQTUYwXggg+W0h7hNXs8LFIFkBB3jPjcoG/9RzLlBsG4Ovbt
         8CaLnWmPTIip9ieXmsnM9BktcVnSOciQ+QKYa0yQGKhUy+PLu0IUEMn24y/shQkBUVRL
         r5uvO+z1U0gsGGGDYq8Q/LioMfHirA48FTYynjice2EqmNoz1Ig4SFY/dINOhoojcuWF
         yQZm7RFZrZRYWqaO+5+lm6HdfBrMh/wkbNxbobuhp5kPO73MwT393cvjb/kYJdmixtqd
         kSwQ==
X-Gm-Message-State: APjAAAVBkMn/kINqaOjz3XjJdPpM8AUzHB/FWCQmbfM6tvPyZKLhulr1
        B6roD7pU5rdZOsxBssjYsm80lL9Z
X-Google-Smtp-Source: APXvYqxnSy75vaTrAEtVkMxy3DnthsvUhUY1+RPgyOwH03Ar5AtQLbivtS2Dxz6Z9Fegpw5JIOo75Q==
X-Received: by 2002:a62:2983:: with SMTP id p125mr22924451pfp.154.1559991455923;
        Sat, 08 Jun 2019 03:57:35 -0700 (PDT)
Received: from localhost.localdomain ([117.192.25.72])
        by smtp.googlemail.com with ESMTPSA id s24sm5021384pfh.133.2019.06.08.03.57.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 08 Jun 2019 03:57:35 -0700 (PDT)
From:   Deepak Mishra <linux.dkm@gmail.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux.dkm@gmail.com, straube.linux@gmail.com
Subject: [PATCH v4 3/6] staging: rtl8712: Fixed CamelCase cmdThread rename to cmd_thread
Date:   Sat,  8 Jun 2019 16:26:58 +0530
Message-Id: <cf8b19d6dc86962021d9f7f397729cb6ac6c64f4.1559990697.git.linux.dkm@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1559990697.git.linux.dkm@gmail.com>
References: <cover.1559990697.git.linux.dkm@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch renames CamelCase cmdThread to cmd_thread in struct _adapter in
drv_types.h and in os_intfs.c

This was reported by checkpatch.pl

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

