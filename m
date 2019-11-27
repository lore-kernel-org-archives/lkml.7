Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00365C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D0B20870
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574891053;
	bh=iIrIemM+N0M5lPeZn0XH1Xik9bRC7HEGUjRHqXeNVLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s0xigwV/4f03wbmjPt49ihEWUtD0WLansEtN3B5lkWsGSJpb+zJq9MzkoPIEFl0sw
	 lLuWxM0Hs1mF5+z1d77/hQC1WRVUgNhZWPTwJC5H24oUz72moJEhJN1CjmjkOJcl63
	 TKBGnmXVwrjsufmCS6FXRhB/0wB3cj82eYAsoRIs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbfK0Uhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:37:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:40974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728625AbfK0Uhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:37:47 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6504215A5;
        Wed, 27 Nov 2019 20:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887067;
        bh=iIrIemM+N0M5lPeZn0XH1Xik9bRC7HEGUjRHqXeNVLM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zF12eRsrZdepw1o1OSBfuyJWEDBqvY2si3ReajSlI3hjGGoD1aY19aiJXO730twDX
         of3K4kOZKvOZZ4tGctmUZ/tFDDL3T6WymTyzrCGVvIi4WdTjfVD/SF2RxMrOHu7RrQ
         Lm3iNftJZESsaUlqIOEtqM/9eTin/q7Nlyza74UY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomas Bortoli <tomasbortoli@gmail.com>,
        syzbot+a0d209a4676664613e76@syzkaller.appspotmail.com,
        Marcel Holtmann <marcel@holtmann.org>,
        Alexander Potapenko <glider@google.com>
Subject: [PATCH 4.4 099/132] Bluetooth: Fix invalid-free in bcsp_close()
Date:   Wed, 27 Nov 2019 21:31:30 +0100
Message-Id: <20191127203023.527104381@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127202857.270233486@linuxfoundation.org>
References: <20191127202857.270233486@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomas Bortoli <tomasbortoli@gmail.com>

commit cf94da6f502d8caecabd56b194541c873c8a7a3c upstream.

Syzbot reported an invalid-free that I introduced fixing a memleak.

bcsp_recv() also frees bcsp->rx_skb but never nullifies its value.
Nullify bcsp->rx_skb every time it is freed.

Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
Reported-by: syzbot+a0d209a4676664613e76@syzkaller.appspotmail.com
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Cc: Alexander Potapenko <glider@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/bluetooth/hci_bcsp.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/bluetooth/hci_bcsp.c
+++ b/drivers/bluetooth/hci_bcsp.c
@@ -566,6 +566,7 @@ static int bcsp_recv(struct hci_uart *hu
 			if (*ptr == 0xc0) {
 				BT_ERR("Short BCSP packet");
 				kfree_skb(bcsp->rx_skb);
+				bcsp->rx_skb = NULL;
 				bcsp->rx_state = BCSP_W4_PKT_START;
 				bcsp->rx_count = 0;
 			} else
@@ -581,6 +582,7 @@ static int bcsp_recv(struct hci_uart *hu
 					bcsp->rx_skb->data[2])) != bcsp->rx_skb->data[3]) {
 				BT_ERR("Error in BCSP hdr checksum");
 				kfree_skb(bcsp->rx_skb);
+				bcsp->rx_skb = NULL;
 				bcsp->rx_state = BCSP_W4_PKT_DELIMITER;
 				bcsp->rx_count = 0;
 				continue;
@@ -615,6 +617,7 @@ static int bcsp_recv(struct hci_uart *hu
 					bscp_get_crc(bcsp));
 
 				kfree_skb(bcsp->rx_skb);
+				bcsp->rx_skb = NULL;
 				bcsp->rx_state = BCSP_W4_PKT_DELIMITER;
 				bcsp->rx_count = 0;
 				continue;


