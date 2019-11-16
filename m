Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAF3C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 911302089D
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573920634;
	bh=7Zb84RMymvrQrGc5whayYZnaI5yyN4gn14MocjTCebU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=njEAZAQC3BjDWKbYZiS4NVYU0TsFFP8Z/AA8yz3fK3pqG7ccm+lnmqsJyahQgAuhr
	 FLhLhvKHxOsr6uyi/o8VaYU+xQwnf1G1FzDhG2cv5Bs4FtS9ASLbD0EeOv1FpDkHqw
	 nDiYTURAhQDoZcSNqI52K20pjf5rOAQo/IPrCSuI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731719AbfKPQKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 11:10:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:56270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730216AbfKPPsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:48:54 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B9E820870;
        Sat, 16 Nov 2019 15:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919333;
        bh=7Zb84RMymvrQrGc5whayYZnaI5yyN4gn14MocjTCebU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v5dj0KByEFMWNhJSN+UUBBoQJtCk3BPNHlm6MOKOhmRFynYN5KEKaiBvFwHBNUkdA
         FS81n79opGvHwYe2k1meWOuidvf9RNjhppKn8QYSEWb9ToOY6mZ8InX4sMDzU/PIYf
         hqyLD0U1HQLv7S2kXCfZz77+DpTqW4stDG+mi+6I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Taehee Yoo <ap420073@gmail.com>, Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 075/150] bpf: devmap: fix wrong interface selection in notifier_call
Date:   Sat, 16 Nov 2019 10:46:13 -0500
Message-Id: <20191116154729.9573-75-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154729.9573-1-sashal@kernel.org>
References: <20191116154729.9573-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taehee Yoo <ap420073@gmail.com>

[ Upstream commit f592f804831f1cf9d1f9966f58c80f150e6829b5 ]

The dev_map_notification() removes interface in devmap if
unregistering interface's ifindex is same.
But only checking ifindex is not enough because other netns can have
same ifindex. so that wrong interface selection could occurred.
Hence netdev pointer comparison code is added.

v2: compare netdev pointer instead of using net_eq() (Daniel Borkmann)
v1: Initial patch

Fixes: 2ddf71e23cc2 ("net: add notifier hooks for devmap bpf map")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/devmap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 482bf42e21a41..1060eee6c8d5f 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -388,8 +388,7 @@ static int dev_map_notification(struct notifier_block *notifier,
 				struct bpf_dtab_netdev *dev, *odev;
 
 				dev = READ_ONCE(dtab->netdev_map[i]);
-				if (!dev ||
-				    dev->dev->ifindex != netdev->ifindex)
+				if (!dev || netdev != dev->dev)
 					continue;
 				odev = cmpxchg(&dtab->netdev_map[i], dev, NULL);
 				if (dev == odev)
-- 
2.20.1

