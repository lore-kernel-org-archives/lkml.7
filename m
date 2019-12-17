Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A70C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 922C92176D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576613413;
	bh=Rbxn+mhz5nZooNXEHWaE4uC+r8lmHz35r1FEl8qsTw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RQYGeoUTlZjl5tyju3/2p1kn+zd7TGeOwFNkFSXp39e2d6vBszk9x2FmRv5PhWM1k
	 hpJ6rYY+CKnip8Q0RXVwexb+M8bGOm0KDV0JywkKPxVMzwuul1ursgghp82PAEOViA
	 vkoNKWhD05gx3Kkx2J5EyD0i725nXIz+1LvyLqyk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbfLQUKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 15:10:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:36272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbfLQUKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 15:10:10 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B73102176D;
        Tue, 17 Dec 2019 20:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576613410;
        bh=Rbxn+mhz5nZooNXEHWaE4uC+r8lmHz35r1FEl8qsTw0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mj7UEqQ6vjAzmGlOoa4+T8beXLR0vD8qBnsJQveXAHv/4m9FxXrtci9Fv/U+F8lyT
         ER4/mJs8xuYY2+2X/EcURjHb0NYlpQMToe2FOmlmYuiENIygtcCZ08YGtO/eHHDt0a
         l86FxKkmkMZ9jaIVOmF1Od3xVKHVjI/M/KtpZVcU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vladyslav Tarasiuk <vladyslavt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 02/37] mqprio: Fix out-of-bounds access in mqprio_dump
Date:   Tue, 17 Dec 2019 21:09:23 +0100
Message-Id: <20191217200722.933512271@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191217200721.741054904@linuxfoundation.org>
References: <20191217200721.741054904@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladyslav Tarasiuk <vladyslavt@mellanox.com>

[ Upstream commit 9f104c7736904ac72385bbb48669e0c923ca879b ]

When user runs a command like
tc qdisc add dev eth1 root mqprio
KASAN stack-out-of-bounds warning is emitted.
Currently, NLA_ALIGN macro used in mqprio_dump provides too large
buffer size as argument for nla_put and memcpy down the call stack.
The flow looks like this:
1. nla_put expects exact object size as an argument;
2. Later it provides this size to memcpy;
3. To calculate correct padding for SKB, nla_put applies NLA_ALIGN
   macro itself.

Therefore, NLA_ALIGN should not be applied to the nla_put parameter.
Otherwise it will lead to out-of-bounds memory access in memcpy.

Fixes: 4e8b86c06269 ("mqprio: Introduce new hardware offload mode and shaper in mqprio")
Signed-off-by: Vladyslav Tarasiuk <vladyslavt@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_mqprio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/sched/sch_mqprio.c
+++ b/net/sched/sch_mqprio.c
@@ -433,7 +433,7 @@ static int mqprio_dump(struct Qdisc *sch
 		opt.offset[tc] = dev->tc_to_txq[tc].offset;
 	}
 
-	if (nla_put(skb, TCA_OPTIONS, NLA_ALIGN(sizeof(opt)), &opt))
+	if (nla_put(skb, TCA_OPTIONS, sizeof(opt), &opt))
 		goto nla_put_failure;
 
 	if ((priv->flags & TC_MQPRIO_F_MODE) &&


