Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48EDC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 729792173B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573498452;
	bh=3We5enV7MlKPPpIE/WlLtKgeM9KV3gZm3dvrTQOWq4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DXtwagxHZ4j9+B7xAb0Z66nPgbcLLd3uIM4LzC6VkD2cD6kMalIAmzjIgQTl+6Xrb
	 OVmJi6L6jbVSueu6xJSI6vsz2Je+BsDfUvbpre8ORS0X4XWFfBQD+JqS0YI23lvKJ9
	 Bn1lp5v0PDqdN8m8x/qNFn+T/08JTERYtpgw6hZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729761AbfKKSyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:54:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:49664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730372AbfKKSyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:54:08 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5F8A21655;
        Mon, 11 Nov 2019 18:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573498447;
        bh=3We5enV7MlKPPpIE/WlLtKgeM9KV3gZm3dvrTQOWq4U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pTpuvYJjux83Z19Nid0IlsHavbmLaqLtY96hpZxuVHzRNh9U4Vz57KdSdSe81ck/m
         /rHQ5hSczhC2PmxhTMWWrEM3gv7Ykp2ich7pPIhYITezXTPbYvDRLS6vAlQ7w7U+os
         6O9Y1FD/DZtRbP1/kGHpu73by1tPAhSh7H/QsaOw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Luca Coelho <luciano.coelho@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 123/193] iwlwifi: pcie: 0x2720 is qu and 0x30DC is not
Date:   Mon, 11 Nov 2019 19:28:25 +0100
Message-Id: <20191111181510.246800369@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181459.850623879@linuxfoundation.org>
References: <20191111181459.850623879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

[ Upstream commit 17c216ed6b9eef34e647192063f6149d33eff579 ]

When converting the wrong qu configurations in an earlier commit, I
accidentally swapped 0x2720 and 0x30DC.  Instead of converting 0x2720,
I converted 0x30DC.  Undo 0x30DC and convert 0x2720.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 109 +++++++++---------
 1 file changed, 55 insertions(+), 54 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 3645c98c407e1..2ee5c5dc78cbb 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -618,60 +618,61 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x271B, 0x0210, iwl9160_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x271B, 0x0214, iwl9260_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x271C, 0x0214, iwl9260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x2720, 0x0034, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x2720, 0x0038, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x2720, 0x003C, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x2720, 0x0060, iwl9461_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x2720, 0x0064, iwl9461_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x2720, 0x00A0, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x2720, 0x00A4, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x2720, 0x0230, iwl9560_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x2720, 0x0234, iwl9560_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x2720, 0x0238, iwl9560_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x2720, 0x023C, iwl9560_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x2720, 0x0260, iwl9461_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x2720, 0x0264, iwl9461_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x2720, 0x02A0, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x2720, 0x02A4, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x2720, 0x1010, iwl9260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x2720, 0x1030, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x2720, 0x1210, iwl9260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x2720, 0x1551, iwl9560_killer_s_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x2720, 0x1552, iwl9560_killer_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x2720, 0x2030, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x2720, 0x2034, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x2720, 0x4030, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x2720, 0x4034, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x2720, 0x40A4, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x2720, 0x4234, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x2720, 0x42A4, iwl9462_2ac_cfg_soc)},
-
-	{IWL_PCI_DEVICE(0x30DC, 0x0030, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x30DC, 0x0034, iwl9560_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x30DC, 0x0038, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x30DC, 0x003C, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x30DC, 0x0060, iwl9461_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x30DC, 0x0064, iwl9461_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x30DC, 0x00A0, iwl9462_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x30DC, 0x00A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x30DC, 0x0230, iwl9560_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x30DC, 0x0234, iwl9560_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x30DC, 0x0238, iwl9560_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x30DC, 0x023C, iwl9560_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x30DC, 0x0260, iwl9461_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x30DC, 0x0264, iwl9461_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x30DC, 0x02A0, iwl9462_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x30DC, 0x02A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x30DC, 0x1030, iwl9560_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x30DC, 0x1551, killer1550s_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x30DC, 0x1552, killer1550i_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x30DC, 0x2030, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x30DC, 0x2034, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x30DC, 0x4030, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x30DC, 0x4034, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x30DC, 0x40A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x30DC, 0x4234, iwl9560_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x30DC, 0x42A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
+
+	{IWL_PCI_DEVICE(0x2720, 0x0034, iwl9560_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x2720, 0x0038, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x2720, 0x003C, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x2720, 0x0060, iwl9461_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x2720, 0x0064, iwl9461_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x2720, 0x00A0, iwl9462_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x2720, 0x00A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x2720, 0x0230, iwl9560_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x2720, 0x0234, iwl9560_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x2720, 0x0238, iwl9560_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x2720, 0x023C, iwl9560_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x2720, 0x0260, iwl9461_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x2720, 0x0264, iwl9461_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x2720, 0x02A0, iwl9462_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x2720, 0x02A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x2720, 0x1030, iwl9560_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x2720, 0x1551, killer1550s_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x2720, 0x1552, killer1550i_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x2720, 0x2030, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x2720, 0x2034, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x2720, 0x4030, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x2720, 0x4034, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x2720, 0x40A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x2720, 0x4234, iwl9560_2ac_cfg_qu_b0_jf_b0)},
+	{IWL_PCI_DEVICE(0x2720, 0x42A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
+
+	{IWL_PCI_DEVICE(0x30DC, 0x0030, iwl9560_2ac_160_cfg_soc)},
+	{IWL_PCI_DEVICE(0x30DC, 0x0034, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x30DC, 0x0038, iwl9560_2ac_160_cfg_soc)},
+	{IWL_PCI_DEVICE(0x30DC, 0x003C, iwl9560_2ac_160_cfg_soc)},
+	{IWL_PCI_DEVICE(0x30DC, 0x0060, iwl9460_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x30DC, 0x0064, iwl9461_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x30DC, 0x00A0, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x30DC, 0x00A4, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x30DC, 0x0230, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x30DC, 0x0234, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x30DC, 0x0238, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x30DC, 0x023C, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x30DC, 0x0260, iwl9461_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x30DC, 0x0264, iwl9461_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x30DC, 0x02A0, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x30DC, 0x02A4, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x30DC, 0x1010, iwl9260_2ac_cfg)},
+	{IWL_PCI_DEVICE(0x30DC, 0x1030, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x30DC, 0x1210, iwl9260_2ac_cfg)},
+	{IWL_PCI_DEVICE(0x30DC, 0x1551, iwl9560_killer_s_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x30DC, 0x1552, iwl9560_killer_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x30DC, 0x2030, iwl9560_2ac_160_cfg_soc)},
+	{IWL_PCI_DEVICE(0x30DC, 0x2034, iwl9560_2ac_160_cfg_soc)},
+	{IWL_PCI_DEVICE(0x30DC, 0x4030, iwl9560_2ac_160_cfg_soc)},
+	{IWL_PCI_DEVICE(0x30DC, 0x4034, iwl9560_2ac_160_cfg_soc)},
+	{IWL_PCI_DEVICE(0x30DC, 0x40A4, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x30DC, 0x4234, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x30DC, 0x42A4, iwl9462_2ac_cfg_soc)},
 
 	{IWL_PCI_DEVICE(0x31DC, 0x0030, iwl9560_2ac_160_cfg_shared_clk)},
 	{IWL_PCI_DEVICE(0x31DC, 0x0034, iwl9560_2ac_cfg_shared_clk)},
-- 
2.20.1



