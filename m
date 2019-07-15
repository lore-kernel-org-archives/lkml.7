Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D99C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17ED020868
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563200230;
	bh=zCNqmRsIrfkKLauR/xi8cjfB1cuIG0NmwcE6Nd8GDmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fnjatB///CjPZGPNbTY0h8L1pDpfg/PaLICAnf2ll51+WH1bwqOEZn6+M8cfDQYTF
	 cTtDLdsPHUy+bMwNmuagD7K2qAlHK9kv98n1OmgxaHOlZ8sBqXbi98Ib4m4SYem5Ww
	 +8EPv7/jnorl4sRPD7nN5IrxH8B5W8JDkmO8TSLY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389482AbfGOORJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:17:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:35704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731682AbfGOORG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:17:06 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2B852081C;
        Mon, 15 Jul 2019 14:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563200225;
        bh=zCNqmRsIrfkKLauR/xi8cjfB1cuIG0NmwcE6Nd8GDmI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rc7i6tfelcUBA63sZ7KmOsSzih31JdCtgYcuFTx5D9Ws/1/dkt+p4++8agcwPfiWo
         gVSz8hNDRtABozVA0Fqtv2OqD0NM5+B5+jDweUk9sRY5cDAVN2ntGsDFVM24TCm89j
         YpWSyJHyjq+x7Et9F9ciVYAuJ/EErlNKjp/ZX+IM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 211/219] Bluetooth: hidp: NUL terminate a string in the compat ioctl
Date:   Mon, 15 Jul 2019 10:03:32 -0400
Message-Id: <20190715140341.6443-211-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715140341.6443-1-sashal@kernel.org>
References: <20190715140341.6443-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit dcae9052ebb0c5b2614de620323d615fcbfda7f8 ]

This change is similar to commit a1616a5ac99e ("Bluetooth: hidp: fix
buffer overflow") but for the compat ioctl.  We take a string from the
user and forgot to ensure that it's NUL terminated.

I have also changed the strncpy() in to strscpy() in hidp_setup_hid().
The difference is the strncpy() doesn't necessarily NUL terminate the
destination string.  Either change would fix the problem but it's nice
to take a belt and suspenders approach and do both.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hidp/core.c | 2 +-
 net/bluetooth/hidp/sock.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index a442e21f3894..5abd423b55fa 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -775,7 +775,7 @@ static int hidp_setup_hid(struct hidp_session *session,
 	hid->version = req->version;
 	hid->country = req->country;
 
-	strncpy(hid->name, req->name, sizeof(hid->name));
+	strscpy(hid->name, req->name, sizeof(hid->name));
 
 	snprintf(hid->phys, sizeof(hid->phys), "%pMR",
 		 &l2cap_pi(session->ctrl_sock->sk)->chan->src);
diff --git a/net/bluetooth/hidp/sock.c b/net/bluetooth/hidp/sock.c
index 2151913892ce..03be6a4baef3 100644
--- a/net/bluetooth/hidp/sock.c
+++ b/net/bluetooth/hidp/sock.c
@@ -192,6 +192,7 @@ static int hidp_sock_compat_ioctl(struct socket *sock, unsigned int cmd, unsigne
 		ca.version = ca32.version;
 		ca.flags = ca32.flags;
 		ca.idle_to = ca32.idle_to;
+		ca32.name[sizeof(ca32.name) - 1] = '\0';
 		memcpy(ca.name, ca32.name, 128);
 
 		csock = sockfd_lookup(ca.ctrl_sock, &err);
-- 
2.20.1

