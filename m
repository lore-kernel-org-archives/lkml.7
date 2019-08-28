Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56224C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 08:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE1222DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 08:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="rox5sQfK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfH1IEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 04:04:21 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:35714 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfH1IEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 04:04:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id A6C693F4AF;
        Wed, 28 Aug 2019 10:04:18 +0200 (CEST)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=rox5sQfK;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xTg1Ga307zmO; Wed, 28 Aug 2019 10:04:17 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 0C5B33F623;
        Wed, 28 Aug 2019 10:04:17 +0200 (CEST)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id C9CDA36118B;
        Wed, 28 Aug 2019 10:04:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1566979456; bh=MyZfORI1Xf0KtJaMhhnImwZ8Mwln+ZkdwP8hUtSS3nc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rox5sQfKnouVMkR44u1J6Ph6A7CFwlr/BpLaoINFJDXIPDqKYCfc/d2mURMAp6IqC
         /O7YCvq+0ciftK/FcEg/XEB6GinI0OWjTCViLaghSjgj8v/838DuOJDEZZKSU5qTwC
         adJHx6YEmlNrR8QktR+3F+40S8QWQLteeYK2KYE8=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-kernel@vger.kernel.org
Cc:     pv-drivers@vmware.com, linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Doug Covelli <dcovelli@vmware.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v3 4/4] input/vmmouse: Update the backdoor call with support for new instructions
Date:   Wed, 28 Aug 2019 10:03:53 +0200
Message-Id: <20190828080353.12658-5-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190828080353.12658-1-thomas_os@shipmail.org>
References: <20190828080353.12658-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

Use the definition provided by include/asm/vmware.h

CC: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <x86@kernel.org>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Doug Covelli <dcovelli@vmware.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/vmmouse.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/mouse/vmmouse.c b/drivers/input/mouse/vmmouse.c
index 871e5b5ab129..148245c69be7 100644
--- a/drivers/input/mouse/vmmouse.c
+++ b/drivers/input/mouse/vmmouse.c
@@ -16,12 +16,12 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <asm/hypervisor.h>
+#include <asm/vmware.h>
 
 #include "psmouse.h"
 #include "vmmouse.h"
 
 #define VMMOUSE_PROTO_MAGIC			0x564D5868U
-#define VMMOUSE_PROTO_PORT			0x5658
 
 /*
  * Main commands supported by the vmmouse hypervisor port.
@@ -84,7 +84,7 @@ struct vmmouse_data {
 #define VMMOUSE_CMD(cmd, in1, out1, out2, out3, out4)	\
 ({							\
 	unsigned long __dummy1, __dummy2;		\
-	__asm__ __volatile__ ("inl %%dx" :		\
+	__asm__ __volatile__ (VMWARE_HYPERCALL :	\
 		"=a"(out1),				\
 		"=b"(out2),				\
 		"=c"(out3),				\
@@ -94,7 +94,7 @@ struct vmmouse_data {
 		"a"(VMMOUSE_PROTO_MAGIC),		\
 		"b"(in1),				\
 		"c"(VMMOUSE_PROTO_CMD_##cmd),		\
-		"d"(VMMOUSE_PROTO_PORT) :		\
+		"d"(0) :			        \
 		"memory");		                \
 })
 
-- 
2.20.1

