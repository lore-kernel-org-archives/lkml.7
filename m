Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83553C4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 01:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B18621744
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 01:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idqshwqd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393233AbfIHB2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 21:28:37 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45737 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfIHB2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 21:28:33 -0400
Received: by mail-pf1-f195.google.com with SMTP id y72so6887948pfb.12
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2019 18:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mg3rD7UYoQohcNlJDhvas+f5gcb8SahIBcKJEgl17NA=;
        b=idqshwqdoBLOeLVNPz9c5arwrGAf6HFGQkcV7H0h/m185HR5I2kwaEGTeIWoJKzeOX
         X4Y9eZL6j5AIDaa2hFKMmWuSo4xWwO/B0w/DlS3QD2w8dews+oejGU9qK2d1QSWeIy8P
         PW/Wo8OzbBDyH7Ha4miD86HHpw8HeTI1N25VfR7joDYwIPCJhr4sRPpGoRsxCxUEiFPC
         YuLuNQU8Jc5kIdNE7iex4A8iRMVZayvpf/137nOep5NcRApqf6dy2HJUBS0neOFFG2PT
         rzZ5rtnqCUqhikApoPqLar9eHIYoE6iFX0AoSf1MF25aV1BdSHVs4HPzHVaziBT+OmGo
         TqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mg3rD7UYoQohcNlJDhvas+f5gcb8SahIBcKJEgl17NA=;
        b=fBIRFwr5FryxXW7JeBZLgunoC7w7CEecI+ZCkTr8cAdpoAdeQqvp6ZIqj8mjS510n8
         kRv5PKW/lzPHiNJJOEwi0IsrBtPwA/w+fjxr/U6dvEX8RgUUrt/NvSMVKJKqV/gTe0ne
         SwPsiGlmCWM6VPqC2JyzAMAH/gfXNFcTwo6xTvmQtPJvZmCp+RzDPZe+2yrK9Fpl1cdM
         0gEB9z4aOnX8ZZjkEULv3w00GHnFgQ78ItpbC8BL/l0Q+TSAjOOYHIWtC3R+IldinmyQ
         T852ozbbRor4jpMCWhkL0GPBfLPXoh4LZI8cVxi8LI4rvYMUoRYeiaQd+xUTlwzKu73o
         cO+A==
X-Gm-Message-State: APjAAAU7HBXYFKHULYmVmvpwBmruo6aKQpXWbHavipdsesChgRnfxv+w
        1dWVii84r2ZQ3+jZy3NdlMjJIi0cGDo=
X-Google-Smtp-Source: APXvYqwiao79zpcoqVrF0PAKbwXBaUkV1yAiPaEbCaovZ1A/R8Y4wI4pfDpATG5o9MAIoXTmDxYDlw==
X-Received: by 2002:a17:90b:34a:: with SMTP id fh10mr9799400pjb.35.1567906112283;
        Sat, 07 Sep 2019 18:28:32 -0700 (PDT)
Received: from localhost.localdomain ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id s1sm18367884pjs.31.2019.09.07.18.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 18:28:31 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 3/8] kconfig/hacking: Group kernel data structures debugging together
Date:   Sun,  8 Sep 2019 09:27:55 +0800
Message-Id: <20190908012800.12979-4-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190908012800.12979-1-changbin.du@gmail.com>
References: <20190908012800.12979-1-changbin.du@gmail.com>
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
index 96047140be93..3c9674483ec2 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1374,6 +1374,8 @@ config DEBUG_BUGVERBOSE
 	  of the BUG call as well as the EIP and oops trace.  This aids
 	  debugging but costs about 70-100K of memory.
 
+menu "Debug kernel data structures"
+
 config DEBUG_LIST
 	bool "Debug linked list manipulation"
 	depends on DEBUG_KERNEL || BUG_ON_DATA_CORRUPTION
@@ -1403,6 +1405,18 @@ config DEBUG_SG
 
 	  If unsure, say N.
 
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
 config DEBUG_NOTIFIERS
 	bool "Debug notifier call chains"
 	depends on DEBUG_KERNEL
@@ -2095,16 +2109,6 @@ config MEMTEST
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

