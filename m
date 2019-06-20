Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF87C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C8B21530
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561053983;
	bh=5g4ElFNDCPyJ9TdYepS3uPQ5YhDdovUUaE1ZRrmnZNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LB4AqHf8By5EmwX4z7ssTOoWt8Ul4RYBwHhMOEEDz84cK/7iRGOgC/AGW/P9P22NJ
	 GJ1yYC61Tf8g3bb/3kVU7lROnpYFtLGHqif92FbAu/l4qI/rx3uijW2s8bvmQUR+aT
	 tbmw4vYPqk5G0EKTuBHSUrbTMfXoQhs8Ii+lBkFU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbfFTSGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:06:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:60298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728124AbfFTSGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:06:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9471221530;
        Thu, 20 Jun 2019 18:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561053973;
        bh=5g4ElFNDCPyJ9TdYepS3uPQ5YhDdovUUaE1ZRrmnZNM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f+UlOrJNiNq7WUAUzqRGMt0wZssHx+tHEc5GN445Fuv17uY/+eQ+xxuU4VYYtj6qX
         1EKoNGGJm6Is/SBnxen8RGMfsTcXsX86g+zYsEGzLfc58MFJLEPYrPdCITJXzI7BLS
         RAzlRHJvUy1OlUFkqs2fm8GV948HTRruVvWQjMY4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 092/117] ipv6: flowlabel: fl6_sock_lookup() must use atomic_inc_not_zero
Date:   Thu, 20 Jun 2019 19:57:06 +0200
Message-Id: <20190620174357.517902879@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174351.964339809@linuxfoundation.org>
References: <20190620174351.964339809@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 65a3c497c0e965a552008db8bc2653f62bc925a1 ]

Before taking a refcount, make sure the object is not already
scheduled for deletion.

Same fix is needed in ipv6_flowlabel_opt()

Fixes: 18367681a10b ("ipv6 flowlabel: Convert np->ipv6_fl_list to RCU.")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_flowlabel.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/net/ipv6/ip6_flowlabel.c
+++ b/net/ipv6/ip6_flowlabel.c
@@ -254,9 +254,9 @@ struct ip6_flowlabel *fl6_sock_lookup(st
 	rcu_read_lock_bh();
 	for_each_sk_fl_rcu(np, sfl) {
 		struct ip6_flowlabel *fl = sfl->fl;
-		if (fl->label == label) {
+
+		if (fl->label == label && atomic_inc_not_zero(&fl->users)) {
 			fl->lastuse = jiffies;
-			atomic_inc(&fl->users);
 			rcu_read_unlock_bh();
 			return fl;
 		}
@@ -623,7 +623,8 @@ int ipv6_flowlabel_opt(struct sock *sk,
 						goto done;
 					}
 					fl1 = sfl->fl;
-					atomic_inc(&fl1->users);
+					if (!atomic_inc_not_zero(&fl1->users))
+						fl1 = NULL;
 					break;
 				}
 			}


