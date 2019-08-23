Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	DX_TEXT_01,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4344C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A309C233A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="MGSUg4yS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392432AbfHWINy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 04:13:54 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:38168 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390636AbfHWINx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 04:13:53 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id E31043F398;
        Fri, 23 Aug 2019 10:13:49 +0200 (CEST)
Authentication-Results: pio-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b="MGSUg4yS";
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0iLQwW2pmq3U; Fri, 23 Aug 2019 10:13:49 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id A749D3F393;
        Fri, 23 Aug 2019 10:13:48 +0200 (CEST)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id EC9C3360333;
        Fri, 23 Aug 2019 10:13:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1566548028; bh=dXqFbDvsXRKevM7HS4+7LJ8WrBiTmlMAJGuuYMFPIPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MGSUg4ySYAfDhcDYNYmQY4IuuNKSftmFZkx4ZP0q0brh+Up6r3g802I30Bzp01p5/
         Saqy5/ZXbAXqp9AvGnL46jL7UMBiC2PkCQgK1P5z/yccqj3Q9Sr0NVkl+7y3jkJh1R
         uCecZo8XVg42AZ+s87tTgdHWwAgZ+oOgDiShIHGU=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-kernel@vger.kernel.org
Cc:     pv-drivers@vmware.com, linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        dri-devel@lists.freedesktop.org, Doug Covelli <dcovelli@vmware.com>
Subject: [PATCH v2 3/4] drm/vmwgfx: Update the backdoor call with support for new instructions
Date:   Fri, 23 Aug 2019 10:13:15 +0200
Message-Id: <20190823081316.28478-4-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190823081316.28478-1-thomas_os@shipmail.org>
References: <20190823081316.28478-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

Use the definition provided by include/asm/vmware.h

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <x86@kernel.org>
Cc: <dri-devel@lists.freedesktop.org>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Doug Covelli <dcovelli@vmware.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c | 21 +++++++++--------
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.h | 35 +++++++++++++++--------------
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
index 81a86c3b77bc..1281e52898ee 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
@@ -45,8 +45,6 @@
 #define RETRIES                 3
 
 #define VMW_HYPERVISOR_MAGIC    0x564D5868
-#define VMW_HYPERVISOR_PORT     0x5658
-#define VMW_HYPERVISOR_HB_PORT  0x5659
 
 #define VMW_PORT_CMD_MSG        30
 #define VMW_PORT_CMD_HB_MSG     0
@@ -92,7 +90,7 @@ static int vmw_open_channel(struct rpc_channel *channel, unsigned int protocol)
 
 	VMW_PORT(VMW_PORT_CMD_OPEN_CHANNEL,
 		(protocol | GUESTMSG_FLAG_COOKIE), si, di,
-		VMW_HYPERVISOR_PORT,
+		0,
 		VMW_HYPERVISOR_MAGIC,
 		eax, ebx, ecx, edx, si, di);
 
@@ -125,7 +123,7 @@ static int vmw_close_channel(struct rpc_channel *channel)
 
 	VMW_PORT(VMW_PORT_CMD_CLOSE_CHANNEL,
 		0, si, di,
-		(VMW_HYPERVISOR_PORT | (channel->channel_id << 16)),
+		channel->channel_id << 16,
 		VMW_HYPERVISOR_MAGIC,
 		eax, ebx, ecx, edx, si, di);
 
