Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3686C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FD93205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576013512;
	bh=3VioIPXcwSHgv1LxAJxjtKwmHJCLok8lLIgAF8k9yIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CNrk210X3HzM+dnZptva8MTR5J7HGrPlsNfVaWjUTELgaGlZEdyH8kg6eNZyTs3iF
	 OwQmnMyvxABubtssx0NScyv7eNJnR6nXxIS44NfflE+6LgEl8CyBTzz+bkoLf3ntx0
	 sbE/w4/bZnskVVnLrVtcK3en8+Tpgsh4ZnLg8z/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbfLJVJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:09:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:57582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728092AbfLJVJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:09:17 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A96924699;
        Tue, 10 Dec 2019 21:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012157;
        bh=3VioIPXcwSHgv1LxAJxjtKwmHJCLok8lLIgAF8k9yIk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=psdz+E/U3EkQ1FG7Z0Xtmmer1UOyv9OV/9GJmrISqaLChMDDYcta6ncDtCefko2NV
         zexPf/ULIbMV2rYPWoOlw5zJpsB8eJiGgqNdwMVRWV7EaqnWChy3CTI59ivHTiYMVz
         zXn1ZvgMbuU7JSCnR0Q7/UvFF3mZI+N0gtcLGZiE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 119/350] Bluetooth: missed cpu_to_le16 conversion in hci_init4_req
Date:   Tue, 10 Dec 2019 16:03:44 -0500
Message-Id: <20191210210735.9077-80-sashal@kernel.org>
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

From: "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>

[ Upstream commit 727ea61a5028f8ac96f75ab34cb1b56e63fd9227 ]

It looks like in hci_init4_req() the request is being
initialised from cpu-endian data but the packet is specified
to be little-endian. This causes an warning from sparse due
to __le16 to u16 conversion.

Fix this by using cpu_to_le16() on the two fields in the packet.

net/bluetooth/hci_core.c:845:27: warning: incorrect type in assignment (different base types)
net/bluetooth/hci_core.c:845:27:    expected restricted __le16 [usertype] tx_len
net/bluetooth/hci_core.c:845:27:    got unsigned short [usertype] le_max_tx_len
net/bluetooth/hci_core.c:846:28: warning: incorrect type in assignment (different base types)
net/bluetooth/hci_core.c:846:28:    expected restricted __le16 [usertype] tx_time
net/bluetooth/hci_core.c:846:28:    got unsigned short [usertype] le_max_tx_time

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 04bc79359a173..b2559d4bed815 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -842,8 +842,8 @@ static int hci_init4_req(struct hci_request *req, unsigned long opt)
 	if (hdev->le_features[0] & HCI_LE_DATA_LEN_EXT) {
 		struct hci_cp_le_write_def_data_len cp;
 
-		cp.tx_len = hdev->le_max_tx_len;
-		cp.tx_time = hdev->le_max_tx_time;
+		cp.tx_len = cpu_to_le16(hdev->le_max_tx_len);
+		cp.tx_time = cpu_to_le16(hdev->le_max_tx_time);
 		hci_req_add(req, HCI_OP_LE_WRITE_DEF_DATA_LEN, sizeof(cp), &cp);
 	}
 
-- 
2.20.1

