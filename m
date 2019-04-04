Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FC3C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59FB1205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554370348;
	bh=8pZKyeHvzoHYM+Wagxl1rFSJP1QwdutGa6Jx3W0N3LE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BlLE1s5OPRWEC5LG4r+tsHi3Iydry7YIy5cRVItWFXslJlPIfrOdv9ZJ2RO1rapwW
	 2+xgjWtRwYUJBOEw1sIY3utEX7BjdFuLoVn/+n+mOtP0PIL4gLUpmwE9otP8rJnnBG
	 ru6I1fHvH80i6qGcAoai/hG/tXiyKQwXktcIIIXM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732997AbfDDJc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:32:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:47972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732722AbfDDJIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:08:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 890D62186A;
        Thu,  4 Apr 2019 09:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368931;
        bh=8pZKyeHvzoHYM+Wagxl1rFSJP1QwdutGa6Jx3W0N3LE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oTLR1O/cbTmoqqvQ1W4mHW/sVVHkTzp6WAluHNEqEUmdzqrbIfPTOHNrG7qMJf7+6
         shKnPeUt4D/+HdlEHHKsEtbQ5pYd3w0jL5fXw7qGr6wILB7iX5jIUSaIxk7jePSRvQ
         wcao6fbxY2WMT42V461esDITyU0C9e2CviPtQo14=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 018/246] net: stmmac: Avoid sometimes uninitialized Clang warnings
Date:   Thu,  4 Apr 2019 10:45:18 +0200
Message-Id: <20190404084619.803637247@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 685d20472358..019ab99e65bb 100644
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



