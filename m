Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78451C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F3A3204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552902325;
	bh=RE2TTe+ki30jktSvsh7vggaJ2pvVVu1pzsfa6BPAJpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f5JgBAYONLS11IjuZ9SuwEO0I8+bx81b0s2WzvPWtLYRWYSRextrqy8aeRwvTMwRd
	 AS9wClkLL5YL5wcBvJYvA2acauA4bBBdcYM1c5lK3fyYbA1a1ecNPtUwoWARvN5E0n
	 9wiFNjkjU26Ji/EtXHzQpDkZ3iguUp9NQ8an8M7o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfCRJaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:30:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727093AbfCRJaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:30:04 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CACC2083D;
        Mon, 18 Mar 2019 09:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901403;
        bh=RE2TTe+ki30jktSvsh7vggaJ2pvVVu1pzsfa6BPAJpI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IVgCl1SwvmWh6ArFprgFNakB7bxPwTnuFkl67JOzuAlQrssEkUV63EAqLYPIoc/Gu
         ptOBit6hFtFwnk1ZWj/4Oo3PElOmJhA3Qgy8n1ljG50b0/6y1Fqt2NNbv/exuvdOlX
         /A3wl59HBAhEUAcYJOaUHV4QBpOTQrW7H42myINI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 34/52] ipv6: route: enforce RCU protection in rt6_update_exception_stamp_rt()
Date:   Mon, 18 Mar 2019 10:25:21 +0100
Message-Id: <20190318083847.372147753@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318083843.398913295@linuxfoundation.org>
References: <20190318083843.398913295@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1608,15 +1608,15 @@ static int rt6_remove_exception_rt(struc
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
@@ -1635,6 +1635,7 @@ static void rt6_update_exception_stamp_r
 	if (rt6_ex)
 		rt6_ex->stamp = jiffies;
 
+unlock:
 	rcu_read_unlock();
 }
 


