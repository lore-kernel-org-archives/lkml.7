Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5252C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B36F124672
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfLRUka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:40:30 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44975 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbfLRUkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:40:23 -0500
Received: by mail-qk1-f193.google.com with SMTP id w127so2711632qkb.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 12:40:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j5XzsPTW77IQ+wYXeiRlE/nsYq/nq9N3u2AC5HLtW6I=;
        b=UntsBlxQURJhZYbJxo+rrAOv+enPANyPunPF2f0l+qIhZ++2eX/zIb90VGJYUO2e/b
         RTy+VYN8a+PUnuYeBLheplISMqwr4HK0px6rq9dUpaOMri4Y2zuJ1G/3ISrUeGQVFU98
         TdkDb9UdN4q4iqpNSHEl25YgrK0MJNDoCOk+DxxA8nP7Z5XpuqRwEbYYCGKsZSAptLTM
         44q7Sk8HJjcO14A1HPl4/3Gzq/Tnxh3DhX4Iw7CvpYUbron5szH29KK2xIZLhqF2sIPk
         0+KZWnpBUj5f9v6kAwFiRf02BvP+XoJOYyaVVMMboFf6wq+BTNsdp9/hA2tDxD0xq5/A
         OPxA==
X-Gm-Message-State: APjAAAWuKLCr6BN3mXmQXojq3NjcOgv5d7mym6aIL6+FOqil+hcHOhIp
        zDdTOuaVCkmAFAh2ZfGKGfU=
X-Google-Smtp-Source: APXvYqxtM2f6kJpeME/cRJ5LyuC/Bf1fnDPja9tBr8F0VcYH9J5laxKOzvWmUOINe9th+g76l/gZEg==
X-Received: by 2002:a37:3ce:: with SMTP id 197mr4780679qkd.454.1576701622414;
        Wed, 18 Dec 2019 12:40:22 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t7sm993347qkm.136.2019.12.18.12.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 12:40:21 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 23/24] arch/setup: Drop dummy_con initialization
Date:   Wed, 18 Dec 2019 15:40:01 -0500
Message-Id: <20191218204002.30512-24-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218204002.30512-1-nivedita@alum.mit.edu>
References: <20191218204002.30512-1-nivedita@alum.mit.edu>
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
 arch/x86/kernel/setup.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index cedfe2077a69..8ad29fa05d00 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1295,8 +1295,6 @@ void __init setup_arch(char **cmdline_p)
 #if defined(CONFIG_VGA_CONSOLE)
 	if (!efi_enabled(EFI_BOOT) || (efi_mem_type(0xa0000) != EFI_CONVENTIONAL_MEMORY))
 		conswitchp = &vga_con;
-#elif defined(CONFIG_DUMMY_CONSOLE)
-	conswitchp = &dummy_con;
 #endif
 #endif
 	x86_init.oem.banner();
-- 
2.24.1

