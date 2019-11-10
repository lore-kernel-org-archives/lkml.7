Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F028C17440
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5740E21D7E
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573353914;
	bh=r64Ku2WpgWZ33C/ouKN9RgAuvGGM6d+Ynye61UfTUIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xQEmFAmzEvYTd847dlMvUcywURSJ5pjwZYBunOdtoUF2uwUp5xd/XqRo+g/WVoHYC
	 B+zqKAmZhxXBr59Kmr+9q1NOj2RWUHCnmIaC7J/AcbietstZU19y7XzH0VbG27ik5r
	 pUYLsPdEKRW7dWc0O/uN/UFJT6xTs0r8B9jrzSd8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbfKJCpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 21:45:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:44142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727585AbfKJCog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:44:36 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D57721655;
        Sun, 10 Nov 2019 02:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573353875;
        bh=r64Ku2WpgWZ33C/ouKN9RgAuvGGM6d+Ynye61UfTUIw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gfYPUb1iz3k4vnUSbDZ7ogTd6QxwrmaYkV6Rr1jb1d28U+ZUzpns4TabVSYP7naq1
         WTbgpCasANM4VWN9/Bo4gkSymGwwvBB6w8mvFaf2HV/K5kx3E4kuxaQOBn9jGCO1C2
         G0ltCabgoc+HdpTeq5wMIX99UMI5rYs39FG54bvU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 154/191] Bluetooth: L2CAP: Detect if remote is not able to use the whole MPS
Date:   Sat,  9 Nov 2019 21:39:36 -0500
Message-Id: <20191110024013.29782-154-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024013.29782-1-sashal@kernel.org>
References: <20191110024013.29782-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit a5c3021bb62b970713550db3f7fd08aa70665d7e ]

If the remote is not able to fully utilize the MPS choosen recalculate
the credits based on the actual amount it is sending that way it can
still send packets of MTU size without credits dropping to 0.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/l2cap_core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 260ef5426e0ca..974c1b8a689c1 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6819,6 +6819,16 @@ static int l2cap_le_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
 		chan->sdu_len = sdu_len;
 		chan->sdu_last_frag = skb;
 
+		/* Detect if remote is not able to use the selected MPS */
+		if (skb->len + L2CAP_SDULEN_SIZE < chan->mps) {
+			u16 mps_len = skb->len + L2CAP_SDULEN_SIZE;
+
+			/* Adjust the number of credits */
+			BT_DBG("chan->mps %u -> %u", chan->mps, mps_len);
+			chan->mps = mps_len;
+			l2cap_chan_le_send_credits(chan);
+		}
+
 		return 0;
 	}
 
-- 
2.20.1

