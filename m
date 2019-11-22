Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC767C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB7742071B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574401829;
	bh=KvXmXgsOBUm4pN/y4t22krllwunUSh8WzMwx6xR7Cok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Bn217d+LONjdaCCXPTlMQZQ+RCvrGDGzfaX5y/GfpRYZW9SAdZVJ48XskTRuxxn9t
	 STvUyC/fM0mHh/Wzjb4OcqcuOgAy4kw7X0RBiggG0/ia2JSfQkCzSUf41pIUwuBvi9
	 OTfMJS0BCOROmNGRs426H8WkzNHLA3eWU2KMYBOY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfKVFu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 00:50:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:54924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727672AbfKVFuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:50:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B60DB2070A;
        Fri, 22 Nov 2019 05:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574401824;
        bh=KvXmXgsOBUm4pN/y4t22krllwunUSh8WzMwx6xR7Cok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t1WeQAAKnGDLNRej4TrRZX1G6jafd/Ay+jUUNmwE1zrVz+REDCr1usPME47Poyq/2
         LFFCe0q0oaIJKzpHtoX5ClBjaqP2gWNpffjXvPIEiO3Gwumf+iaajmX2EuMMbDKTVB
         7N+6adoIbH/Px0ojOZHh9OHAMux49SPwUuYH8Lp0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lepton Wu <ytht.net@gmail.com>, Jorgen Hansen <jhansen@vmware.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 067/219] VSOCK: bind to random port for VMADDR_PORT_ANY
Date:   Fri, 22 Nov 2019 00:46:39 -0500
Message-Id: <20191122054911.1750-60-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122054911.1750-1-sashal@kernel.org>
References: <20191122054911.1750-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lepton Wu <ytht.net@gmail.com>

[ Upstream commit 8236b08cf50f85bbfaf48910a0b3ee68318b7c4b ]

The old code always starts from fixed port for VMADDR_PORT_ANY. Sometimes
when VMM crashed, there is still orphaned vsock which is waiting for
close timer, then it could cause connection time out for new started VM
if they are trying to connect to same port with same guest cid since the
new packets could hit that orphaned vsock. We could also fix this by doing
more in vhost_vsock_reset_orphans, but any way, it should be better to start
from a random local port instead of a fixed one.

Signed-off-by: Lepton Wu <ytht.net@gmail.com>
Reviewed-by: Jorgen Hansen <jhansen@vmware.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/vmw_vsock/af_vsock.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index b2724fb06bbbb..62ec9182f234d 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -107,6 +107,7 @@
 #include <linux/mutex.h>
 #include <linux/net.h>
 #include <linux/poll.h>
+#include <linux/random.h>
 #include <linux/skbuff.h>
 #include <linux/smp.h>
 #include <linux/socket.h>
@@ -480,9 +481,13 @@ static void vsock_pending_work(struct work_struct *work)
 static int __vsock_bind_stream(struct vsock_sock *vsk,
 			       struct sockaddr_vm *addr)
 {
-	static u32 port = LAST_RESERVED_PORT + 1;
+	static u32 port = 0;
 	struct sockaddr_vm new_addr;
 
+	if (!port)
+		port = LAST_RESERVED_PORT + 1 +
+			prandom_u32_max(U32_MAX - LAST_RESERVED_PORT);
+
 	vsock_addr_init(&new_addr, addr->svm_cid, addr->svm_port);
 
 	if (addr->svm_port == VMADDR_PORT_ANY) {
-- 
2.20.1

