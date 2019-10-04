Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF16C32792
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 01:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC5E2133F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 01:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HICZc7Xc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732097AbfJDBUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 21:20:32 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50704 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731802AbfJDBUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 21:20:31 -0400
Received: by mail-wm1-f65.google.com with SMTP id 5so3959041wmg.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 18:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YXyavoKgvf6Zgzf9UFUGtAunNoGgQxULYxae2YpF/kw=;
        b=HICZc7XctazMnAUd4paJzmShGCce7ggWUswDBudC8lUhsm/L4Nod57XaP9s23Ad4G+
         mnbJGG3nkWF/0y4nMzEpWN6RxEPN8BEZrt+ylI/gEv+HYfjorE05IfA8n40rGCTa8A7T
         md4JVYdEt4LqrrxkdO2U5s16ZZQVEg1Zy0SixPSiqTdkF3GmnX7rTf7rXe4859gVAY24
         damPYwcic9cGNQz4+tRuovMKbrkJZjNQ529QX1W87tlSMjCP8btP6EfCNcHFDaC6psmP
         A1zgHlaOgeG1MzM0mo2DR431raoUSL7X3ewDiahgpJnrBJI71czI0cupZAV2lAC6Hag/
         mXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YXyavoKgvf6Zgzf9UFUGtAunNoGgQxULYxae2YpF/kw=;
        b=WZ4t9QXRTimGSIN6LjqeMHvKQUbRMpk9dUnuqeNJkX99ckiHntWpH185foUVvq9yst
         2yelivbUsbCfW2HSmDUnmvkSrpP6b93X54djaGQGXhYsoQBw+C1IKHi1+zQSZ9tnN+fh
         Ylj5kpwNXqxJCJP7lsOdVpW9D38suQsfiuN/rOaeRJeowPTu+LIwjutpKKs/9rt/+kAs
         xIw3pUDYOiKQdRHPUmfL8KjitUlOKUyUZS3VmFZ/r0vMXaI+JjzUKrJwAJRmOLhifaXq
         hY5ffIjly+mjw4ZNBnK+5vI+4OIu3j3mh3ECZfcGLyaR69Q7OrT1WrTFzAp6ycoN9diV
         RSqA==
X-Gm-Message-State: APjAAAUcA92pjL9sEopQl8dGE3fwDtB4/+GxSxO13Y5PPjY8FqaAsN+a
        89j/V/kHCUvkkJmBn8wval4=
X-Google-Smtp-Source: APXvYqxeKrjkI6LPkW9rhTxj4hEvybqZXksvvrtuTV8jSHnzYAP+jwpdfTpxMmHZ+jU23knrAydOkA==
X-Received: by 2002:a1c:3281:: with SMTP id y123mr8494127wmy.118.1570152029383;
        Thu, 03 Oct 2019 18:20:29 -0700 (PDT)
Received: from localhost.localdomain ([104.238.174.53])
        by smtp.gmail.com with ESMTPSA id a4sm4097404wmm.10.2019.10.03.18.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 18:20:28 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [RESEND PATCH v3 1/9] hacking: Group sysrq/kgdb/ubsan into 'Generic Kernel Debugging Instruments'
Date:   Fri,  4 Oct 2019 09:20:02 +0800
Message-Id: <20191004012010.11287-2-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191004012010.11287-1-changbin.du@gmail.com>
References: <20191004012010.11287-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Group generic kernel debugging instruments sysrq/kgdb/ubsan together into
a new submenu.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
---
 lib/Kconfig.debug | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index a0250e53954a..157db30e626d 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -401,6 +401,8 @@ config DEBUG_FORCE_WEAK_PER_CPU
 
 endmenu # "Compiler options"
 
+menu "Generic Kernel Debugging Instruments"
+
 config MAGIC_SYSRQ
 	bool "Magic SysRq key"
 	depends on !UML
@@ -434,6 +436,12 @@ config MAGIC_SYSRQ_SERIAL
 	  This option allows you to decide whether you want to enable the
 	  magic SysRq key.
 
+source "lib/Kconfig.kgdb"
+
+source "lib/Kconfig.ubsan"
+
+endmenu
+
 config DEBUG_KERNEL
 	bool "Kernel debugging"
 	help
@@ -2095,10 +2103,6 @@ config BUG_ON_DATA_CORRUPTION
 
 source "samples/Kconfig"
 
-source "lib/Kconfig.kgdb"
-
-source "lib/Kconfig.ubsan"
-
 config ARCH_HAS_DEVMEM_IS_ALLOWED
 	bool
 
-- 
2.20.1

