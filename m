Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8999BC2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 627F6206A4
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577641650;
	bh=LLK2WDRQKpbT89PAW7GOLuuF7OI6LutJI+T83UbbLN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QjbSwsOZbL9dIf2K/EHBc4Z68UWavXWvWgqE1z10A/MBKbOlVzQrx/4paN9YosJyh
	 RGx2R6MCiRTaw/yGZMIaDFVOSZY9oDhsyNfGOWg0sTfFI5LahrXlOMbIzPjXVlh7Uj
	 LsAsrRs/zhpQBnddrO9yI1NFQxz7/IP5FaTx29Zs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730796AbfL2Rr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:47:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:58052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731262AbfL2Rr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:47:26 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C920A20718;
        Sun, 29 Dec 2019 17:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577641646;
        bh=LLK2WDRQKpbT89PAW7GOLuuF7OI6LutJI+T83UbbLN0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cdwydremUIM9nQLRQ1IgQw6El6DDfQVMFrXr85e33rDZEM4iJS75W/pE7967MVXT+
         bFDRXfMtdfVSJRhHv6qKFpzqri5JRuIX4Q5iVJ9lPjZCVGoGHJpZa/6ujeN6Tt4OC5
         HD/BI5d586AKahIJFRz/kwv30Ykb/knjWYSleBts=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Dooks <ben.dooks@codethink.co.uk>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 153/434] Bluetooth: missed cpu_to_le16 conversion in hci_init4_req
Date:   Sun, 29 Dec 2019 18:23:26 +0100
Message-Id: <20191229172711.921929480@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Dooks (Codethink) <ben.dooks@codethink.co.uk>

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
index 04bc79359a17..b2559d4bed81 100644
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



