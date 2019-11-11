Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A66C17445
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0A7621783
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573498444;
	bh=hVBubz4rwFYa5gB824UlUc8aIPHfTaoH42m9peRe0Po=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ioSq2Nr5rAFhhDe3A1Ib0d//M0iZ2vwU6zPZIUWhipArEjJ35rogFvU8aV3Fc18lI
	 vgSG0ObyipOEjEzecOxti7+Ot5dW/EynRZ+MFSQjAeyFW9XOepv2eygTUVjweliNTS
	 FP+pUyecB4SIGd6Ao9W8PKCHaKMwTVxeDhjFFqE0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730451AbfKKSyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:54:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:49378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729714AbfKKSyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:54:00 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A76920818;
        Mon, 11 Nov 2019 18:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573498439;
        bh=hVBubz4rwFYa5gB824UlUc8aIPHfTaoH42m9peRe0Po=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D8oowhJ4AA1Zk8EOz5nsXL5Jd58XCCB9CFfmbMCHGeXMSPOZAvppewuPXhuvixEH5
         GrCxcTVjqyGHl602QJ7kgSZD9qFZPl9GgETqaIDlNFlTx5S/4QKHbEtfGEmkboGzjD
         f7hoU4ZfJuB37/Njr7vpXc7t1g/Fi3L8E9DDlPWE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Luca Coelho <luciano.coelho@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 121/193] iwlwifi: pcie: fix PCI ID 0x2720 configs that should be soc
Date:   Mon, 11 Nov 2019 19:28:23 +0100
Message-Id: <20191111181510.101991723@linuxfoundation.org>
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

[ Upstream commit 6dea7da7019aa04c02edf1878c9c2e59d6cb75a5 ]

Some entries for PCI ID 0x2720 were using iwl9260_2ac_cfg, but the
correct is to use iwl9260_2ac_cfg_soc.  Fix that.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index acbadfdbdd3fe..cef29de053932 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -618,9 +618,9 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x271B, 0x0210, iwl9160_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x271B, 0x0214, iwl9260_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x271C, 0x0214, iwl9260_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x2720, 0x0034, iwl9560_2ac_160_cfg)},
-	{IWL_PCI_DEVICE(0x2720, 0x0038, iwl9560_2ac_160_cfg)},
-	{IWL_PCI_DEVICE(0x2720, 0x003C, iwl9560_2ac_160_cfg)},
+	{IWL_PCI_DEVICE(0x2720, 0x0034, iwl9560_2ac_160_cfg_soc)},
+	{IWL_PCI_DEVICE(0x2720, 0x0038, iwl9560_2ac_160_cfg_soc)},
+	{IWL_PCI_DEVICE(0x2720, 0x003C, iwl9560_2ac_160_cfg_soc)},
 	{IWL_PCI_DEVICE(0x2720, 0x0060, iwl9461_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x2720, 0x0064, iwl9461_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x2720, 0x00A0, iwl9462_2ac_cfg_soc)},
@@ -640,7 +640,7 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x2720, 0x1552, iwl9560_killer_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x2720, 0x2030, iwl9560_2ac_160_cfg_soc)},
 	{IWL_PCI_DEVICE(0x2720, 0x2034, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x2720, 0x4030, iwl9560_2ac_160_cfg)},
+	{IWL_PCI_DEVICE(0x2720, 0x4030, iwl9560_2ac_160_cfg_soc)},
 	{IWL_PCI_DEVICE(0x2720, 0x4034, iwl9560_2ac_160_cfg_soc)},
 	{IWL_PCI_DEVICE(0x2720, 0x40A4, iwl9462_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x2720, 0x4234, iwl9560_2ac_cfg_soc)},
-- 
2.20.1



