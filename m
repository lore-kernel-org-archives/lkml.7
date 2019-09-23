Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE30C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 07:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E02F72064A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 07:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="YUrCwRvB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436911AbfIWHtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 03:49:15 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:33980 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404826AbfIWHtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 03:49:14 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2BD0EC0393;
        Mon, 23 Sep 2019 07:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1569224954; bh=vRW8n17JID3cq//x3ZOP6/PLKPY+2IzDjG/7sDZ9vCI=;
        h=From:To:Cc:Subject:Date:From;
        b=YUrCwRvBRNLXxe2r2lBfAIkYQcljCiOLVFSgBNjtrB1G74Icn7pVZV/Lm5SHztjYc
         LTTt2hILdXaE1yARTwR6uWNejB8CmHK/4RxSLCbOdDztRP1OTDFbQjCyL1S8NeBlrL
         lwAWai+o2PRCiuwmyvkvPIqzDhB2nWWAEesF7Og2jbcbOa/rFgAhnEH3GxyHGFCoBB
         Qed4pVOk2V7JVmyZ2jT62bV+1zWTm6I7UNlpf51stCw/YUWaAr1V2qdk9T4qTbbPqa
         Kh20VhG6FCOe3HRKEFuUw0VO3ve1bCxi8u6SZx+U/2Liqi5vrx+t7QA9hxcmU2CY+c
         laEcuoLx5WJGQ==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id DB888A0057;
        Mon, 23 Sep 2019 07:49:09 +0000 (UTC)
From:   Jose Abreu <Jose.Abreu@synopsys.com>
To:     netdev@vger.kernel.org
Cc:     Joao Pinto <Joao.Pinto@synopsys.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: stmmac: selftests: Flow Control test can also run with ASYM Pause
Date:   Mon, 23 Sep 2019 09:49:08 +0200
Message-Id: <efc49b6ea500115ff1442ddebe9dc7d956eb19e9.1569224900.git.Jose.Abreu@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Flow Control selftest is also available with ASYM Pause. Lets add
this check to the test and fix eventual false positive failures.

Fixes: 091810dbded9 ("net: stmmac: Introduce selftests support")
Signed-off-by: Jose Abreu <Jose.Abreu@synopsys.com>

---
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Jose Abreu <joabreu@synopsys.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: netdev@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
index 9c8d210b2d6a..5f66f6161629 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
@@ -670,7 +670,7 @@ static int stmmac_test_flowctrl(struct stmmac_priv *priv)
 	unsigned int pkt_count;
 	int i, ret = 0;
 
-	if (!phydev || !phydev->pause)
+	if (!phydev || (!phydev->pause && !phydev->asym_pause))
 		return -EOPNOTSUPP;
 
 	tpriv = kzalloc(sizeof(*tpriv), GFP_KERNEL);
-- 
2.7.4

