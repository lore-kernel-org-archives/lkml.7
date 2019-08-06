Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36541C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFFCF20665
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gl65vyO7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731980AbfHFNQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 09:16:27 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:58078 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726713AbfHFNQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 09:16:26 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1D2A1C21BE;
        Tue,  6 Aug 2019 13:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1565097385; bh=opvibQbBIJ9hPlS0cfa2HRwHJqvFyO5wQchN17Kouis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=gl65vyO70WuPrNU99j3+rcaGPQE9v0MaLBbO4SGX4mm4j9niN+dkuOcxlB9oHrywT
         QLhGyx7fW7cJrz6Wis3wMyWcsD8h+bitUGhRVJdlpAvVVH7e88SDzKnlAwwRuy4GL+
         Gk2BTFjbWpkdbm04W89UapSOgCJ3aPayfkvR7VtKJ8nVqFa/F1H2UIhPaHTwK32YLd
         t9oHylsakXSlhCNzy0AdaVcqK+tUnALY3Whj+ZArNFtPtI9QUsmHDjjP2QJBjjH0dt
         oNRP3f1vnGgxK+q9Lx+2M0gFrn6xya1rua9kTjmEmwdqSoReL+Sph+zX0Y+Yo71Jhf
         X50G6IQE6yMEA==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id CF8E8A0066;
        Tue,  6 Aug 2019 13:16:23 +0000 (UTC)
From:   Jose Abreu <Jose.Abreu@synopsys.com>
To:     netdev@vger.kernel.org
Cc:     Joao Pinto <Joao.Pinto@synopsys.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 3/3] net: stmmac: tc: Do not return a fragment entry
Date:   Tue,  6 Aug 2019 15:16:18 +0200
Message-Id: <67f380701fc127022e1d5a0922725bdf1bc185f4.1565097294.git.joabreu@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1565097294.git.joabreu@synopsys.com>
References: <cover.1565097294.git.joabreu@synopsys.com>
In-Reply-To: <cover.1565097294.git.joabreu@synopsys.com>
References: <cover.1565097294.git.joabreu@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not try to return a fragment entry from TC list. Otherwise we may not
clean properly allocated entries.

Signed-off-by: Jose Abreu <joabreu@synopsys.com>

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
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 58ea18af9813..37c0bc699cd9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -37,7 +37,7 @@ static struct stmmac_tc_entry *tc_find_entry(struct stmmac_priv *priv,
 		entry = &priv->tc_entries[i];
 		if (!entry->in_use && !first && free)
 			first = entry;
-		if (entry->handle == loc && !free)
+		if ((entry->handle == loc) && !free && !entry->is_frag)
 			dup = entry;
 	}
 
-- 
2.7.4

