Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041F8C47404
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 08:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D02A9206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 08:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="l+/KdG0p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730175AbfI3IT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 04:19:57 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:46112 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730032AbfI3IT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 04:19:27 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 50C11C0371;
        Mon, 30 Sep 2019 08:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1569831567; bh=X6ZuF3t+/sYHmhk5OVSm+g3RjPonhti5heRvhuw4Vho=;
        h=From:To:Cc:Subject:Date:From;
        b=l+/KdG0pKWvbdymwv42EIOi+8FdJw3GGE65tEJc16tl4r9V70l1fb2pIJAWbN8v3I
         5jmyrl7IyHq4kLMFISbiioBWYFz/Th5n4O5YQaWUtIYSS+Kc6lzfFc4RqD5k3/+3ZR
         sj5FtRrsyQ6erUwuVWVrA8JlpgvYDIz1LiopCs+shzQ8gmr7h+vn8pxQWNrGTYdxSH
         e6oU/H+IlaVIilAKZEiHSprmoHIt0LUxTU4IcmpnmRc8ne2g+xeXCrkokwhbGEi+3v
         4BueV+lMcmQwHCTkmiaOklfqdRDx+eM+qFdgsZyd0hUCg6oohEaEmEWgxhrMXrLt5J
         0Jkp6ttf5gvRA==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id B4E7AA0057;
        Mon, 30 Sep 2019 08:19:21 +0000 (UTC)
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
Subject: [PATCH v2 net 0/9] net: stmmac: Fixes for -net
Date:   Mon, 30 Sep 2019 10:19:04 +0200
Message-Id: <cover.1569831228.git.Jose.Abreu@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Misc fixes for -net tree. More info in commit logs.

v2 is just a rebase of v1 against -net and we added a new patch (09/09) to
fix RSS feature.

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

Jose Abreu (9):
  net: stmmac: xgmac: Not all Unicast addresses may be available
  net: stmmac: xgmac: Detect Hash Table size dinamically
  net: stmmac: selftests: Always use max DMA size in Jumbo Test
  net: stmmac: dwmac4: Always update the MAC Hash Filter
  net: stmmac: Correctly take timestamp for PTPv2
  net: stmmac: Do not stop PHY if WoL is enabled
  net: stmmac: xgmac: Disable the Timestamp interrupt by default
  net: stmmac: xgmac: Fix RSS not writing all Keys to HW
  net: stmmac: xgmac: Fix RSS writing wrong keys

 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c     | 13 +++++++------
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h        |  3 ++-
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c   |  9 +++++----
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c    |  1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c     | 19 +++++++++++++------
 .../net/ethernet/stmicro/stmmac/stmmac_selftests.c    |  4 ----
 6 files changed, 28 insertions(+), 21 deletions(-)

-- 
2.7.4

