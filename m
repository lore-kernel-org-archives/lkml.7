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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD35C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA382196E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uw2BTOtX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731738AbfIIOTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 10:19:30 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36222 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732116AbfIIOT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 10:19:27 -0400
Received: by mail-pl1-f194.google.com with SMTP id f19so6588479plr.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 07:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X27PgNjzyIRHhIAJ8fJ6aLdKaxI7wNnavXRhLpvodTc=;
        b=uw2BTOtX1T/Xiu5fLNrjU8jHpig/2qpVlaoX3FEnVCrnTimrD3GBMz59gSvQksgJV4
         1yz3GatWJiaHT4KqZp9GjcZfJr8KLGhYZnPxVYJfFkPDD6w1x+aCQrVQL0XJJpqwMTf5
         O/ey8lUXrCH85V/Vy/1spELvOcSJg3lQormA5CWDSnXglglqMXLcYHuecIejHpqGGlYY
         FOEqoSKGsQRpzhTSmzulpWwENmumsYPOETzvx6JF373oNWrGzE3YMzosvKdozhA8LYLG
         ENE+cJbjQaoNlqgEYgehZT6QfpVQsUxignMbG7OCHVgeXIdLsH2iFD4Tg+WqxfhCYa2D
         QCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X27PgNjzyIRHhIAJ8fJ6aLdKaxI7wNnavXRhLpvodTc=;
        b=hfoKACTMMviXV8HohIpSWzqmQhro9igo68FhNjim0dO9RiQ/FAL1LvKApU+6d0TMYt
         ycwrBO6ec4ewhWzrX1Gx04Gzjw+1JwOtYWGTrBGKMxJgg6GwD7LuL+5xHktu7GQDVGCW
         oFzy4JPohzibl4i/KI3FiEn3Y4cjNfANtzYOcD5C+ghkQY+kUTigqOTlwltt5D1n4Gzo
         EVEHVECYuAnWD2Fl9g9dz3xj+fFE6QFkGmWIz1JrjsV/beEIRIrEinPLVllFrZvhY7i5
         p40l+tQpjXWBO/HYcjH9S4q4omuQZ2ZGVkHQ0zGl/ftQ5UlwtcGoMQKQ3vcujm5RMhCX
         sTDg==
X-Gm-Message-State: APjAAAUnQavznRcM9+id3Rn1iuC785lzrro6010kBZuER2O/9hvGKfaQ
        5BGn4diho6IfrTX7oqX3qKQ=
X-Google-Smtp-Source: APXvYqwY39rL2ZGxwhejTW+zx/bYXbE93xb8Lzg6Z1u0Cxe4DtP0RK8xErHu7CCDOmSO1B9GYRpjuA==
X-Received: by 2002:a17:902:142:: with SMTP id 60mr24585857plb.155.1568038766549;
        Mon, 09 Sep 2019 07:19:26 -0700 (PDT)
Received: from localhost.localdomain ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id w6sm34574695pfw.84.2019.09.09.07.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 07:19:26 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 9/9] kconfig/hacking: Move DEBUG_FS to 'Generic Kernel Debugging Instruments'
Date:   Mon,  9 Sep 2019 22:18:23 +0800
Message-Id: <20190909141823.8638-10-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190909141823.8638-1-changbin.du@gmail.com>
References: <20190909141823.8638-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DEBUG_FS does not belong to 'Compile-time checks and compiler options'.

Cc: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 lib/Kconfig.debug | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ceefe0c1e78b..09e82676e59c 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -302,18 +302,6 @@ config UNUSED_SYMBOLS
 	  you really need it, and what the merge plan to the mainline kernel for
 	  your module is.
 
-config DEBUG_FS
-	bool "Debug Filesystem"
-	help
-	  debugfs is a virtual file system that kernel developers use to put
-	  debugging files into.  Enable this option to be able to read and
-	  write to these files.
-
-	  For detailed documentation on the debugfs API, see
-	  Documentation/filesystems/.
-
-	  If unsure, say N.
-
 config HEADERS_INSTALL
 	bool "Install uapi headers to usr/include"
 	depends on !UML
@@ -463,6 +451,18 @@ config MAGIC_SYSRQ_SERIAL
 	  This option allows you to decide whether you want to enable the
 	  magic SysRq key.
 
+config DEBUG_FS
+	bool "Debug Filesystem"
+	help
+	  debugfs is a virtual file system that kernel developers use to put
+	  debugging files into.  Enable this option to be able to read and
+	  write to these files.
+
+	  For detailed documentation on the debugfs API, see
+	  Documentation/filesystems/.
+
+	  If unsure, say N.
+
 source "lib/Kconfig.kgdb"
 
 source "lib/Kconfig.ubsan"
-- 
2.20.1

