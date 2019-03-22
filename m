Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9933EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660042190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553253695;
	bh=3Sgdnf3koeXeTMaPS3J74eXibG0SHxcWUNDSWmsQVkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0gOP2GjtBOGBbLlphglghoTOJuA15S4vQVhOCnKGTJhuFsk0x4PMl68nppAPkshNF
	 PK2fZ9CJRhbwHHUhWsBBmw543SkvUqgoGJwmc090QY88H1S2Ey7yyW0rYOm6/njYeE
	 Sye0lJPl5PxxNPFnMmXBbqUI0XGlkB+u5ipAAQgM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbfCVLVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:21:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:48044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728605AbfCVLVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:21:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C88F1218D4;
        Fri, 22 Mar 2019 11:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553253691;
        bh=3Sgdnf3koeXeTMaPS3J74eXibG0SHxcWUNDSWmsQVkE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ki17kg3FxDhdL9rz3mg4q4CbtEXuySJ8XAybN1QduiReGTbCSyZq9v0W1kOqKF8HH
         YnmQ2IWJHu9g9fM02g0/RnQdw+zsrcoPuKFcaBVSJSD+nBZrwHfZBa3f2WcQnGpDi4
         sHPdaYH1NYs51yhZLacbUGxw15JG73uKDHuKOe7U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ronen Arad <ronen.arad@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mark Salyzyn <salyzyn@android.com>
Subject: [PATCH 3.18 024/134] netlink: Trim skb to alloc size to avoid MSG_TRUNC
Date:   Fri, 22 Mar 2019 12:13:57 +0100
Message-Id: <20190322111211.573883178@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111210.465931067@linuxfoundation.org>
References: <20190322111210.465931067@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arad, Ronen <ronen.arad@intel.com>

commit db65a3aaf29ecce2e34271d52e8d2336b97bd9fe upstream.

netlink_dump() allocates skb based on the calculated min_dump_alloc or
a per socket max_recvmsg_len.
min_alloc_size is maximum space required for any single netdev
attributes as calculated by rtnl_calcit().
max_recvmsg_len tracks the user provided buffer to netlink_recvmsg.
It is capped at 16KiB.
The intention is to avoid small allocations and to minimize the number
of calls required to obtain dump information for all net devices.

netlink_dump packs as many small messages as could fit within an skb
that was sized for the largest single netdev information. The actual
space available within an skb is larger than what is requested. It could
be much larger and up to near 2x with align to next power of 2 approach.

Allowing netlink_dump to use all the space available within the
allocated skb increases the buffer size a user has to provide to avoid
truncaion (i.e. MSG_TRUNG flag set).

It was observed that with many VLANs configured on at least one netdev,
a larger buffer of near 64KiB was necessary to avoid "Message truncated"
error in "ip link" or "bridge [-c[ompressvlans]] vlan show" when
min_alloc_size was only little over 32KiB.

This patch trims skb to allocated size in order to allow the user to
avoid truncation with more reasonable buffer size.

Signed-off-by: Ronen Arad <ronen.arad@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Mark Salyzyn <salyzyn@android.com>

---
 net/netlink/af_netlink.c |   34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1977,6 +1977,7 @@ static int netlink_dump(struct sock *sk)
 	struct nlmsghdr *nlh;
 	struct module *module;
 	int err = -ENOBUFS;
+	int alloc_min_size;
 	int alloc_size;
 
 	mutex_lock(nlk->cb_mutex);
@@ -1985,9 +1986,6 @@ static int netlink_dump(struct sock *sk)
 		goto errout_skb;
 	}
 
-	cb = &nlk->cb;
-	alloc_size = max_t(int, cb->min_dump_alloc, NLMSG_GOODSIZE);
-
 	if (atomic_read(&sk->sk_rmem_alloc) >= sk->sk_rcvbuf)
 		goto errout_skb;
 
@@ -1996,22 +1994,34 @@ static int netlink_dump(struct sock *sk)
 	 * to reduce number of system calls on dump operations, if user
 	 * ever provided a big enough buffer.
 	 */
-	if (alloc_size < nlk->max_recvmsg_len) {
-		skb = netlink_alloc_skb(sk,
-					nlk->max_recvmsg_len,
-					nlk->portid,
+	cb = &nlk->cb;
+	alloc_min_size = max_t(int, cb->min_dump_alloc, NLMSG_GOODSIZE);
+
+	if (alloc_min_size < nlk->max_recvmsg_len) {
+		alloc_size = nlk->max_recvmsg_len;
+		skb = netlink_alloc_skb(sk, alloc_size, nlk->portid,
 					(GFP_KERNEL & ~__GFP_WAIT) |
 					__GFP_NOWARN | __GFP_NORETRY);
-		/* available room should be exact amount to avoid MSG_TRUNC */
-		if (skb)
-			skb_reserve(skb, skb_tailroom(skb) -
-					 nlk->max_recvmsg_len);
 	}
-	if (!skb)
+	if (!skb) {
+		alloc_size = alloc_min_size;
 		skb = netlink_alloc_skb(sk, alloc_size, nlk->portid,
 					(GFP_KERNEL & ~__GFP_WAIT));
+	}
 	if (!skb)
 		goto errout_skb;
+
+	/* Trim skb to allocated size. User is expected to provide buffer as
+	 * large as max(min_dump_alloc, 16KiB (mac_recvmsg_len capped at
+	 * netlink_recvmsg())). dump will pack as many smaller messages as
+	 * could fit within the allocated skb. skb is typically allocated
+	 * with larger space than required (could be as much as near 2x the
+	 * requested size with align to next power of 2 approach). Allowing
+	 * dump to use the excess space makes it difficult for a user to have a
+	 * reasonable static buffer based on the expected largest dump of a
+	 * single netdev. The outcome is MSG_TRUNC error.
+	 */
+	skb_reserve(skb, skb_tailroom(skb) - alloc_size);
 	netlink_skb_set_owner_r(skb, sk);
 
 	if (nlk->dump_done_errno > 0)


