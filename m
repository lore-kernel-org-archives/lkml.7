Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D078BC28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 18:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1EE27791
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 18:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftypME8L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfFASoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 14:44:14 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42505 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfFASoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 14:44:10 -0400
Received: by mail-pl1-f196.google.com with SMTP id go2so5321009plb.9
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2019 11:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4aURa9Jn2nN3EQ9knSGa/SVX6K9OEP27rSyNUYRBpLU=;
        b=ftypME8L1sPq3uH7VwC2rN1aGBXA9xKNRkFpHHEGdNxr7o82ahwgCapz2yqdlQuUkq
         kQ1nPYwAGoT9z8PXHfo45JjT+uCNNl2qKMsxSoC6K+Nx/x1GNubKQAAgdODSs7JEiZy9
         yD5gHwjbOHtE1eja8hxREPpujDEyiZHGPEwBQ8X5ZhGj0jObBJOGIDAqHDOWdurVoXKR
         snh5A4KU9gVomZ16su/OX9pNoLcIj/5gveNS1nTqADBogv+MbpMCzQUstuwf4h1Welgl
         JCWJU6m+UnVzpOSRvzyyszlLd2N9BuyWb3zSuNX3YT0JFjK17EcTBsCba9haEkQFsxj5
         3VPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4aURa9Jn2nN3EQ9knSGa/SVX6K9OEP27rSyNUYRBpLU=;
        b=COCI25+a5NZdfkHnNY9rjQCiLa7VFjGKoH5eqa9O8m5ZGVtrq3D88gyBTwjZrdOvke
         AfXzQzZ/1+z7OFpq9QuZOo1cZiyTxR+MLh0mo1/4vQs2kZpB1sF967GTlbICdpDdirqi
         AlPftOKiS1x62GKCFV4rzdvG3T7CajmyJ0xI6t/rb8lJUy3YQ97J8OCA+0lz0Nemqd91
         roKi/6przJWTj0ZsTfqK9Tqoc9GtUKmlKRfhykfllkkZOn1G1eS5Vv9AepluN0XRNkzS
         n8jbq1KrYgu8Dq+oGWm9oo6Y5h3nT2n9T/QpOspXJRUK+OAp0bbZbLQUf7ikzp5ov4My
         /y2A==
X-Gm-Message-State: APjAAAWYeQPXDBtiFKsD59jhk0uCsk2E3oWzsmapJ7wGsfcXMTpJIrSI
        FlD0bgnwW1fTXhj2Csr2KxjYQT0Y
X-Google-Smtp-Source: APXvYqzSYeluQlMf2KQf9cXFblj5W+snp0NtvYkw70eZIKw6b7CZOsgdpHr9VkVaGPJATpKcKS0FUQ==
X-Received: by 2002:a17:902:6bcb:: with SMTP id m11mr17579085plt.318.1559414650116;
        Sat, 01 Jun 2019 11:44:10 -0700 (PDT)
Received: from localhost.localdomain ([117.192.16.207])
        by smtp.googlemail.com with ESMTPSA id w187sm13287950pfw.20.2019.06.01.11.44.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Jun 2019 11:44:09 -0700 (PDT)
From:   Deepak Mishra <linux.dkm@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com, linux.dkm@gmail.com,
        himadri18.07@gmail.com, straube.linux@gmail.com
Subject: [PATCH 3/8] staging: rtl8712: Fixed CamelCase in struct _adapter from drv_types.h
Date:   Sun,  2 Jun 2019 00:13:37 +0530
Message-Id: <8d774dfe7a3e640039464f2bd87d0af148fce53f.1559412149.git.linux.dkm@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1559412149.git.linux.dkm@gmail.com>
References: <cover.1559412149.git.linux.dkm@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes CamelCase cmdThread from struct _adapter and in related
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

