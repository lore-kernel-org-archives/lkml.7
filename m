Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D05C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4732B2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552902164;
	bh=yk7xUdqeH99YrZqC6L8/q5GhNvSRayH5+0aTZym/fCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AN3U9EjVwc9A3LfhKzbt0oyNLjIAJh6uSD355cTjgStHrEfv7DMDKshKBh6Q1GYKO
	 cQz3b1VXDRQ92WhvfCylbQRJ3SE3qFzBIPv6LO29XUMWP3ZAlNVvxEopoF4atBJKzY
	 mv5od4BHZw7NA+v/CQ4SGq44U2m94DeuffuUmNH4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfCRJmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:42:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:40842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728769AbfCRJcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:32:46 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC198214AF;
        Mon, 18 Mar 2019 09:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901565;
        bh=yk7xUdqeH99YrZqC6L8/q5GhNvSRayH5+0aTZym/fCI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WIkShkTuJ9hF+DV/Rbwj1oo6typ9NI8lnJv6M6JuUk9F/0AX2ulGhglw5yM8mG6eg
         4nr9y8CZsFNinGZPEn6JgAbfQTo8UW9QDvW24I+M/Bq6XNC3KkLtQrk/OIsHxiCPE2
         eC/azIirQg1uQgu5KFPtUlAAKx7hihHyGwKWWJ5I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 31/52] ipv6: route: enforce RCU protection in rt6_update_exception_stamp_rt()
Date:   Mon, 18 Mar 2019 10:25:28 +0100
Message-Id: <20190318084017.211496750@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318084013.532280682@linuxfoundation.org>
References: <20190318084013.532280682@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 193f3685d0546b0cea20c99894aadb70098e47bf ]

We must access rt6_info->from under RCU read lock: move the
dereference under such lock, with proper annotation.

v1 -> v2:
 - avoid using multiple, racy, fetch operations for rt->from

Fixes: a68886a69180 ("net/ipv6: Make from in rt6_info rcu protected")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/route.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -1623,15 +1623,15 @@ static int rt6_remove_exception_rt(struc
 static void rt6_update_exception_stamp_rt(struct rt6_info *rt)
 {
 	struct rt6_exception_bucket *bucket;
-	struct fib6_info *from = rt->from;
 	struct in6_addr *src_key = NULL;
 	struct rt6_exception *rt6_ex;
-
-	if (!from ||
-	    !(rt->rt6i_flags & RTF_CACHE))
-		return;
+	struct fib6_info *from;
 
 	rcu_read_lock();
+	from = rcu_dereference(rt->from);
+	if (!from || !(rt->rt6i_flags & RTF_CACHE))
+		goto unlock;
+
 	bucket = rcu_dereference(from->rt6i_exception_bucket);
 
 #ifdef CONFIG_IPV6_SUBTREES
@@ -1650,6 +1650,7 @@ static void rt6_update_exception_stamp_r
 	if (rt6_ex)
 		rt6_ex->stamp = jiffies;
 
+unlock:
 	rcu_read_unlock();
 }
 


