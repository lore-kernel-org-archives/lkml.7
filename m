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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C43C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A63ED218DE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lABTPVwU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391219AbfIIOpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 10:45:54 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35262 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388058AbfIIOpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 10:45:53 -0400
Received: by mail-pg1-f195.google.com with SMTP id n4so7978513pgv.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 07:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X27PgNjzyIRHhIAJ8fJ6aLdKaxI7wNnavXRhLpvodTc=;
        b=lABTPVwUEM/jSLH0LclUBSo6/DiKeOgE9kR0PjYwD5c07lAOpPGwa4wiuA4i3tuRBk
         HLzsC4DaXs4SbJoIZ+XaRKvyru3JI54AwOKf+ZhtCH3BNcBydJzPKtaVl7zo9dwvlTUy
         L7NOHIslucv+u2g9cfP7SFT/lHBYN2ypvmItyV6ni2DrV9o20BVvXqxTL6WcZ61pTVK+
         It85mVkDC4skRqXT59d87rOQM3iy17rzBpu4BWHA8tOvdW7ZJI08Bje/Zyr3LAR7LHfa
         DJPF6+hS9L++PqPPn4uNWILlymzHv2C1UAiYOAMstMGjNadmZnzC2wJESGP83lgufnKB
         hITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X27PgNjzyIRHhIAJ8fJ6aLdKaxI7wNnavXRhLpvodTc=;
        b=Ff/ld/MWRdU+jisvW7R9oyEfM23Ndun1H3BRh04nmyZ+e1AMTfsK7GedebrX4Hqtwi
         xyh1bgpMkw0B7xWLn25Tj83+RiRsNtYvPDWwdct/ejw+G4Cw00zCNPC3TND8mw8RKkQK
         62iagULXy0QI0jopj0nOWSXeBGFT6oU835VbBT+SdT6cyiDlyy6cr/MjQ1aPGz+R41Gs
         kNRVk3jPeUGA5etvrMg4Y8i2+zS8rzKhii5aM0C5vqDmU0IDHSFHL7JEN3bHZTPklq2C
         s8bHdHM0u9KeWhO5mRsiXagUODOwd37H9LIN+8rshQ4fB670WmEPe2vlFbk7DUjH8waP
         PjBQ==
X-Gm-Message-State: APjAAAVnMn+aUaTomP98yBh6C+DVXuFf6ZWUJYq9XzBTQirAOurMutXk
        cPu5vgL2z7rVRj1Kc1vU/z4=
X-Google-Smtp-Source: APXvYqzMP3YClxdtCzxJyWIB9dX1Z1YX9wv+5VNF8vueQgXKay0Wp13gJHT0kD/8s70m9eZ4rzmmWw==
X-Received: by 2002:a63:2264:: with SMTP id t36mr21117473pgm.87.1568040352240;
        Mon, 09 Sep 2019 07:45:52 -0700 (PDT)
Received: from localhost.localdomain ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id t9sm15334693pgj.89.2019.09.09.07.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 07:45:51 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v3 9/9] hacking: Move DEBUG_FS to 'Generic Kernel Debugging Instruments'
Date:   Mon,  9 Sep 2019 22:44:53 +0800
Message-Id: <20190909144453.3520-10-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190909144453.3520-1-changbin.du@gmail.com>
References: <20190909144453.3520-1-changbin.du@gmail.com>
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

