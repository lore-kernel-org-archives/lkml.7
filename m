Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAC7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E512192D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254279;
	bh=POs0ZajvyHmeZti11i8IWX7NMSSII6DBlYdn/BzcfN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FrvFViMOyNt03Z0lrtD4Jtf0Mde2pkd73l99C2H9cgP8ADJhMswom+gadUB+J1J/b
	 GbMB9ba8S0mhM6y7hgsQD5rqPr1uWSRfO5V6V10ZSesLn58yZ7t0zEL2Pgt7maaZyL
	 3XrteE08NR1y/V1U5uCPO2bF+ArBY/REeL9kPKgw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbfCVLbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:31:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:59374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729212AbfCVLbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:31:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3198920449;
        Fri, 22 Mar 2019 11:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254274;
        bh=POs0ZajvyHmeZti11i8IWX7NMSSII6DBlYdn/BzcfN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TeYmJNzYX3L4VJ/oy6Oo0M86/KXKqIHsX58NZZMhI+2blFKHrG3nH7NfkiLBYsWMV
         vAzwRl60HYMX/MM5Zv8vmCWInBfTyjFQ6i4/n3+7yOYCLHLRxdJ7kgtmArHEo/q7U/
         U0IMYFqciYIgNfpMuO2TgqVKS9Ord4FtKmMM6jWg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 067/230] net: nfc: Fix NULL dereference on nfc_llcp_build_tlv fails
Date:   Fri, 22 Mar 2019 12:13:25 +0100
Message-Id: <20190322111241.373503603@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 58bdd544e2933a21a51eecf17c3f5f94038261b5 ]

KASAN report this:

BUG: KASAN: null-ptr-deref in nfc_llcp_build_gb+0x37f/0x540 [nfc]
Read of size 3 at addr 0000000000000000 by task syz-executor.0/5401

CPU: 0 PID: 5401 Comm: syz-executor.0 Not tainted 5.0.0-rc7+ #45
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xfa/0x1ce lib/dump_stack.c:113
 kasan_report+0x171/0x18d mm/kasan/report.c:321
 memcpy+0x1f/0x50 mm/kasan/common.c:130
 nfc_llcp_build_gb+0x37f/0x540 [nfc]
 nfc_llcp_register_device+0x6eb/0xb50 [nfc]
 nfc_register_device+0x50/0x1d0 [nfc]
 nfcsim_device_new+0x394/0x67d [nfcsim]
 ? 0xffffffffc1080000
 nfcsim_init+0x6b/0x1000 [nfcsim]
 do_one_initcall+0xfa/0x5ca init/main.c:887
 do_init_module+0x204/0x5f6 kernel/module.c:3460
 load_module+0x66b2/0x8570 kernel/module.c:3808
 __do_sys_finit_module+0x238/0x2a0 kernel/module.c:3902
 do_syscall_64+0x147/0x600 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x462e99
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9cb79dcc58 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 000000000073bf00 RCX: 0000000000462e99
RDX: 0000000000000000 RSI: 0000000020000280 RDI: 0000000000000003
RBP: 00007f9cb79dcc70 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f9cb79dd6bc
R13: 00000000004bcefb R14: 00000000006f7030 R15: 0000000000000004

nfc_llcp_build_tlv will return NULL on fails, caller should check it,
otherwise will trigger a NULL dereference.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: eda21f16a5ed ("NFC: Set MIU and RW values from CONNECT and CC LLCP frames")
Fixes: d646960f7986 ("NFC: Initial LLCP support")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/nfc/llcp_commands.c |   20 ++++++++++++++++++++
 net/nfc/llcp_core.c     |   24 ++++++++++++++++++++----
 2 files changed, 40 insertions(+), 4 deletions(-)

--- a/net/nfc/llcp_commands.c
+++ b/net/nfc/llcp_commands.c
@@ -419,6 +419,10 @@ int nfc_llcp_send_connect(struct nfc_llc
 						      sock->service_name,
 						      sock->service_name_len,
 						      &service_name_tlv_length);
