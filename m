Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0DCC4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22BCD206CD
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrvL8TG+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731891AbfIIOS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 10:18:58 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40017 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731355AbfIIOS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 10:18:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id x127so9247052pfb.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 07:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZjQZhq0VIl7AW/Jucj8979nUOERXvLfdaUdgqq8/W+c=;
        b=jrvL8TG+Hsqq23bsoEmVtN1+bborTEPNq29Taq/GJel3RuiI/nQOY6ZkQMlaHKzkbt
         OwvKZdeeN6PlfgT8cBwBPHztjkEjUq7PNZSUGNG5PNDuK0qDq+LyW96o0rlsUl0Xn5US
         Ax39hNB+alEogx41nSc54sQ3XerKcXGTFFNrebIOyC2YRH7hlsA4T7ki/wW2EKT/enmG
         2T180VWn8V/etctpF6asezB/nEjQSL4sFgC9x46+eP7V9vZ3hCFYYylAgGRbJN0NctCG
         Km9zHlrK9w9uO9eywomgIw+gMK7iBc6KIDZCFo9S/vAK5pMjLrKBhCbq9TBmq08c96xt
         C9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZjQZhq0VIl7AW/Jucj8979nUOERXvLfdaUdgqq8/W+c=;
        b=PKLklkL2/54eTcOSsA4YGP8r7ncn4COlAYCWPGwnmhZDpnp80aNOF2dOfOQ+0Xm7hr
         THK8pRjRNmu7Hh2FEs+Vf8n+uvHfGuiU1c9WbOZebZp5XHFnDG+LS/a38CeIFoUU68by
         4tGdm3mlUHKGyqqHA6qfDnzaBUR4lcfGXsTzUneDwDZpWCMyC0PFOlpl6M2zmO52Drt6
         Qnt8reLnPdTfKm/InpoJATOC2K0YP2Zz+hnYJJafxEaqdq3axtj83YZvikRyed+82bOE
         +rZN3JIITpLdzfJ+TyypKkxlo2EEGNSk+TU++9aIdJhw9r1RLtJbOfO9bNRL1IMlbYcK
         KCkw==
X-Gm-Message-State: APjAAAVyFs1lFcNp6mDOymTTAnqEqGKP/1grBzxraTOS1rEAYIKI9XCG
        iUPPRkwZMjHKM4y1BjLammM=
X-Google-Smtp-Source: APXvYqzwgQxRIlQ7HyWuaEUIW2Ii2lvRni8Af2vaL3sDZwFH2VoEtuf3zNAI5xaPBj4ITCWKqY5vxA==
X-Received: by 2002:a62:1658:: with SMTP id 85mr28179645pfw.195.1568038736288;
        Mon, 09 Sep 2019 07:18:56 -0700 (PDT)
Received: from localhost.localdomain ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id w6sm34574695pfw.84.2019.09.09.07.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 07:18:55 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 3/9] kconfig/hacking: Group kernel data structures debugging together
Date:   Mon,  9 Sep 2019 22:18:17 +0800
Message-Id: <20190909141823.8638-4-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190909141823.8638-1-changbin.du@gmail.com>
References: <20190909141823.8638-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Group these similar runtime data structures verification options together.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 lib/Kconfig.debug | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index cc4d8e71ae81..92271898b029 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1375,6 +1375,8 @@ config DEBUG_BUGVERBOSE
 	  of the BUG call as well as the EIP and oops trace.  This aids
 	  debugging but costs about 70-100K of memory.
 
+menu "Debug kernel data structures"
+
 config DEBUG_LIST
 	bool "Debug linked list manipulation"
 	depends on DEBUG_KERNEL || BUG_ON_DATA_CORRUPTION
@@ -1414,6 +1416,18 @@ config DEBUG_NOTIFIERS
 	  This is a relatively cheap check but if you care about maximum
 	  performance, say N.
 
+config BUG_ON_DATA_CORRUPTION
+	bool "Trigger a BUG when data corruption is detected"
+	select DEBUG_LIST
+	help
+	  Select this option if the kernel should BUG when it encounters
+	  data corruption in kernel memory structures when they get checked
+	  for validity.
+
+	  If unsure, say N.
+
+endmenu
+
 config DEBUG_CREDENTIALS
 	bool "Debug credential management"
 	depends on DEBUG_KERNEL
@@ -2107,16 +2121,6 @@ config MEMTEST
 	        memtest=17, mean do 17 test patterns.
 	  If you are unsure how to answer this question, answer N.
 
-config BUG_ON_DATA_CORRUPTION
-	bool "Trigger a BUG when data corruption is detected"
-	select DEBUG_LIST
-	help
-	  Select this option if the kernel should BUG when it encounters
-	  data corruption in kernel memory structures when they get checked
-	  for validity.
-
-	  If unsure, say N.
-
 source "samples/Kconfig"
 
 config ARCH_HAS_DEVMEM_IS_ALLOWED
-- 
2.20.1

