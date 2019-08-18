Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3EEC3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 14:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 935DC20B7C
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 14:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="enzcM+ef"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfHROkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 10:40:33 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:31357 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfHROkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 10:40:32 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 65F313F7C7;
        Sun, 18 Aug 2019 16:33:51 +0200 (CEST)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=enzcM+ef;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id omKhVBcd1px2; Sun, 18 Aug 2019 16:33:50 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 1CBE73F704;
        Sun, 18 Aug 2019 16:33:50 +0200 (CEST)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id D3484360331;
        Sun, 18 Aug 2019 16:33:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1566138829; bh=wX7r4rQL9PmCx95uRebSs4gE+H5at0oCTJcfkHLE2LE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=enzcM+ef6Ik+/tcp1k4+oUlEjxoHjaMCwiad0JKs8n/sXKHxD/nIC1xwZgaicsy2Q
         FF3VE/oryj4Wz85l5m9g1B2zluiHsJl4PzxFrOzzv4AWWIKZRx2U25sURLlEBwQn2T
         bkaranfY5Kwe1K240TQEQTIrDR+ZmonXzY6ErrKA=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-kernel@vger.kernel.org, pv-drivers@vmware.com
Cc:     Thomas Hellstrom <thellstrom@vmware.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Doug Covelli <dcovelli@vmware.com>
Subject: [PATCH 4/4] input/vmmouse: Update the backdoor call with support for new instructions
Date:   Sun, 18 Aug 2019 16:33:16 +0200
Message-Id: <20190818143316.4906-5-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190818143316.4906-1-thomas_os@shipmail.org>
References: <20190818143316.4906-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

Use the definition provided by include/asm/vmware.h

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: <linux-input@vger.kernel.org>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Doug Covelli <dcovelli@vmware.com>
---
 drivers/input/mouse/vmmouse.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/vmmouse.c b/drivers/input/mouse/vmmouse.c
index 871e5b5ab129..0c7707c7bede 100644
--- a/drivers/input/mouse/vmmouse.c
+++ b/drivers/input/mouse/vmmouse.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <asm/hypervisor.h>
+#include <asm/vmware.h>
 
 #include "psmouse.h"
 #include "vmmouse.h"
@@ -84,7 +85,7 @@ struct vmmouse_data {
 #define VMMOUSE_CMD(cmd, in1, out1, out2, out3, out4)	\
 ({							\
 	unsigned long __dummy1, __dummy2;		\
-	__asm__ __volatile__ ("inl %%dx" :		\
+	__asm__ __volatile__ (VMWARE_HYPERCALL :	\
 		"=a"(out1),				\
 		"=b"(out2),				\
 		"=c"(out3),				\
-- 
2.20.1

