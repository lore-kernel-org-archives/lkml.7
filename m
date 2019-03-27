Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9753EC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F6AA2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553714109;
	bh=92zrjK9+2OxQcwL86HWfOxqPvfxC31dI70oNFNOH2VA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rCpd6hxm95rMdIJo63R/fLJ4nBURhMaR3AzBRVk4dT1cSsrSYUZ9LcwJagPAf1OIT
	 70bdqhMu+tFdy0BrmobIhUABDMyCvJgammkknxX6anZE/SmGdPGARwNE60r4MpyX1P
	 v7RvFHoTUEzLIyl9t5aASBmbJaN/mfcq6wzRi0Q8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387874AbfC0SJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:09:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:51122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388538AbfC0SJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:09:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8E762063F;
        Wed, 27 Mar 2019 18:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710157;
        bh=92zrjK9+2OxQcwL86HWfOxqPvfxC31dI70oNFNOH2VA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GP06BADXhNoAUXKJEkHEI2ReMVit3ntLFf+L72oA9wdOcffm8b/ZRkZxpRG5kLkGj
         jVEi1mLYsaAUkHqu7jsJcPaGeapgbz0WjPCgfXBL8iqIsXZj2xY7cn1xtRGDhG7zvV
         Q+tHlh01VS+MitvdpmTWnlgejnb+tLOz5Do13wSw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Myungho Jung <mhjungk@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 225/262] Bluetooth: hci_uart: Check if socket buffer is ERR_PTR in h4_recv_buf()
Date:   Wed, 27 Mar 2019 14:01:20 -0400
Message-Id: <20190327180158.10245-225-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
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

