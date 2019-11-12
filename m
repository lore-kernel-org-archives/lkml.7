Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0130DC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 22:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA24A2196E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 22:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSEHMQ21"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfKLWpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 17:45:20 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46669 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbfKLWpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 17:45:19 -0500
Received: by mail-lj1-f194.google.com with SMTP id e9so237819ljp.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 14:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dlzc9ZW2QK+Bf04vZsdeB35W1UEikvkDQZdvHiTdHiw=;
        b=fSEHMQ2152EQPx9pY74DdNe3R/DLJhrZrzSt/FcS5QA0aJOwx5p1V2R4kQhGRZ7r+o
         wru3mBbU5BmpXiTjx42QZ9jghV+5sNbfS8baupjOQZ6n25v64Xoo2M+tyzmIPFxZ1dcv
         UGJNRwL+fDOYGUdcvBSiagvT9vYup23aTtnzkcy1uV6qlNrZKUah99IvMOSzx2JAnJWm
         FLW27/ZAa4pjhlb/vIHR+jrqWUrBSTaXbdJUSf2BZK/hYOYf86gPFhVD2EBFVr1JX4nJ
         wzhlzta7m/H0u6+hiZeqBUTnD3aBROdtxrhjL4+mEhpOOUzKvs53XjslZxR/Ns29QnHJ
         QG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dlzc9ZW2QK+Bf04vZsdeB35W1UEikvkDQZdvHiTdHiw=;
        b=TNVM3+mbxD8oK/7mptQKlof3TlC0+rKQSXn/YyDxDfUSNz6qRw8dUwWMn0XHcQ4f0N
         dZ7cLe7dQVy+Z/sW9YeCD3awBDrmx263M3RludLa2FJmIOffyrmTgSGmqrnfn2+sMTyR
         gVvkY/yhWfijtg41gsVzfk19U7Wp71/eUFYT4JYyvo9BNLKXZMVsNQOO2C6LZ/Cyg9hM
         Z++AkipwPDZCw+4A0eQZmm7O9YTUps4U4ikiOrIShC7Ckl+SacW8Mxr04j7z6UCakmKJ
         dyWDjl+ZK4TEv3RphrB1j+5bH1shpzb8jKaPjbz58S+Taj3K4mmDzxHjxXTSaFNcUBXX
         UKlw==
X-Gm-Message-State: APjAAAXTPzqQzZtRh0tMywolvvgJJd//O9Px6e5e0T5V9W7JVGKWAAjy
        bu4Y2Z0v7F0zqxgLsN2V/L4=
X-Google-Smtp-Source: APXvYqyKR8f+A1blypWPTt6vPOpdDDjtrTZpb+CWB3Fb3V0DJ5Jo0xdGXqfKLevZ7X/JP0euhNYAuQ==
X-Received: by 2002:a05:651c:1117:: with SMTP id d23mr139959ljo.90.1573598717383;
        Tue, 12 Nov 2019 14:45:17 -0800 (PST)
Received: from octofox.cadence.com (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
        by smtp.gmail.com with ESMTPSA id x16sm38677ljd.69.2019.11.12.14.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 14:45:16 -0800 (PST)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Dmitry Safonov <dima@arista.com>,
        Petr Mladek <pmladek@suse.com>, Joe Perches <joe@perches.com>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v3 2/2] xtensa: make stack dump size configurable
Date:   Tue, 12 Nov 2019 14:44:43 -0800
Message-Id: <20191112224443.12267-3-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191112224443.12267-1-jcmvbkbc@gmail.com>
References: <20191112224443.12267-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce Kconfig symbol PRINT_STACK_DEPTH and use it to initialize
kstack_depth_to_print.

Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v2->v3:
- split Kconfig change into separate patch

 arch/xtensa/Kconfig.debug  | 7 +++++++
 arch/xtensa/kernel/traps.c | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/xtensa/Kconfig.debug b/arch/xtensa/Kconfig.debug
index 39de98e20018..83cc8d12fa0e 100644
--- a/arch/xtensa/Kconfig.debug
+++ b/arch/xtensa/Kconfig.debug
@@ -31,3 +31,10 @@ config S32C1I_SELFTEST
 	  It is easy to make wrong hardware configuration, this test should catch it early.
 
 	  Say 'N' on stable hardware.
+
+config PRINT_STACK_DEPTH
+	int "Stack depth to print" if DEBUG_KERNEL
+	default 64
+	help
+	  This option allows you to set the stack depth that the kernel
+	  prints in stack traces.
diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index be26ec6c0e0e..87bd68dd7687 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -495,7 +495,7 @@ void show_trace(struct task_struct *task, unsigned long *sp)
 
 #define STACK_DUMP_ENTRY_SIZE 4
 #define STACK_DUMP_LINE_SIZE 32
-static size_t kstack_depth_to_print = 24;
+static size_t kstack_depth_to_print = CONFIG_PRINT_STACK_DEPTH;
 
 void show_stack(struct task_struct *task, unsigned long *sp)
 {
-- 
2.20.1

