Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC5CC43215
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6992920733
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573918958;
	bh=kAqtKWCDZXsE9YhDOOmXD4HFJ72pPiA6mcNcJzI0bfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QSt+xTYENsewYyE27daXsPZqnGMmpSBAV2B4S1zwB0GIgryIv1bQqWVKFoF8UAI1G
	 JcYGtwVTZnvP7bUAOsWuVg7gzvBJSJGZ9p/bKZLyZ7RlNVxyaGniAJF7OtxRCndoh4
	 pZt24Yh8TiGpn637Lb+ugnKqAH7N/0dyU7XMVsA8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbfKPPmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:42:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:46034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728250AbfKPPm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:42:27 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC40420855;
        Sat, 16 Nov 2019 15:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573918946;
        bh=kAqtKWCDZXsE9YhDOOmXD4HFJ72pPiA6mcNcJzI0bfs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qCZgFQ+XKbEMYZHrNdoAFqrrMi5cFtFN7KdOz5TmckBXIpAQxi8pYoqizCrGxe7Ja
         phBFGNOCQFFsJdkqR/qU4JUC3aaxGrLA39EvB7V0KrSRmZ8ax3DLe6q6jI06u3Xwar
         ECqh6QRCmLLQFBr7zIgU9Nu2ZXntf6OkzItKvSaw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kyeongdon Kim <kyeongdon.kim@lge.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 067/237] net: fix warning in af_unix
Date:   Sat, 16 Nov 2019 10:38:22 -0500
Message-Id: <20191116154113.7417-67-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154113.7417-1-sashal@kernel.org>
References: <20191116154113.7417-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kyeongdon Kim <kyeongdon.kim@lge.com>

[ Upstream commit 33c4368ee2589c165aebd8d388cbd91e9adb9688 ]

This fixes the "'hash' may be used uninitialized in this function"

net/unix/af_unix.c:1041:20: warning: 'hash' may be used uninitialized in this function [-Wmaybe-uninitialized]
  addr->hash = hash ^ sk->sk_type;

Signed-off-by: Kyeongdon Kim <kyeongdon.kim@lge.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/unix/af_unix.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 231b6c032d2c3..d2d6ff0c6265d 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -225,6 +225,8 @@ static inline void unix_release_addr(struct unix_address *addr)
 
 static int unix_mkname(struct sockaddr_un *sunaddr, int len, unsigned int *hashp)
 {
+	*hashp = 0;
+
 	if (len <= sizeof(short) || len > sizeof(*sunaddr))
 		return -EINVAL;
 	if (!sunaddr || sunaddr->sun_family != AF_UNIX)
-- 
2.20.1

