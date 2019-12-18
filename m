Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0A8C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A912A2465E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfLRVp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 16:45:28 -0500
Received: from mail-qt1-f170.google.com ([209.85.160.170]:34029 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbfLRVpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 16:45:25 -0500
Received: by mail-qt1-f170.google.com with SMTP id 5so3222909qtz.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 13:45:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KgXggyBkLko/7fucrNtd/eA0bpwPzuBhzGiPiW5MoEI=;
        b=jKiliinfOtCj5bpt1GUcZghTWrkH0UInoNQagEC2TfIJTXVxeWaU1UkYho1EeACnnn
         2KU/rlq0L2bc3yHVwm6aiLYTt9LusItbmdxgOmqv8xzyrbmt48hTn3wjRRG0wtIWvgUg
         0JFANUHFx+0jCVJZFaRAN24sxakLzwUlZx7JDMAkXm53WzLrwb8cxj5x7l1g4i9X+TBT
         EXZBCqbb+5xp2r9eL1LmRyg4JX7NhxM5fTAO2nXO8xdhAsrn9edPThKxt9UFTgmMadQK
         0StfhxghghGFIByYKwy/xLdBt89B28Om6zxphjKdEIT2cjJAtR42xKjwGV//nIT1W9Yc
         8nGg==
X-Gm-Message-State: APjAAAVwkB1SXrVU7AlAl9YJBwlqXt1DB8P6AiTe43LonYe2F6nzabr3
        JzAIqoaKSmCPtel2yNRGoPE=
X-Google-Smtp-Source: APXvYqy6wLofP2dUo1+No7parVCNDg4VrfCVmbkY5VmaWgcpefgtWXdpj4VuWLR0FQysetJowrHqYg==
X-Received: by 2002:ac8:64a:: with SMTP id e10mr4208634qth.292.1576705524903;
        Wed, 18 Dec 2019 13:45:24 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id u4sm1059851qkh.59.2019.12.18.13.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 13:45:24 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 21/24] arch/sparc/setup: Drop dummy_con initialization
Date:   Wed, 18 Dec 2019 16:45:03 -0500
Message-Id: <20191218214506.49252-22-nivedita@alum.mit.edu>
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
 arch/sparc/kernel/setup_32.c | 4 ----
 arch/sparc/kernel/setup_64.c | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index afe1592a6d08..5d1bcfce05d8 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -332,10 +332,6 @@ void __init setup_arch(char **cmdline_p)
 		break;
 	}
 
-#ifdef CONFIG_DUMMY_CONSOLE
-	conswitchp = &dummy_con;
-#endif
-
 	idprom_init();
 	load_mmu();
 
diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index fd2182a5c32d..75e3992203b6 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -653,10 +653,6 @@ void __init setup_arch(char **cmdline_p)
 	else
 		pr_info("ARCH: SUN4U\n");
 
-#ifdef CONFIG_DUMMY_CONSOLE
-	conswitchp = &dummy_con;
-#endif
-
 	idprom_init();
 
 	if (!root_flags)
-- 
2.24.1

