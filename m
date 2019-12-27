Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10355C2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 18:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D215220722
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 18:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577470546;
	bh=cxid6C6F9WrArkdBSO7ewILRRUwrf6B52AkZM6I+OZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XdEnJ6pj2BOGKdXoOgMf32jtvzYcmNIp3IIIXpN4m7G0ikF5gF0pkzBGQlM0ITbdA
	 FtFm+LHh8zwpCyKluzEV7xtSZLtdoTjvUuaZFg4kKcLAdYN/4XQqRwFEvgpdxQGdzX
	 oebJmSdnev5N8nk01YjHlsd0M7IpJWALPMgY8seA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbfL0SPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 13:15:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:40024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727889AbfL0SPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 13:15:15 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3898C222C3;
        Fri, 27 Dec 2019 18:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577470515;
        bh=cxid6C6F9WrArkdBSO7ewILRRUwrf6B52AkZM6I+OZc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2qG01NYOn0Y37GwO8gHApB7RtMv2izzTlXK3jcOEL7HOTytQAO0MDtCGQDxRa2O4d
         x52toZX6Aff+HdI5lRhiC3srnikgk25R7MwJCENPS88goK+Pnwud9cTEmt0GaqPm3E
         e7UMkpF8KRIh1dQb4nWe+oEFyHJEbyApqoqxyeG4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.9 32/38] net: stmmac: RX buffer size must be 16 byte aligned
Date:   Fri, 27 Dec 2019 13:14:29 -0500
Message-Id: <20191227181435.7644-32-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227181435.7644-1-sashal@kernel.org>
References: <20191227181435.7644-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jose Abreu <Jose.Abreu@synopsys.com>

[ Upstream commit 8d558f0294fe92e04af192e221d0d0f6a180ee7b ]

We need to align the RX buffer size to at least 16 byte so that IP
doesn't mis-behave. This is required by HW.

Changes from v2:
- Align UP and not DOWN (David)

Fixes: 7ac6653a085b ("stmmac: Move the STMicroelectronics driver")
Signed-off-by: Jose Abreu <Jose.Abreu@synopsys.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 5ac48a594951..a2b7c685cbf1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -55,7 +55,7 @@
 #include <linux/of_mdio.h>
 #include "dwmac1000.h"
 
-#define	STMMAC_ALIGN(x)		__ALIGN_KERNEL(x, SMP_CACHE_BYTES)
+#define	STMMAC_ALIGN(x)		ALIGN(ALIGN(x, SMP_CACHE_BYTES), 16)
 #define	TSO_MAX_BUFF_SIZE	(SZ_16K - 1)
 
 /* Module parameters */
-- 
2.20.1

