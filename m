Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148C0C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D616F205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554370460;
	bh=9ekxfH/2yA015iu0SdQuGw7mv6F5tSSW9kC8MnEu9BU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H2ehL0BBfCuZYm77ULGFrk0+aQv09s6qcLZNJqlvCylIbc+eqPR3P6KQhEx+PmOYX
	 mnWVQun1Yg1TMTOwMSI8U0On4u7go1sn3taC2JrnKZ9nIbfhGRSabGzYu6nWB67+YX
	 XKEPd9Xv0S8hIiZnXYHMuAS8qurpfVqPL122VPVI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732717AbfDDJeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:34:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732272AbfDDJH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:07:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB96F218C3;
        Thu,  4 Apr 2019 09:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368847;
        bh=9ekxfH/2yA015iu0SdQuGw7mv6F5tSSW9kC8MnEu9BU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IiomXQdGW+VRcxGptz0xJAo8K7tDoPcJbgkbTDj8TwDHwsLozemmYN6PG0DwYsfNB
         jY31UnxtrvSdVpUsgMK9PUlxrDPnadW/gIFE9A5kLzLChB5YqSs0EEBGs7zXJgL+u5
         hratA4xl7K19YhGXKpP0N3LhkV8/ylN9WfwAF7mk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 184/187] net: stmmac: Avoid one more sometimes uninitialized Clang warning
Date:   Thu,  4 Apr 2019 10:48:41 +0200
Message-Id: <20190404084611.781416014@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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



