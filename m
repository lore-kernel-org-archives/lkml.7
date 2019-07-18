Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D81EC7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 02:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 321A72173B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 02:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fredlawl-com.20150623.gappssmtp.com header.i=@fredlawl-com.20150623.gappssmtp.com header.b="mTXnqU5j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387444AbfGRCIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 22:08:51 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34803 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbfGRCIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 22:08:51 -0400
Received: by mail-oi1-f196.google.com with SMTP id l12so20243088oil.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 19:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fredlawl-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pYIGokAnHiTaXGPTQHk0GqCr5VmgXxhysOu7yDy4mE8=;
        b=mTXnqU5jjT+d2PiAwqfS+oHZeBwddIfIzbgwJr5HJVj8OZu3Ejhi+A9hQAi3E1QXSB
         p6yso+LASKDHoVMvrSZNUJW8Qr/lVybvydLGLZG3dAWCnsQe9rQVN9QPaP7cXSOOm7xG
         WeqBJrZ7jJE0djFZh+4thTZM1/E0H6ZFc4+kAD5x48/AIdMh8SWZL9dZtCJBm9OVm3eH
         hJBKA/kvNzNJnG5RfU9oPb10jIKyI3UyWzoAX2uJ9/ndXvbz/1w5O7at+bEgY29vT8Un
         cx5tgXraKzGDqNnRvqxLNfVGtKJDyu6t+DvKjYCl0HBdgLrZT/IlUcw4u2gwiB4nTnZ7
         vcMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pYIGokAnHiTaXGPTQHk0GqCr5VmgXxhysOu7yDy4mE8=;
        b=rt0Y06bkqGIc37A3c7CNvhipXZWj+K7iEoinDbbF9UT3mY+2NzYwV5ZWtGmxVaR/Pg
         Rb7LhE+BOU4dpziNZW96Eg4uF2BoSOjOsyQN91wvQB6iuR8SGA0YTrze8uQcsjJaAKDO
         Nh75REGt3Uzh0y7W6FgY/GkunCpSg2UpFZdu7ovb3BGEvYCl7iBjzQmZJNWvBk89r96n
         TotS8We0WTC1XBlhGaPYzbkUJsCovYHp9ZtLUncyjKcLP6ARtpr6LDcpFz7eVyFZlyV7
         ivWBrIAuwJOVbiN5wyimDjVabPqn/lMQipK1tPvr4SXw3Jh4ODir/WdWOFiL0O1m2UZV
         ov1Q==
X-Gm-Message-State: APjAAAUh0rkssYfdva3BT3IyJ+40xuDX7W3YmmGr2n9dnFrLyX6MzvjK
        65fpqXY1FJ5Kt/5PWcRmMXk=
X-Google-Smtp-Source: APXvYqyU0Pfb/5vUCO66TmKbYlCzgLlHqd41g6a+kdgNWxNg9gHANJ35Dgn3P91SIentrM9mHXMU4w==
X-Received: by 2002:aca:382:: with SMTP id 124mr19829874oid.80.1563415730827;
        Wed, 17 Jul 2019 19:08:50 -0700 (PDT)
Received: from linux.fredlawl.com ([2600:1700:18a0:11d0:18af:e893:6cb0:139a])
        by smtp.gmail.com with ESMTPSA id 93sm9102146ota.77.2019.07.17.19.08.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 19:08:50 -0700 (PDT)
From:   Frederick Lawler <fred@fredlawl.com>
To:     jeffrey.t.kirsher@intel.com
Cc:     Frederick Lawler <fred@fredlawl.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhelgaas@google.com
Subject: [PATCH] igc: Prefer pcie_capability_read_word()
Date:   Wed, 17 Jul 2019 21:07:39 -0500
Message-Id: <20190718020745.8867-4-fred@fredlawl.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190718020745.8867-1-fred@fredlawl.com>
References: <20190718020745.8867-1-fred@fredlawl.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8c0d3a02c130 ("PCI: Add accessors for PCI Express Capability")
added accessors for the PCI Express Capability so that drivers didn't
need to be aware of differences between v1 and v2 of the PCI
Express Capability.

Replace pci_read_config_word() and pci_write_config_word() calls with
pcie_capability_read_word() and pcie_capability_write_word().

Signed-off-by: Frederick Lawler <fred@fredlawl.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 34fa0e60a780..8e8ad07a5776 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -3891,13 +3891,11 @@ void igc_write_pci_cfg(struct igc_hw *hw, u32 reg, u16 *value)
 s32 igc_read_pcie_cap_reg(struct igc_hw *hw, u32 reg, u16 *value)
 {
 	struct igc_adapter *adapter = hw->back;
-	u16 cap_offset;
 
-	cap_offset = pci_find_capability(adapter->pdev, PCI_CAP_ID_EXP);
-	if (!cap_offset)
+	if (!pci_is_pcie(adapter->pdev))
 		return -IGC_ERR_CONFIG;
 
-	pci_read_config_word(adapter->pdev, cap_offset + reg, value);
+	pcie_capability_read_word(adapter->pdev, reg, value);
 
 	return IGC_SUCCESS;
 }
@@ -3905,13 +3903,11 @@ s32 igc_read_pcie_cap_reg(struct igc_hw *hw, u32 reg, u16 *value)
 s32 igc_write_pcie_cap_reg(struct igc_hw *hw, u32 reg, u16 *value)
 {
 	struct igc_adapter *adapter = hw->back;
-	u16 cap_offset;
 
-	cap_offset = pci_find_capability(adapter->pdev, PCI_CAP_ID_EXP);
-	if (!cap_offset)
+	if (!pci_is_pcie(adapter->pdev))
 		return -IGC_ERR_CONFIG;
 
-	pci_write_config_word(adapter->pdev, cap_offset + reg, *value);
+	pcie_capability_write_word(adapter->pdev, reg, *value);
 
 	return IGC_SUCCESS;
 }
-- 
2.17.1

