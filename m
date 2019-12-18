Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176C2C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4CA821D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfLRVqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 16:46:15 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46390 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfLRVpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 16:45:16 -0500
Received: by mail-qt1-f194.google.com with SMTP id 38so3174533qtb.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 13:45:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a3CngsofCLiiBus+wS+2g2HZdYbmV2oX+9kndN4OJ+g=;
        b=XVSyL2s0cRcNi598s6/xh1v4JjHfoaMgpKcUwckhTHdayDLsWEP1EKNb57MBbIUyHn
         GHVbyf4OILoTrlnSx28SDkES62MxFV+biCfV8o3VWkvmOVK1xTQGCfmJmKC/inE0nVMf
         O9h/Veub608/VHRrV3Rp4SGLJ43qmby0xewEkmPZpKigGOW1gMbsEsgPWFIuZFc/FCmz
         C+2gYQb5hGA9RSM3dlknS4Rc7RILPl2pfxv/dW2Y3mQew3+xg3Ts/w/rMGSFO+/eX8G+
         gxcQEmZTkncohGmZSY+6ioc0YCNkk/Ghsrb/Hp4JoWw8qBqtt7kn+obLYQUo0mFbfT3f
         W8YQ==
X-Gm-Message-State: APjAAAXoRv8ykIgjsSAVlOVnbolP6EhKZyr54FlmHev6UIK+wT3x5pw/
        l3ITQwJWze2lPG7HQ4uogtyOSgLZ
X-Google-Smtp-Source: APXvYqxrWCd1ojPRsHYTrmEasHOjoiX7H814GM8kgLrrOb5Ai6KTdaiwm89CP7f1vOPf1gk/YeRUVg==
X-Received: by 2002:ac8:5159:: with SMTP id h25mr4320844qtn.249.1576705515737;
        Wed, 18 Dec 2019 13:45:15 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id u4sm1059851qkh.59.2019.12.18.13.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 13:45:15 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/24] arch/m68k/setup: Drop dummy_con initialization
Date:   Wed, 18 Dec 2019 16:44:52 -0500
Message-Id: <20191218214506.49252-11-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218214506.49252-1-nivedita@alum.mit.edu>
References: <20191218211231.GA918900@kroah.com>
 <20191218214506.49252-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

con_init in tty/vt.c will now set conswitchp to dummy_con if it's unset.
Drop it from arch setup code.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/m68k/kernel/setup_mm.c | 4 ----
 arch/m68k/kernel/setup_no.c | 4 ----
 arch/m68k/sun3x/config.c    | 1 -
 3 files changed, 9 deletions(-)

diff --git a/arch/m68k/kernel/setup_mm.c b/arch/m68k/kernel/setup_mm.c
index 528484feff80..ab8aa7be260f 100644
--- a/arch/m68k/kernel/setup_mm.c
+++ b/arch/m68k/kernel/setup_mm.c
@@ -274,10 +274,6 @@ void __init setup_arch(char **cmdline_p)
 
 	parse_early_param();
 
-#ifdef CONFIG_DUMMY_CONSOLE
-	conswitchp = &dummy_con;
-#endif
-
 	switch (m68k_machtype) {
 #ifdef CONFIG_AMIGA
 	case MACH_AMIGA:
diff --git a/arch/m68k/kernel/setup_no.c b/arch/m68k/kernel/setup_no.c
index 3c5def10d486..a63483de7a42 100644
--- a/arch/m68k/kernel/setup_no.c
+++ b/arch/m68k/kernel/setup_no.c
@@ -146,10 +146,6 @@ void __init setup_arch(char **cmdline_p)
 	memcpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
 	boot_command_line[COMMAND_LINE_SIZE-1] = 0;
 
-#if defined(CONFIG_FRAMEBUFFER_CONSOLE) && defined(CONFIG_DUMMY_CONSOLE)
-	conswitchp = &dummy_con;
-#endif
-
 	/*
 	 * Give all the memory to the bootmap allocator, tell it to put the
 	 * boot mem_map at the start of memory.
diff --git a/arch/m68k/sun3x/config.c b/arch/m68k/sun3x/config.c
index 03ce7f9facfe..d806dee71a9c 100644
--- a/arch/m68k/sun3x/config.c
+++ b/arch/m68k/sun3x/config.c
@@ -70,7 +70,6 @@ void __init config_sun3x(void)
 		break;
 	default:
 		serial_console = 0;
-		conswitchp = &dummy_con;
 		break;
 	}
 #endif
-- 
2.24.1

