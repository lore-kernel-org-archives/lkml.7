Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360DAC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 094B920830
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570122963;
	bh=SGCl/7o3pIUVUon5GSr1I0zVFIJ8Ua8QgL4bkQYqCIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HAi7or9RAb05qQnhs3BowKzaw/q/VejsiaExxQ3ceZEYJS97lRJFpO+Du31SJd+sq
	 L+Q2v11PsykTGCkUcgprW4ZxM7CFu+JljNH8kC3giLD/TipFbmSmcMhsRs7lQeQm1k
	 5C5KGwgCLHqTg6NEdpfUTwez3hIHHEn7PMYJbJjY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391188AbfJCRQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:16:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:55014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729193AbfJCQZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:25:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 264552054F;
        Thu,  3 Oct 2019 16:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119901;
        bh=SGCl/7o3pIUVUon5GSr1I0zVFIJ8Ua8QgL4bkQYqCIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HXoHQk+vP1RMK0LMKKJ5gpcS2ZFbtsgSBtxbp7HJyjFVEcLKRUs6qkCLA/AaQP5lq
         qJGdOhM41RNSgDeJOaKJ9zlzbzrL9v+3keRZmY2jDu6dGrT9konNA9lgh35c9zWvKT
         unSN1jXQrs5QOk5xQYFPxu8DgNkpQdW8iOZFS678=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        Patrick Ruddy <pruddy@vyatta.att-mail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.2 023/313] vrf: Do not attempt to create IPv6 mcast rule if IPv6 is disabled
Date:   Thu,  3 Oct 2019 17:50:01 +0200
Message-Id: <20191003154535.650544593@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154533.590915454@linuxfoundation.org>
References: <20191003154533.590915454@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Ahern <dsahern@gmail.com>

[ Upstream commit dac91170f8e9c73784af5fad6225e954b795601c ]

A user reported that vrf create fails when IPv6 is disabled at boot using
'ipv6.disable=1':
   https://bugzilla.kernel.org/show_bug.cgi?id=204903

The failure is adding fib rules at create time. Add RTNL_FAMILY_IP6MR to
the check in vrf_fib_rule if ipv6_mod_enabled is disabled.

Fixes: e4a38c0c4b27 ("ipv6: add vrf table handling code for ipv6 mcast")
Signed-off-by: David Ahern <dsahern@gmail.com>
Cc: Patrick Ruddy <pruddy@vyatta.att-mail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/vrf.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -1153,7 +1153,8 @@ static int vrf_fib_rule(const struct net
 	struct sk_buff *skb;
 	int err;
 
-	if (family == AF_INET6 && !ipv6_mod_enabled())
+	if ((family == AF_INET6 || family == RTNL_FAMILY_IP6MR) &&
+	    !ipv6_mod_enabled())
 		return 0;
 
 	skb = nlmsg_new(vrf_fib_rule_nl_size(), GFP_KERNEL);


