Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14860C04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 08:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9C3A20B7C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 08:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="KG/omzjh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfE2Ial (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 04:30:41 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:41640 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725957AbfE2Ial (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 04:30:41 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D298EC2132;
        Wed, 29 May 2019 08:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1559118623; bh=F8sZHFsPIFdqkj3KFIDJ0n8BZL1rcqZwyQxdnVl+krY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=KG/omzjhU5pdEhIq4AYIMCffBuSJ2Cksbnt2zH5wDqHBrtwSR/K9Wgdaoh60L5zXP
         vZds7MuvMr3+m14ycP9OE03dlzL1NDlfwqH2dwD74Z1UrNc9GiuN++xl64QeyfRmw0
         pxy0JiAD8u1uC544Ef8dRPLEfrBTXxQVQ+Ow3pYCXIfhv0ZCHEqUlSX7mecSAkttrA
         rg7e3W7opGoEeyegglfh6x0E4EYuK6kabuYnLdlTOBRCS/VJTUv3sDyBCcxqqNhD4E
         GfembFAJgHP6sliUmVMx7BtofPvZJTOOQ0oEG9uZpn0PSBKyu6iYZze/IGmVavmAKX
         HeJz/RTglFE4Q==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 42B87A00A5;
        Wed, 29 May 2019 08:30:40 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 645D83E891;
        Wed, 29 May 2019 10:30:39 +0200 (CEST)
From:   Jose Abreu <Jose.Abreu@synopsys.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Jose Abreu <Jose.Abreu@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH net-next 2/2] net: stmmac: selftests: Use kfree_skb() instead of kfree()
Date:   Wed, 29 May 2019 10:30:26 +0200
Message-Id: <8e2d23ac49fb9d62c3e839b560ebd719fbe9ed7b.1559118521.git.joabreu@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1559118521.git.joabreu@synopsys.com>
References: <cover.1559118521.git.joabreu@synopsys.com>
In-Reply-To: <cover.1559118521.git.joabreu@synopsys.com>
References: <cover.1559118521.git.joabreu@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kfree_skb() shall be used instead of kfree(). Fix it.

Fixes: 091810dbded9 ("net: stmmac: Introduce selftests support")
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
index 9d9bad5d31bf..a97b1ea76438 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
@@ -617,7 +617,7 @@ static int stmmac_test_flowctrl_validate(struct sk_buff *skb,
 	tpriv->ok = true;
 	complete(&tpriv->comp);
 out:
-	kfree(skb);
+	kfree_skb(skb);
 	return 0;
 }
 
-- 
2.7.4

