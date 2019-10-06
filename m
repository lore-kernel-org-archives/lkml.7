Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB27C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 11:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 967D12084D
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 11:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="kgXlkXsJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfJFLJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 07:09:25 -0400
Received: from us03-smtprelay2.synopsys.com ([149.117.87.133]:46816 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726322AbfJFLJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 07:09:08 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E8E11C04C1;
        Sun,  6 Oct 2019 11:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1570360147; bh=HsZL/b2XjmKMURLvNgIusI3oggJImdu/rO/oTDqojMA=;
        h=From:To:Cc:Subject:Date:From;
        b=kgXlkXsJ9Y/zbnyCy2qhXDHMGe1cWiyj1MR6m9Z88cewH+JMinOoCVF5teP4IBrnJ
         2W5TpM8QgD2gVJ6scmaGCA5gE2XPw3PDt6xAQL8BmzJ+HPrAfLxaAZmJIFw6THh+SI
         3cTrzCpY4FE/coRplublUhMBGF98ZJJF2yUynQwlA+yIFRbfbM+NLD2QsMpq+IpQaX
         Da5X8FYkqAMpaLGGt6ZLSeWq1znuE/TaqZ3Hx/1hRV0HCvYay+o7uXb8dNeVw/eCNH
         CRIdGW5vRzZwd8ThjWu2AbGco8QKyCXOjtXDxDohEGX5NyRxta/1tlelIahuJEoHCa
         um4Mq1bg8ZcYA==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 90F4AA005C;
        Sun,  6 Oct 2019 11:09:03 +0000 (UTC)
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
Subject: [PATCH net 0/3] net: stmmac: Fixes for -net
Date:   Sun,  6 Oct 2019 13:08:54 +0200
Message-Id: <cover.1570359800.git.Jose.Abreu@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes for -net. More info in commit logs.

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

Jose Abreu (3):
  net: stmmac: selftests: Check if filtering is available before running
  net: stmmac: gmac4+: Not all Unicast addresses may be available
  net: stmmac: selftests: Fix L2 Hash Filter test

 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c      |  2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c | 11 +++++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

-- 
2.7.4

