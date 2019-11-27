Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCD3C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 900192086A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574888641;
	bh=2Wlb3YZLDLsri+AOZgu2/8+1BzXQy5enQQEq+o4T+ec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZFi7cZ1lyXkK+u3SoypJuAbHzZFVUzWXqOSR860PTiHo2lxBp61noNRUoqCe3Uwa+
	 vIwOaXoJBPFeuc/ii8uLaph0kY5VAR3Jm85LvMiuXUjYHL92CdQmNKxxtZMxGTeOZj
	 sRLKvM328sjjvyl4NbGkWqfat3L5s9tP8qq+HIYU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730679AbfK0VEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:04:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:57184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731772AbfK0VDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:03:52 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 133FC215F1;
        Wed, 27 Nov 2019 21:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888631;
        bh=2Wlb3YZLDLsri+AOZgu2/8+1BzXQy5enQQEq+o4T+ec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xd8uVWP3Q3UFtlBoaSA9YXpWCacpDjQ7B4shVD6+JXbVN1uA7AKksD3JcacnZutju
         +c3Gch0qDln1YMZbyM5XXzCbnq7tLWfA92UVoVLyfXCpc9KuZo8HitM4wIpICjiElC
         oReoZ8vGRwl+qj1dmQkTfPpVij1O4+rpfR30x2gA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 209/306] net: bpfilter: fix iptables failure if bpfilter_umh is disabled
Date:   Wed, 27 Nov 2019 21:30:59 +0100
Message-Id: <20191127203130.406914065@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taehee Yoo <ap420073@gmail.com>

[ Upstream commit 97adaddaa6db7a8af81b9b11e30cbe3628cd6700 ]

When iptables command is executed, ip_{set/get}sockopt() try to upload
bpfilter.ko if bpfilter is enabled. if it couldn't find bpfilter.ko,
command is failed.
bpfilter.ko is generated if CONFIG_BPFILTER_UMH is enabled.
ip_{set/get}sockopt() only checks CONFIG_BPFILTER.
So that if CONFIG_BPFILTER is enabled and CONFIG_BPFILTER_UMH is disabled,
iptables command is always failed.

test config:
   CONFIG_BPFILTER=y
   # CONFIG_BPFILTER_UMH is not set

test command:
   %iptables -L
   iptables: No chain/target/match by that name.

Fixes: d2ba09c17a06 ("net: add skeleton of bpfilter kernel module")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/ip_sockglue.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index b7a26120d5521..82f341e84faec 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1244,7 +1244,7 @@ int ip_setsockopt(struct sock *sk, int level,
 		return -ENOPROTOOPT;
 
 	err = do_ip_setsockopt(sk, level, optname, optval, optlen);
-#ifdef CONFIG_BPFILTER
+#if IS_ENABLED(CONFIG_BPFILTER_UMH)
 	if (optname >= BPFILTER_IPT_SO_SET_REPLACE &&
 	    optname < BPFILTER_IPT_SET_MAX)
 		err = bpfilter_ip_set_sockopt(sk, optname, optval, optlen);
@@ -1557,7 +1557,7 @@ int ip_getsockopt(struct sock *sk, int level,
 	int err;
 
 	err = do_ip_getsockopt(sk, level, optname, optval, optlen, 0);
-#ifdef CONFIG_BPFILTER
+#if IS_ENABLED(CONFIG_BPFILTER_UMH)
 	if (optname >= BPFILTER_IPT_SO_GET_INFO &&
 	    optname < BPFILTER_IPT_GET_MAX)
 		err = bpfilter_ip_get_sockopt(sk, optname, optval, optlen);
@@ -1594,7 +1594,7 @@ int compat_ip_getsockopt(struct sock *sk, int level, int optname,
 	err = do_ip_getsockopt(sk, level, optname, optval, optlen,
 		MSG_CMSG_COMPAT);
 
-#ifdef CONFIG_BPFILTER
+#if IS_ENABLED(CONFIG_BPFILTER_UMH)
 	if (optname >= BPFILTER_IPT_SO_GET_INFO &&
 	    optname < BPFILTER_IPT_GET_MAX)
 		err = bpfilter_ip_get_sockopt(sk, optname, optval, optlen);
-- 
2.20.1



