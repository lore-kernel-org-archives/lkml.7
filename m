Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E81C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 998F020873
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329742;
	bh=ebZ2JQFsRBywP2cfhViDCO5K5tyo5Vy6F15psqCltzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tv44ZgXu8YrUBSXD0e9oVIegAzSHdbVwvXdsrN0iGCF29UAcKf+zHOaFqSZSwTGS8
	 UPuS/HA/NOvcomYEx+3bRY6UrOiyxnYPm7FMZdWNlByIWKrXLmN1OafFoYiLWV7HUU
	 D/JiquCEla3XvgyHBGO35BA2QEfuhb3sBcrbla6Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbfD0BtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:49:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:46296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727981AbfD0BmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:42:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0642E208CB;
        Sat, 27 Apr 2019 01:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329331;
        bh=ebZ2JQFsRBywP2cfhViDCO5K5tyo5Vy6F15psqCltzw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T5N3UUjDN8oGFEBlZSMmMSaJmTmntCuUj0mRLOLc0pBx4RlmOJkyBAb7TRWPB7Fo7
         Bud1toKm1n+18LqpCMM8+vAliTRavX6RdDinsu76Sd1iDJg7vSRmPLGy2Q8AGSr101
         z1Ic0yMh6yt9YjDzqcZ1GngKXjlGqXGPX8nvYKHs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>, linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 48/53] NFS: Forbid setting AF_INET6 to "struct sockaddr_in"->sin_family.
Date:   Fri, 26 Apr 2019 21:40:45 -0400
Message-Id: <20190427014051.7522-48-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427014051.7522-1-sashal@kernel.org>
References: <20190427014051.7522-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

[ Upstream commit 7c2bd9a39845bfb6d72ddb55ce737650271f6f96 ]

syzbot is reporting uninitialized value at rpc_sockaddr2uaddr() [1]. This
is because syzbot is setting AF_INET6 to "struct sockaddr_in"->sin_family
(which is embedded into user-visible "struct nfs_mount_data" structure)
despite nfs23_validate_mount_data() cannot pass sizeof(struct sockaddr_in6)
bytes of AF_INET6 address to rpc_sockaddr2uaddr().

Since "struct nfs_mount_data" structure is user-visible, we can't change
"struct nfs_mount_data" to use "struct sockaddr_storage". Therefore,
assuming that everybody is using AF_INET family when passing address via
"struct nfs_mount_data"->addr, reject if its sin_family is not AF_INET.

[1] https://syzkaller.appspot.com/bug?id=599993614e7cbbf66bc2656a919ab2a95fb5d75c

Reported-by: syzbot <syzbot+047a11c361b872896a4f@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 6b666d187907..6df9b85caf20 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -2052,7 +2052,8 @@ static int nfs23_validate_mount_data(void *options,
 		memcpy(sap, &data->addr, sizeof(data->addr));
 		args->nfs_server.addrlen = sizeof(data->addr);
 		args->nfs_server.port = ntohs(data->addr.sin_port);
-		if (!nfs_verify_server_address(sap))
+		if (sap->sa_family != AF_INET ||
+		    !nfs_verify_server_address(sap))
 			goto out_no_address;
 
 		if (!(data->flags & NFS_MOUNT_TCP))
-- 
2.19.1

