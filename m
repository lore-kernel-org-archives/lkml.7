Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD60C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 290BA2068F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574403324;
	bh=4ViH26CfKQ55nuwcbzbxlFI+t7zG1NSHwlFV6FltphI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yOF7VZK8vAfzfMgTNKyaHClkOf+WCVvZgziUcjZ4g69SbHgkfdaqGOlMDZxbqmwGE
	 tU61DGiNZssKAgVNUp/8y8lx0E20PBk6wDX3qLKP+jqXAUXzmwPpZ4bCmslMJQ8cWP
	 xXXFz475b2bNyPWtR81FEQiS48RVUxIGv+dqNv5c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbfKVGPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:15:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:51698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729516AbfKVGOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 01:14:11 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA5BC2068F;
        Fri, 22 Nov 2019 06:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574403250;
        bh=4ViH26CfKQ55nuwcbzbxlFI+t7zG1NSHwlFV6FltphI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LFxfePbFEL3XA11K4zQnk8eo7oi0At68HOV+ZvAfpNp9ijOlTfzVVk3j9JSAaaagM
         vywaBfQ5A6rjBuL8BRJNmPj0I8CxCRiiuRfR5LNMnW9yAttKeyRQYS3K/HLuqvjbLO
         HYh/ZDJJL/Tphy70DB+XR6cX5oio1QVqQNCNhFbY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hoang Le <hoang.h.le@dektech.com.au>,
        Ying Xue <ying.xue@windriver.com>,
        Jon Maloy <maloy@donjonn.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.4 60/68] tipc: fix skb may be leaky in tipc_link_input
Date:   Fri, 22 Nov 2019 01:12:53 -0500
Message-Id: <20191122061301.4947-59-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122061301.4947-1-sashal@kernel.org>
References: <20191122061301.4947-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hoang Le <hoang.h.le@dektech.com.au>

[ Upstream commit 7384b538d3aed2ed49d3575483d17aeee790fb06 ]

When we free skb at tipc_data_input, we return a 'false' boolean.
Then, skb passed to subcalling tipc_link_input in tipc_link_rcv,

<snip>
1303 int tipc_link_rcv:
...
1354    if (!tipc_data_input(l, skb, l->inputq))
1355        rc |= tipc_link_input(l, skb, l->inputq);
</snip>

Fix it by simple changing to a 'true' boolean when skb is being free-ed.
Then, tipc_link_rcv will bypassed to subcalling tipc_link_input as above
condition.

Acked-by: Ying Xue <ying.xue@windriver.com>
Acked-by: Jon Maloy <maloy@donjonn.com>
Signed-off-by: Hoang Le <hoang.h.le@dektech.com.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tipc/link.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tipc/link.c b/net/tipc/link.c
index 736fffb28ab6f..0080699b7cd1b 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -883,7 +883,7 @@ static bool tipc_data_input(struct tipc_link *l, struct sk_buff *skb,
 	default:
 		pr_warn("Dropping received illegal msg type\n");
 		kfree_skb(skb);
-		return false;
+		return true;
 	};
 }
 
-- 
2.20.1

