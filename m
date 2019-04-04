Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7205C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9143A20652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369512;
	bh=ZIy8upD26bbsGF0jz4sS5OVUmzazDpG5c+JGASpA/BQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Fcja48gUV5SwVviH5vzYgPwB8LwR6ur6DDrmpDh95ZnfokAgX3d2DPQ6glCY3KfkH
	 oui+G8bZG3ms75dpeJ64HQtoAj4dpKXt6aSKhrqAe27XY4ovz2Q7Fago9EjfmpOcoN
	 jBF/+padsaUY5bGVd73E6qLz8Dso54CL5DlYI/dI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388390AbfDDJSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:18:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388363AbfDDJS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:18:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5264720652;
        Thu,  4 Apr 2019 09:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369507;
        bh=ZIy8upD26bbsGF0jz4sS5OVUmzazDpG5c+JGASpA/BQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=veHwvFV9VCbZlqGXfKbI87O7tDc5GyrKDBVriZR220keSg9WxPJbqV6BNJvqlGuqq
         hrYTZTB6n3/JFpxklJWHjz7YGFXqmpI2ZvHlyoKxvLsNTbjbEG4AF2wd3oVppppEl3
         YR0eHZ+FVytZFGKSBbQukcxlkZDeA6HSoUzFZmA8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 242/246] net: stmmac: Avoid one more sometimes uninitialized Clang warning
Date:   Thu,  4 Apr 2019 10:49:02 +0200
Message-Id: <20190404084627.771588079@linuxfoundation.org>
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



