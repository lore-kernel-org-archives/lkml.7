Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E01C3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 14:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A8320B7C
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 14:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="POPU5TJC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfHROnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 10:43:14 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:46174 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbfHROnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 10:43:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 695903F5D7;
        Sun, 18 Aug 2019 16:33:51 +0200 (CEST)
Authentication-Results: pio-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=POPU5TJC;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nIgg4y8S9GTK; Sun, 18 Aug 2019 16:33:50 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 2D5F13F3E6;
        Sun, 18 Aug 2019 16:33:49 +0200 (CEST)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id B95F9360309;
        Sun, 18 Aug 2019 16:33:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1566138829; bh=6OlyDR2AfpPPLg+YUceohHTjeWPkzYwbA+F3tv8l/y4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=POPU5TJCOR3fA0Yx0eBmng4l2dxdEzqjvEiYiBCxfHgBW6a6ycY0mwmOAbi6QSh3f
         VvxJd+T4KdMjXa0HaZVBRXIzGpm51Bp7otHLY6vALrUDV+Oz6wDancFor72XpxRizS
         tBiZsXNQBPiXn2ZLJ3eWoPegfWGi9wkmYJXKxZZ0=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-kernel@vger.kernel.org, pv-drivers@vmware.com
Cc:     Thomas Hellstrom <thellstrom@vmware.com>,
        Doug Covelli <dcovelli@vmware.com>
Subject: [PATCH 3/4] drm/vmwgfx: Update the backdoor call with support for new instructions
Date:   Sun, 18 Aug 2019 16:33:15 +0200
Message-Id: <20190818143316.4906-4-thomas_os@shipmail.org>
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

Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Doug Covelli <dcovelli@vmware.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.h b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.h
index 4907e50fb20a..7fc3ff63b1a8 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.h
@@ -32,6 +32,7 @@
 #ifndef _VMWGFX_MSG_H
 #define _VMWGFX_MSG_H
 
+#include <asm/vmware.h>
 
 /**
  * Hypervisor-specific bi-directional communication channel.  Should never
@@ -57,7 +58,7 @@
 		 port_num, magic,		\
 		 eax, ebx, ecx, edx, si, di)	\
 ({						\
-	asm volatile ("inl %%dx, %%eax;" :	\
+	asm volatile (VMWARE_HYPERCALL :	\
 		"=a"(eax),			\
 		"=b"(ebx),			\
 		"=c"(ecx),			\
-- 
2.20.1