@@ -159,7 +157,8 @@ static unsigned long vmw_port_hb_out(struct rpc_channel *channel,
 		VMW_PORT_HB_OUT(
 			(MESSAGE_STATUS_SUCCESS << 16) | VMW_PORT_CMD_HB_MSG,
 			msg_len, si, di,
-			VMW_HYPERVISOR_HB_PORT | (channel->channel_id << 16),
+			VMWARE_HYPERVISOR_HB | (channel->channel_id << 16) |
+			VMWARE_HYPERVISOR_OUT,
 			VMW_HYPERVISOR_MAGIC, bp,
 			eax, ebx, ecx, edx, si, di);
 
@@ -180,7 +179,7 @@ static unsigned long vmw_port_hb_out(struct rpc_channel *channel,
 
 		VMW_PORT(VMW_PORT_CMD_MSG | (MSG_TYPE_SENDPAYLOAD << 16),
 			 word, si, di,
-			 VMW_HYPERVISOR_PORT | (channel->channel_id << 16),
+			 channel->channel_id << 16,
 			 VMW_HYPERVISOR_MAGIC,
 			 eax, ebx, ecx, edx, si, di);
 	}
@@ -212,7 +211,7 @@ static unsigned long vmw_port_hb_in(struct rpc_channel *channel, char *reply,
 		VMW_PORT_HB_IN(
 			(MESSAGE_STATUS_SUCCESS << 16) | VMW_PORT_CMD_HB_MSG,
 			reply_len, si, di,
-			VMW_HYPERVISOR_HB_PORT | (channel->channel_id << 16),
+			VMWARE_HYPERVISOR_HB | (channel->channel_id << 16),
 			VMW_HYPERVISOR_MAGIC, bp,
 			eax, ebx, ecx, edx, si, di);
 
@@ -229,7 +228,7 @@ static unsigned long vmw_port_hb_in(struct rpc_channel *channel, char *reply,
 
 		VMW_PORT(VMW_PORT_CMD_MSG | (MSG_TYPE_RECVPAYLOAD << 16),
 			 MESSAGE_STATUS_SUCCESS, si, di,
-			 VMW_HYPERVISOR_PORT | (channel->channel_id << 16),
+			 channel->channel_id << 16,
 			 VMW_HYPERVISOR_MAGIC,
 			 eax, ebx, ecx, edx, si, di);
 
@@ -268,7 +267,7 @@ static int vmw_send_msg(struct rpc_channel *channel, const char *msg)
 
 		VMW_PORT(VMW_PORT_CMD_SENDSIZE,
 			msg_len, si, di,
-			VMW_HYPERVISOR_PORT | (channel->channel_id << 16),
+			channel->channel_id << 16,
 			VMW_HYPERVISOR_MAGIC,
 			eax, ebx, ecx, edx, si, di);
 
@@ -326,7 +325,7 @@ static int vmw_recv_msg(struct rpc_channel *channel, void **msg,
 
 		VMW_PORT(VMW_PORT_CMD_RECVSIZE,
 			0, si, di,
-			(VMW_HYPERVISOR_PORT | (channel->channel_id << 16)),
+			channel->channel_id << 16,
 			VMW_HYPERVISOR_MAGIC,
 			eax, ebx, ecx, edx, si, di);
 
@@ -370,7 +369,7 @@ static int vmw_recv_msg(struct rpc_channel *channel, void **msg,
 
 		VMW_PORT(VMW_PORT_CMD_RECVSTATUS,
 			MESSAGE_STATUS_SUCCESS, si, di,
-			(VMW_HYPERVISOR_PORT | (channel->channel_id << 16)),
+			channel->channel_id << 16,
 			VMW_HYPERVISOR_MAGIC,
 			eax, ebx, ecx, edx, si, di);
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.h b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.h
index 4907e50fb20a..f685c7071dec 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.h
@@ -32,6 +32,7 @@
 #ifndef _VMWGFX_MSG_H
 #define _VMWGFX_MSG_H
 
+#include <asm/vmware.h>
 
 /**
  * Hypervisor-specific bi-directional communication channel.  Should never
@@ -44,7 +45,7 @@
  * @in_ebx: [IN] Message Len, through EBX
  * @in_si: [IN] Input argument through SI, set to 0 if not used
  * @in_di: [IN] Input argument through DI, set ot 0 if not used
- * @port_num: [IN] port number + [channel id]
+ * @flags: [IN] hypercall flags + [channel id]
  * @magic: [IN] hypervisor magic value
  * @eax: [OUT] value of EAX register
  * @ebx: [OUT] e.g. status from an HB message status command
@@ -54,10 +55,10 @@
  * @di:  [OUT]
  */
 #define VMW_PORT(cmd, in_ebx, in_si, in_di,	\
-		 port_num, magic,		\
+		 flags, magic,		\
 		 eax, ebx, ecx, edx, si, di)	\
 ({						\
-	asm volatile ("inl %%dx, %%eax;" :	\
+	asm volatile (VMWARE_HYPERCALL :	\
 		"=a"(eax),			\
 		"=b"(ebx),			\
 		"=c"(ecx),			\
@@ -67,7 +68,7 @@
 		"a"(magic),			\
 		"b"(in_ebx),			\
 		"c"(cmd),			\
-		"d"(port_num),			\
+		"d"(flags),			\
 		"S"(in_si),			\
 		"D"(in_di) :			\
 		"memory");			\
@@ -85,7 +86,7 @@
  * @in_ecx: [IN] Message Len, through ECX
  * @in_si: [IN] Input argument through SI, set to 0 if not used
  * @in_di: [IN] Input argument through DI, set to 0 if not used
- * @port_num: [IN] port number + [channel id]
+ * @flags: [IN] hypercall flags + [channel id]
  * @magic: [IN] hypervisor magic value
  * @bp:  [IN]
  * @eax: [OUT] value of EAX register
@@ -98,12 +99,12 @@
 #ifdef __x86_64__
 
 #define VMW_PORT_HB_OUT(cmd, in_ecx, in_si, in_di,	\
-			port_num, magic, bp,		\
+			flags, magic, bp,		\
 			eax, ebx, ecx, edx, si, di)	\
 ({							\
 	asm volatile ("push %%rbp;"			\
 		"mov %12, %%rbp;"			\
-		"rep outsb;"				\
+		VMWARE_HYPERCALL_HB_OUT			\
 		"pop %%rbp;" :				\
 		"=a"(eax),				\
 		"=b"(ebx),				\
@@ -114,7 +115,7 @@
 		"a"(magic),				\
 		"b"(cmd),				\
 		"c"(in_ecx),				\
-		"d"(port_num),				\
+		"d"(flags),				\
 		"S"(in_si),				\
 		"D"(in_di),				\
 		"r"(bp) :				\
@@ -123,12 +124,12 @@
 
 
 #define VMW_PORT_HB_IN(cmd, in_ecx, in_si, in_di,	\
-		       port_num, magic, bp,		\
+		       flags, magic, bp,		\
 		       eax, ebx, ecx, edx, si, di)	\
 ({							\
 	asm volatile ("push %%rbp;"			\
 		"mov %12, %%rbp;"			\
-		"rep insb;"				\
+		VMWARE_HYPERCALL_HB_IN			\
 		"pop %%rbp" :				\
 		"=a"(eax),				\
 		"=b"(ebx),				\
@@ -139,7 +140,7 @@
 		"a"(magic),				\
 		"b"(cmd),				\
 		"c"(in_ecx),				\
-		"d"(port_num),				\
+		"d"(flags),				\
 		"S"(in_si),				\
 		"D"(in_di),				\
 		"r"(bp) :				\
@@ -157,13 +158,13 @@
  * just pushed it.
  */
 #define VMW_PORT_HB_OUT(cmd, in_ecx, in_si, in_di,	\
-			port_num, magic, bp,		\
+			flags, magic, bp,		\
 			eax, ebx, ecx, edx, si, di)	\
 ({							\
 	asm volatile ("push %12;"			\
 		"push %%ebp;"				\
 		"mov 0x04(%%esp), %%ebp;"		\
-		"rep outsb;"				\
+		VMWARE_HYPERCALL_HB_OUT			\
 		"pop %%ebp;"				\
 		"add $0x04, %%esp;" :			\
 		"=a"(eax),				\
@@ -175,7 +176,7 @@
 		"a"(magic),				\
 		"b"(cmd),				\
 		"c"(in_ecx),				\
-		"d"(port_num),				\
+		"d"(flags),				\
 		"S"(in_si),				\
 		"D"(in_di),				\
 		"m"(bp) :				\
@@ -184,13 +185,13 @@
 
 
 #define VMW_PORT_HB_IN(cmd, in_ecx, in_si, in_di,	\
-		       port_num, magic, bp,		\
+		       flags, magic, bp,		\
 		       eax, ebx, ecx, edx, si, di)	\
 ({							\
 	asm volatile ("push %12;"			\
 		"push %%ebp;"				\
 		"mov 0x04(%%esp), %%ebp;"		\
-		"rep insb;"				\
+		VMWARE_HYPERCALL_HB_IN			\
 		"pop %%ebp;"				\
 		"add $0x04, %%esp;" :			\
 		"=a"(eax),				\
@@ -202,7 +203,7 @@
 		"a"(magic),				\
 		"b"(cmd),				\
 		"c"(in_ecx),				\
-		"d"(port_num),				\
+		"d"(flags),				\
 		"S"(in_si),				\
 		"D"(in_di),				\
 		"m"(bp) :				\
-- 
2.20.1

