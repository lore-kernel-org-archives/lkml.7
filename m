Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591F1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21F09205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553713093;
	bh=92zrjK9+2OxQcwL86HWfOxqPvfxC31dI70oNFNOH2VA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1Co8a9KkxuajTW1tiCwzR2nE4BM4ihtV4Xb81ga723zVQ+fEUVatkIdKIS0G5JpYw
	 b6IyNnKYSciO/niavxAynMWaRHE4Qrie+XyKg7JauFHOnUblS6770Hh6KN9ygZWsVd
	 k9aEBrMephs7y3s4ZxHjD3Y4aNKsDpGeqJYeVr3g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390062AbfC0S6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:58:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:59330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389616AbfC0SPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:15:41 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3691D2082F;
        Wed, 27 Mar 2019 18:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710540;
        bh=92zrjK9+2OxQcwL86HWfOxqPvfxC31dI70oNFNOH2VA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M3CNlQauUzdBmzwAvwao2n2fQqUPqt36+zqYK6u7KyWXPQf3cKweiApigZLp0L543
         uV1c+12u1PFQwt4JyB/J9jO+SZo76mEl8PJkhpYm54Go7piUlCCW8vc/HURyOgDG4V
         FgJwc8vXLowufBeXruh992LGT9zN3xv/JyAohJ0o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Myungho Jung <mhjungk@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 166/192] Bluetooth: hci_uart: Check if socket buffer is ERR_PTR in h4_recv_buf()
Date:   Wed, 27 Mar 2019 14:09:58 -0400
Message-Id: <20190327181025.13507-166-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Myungho Jung <mhjungk@gmail.com>

[ Upstream commit 1dc2d785156cbdc80806c32e8d2c7c735d0b4721 ]

h4_recv_buf() callers store the return value to socket buffer and
recursively pass the buffer to h4_recv_buf() without protection. So,
ERR_PTR returned from h4_recv_buf() can be dereferenced, if called again
before setting the socket buffer to NULL from previous error. Check if
skb is ERR_PTR in h4_recv_buf().

Reported-by: syzbot+017a32f149406df32703@syzkaller.appspotmail.com
Signed-off-by: Myungho Jung <mhjungk@gmail.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/h4_recv.h | 4 ++++
 drivers/bluetooth/hci_h4.c  | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/bluetooth/h4_recv.h b/drivers/bluetooth/h4_recv.h
index b432651f8236..307d82166f48 100644
--- a/drivers/bluetooth/h4_recv.h
+++ b/drivers/bluetooth/h4_recv.h
@@ -60,6 +60,10 @@ static inline struct sk_buff *h4_recv_buf(struct hci_dev *hdev,
 					  const struct h4_recv_pkt *pkts,
 					  int pkts_count)
 {
+	/* Check for error from previous call */
+	if (IS_ERR(skb))
+		skb = NULL;
+
 	while (count) {
 		int i, len;
 
diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
index fb97a3bf069b..5d97d77627c1 100644
--- a/drivers/bluetooth/hci_h4.c
+++ b/drivers/bluetooth/hci_h4.c
@@ -174,6 +174,10 @@ struct sk_buff *h4_recv_buf(struct hci_dev *hdev, struct sk_buff *skb,
 	struct hci_uart *hu = hci_get_drvdata(hdev);
 	u8 alignment = hu->alignment ? hu->alignment : 1;
 
+	/* Check for error from previous call */
+	if (IS_ERR(skb))
+		skb = NULL;
+
 	while (count) {
 		int i, len;
 
-- 
2.19.1

