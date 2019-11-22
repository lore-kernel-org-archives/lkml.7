Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE491C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B61BD20659
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574402215;
	bh=WOoMctTv0hgR8uQA1LhoU2CPoGGUIvj+eV1wqxmsOjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YJE3u83q74GoUCBtOQMvtE1n1GG5on1BNYf/2GJNMCr1sCLrviUbpzCEoao9VLDs7
	 1fniapGVz6r18m42GZhBuTZ0FihcwV8FKcvFkiVGVbIvU2njPqN9zAeKRghr/bWAj+
	 z2JPFS2SN7FYmYsABjDz7b31Vx1CrwNAE71J/JA4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbfKVF4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 00:56:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:34670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729257AbfKVF4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:56:48 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04DB720717;
        Fri, 22 Nov 2019 05:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574402207;
        bh=WOoMctTv0hgR8uQA1LhoU2CPoGGUIvj+eV1wqxmsOjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1wy98YNuA/Dvr+5jtRufvd3oIAp66CY/WsRnWZdOFsvAQXXJb6vXBX/32R9xd1RC4
         x0FqllTwI72cAMtE6//CeT9SGkPcHgjwO+M01CIy/uiijEh2bxYAYWvFzF8FQLv4Oi
         4wml/vhcq3o3PF2Y0GuQi3jgnK71M4PQmnXNL674=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 056/127] Bluetooth: hci_bcm: Handle specific unknown packets after firmware loading
Date:   Fri, 22 Nov 2019 00:54:34 -0500
Message-Id: <20191122055544.3299-55-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122055544.3299-1-sashal@kernel.org>
References: <20191122055544.3299-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Bakker <xc-racer2@live.ca>

[ Upstream commit 22bba80500fdf624a7cfbb65fdfa97a038ae224d ]

The Broadcom controller on aries S5PV210 boards sends out a couple of
unknown packets after the firmware is loaded.  This will cause
logging of errors such as:
	Bluetooth: hci0: Frame reassembly failed (-84)

This is probably also the case with other boards, as there are related
Android userspace patches for custom ROMs such as
https://review.lineageos.org/#/c/LineageOS/android_system_bt/+/142721/
Since this appears to be intended behaviour, treated them as diagnostic
packets.

Note that this is another variant of commit 01d5e44ace8a
("Bluetooth: hci_bcm: Handle empty packet after firmware loading")

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/hci_bcm.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 6d41b2023f09d..61971ddbd2313 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -50,6 +50,12 @@
 #define BCM_LM_DIAG_PKT 0x07
 #define BCM_LM_DIAG_SIZE 63
 
+#define BCM_TYPE49_PKT 0x31
+#define BCM_TYPE49_SIZE 0
+
+#define BCM_TYPE52_PKT 0x34
+#define BCM_TYPE52_SIZE 0
+
 #define BCM_AUTOSUSPEND_DELAY	5000 /* default autosleep delay */
 
 /* platform device driver resources */
@@ -483,12 +489,28 @@ static int bcm_setup(struct hci_uart *hu)
 	.lsize = 0, \
 	.maxlen = BCM_NULL_SIZE
 
+#define BCM_RECV_TYPE49 \
+	.type = BCM_TYPE49_PKT, \
+	.hlen = BCM_TYPE49_SIZE, \
+	.loff = 0, \
+	.lsize = 0, \
+	.maxlen = BCM_TYPE49_SIZE
+
+#define BCM_RECV_TYPE52 \
+	.type = BCM_TYPE52_PKT, \
+	.hlen = BCM_TYPE52_SIZE, \
+	.loff = 0, \
+	.lsize = 0, \
+	.maxlen = BCM_TYPE52_SIZE
+
 static const struct h4_recv_pkt bcm_recv_pkts[] = {
 	{ H4_RECV_ACL,      .recv = hci_recv_frame },
 	{ H4_RECV_SCO,      .recv = hci_recv_frame },
 	{ H4_RECV_EVENT,    .recv = hci_recv_frame },
 	{ BCM_RECV_LM_DIAG, .recv = hci_recv_diag  },
 	{ BCM_RECV_NULL,    .recv = hci_recv_diag  },
+	{ BCM_RECV_TYPE49,  .recv = hci_recv_diag  },
+	{ BCM_RECV_TYPE52,  .recv = hci_recv_diag  },
 };
 
 static int bcm_recv(struct hci_uart *hu, const void *data, int count)
-- 
2.20.1

