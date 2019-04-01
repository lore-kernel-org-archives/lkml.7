Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B61C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5BE92070B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140078;
	bh=ewhUAgHSC7JKKNWubdxiioxiVn0TbPkQB+FjLeFaTFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p41EwPAZUkalfRU5UcJHgAJ6LjWJOzNzWnnMRsa3lGw3yw0gWTuiixVZs82vWAH83
	 oR4TQIj3d6ngeeQFnxUHZCpMjT+S8rO+NGLD/L7sAOSpw82CujL93hJd0e4rkpiBZ8
	 KPsnJbZyAbCwAbVs54v1uA0S9CyArzSCUloVoQmc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387812AbfDAReh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:34:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:44518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733306AbfDARee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:34:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B8E72070B;
        Mon,  1 Apr 2019 17:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140074;
        bh=ewhUAgHSC7JKKNWubdxiioxiVn0TbPkQB+FjLeFaTFo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UTSvBx5YZXSNjb121XuBt6OZDdHQdDXIayS8NSQDqGWKz3aNZ97ETbyKqEQ08pDoZ
         mOX2U3NxeDACVigY2JlJ3CcDlVXH6BzwDJFZv2sHjgEKPuGsosg86iFDv2rVIPGQA5
         ui2oGG0N/194wqDZ7mU0fLhz43NwQetwdhjXx+U8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lorenzo Colitti <lorenzo@google.com>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 081/131] ipv6: fix endianness error in icmpv6_err
Date:   Mon,  1 Apr 2019 19:02:31 +0200
Message-Id: <20190401170058.898310881@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit dcb94b88c09ce82a80e188d49bcffdc83ba215a6 ]

IPv6 ping socket error handler doesn't correctly convert the new 32 bit
mtu to host endianness before using.

Cc: Lorenzo Colitti <lorenzo@google.com>
Fixes: 6d0bfe22611602f ("net: ipv6: Add IPv6 support to the ping socket.")
Signed-off-by: Hannes Frederic Sowa <hannes@stressinduktion.org>
Acked-by: Lorenzo Colitti <lorenzo@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/icmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index 0a37ddc7af51..3697cd08c515 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -98,7 +98,7 @@ static void icmpv6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 
 	if (!(type & ICMPV6_INFOMSG_MASK))
 		if (icmp6->icmp6_type == ICMPV6_ECHO_REQUEST)
-			ping_err(skb, offset, info);
+			ping_err(skb, offset, ntohl(info));
 }
 
 static int icmpv6_rcv(struct sk_buff *skb);
-- 
2.19.1



