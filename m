Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E37C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 18:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E212084F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 18:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbfCASju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 13:39:50 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:40733 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfCASju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 13:39:50 -0500
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1gzn4U-0007U3-DS; Fri, 01 Mar 2019 18:39:46 +0000
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92-RC6)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1gzn4T-0001di-MV; Fri, 01 Mar 2019 18:39:45 +0000
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@lists.codethink.co.uk,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] net: fixup address-space warnings in compat_mc_{get,set}sockopt()
Date:   Fri,  1 Mar 2019 18:39:44 +0000
Message-Id: <20190301183944.6260-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add __user attributes in some of the casts in this function to avoid
the following sparse warnings:

net/compat.c:592:57: warning: cast removes address space of expression
net/compat.c:592:57: warning: incorrect type in initializer (different address spaces)
net/compat.c:592:57:    expected struct compat_group_req [noderef] <asn:1>*gr32
net/compat.c:592:57:    got void *<noident>
net/compat.c:613:65: warning: cast removes address space of expression
net/compat.c:613:65: warning: incorrect type in initializer (different address spaces)
net/compat.c:613:65:    expected struct compat_group_source_req [noderef] <asn:1>*gsr32
net/compat.c:613:65:    got void *<noident>
net/compat.c:634:60: warning: cast removes address space of expression
net/compat.c:634:60: warning: incorrect type in initializer (different address spaces)
net/compat.c:634:60:    expected struct compat_group_filter [noderef] <asn:1>*gf32
net/compat.c:634:60:    got void *<noident>
net/compat.c:672:52: warning: cast removes address space of expression
net/compat.c:672:52: warning: incorrect type in initializer (different address spaces)
net/compat.c:672:52:    expected struct compat_group_filter [noderef] <asn:1>*gf32
net/compat.c:672:52:    got void *<noident>

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 net/compat.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/compat.c b/net/compat.c
index 3d348198004f..8c8c57d814af 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -589,7 +589,7 @@ int compat_mc_setsockopt(struct sock *sock, int level, int optname,
 	case MCAST_JOIN_GROUP:
 	case MCAST_LEAVE_GROUP:
 	{
-		struct compat_group_req __user *gr32 = (void *)optval;
+		struct compat_group_req __user *gr32 = (void __user *)optval;
 		struct group_req __user *kgr =
 			compat_alloc_user_space(sizeof(struct group_req));
 		u32 interface;
@@ -610,7 +610,7 @@ int compat_mc_setsockopt(struct sock *sock, int level, int optname,
 	case MCAST_BLOCK_SOURCE:
 	case MCAST_UNBLOCK_SOURCE:
 	{
-		struct compat_group_source_req __user *gsr32 = (void *)optval;
+		struct compat_group_source_req __user *gsr32 = (void __user *)optval;
 		struct group_source_req __user *kgsr = compat_alloc_user_space(
 			sizeof(struct group_source_req));
 		u32 interface;
@@ -631,7 +631,7 @@ int compat_mc_setsockopt(struct sock *sock, int level, int optname,
 	}
 	case MCAST_MSFILTER:
 	{
-		struct compat_group_filter __user *gf32 = (void *)optval;
+		struct compat_group_filter __user *gf32 = (void __user *)optval;
 		struct group_filter __user *kgf;
 		u32 interface, fmode, numsrc;
 
@@ -669,7 +669,7 @@ int compat_mc_getsockopt(struct sock *sock, int level, int optname,
 	char __user *optval, int __user *optlen,
 	int (*getsockopt)(struct sock *, int, int, char __user *, int __user *))
 {
-	struct compat_group_filter __user *gf32 = (void *)optval;
+	struct compat_group_filter __user *gf32 = (void __user *)optval;
 	struct group_filter __user *kgf;
 	int __user	*koptlen;
 	u32 interface, fmode, numsrc;
-- 
2.20.1

