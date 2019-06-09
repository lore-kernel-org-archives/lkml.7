Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC21C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A0B20684
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560100042;
	bh=WzLCNiPrpfQvIu3vfBv4IJIVJwJF/jXNDpCx9ByVCyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DFkef/6eHgNhjBkjjMxdjq4JHTCIvT0VH4YYALfDjTa7j0jVXjp3FIWYmz1zX8Mij
	 /Chz+7wG/yNomwV1Uj2veU+o5mHd5e2P9BP3ygAp9mTu6pJuSVhlKXgWrLhf3smyPt
	 1AENTmc8B2Q1oY3mXGGcWdXjLcVr0T83AY/mi9ew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388770AbfFIRHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 13:07:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389049AbfFIRGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 13:06:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A7C2204EC;
        Sun,  9 Jun 2019 17:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099997;
        bh=WzLCNiPrpfQvIu3vfBv4IJIVJwJF/jXNDpCx9ByVCyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O4poMB60B8p+j3VmeEQMQaYTDU1oiKNCMFOFzKu5iboRj84KQCF8fJLi8bJ8f6sWL
         6mUyEJgPbMLomyPpH9XSV9TKMvSpJwsaVDORjM+wa+iXQyn9Av2R7b8f1DFr4faKBb
         27xtiZQXx0MrJM37I911WLuBGjQQf6kFGbrWUJsQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>,
        Michal Kubecek <mkubecek@suse.cz>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 229/241] ethtool: fix potential userspace buffer overflow
Date:   Sun,  9 Jun 2019 18:42:51 +0200
Message-Id: <20190609164155.332907050@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164147.729157653@linuxfoundation.org>
References: <20190609164147.729157653@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vivien Didelot <vivien.didelot@gmail.com>

[ Upstream commit 0ee4e76937d69128a6a66861ba393ebdc2ffc8a2 ]

ethtool_get_regs() allocates a buffer of size ops->get_regs_len(),
and pass it to the kernel driver via ops->get_regs() for filling.

There is no restriction about what the kernel drivers can or cannot do
with the open ethtool_regs structure. They usually set regs->version
and ignore regs->len or set it to the same size as ops->get_regs_len().

But if userspace allocates a smaller buffer for the registers dump,
we would cause a userspace buffer overflow in the final copy_to_user()
call, which uses the regs.len value potentially reset by the driver.

To fix this, make this case obvious and store regs.len before calling
ops->get_regs(), to only copy as much data as requested by userspace,
up to the value returned by ops->get_regs_len().

While at it, remove the redundant check for non-null regbuf.

Signed-off-by: Vivien Didelot <vivien.didelot@gmail.com>
Reviewed-by: Michal Kubecek <mkubecek@suse.cz>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/ethtool.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/net/core/ethtool.c
+++ b/net/core/ethtool.c
@@ -893,13 +893,16 @@ static int ethtool_get_regs(struct net_d
 			return -ENOMEM;
 	}
 
+	if (regs.len < reglen)
+		reglen = regs.len;
+
 	ops->get_regs(dev, &regs, regbuf);
 
 	ret = -EFAULT;
 	if (copy_to_user(useraddr, &regs, sizeof(regs)))
 		goto out;
 	useraddr += offsetof(struct ethtool_regs, data);
-	if (regbuf && copy_to_user(useraddr, regbuf, regs.len))
+	if (copy_to_user(useraddr, regbuf, reglen))
 		goto out;
 	ret = 0;
 


