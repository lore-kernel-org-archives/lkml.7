Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEF0C00454
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B382073B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576013036;
	bh=njjDUTgh+3uYkyHWL/u2VaDdv36+V/DkVM3Km0gjKtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zQ6nBqtrmIxxrUA3TcppbuCuRTN3Ynq/TRB6qWVg+hL00ACSV0wttQ4dsaJT/eoQP
	 DbEByjBF8V4HhEX/0pOchqUOTxSAZEq69wxNe4sPCvJTGX5R3fh162OvfGDVTpwKd+
	 ef27+/o9QFsl+l6ILKfOQDu4Cd7kWxddfk5Qrqtk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbfLJVLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:11:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:32782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728190AbfLJVKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:10:47 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9ECC246C0;
        Tue, 10 Dec 2019 21:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012246;
        bh=njjDUTgh+3uYkyHWL/u2VaDdv36+V/DkVM3Km0gjKtA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BtU5ozbZJmkaTzYJLVzRFNqogG0e2/Pelwh74w7DMpwQNxWjmkRnlP2UnUJfR6RcM
         l53YaatE1A0dOxOJqSybfH+Nrtv0vo1ymSshuJAiolP7/IMU9jjlu7fRmTZf3MU8O5
         nDbqfeEy2CInAk/BQ1RQD6UaS49f+YiRN/WlUG68=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Johan Hedberg <johan.hedberg@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 194/350] Bluetooth: Fix advertising duplicated flags
Date:   Tue, 10 Dec 2019 16:04:59 -0500
Message-Id: <20191210210735.9077-155-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 6012b9346d8959194c239fd60a62dfec98d43048 ]

Instances may have flags set as part of its data in which case the code
should not attempt to add it again otherwise it can cause duplication:

< HCI Command: LE Set Extended Advertising Data (0x08|0x0037) plen 35
        Handle: 0x00
        Operation: Complete extended advertising data (0x03)
        Fragment preference: Minimize fragmentation (0x01)
        Data length: 0x06
        Flags: 0x04
          BR/EDR Not Supported
        Flags: 0x06
          LE General Discoverable Mode
          BR/EDR Not Supported

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_request.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 7f6a581b5b7e1..3d25dbf10b26f 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1273,6 +1273,14 @@ static u8 create_instance_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
 
 	instance_flags = get_adv_instance_flags(hdev, instance);
 
+	/* If instance already has the flags set skip adding it once
+	 * again.
+	 */
+	if (adv_instance && eir_get_data(adv_instance->adv_data,
+					 adv_instance->adv_data_len, EIR_FLAGS,
+					 NULL))
+		goto skip_flags;
+
 	/* The Add Advertising command allows userspace to set both the general
 	 * and limited discoverable flags.
 	 */
@@ -1305,6 +1313,7 @@ static u8 create_instance_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
 		}
 	}
 
+skip_flags:
 	if (adv_instance) {
 		memcpy(ptr, adv_instance->adv_data,
 		       adv_instance->adv_data_len);
-- 
2.20.1

