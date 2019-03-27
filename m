Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B10C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51E421741
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553710227;
	bh=7EH4dVlSDuD7rrHSEaMh/smm3ISlrRpdbt8Mqn3fxRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s3UOz9mNv2fxom9hn2b/+oqfMaaXN9HutlrlG03+1eVxLpWsYKxde5QABlEuMsHAf
	 vRNcjJnybrdPJDOR91kW82XY4jY3rSdWAhHyDOfTYjYoH4867FbI8ToaGn7oWpfscM
	 8/V99gZD+ng+YwJLlj2zYHXSKy7WeLEmg7BIX0N8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388807AbfC0SK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:10:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:52278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388779AbfC0SKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:10:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9586721741;
        Wed, 27 Mar 2019 18:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710217;
        bh=7EH4dVlSDuD7rrHSEaMh/smm3ISlrRpdbt8Mqn3fxRQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YqzsOHD9U93GumLvrCyMXv83DHV3EXf3FwtK73Mn91i9d+B4i17ddkrgbyG+IaOXx
         vFb6AsdKTqHSF5Ex2jHiDKqm3ok3wrCnbkVHBIrpP1fmT/tXYjYr7yTcid3rKNCrqS
         Dn8JK6qPTsbrSjcq+NDdwjYD9xZFaRF6BIAaL08g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 258/262] net: stmmac: Avoid one more sometimes uninitialized Clang warning
Date:   Wed, 27 Mar 2019 14:01:53 -0400
Message-Id: <20190327180158.10245-258-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit 1f5d861f7fefa971b2c6e766f77932c86419a319 ]

When building with -Wsometimes-uninitialized, Clang warns:

drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c:111:2: error: variable
'ns' is used uninitialized whenever 'if' condition is false
[-Werror,-Wsometimes-uninitialized]
drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c:111:2: error: variable
'ns' is used uninitialized whenever '&&' condition is false
[-Werror,-Wsometimes-uninitialized]

Clang is concerned with the use of stmmac_do_void_callback (which
stmmac_get_systime wraps), as it may fail to initialize these values if
the if condition was ever false (meaning the callback doesn't exist).
It's not wrong because the callback is what initializes ns. While it's
unlikely that the callback is going to disappear at some point and make
that condition false, we can easily avoid this warning by zero
initializing the variable.

Link: https://github.com/ClangBuiltLinux/linux/issues/384
Fixes: df103170854e ("net: stmmac: Avoid sometimes uninitialized Clang warnings")
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 2293e21f789f..cc60b3fb0892 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -105,7 +105,7 @@ static int stmmac_get_time(struct ptp_clock_info *ptp, struct timespec64 *ts)
 	struct stmmac_priv *priv =
 	    container_of(ptp, struct stmmac_priv, ptp_clock_ops);
 	unsigned long flags;
-	u64 ns;
+	u64 ns = 0;
 
 	spin_lock_irqsave(&priv->ptp_lock, flags);
 	stmmac_get_systime(priv, priv->ptpaddr, &ns);
-- 
2.19.1

