Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7FDC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA9E20679
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565749692;
	bh=odyyBf1dcWt2aZKz2xOzM8oQC9QXlBKynRcu4KRY/u8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R3OB3iHrqj5EavyyOhgwtSpF5Rkscb8c6YloiV1pDxYggOaA7VlZ45lvgUxy/vUno
	 vWwKDKrAmyEAVujzl0XCtbNpUkAsarw58WOHLElSGBawWcd9x8oTUc2cI75XkNKJ06
	 X35e/iTH3I178b3V/5fzJnesP8SKmnyeKd18Emac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbfHNC0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 22:26:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:54160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730097AbfHNC0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:26:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 246D820842;
        Wed, 14 Aug 2019 02:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565749561;
        bh=odyyBf1dcWt2aZKz2xOzM8oQC9QXlBKynRcu4KRY/u8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iz7DKMWurab3WFx8KJDGpxnaiBHO7kesSahD31ioH/h0ThZR3QSjqCc8ddZBFvKcl
         3b2+RFKfe4AEnoqX6wXeOmKt+12kvkV+GdQTPkdFK/h/mf2Bwmfgr5i22zBWcZ+swp
         ji1S6hL1ydMr9nz3kZP5mzX8mh/tK3QQw5Olpnfs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 07/28] st21nfca_connectivity_event_received: null check the allocation
Date:   Tue, 13 Aug 2019 22:25:29 -0400
Message-Id: <20190814022550.17463-7-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814022550.17463-1-sashal@kernel.org>
References: <20190814022550.17463-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

[ Upstream commit 9891d06836e67324c9e9c4675ed90fc8b8110034 ]

devm_kzalloc may fail and return null. So the null check is needed.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nfc/st21nfca/se.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nfc/st21nfca/se.c b/drivers/nfc/st21nfca/se.c
index c79d99b24c961..f1b96b5255e08 100644
--- a/drivers/nfc/st21nfca/se.c
+++ b/drivers/nfc/st21nfca/se.c
@@ -327,6 +327,8 @@ int st21nfca_connectivity_event_received(struct nfc_hci_dev *hdev, u8 host,
 
 		transaction = (struct nfc_evt_transaction *)devm_kzalloc(dev,
 						   skb->len - 2, GFP_KERNEL);
+		if (!transaction)
+			return -ENOMEM;
 
 		transaction->aid_len = skb->data[1];
 		memcpy(transaction->aid, &skb->data[2],
-- 
2.20.1

