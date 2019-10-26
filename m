Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCF1CA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C6F521655
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572097036;
	bh=RjBF98q9ZN4vfbuM2PfPKyAj1rMScuopJRkDJbQxx8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h/HIdIG+zbzuD5lUfU/2ndHFof953ask+pE839HFld6Lb2Ggp8fKO91YntcZHeC7c
	 WF1k9qCJrSh5p9IWARMxfF4uOwF1BMtekAGluKGrHHueQ1a3ps+7gjkCMRVNkRuhKH
	 qqERBy9wz3xRHpBNG7PJ/2KAx+NqVvj+8NDEMqOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfJZNhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 09:37:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbfJZNQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 09:16:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2F342070B;
        Sat, 26 Oct 2019 13:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572095780;
        bh=RjBF98q9ZN4vfbuM2PfPKyAj1rMScuopJRkDJbQxx8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VDMtKsQtj5TrQmar12dlJ/jth7V1LDm6j157PttihKwWuABlw4h9w41BcFBvdQ52K
         tIreZ9olTTAvh6bAekfPx8fYf7oarWJOalqF1Ct7yV79cufvGWwt4vk+FC/U7N9abi
         z/Ef6FiMzHnWhqgVqZ+nsf+Z/1nnc19ikOX53ruk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 11/99] net: stmmac: selftests: Check if filtering is available before running
Date:   Sat, 26 Oct 2019 09:14:32 -0400
Message-Id: <20191026131600.2507-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191026131600.2507-1-sashal@kernel.org>
References: <20191026131600.2507-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jose Abreu <Jose.Abreu@synopsys.com>

[ Upstream commit b870b0f867c77b92d7fd17ace8421904270d3c6a ]

We need to check if the number of available Hash Filters is enough to
run the test, otherwise we will get false failures.

Fixes: 091810dbded9 ("net: stmmac: Introduce selftests support")
Signed-off-by: Jose Abreu <Jose.Abreu@synopsys.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
index a97b1ea76438e..f8915a62d6025 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
@@ -456,6 +456,9 @@ static int stmmac_test_hfilt(struct stmmac_priv *priv)
 	if (ret)
 		return ret;
 
+	if (netdev_mc_count(priv->dev) >= priv->hw->multicast_filter_bins)
+		return -EOPNOTSUPP;
+
 	ret = dev_mc_add(priv->dev, gd_addr);
 	if (ret)
 		return ret;
@@ -533,6 +536,8 @@ static int stmmac_test_mcfilt(struct stmmac_priv *priv)
 
 	if (stmmac_filter_check(priv))
 		return -EOPNOTSUPP;
+	if (!priv->hw->multicast_filter_bins)
+		return -EOPNOTSUPP;
 
 	/* Remove all MC addresses */
 	__dev_mc_unsync(priv->dev, NULL);
@@ -571,6 +576,8 @@ static int stmmac_test_ucfilt(struct stmmac_priv *priv)
 
 	if (stmmac_filter_check(priv))
 		return -EOPNOTSUPP;
+	if (!priv->hw->multicast_filter_bins)
+		return -EOPNOTSUPP;
 
 	/* Remove all UC addresses */
 	__dev_uc_unsync(priv->dev, NULL);
-- 
2.20.1

