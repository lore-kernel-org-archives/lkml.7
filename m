Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53032C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 241ED24672
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbfLRUki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:40:38 -0500
Received: from mail-qk1-f171.google.com ([209.85.222.171]:35956 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727751AbfLRUkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:40:21 -0500
Received: by mail-qk1-f171.google.com with SMTP id a203so3110475qkc.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 12:40:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KgXggyBkLko/7fucrNtd/eA0bpwPzuBhzGiPiW5MoEI=;
        b=fRZcoe/wFuK35SimFUYSUJGrm/g3jktPtk/PkAIuJozT6XKgAt6e8NvbR1Qbl6FuUP
         iE7qysnxdi7NgHCUYfReb7OYQ00w4l1iJCFlwDRS/ZZJLhrRhTGPW5FwndP6U4jIN4/e
         jeaneVRW13mVjiH+XfQePygsGJ2OuxnCH9AoXzvhwVez2U2Ul+DDHQBhhllJSAFmH5+Q
         1sPucbveze9hV4Tr3sBTcqTKTwSjU//JY/2IeSTDCbO4IrTZzQkFLSjBg5ENmsgyPReQ
         z3eeVjUt5so2r7F7gA/wYqTmWo6QWNyrBw1IbMDOXVVzG1UL8Cyju27FaPi/fVrSYth2
         W3Vw==
X-Gm-Message-State: APjAAAVLX5+F2Io3CT6Pmg4xTHa/QRjMQYZ/0uG6xpkWUYwPhv3nw2wj
        AuQ3nUo0liapYQZ6KCnd4HpKtSYP
X-Google-Smtp-Source: APXvYqxJjoavg+ryIaepqFDMC5FiMUhrd/5E2y8TBsN86hv45VdwCP9xp2mR+skxbkaJFQ4LWBTb+Q==
X-Received: by 2002:a05:620a:1315:: with SMTP id o21mr4530308qkj.116.1576701620621;
        Wed, 18 Dec 2019 12:40:20 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t7sm993347qkm.136.2019.12.18.12.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 12:40:20 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 21/24] arch/setup: Drop dummy_con initialization
Date:   Wed, 18 Dec 2019 15:39:59 -0500
Message-Id: <20191218204002.30512-22-nivedita@alum.mit.edu>
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