+		if (!service_name_tlv) {
+			err = -ENOMEM;
+			goto error_tlv;
+		}
 		size += service_name_tlv_length;
 	}
 
@@ -429,9 +433,17 @@ int nfc_llcp_send_connect(struct nfc_llc
 
 	miux_tlv = nfc_llcp_build_tlv(LLCP_TLV_MIUX, (u8 *)&miux, 0,
 				      &miux_tlv_length);
+	if (!miux_tlv) {
+		err = -ENOMEM;
+		goto error_tlv;
+	}
 	size += miux_tlv_length;
 
 	rw_tlv = nfc_llcp_build_tlv(LLCP_TLV_RW, &rw, 0, &rw_tlv_length);
+	if (!rw_tlv) {
+		err = -ENOMEM;
+		goto error_tlv;
+	}
 	size += rw_tlv_length;
 
 	pr_debug("SKB size %d SN length %zu\n", size, sock->service_name_len);
@@ -486,9 +498,17 @@ int nfc_llcp_send_cc(struct nfc_llcp_soc
 
 	miux_tlv = nfc_llcp_build_tlv(LLCP_TLV_MIUX, (u8 *)&miux, 0,
 				      &miux_tlv_length);
+	if (!miux_tlv) {
+		err = -ENOMEM;
+		goto error_tlv;
+	}
 	size += miux_tlv_length;
 
 	rw_tlv = nfc_llcp_build_tlv(LLCP_TLV_RW, &rw, 0, &rw_tlv_length);
+	if (!rw_tlv) {
+		err = -ENOMEM;
+		goto error_tlv;
+	}
 	size += rw_tlv_length;
 
 	skb = llcp_allocate_pdu(sock, LLCP_PDU_CC, size);
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -532,10 +532,10 @@ static u8 nfc_llcp_reserve_sdp_ssap(stru
 
 static int nfc_llcp_build_gb(struct nfc_llcp_local *local)
 {
-	u8 *gb_cur, *version_tlv, version, version_length;
-	u8 *lto_tlv, lto_length;
-	u8 *wks_tlv, wks_length;
-	u8 *miux_tlv, miux_length;
+	u8 *gb_cur, version, version_length;
+	u8 lto_length, wks_length, miux_length;
+	u8 *version_tlv = NULL, *lto_tlv = NULL,
+	   *wks_tlv = NULL, *miux_tlv = NULL;
 	__be16 wks = cpu_to_be16(local->local_wks);
 	u8 gb_len = 0;
 	int ret = 0;
@@ -543,17 +543,33 @@ static int nfc_llcp_build_gb(struct nfc_
 	version = LLCP_VERSION_11;
 	version_tlv = nfc_llcp_build_tlv(LLCP_TLV_VERSION, &version,
 					 1, &version_length);
+	if (!version_tlv) {
+		ret = -ENOMEM;
+		goto out;
+	}
 	gb_len += version_length;
 
 	lto_tlv = nfc_llcp_build_tlv(LLCP_TLV_LTO, &local->lto, 1, &lto_length);
+	if (!lto_tlv) {
+		ret = -ENOMEM;
+		goto out;
+	}
 	gb_len += lto_length;
 
 	pr_debug("Local wks 0x%lx\n", local->local_wks);
 	wks_tlv = nfc_llcp_build_tlv(LLCP_TLV_WKS, (u8 *)&wks, 2, &wks_length);
+	if (!wks_tlv) {
+		ret = -ENOMEM;
+		goto out;
+	}
 	gb_len += wks_length;
 
 	miux_tlv = nfc_llcp_build_tlv(LLCP_TLV_MIUX, (u8 *)&local->miux, 0,
 				      &miux_length);
+	if (!miux_tlv) {
+		ret = -ENOMEM;
+		goto out;
+	}
 	gb_len += miux_length;
 
 	gb_len += ARRAY_SIZE(llcp_magic);


