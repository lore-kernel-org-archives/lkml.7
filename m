Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50924C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC282064A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553713880;
	bh=atYNR1HJUYApAKU3brvnzxD54r4XPa6MGDUlBL3BrCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zZsxP0M3HIMhohg1BmS+JGV98y42TEQRJus1Ue5C3zvr99s1E4TQS7kOKgL+v4V3Q
	 bRVa9Qoq9rcqhazaSEvML0XxUA+2ZfvL9ruj9tPxF5zoqsMzbj0wDPT7x51cU4ZYAs
	 EFUATLgQDBgv5fWPQF2uM4LgmYrcNY08OygXzq8c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389466AbfC0TLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:11:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:52868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388428AbfC0SKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:10:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C615221855;
        Wed, 27 Mar 2019 18:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710245;
        bh=atYNR1HJUYApAKU3brvnzxD54r4XPa6MGDUlBL3BrCc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GMwOg6WyzJWuZ2KFROfpn+dup4QuMv8/JQZyozvuR0mCfGIqirQ/s29m20c2gmJ+y
         PQ93I+7JtUgmYP29/+BEF+GCYimU1cqUJvHBcPvBwiAN7kfW5d8L9Am1UWfcBm1zRW
         pUu5QAhGATmhqz0UpqFzchvB63/u4X+3q8iSN4Vk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 013/192] net: stmmac: Avoid sometimes uninitialized Clang warnings
Date:   Wed, 27 Mar 2019 14:07:25 -0400
Message-Id: <20190327181025.13507-13-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit df103170854e87124ee7bdd2bca64b178e653f97 ]

When building with -Wsometimes-uninitialized, Clang warns:

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:495:3: warning: variable 'ns' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:495:3: warning: variable 'ns' is used uninitialized whenever '&&' condition is false [-Wsometimes-uninitialized]
drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:532:3: warning: variable 'ns' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:532:3: warning: variable 'ns' is used uninitialized whenever '&&' condition is false [-Wsometimes-uninitialized]
drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:741:3: warning: variable 'sec_inc' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:741:3: warning: variable 'sec_inc' is used uninitialized whenever '&&' condition is false [-Wsometimes-uninitialized]

Clang is concerned with the use of stmmac_do_void_callback (which
stmmac_get_timestamp and stmmac_config_sub_second_increment wrap),
as it may fail to initialize these values if the if condition was ever
false (meaning the callbacks don't exist). It's not wrong because the
callbacks (get_timestamp and config_sub_second_increment respectively)
are the ones that initialize the variables. While it's unlikely that the
callbacks are ever going to disappear and make that condition false, we
can easily avoid this warning by zero initialize the variables.

Link: https://github.com/ClangBuiltLinux/linux/issues/384
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 43ab9e905bed..886176be818e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -474,7 +474,7 @@ static void stmmac_get_tx_hwtstamp(struct stmmac_priv *priv,
 				   struct dma_desc *p, struct sk_buff *skb)
 {
 	struct skb_shared_hwtstamps shhwtstamp;
-	u64 ns;
+	u64 ns = 0;
 
 	if (!priv->hwts_tx_en)
 		return;
@@ -513,7 +513,7 @@ static void stmmac_get_rx_hwtstamp(struct stmmac_priv *priv, struct dma_desc *p,
 {
 	struct skb_shared_hwtstamps *shhwtstamp = NULL;
 	struct dma_desc *desc = p;
-	u64 ns;
+	u64 ns = 0;
 
 	if (!priv->hwts_rx_en)
 		return;
@@ -558,8 +558,8 @@ static int stmmac_hwtstamp_ioctl(struct net_device *dev, struct ifreq *ifr)
 	u32 snap_type_sel = 0;
 	u32 ts_master_en = 0;
 	u32 ts_event_en = 0;
+	u32 sec_inc = 0;
 	u32 value = 0;
-	u32 sec_inc;
 	bool xmac;
 
 	xmac = priv->plat->has_gmac4 || priv->plat->has_xgmac;
-- 
2.19.1

