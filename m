Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16F5C2D0C8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 11:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7A4C20665
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 11:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="iyb7DJjq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfLQLnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 06:43:03 -0500
Received: from sv2-smtprelay2.synopsys.com ([149.117.73.133]:48824 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727626AbfLQLmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 06:42:55 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9863C4266E;
        Tue, 17 Dec 2019 11:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1576582974; bh=bM8T9PSP5GnAoUaQXQaEg95xhnvdUPdNYJTNEqJMPNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=iyb7DJjqreUutfvIo0Kn0KK0dzIjdXKCcY4xXyPbtZskqAKeK+LMwgtUvjiUtKzaG
         1EhWj+M1LZv8WwEs3mXb/eZBNjxPni+p76G7boxlYguceuUySL6vHqQs92NAe1ittp
         pUS/ySlg/gQCWABqyiaZM8xShvH1hxWGcdEPILGMyKHNxDcUFEyUuD3ExN79gvtkcz
         zpDKMBjIxF6NdKMz7ngc4eWb6V0J/hv4T7I4PrCKGX5BGy56Z4Gi6WBLBFIXF/4hCl
         WaTmeOdq3V7mpjFq1T7f+3UzLd49OBe+vfJE3jzT+glH2vXfkp9pwG2+O4wonouyNQ
         qOrNtFQJL6fZw==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 2A42FA00AE;
        Tue, 17 Dec 2019 11:42:51 +0000 (UTC)
From:   Jose Abreu <Jose.Abreu@synopsys.com>
To:     netdev@vger.kernel.org
Cc:     Joao Pinto <Joao.Pinto@synopsys.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH net v2 8/8] net: stmmac: Enable 16KB buffer size
Date:   Tue, 17 Dec 2019 12:42:38 +0100
Message-Id: <54641d0f06e56ff2470f0575fc901477306a54c6.1576581853.git.Jose.Abreu@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1576581853.git.Jose.Abreu@synopsys.com>
References: <cover.1576581853.git.Jose.Abreu@synopsys.com>
In-Reply-To: <cover.1576581853.git.Jose.Abreu@synopsys.com>
References: <cover.1576581853.git.Jose.Abreu@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

XGMAC supports maximum MTU that can go to 16KB. Lets add this check in
the calculation of RX buffer size.

Fixes: 7ac6653a085b ("stmmac: Move the STMicroelectronics driver")
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
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index eb31d7fb321c..082eeff9f54b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1109,7 +1109,9 @@ static int stmmac_set_bfsize(int mtu, int bufsize)
 {
 	int ret = bufsize;
 
-	if (mtu >= BUF_SIZE_4KiB)
+	if (mtu >= BUF_SIZE_8KiB)
+		ret = BUF_SIZE_16KiB;
+	else if (mtu >= BUF_SIZE_4KiB)
 		ret = BUF_SIZE_8KiB;
 	else if (mtu >= BUF_SIZE_2KiB)
 		ret = BUF_SIZE_4KiB;
-- 
2.7.4

