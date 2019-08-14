Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BEEC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CDE92084F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565750298;
	bh=FI8bcXi9qUd0+dW7z3SAZPdzSJ0ljpA0yLshoH8UWVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=av82nZRZqobiIlihITmLuPyxWO2odKTXFydaXvNdYa8IK0SgJVeVAce3Jky48M9gJ
	 QQwzx6apxxsVig1ZyP4SAHhNs/OiE+0ceQ0f9UgdEt5dzo98IFm3emBWXAqCshUoIw
	 4CjGuQyrg+ar0olc4AnMDozUmss8NaWiGfG5MUjc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbfHNCiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 22:38:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:44582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727157AbfHNCM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:12:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C9D020842;
        Wed, 14 Aug 2019 02:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565748749;
        bh=FI8bcXi9qUd0+dW7z3SAZPdzSJ0ljpA0yLshoH8UWVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HPR503rqiTc08S4uEOU3ZLQxgTKaYDiEvxag4cIxEF3CvcmI945LvVgszqBgpEYaE
         MnfuLrbwR+E2pCVH0IjskR/OcP139S8VVihHNYJnUxWCtzXWjC10hS6ySx1js2gi0i
         T1HXnpyYPo1B8tUJvLi3exTpWMlAy3ay1zUG6Bm8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 044/123] st_nci_hci_connectivity_event_received: null check the allocation
Date:   Tue, 13 Aug 2019 22:09:28 -0400
Message-Id: <20190814021047.14828-44-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814021047.14828-1-sashal@kernel.org>
References: <20190814021047.14828-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

[ Upstream commit 3008e06fdf0973770370f97d5f1fba3701d8281d ]

devm_kzalloc may fail and return NULL. So the null check is needed.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nfc/st-nci/se.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nfc/st-nci/se.c b/drivers/nfc/st-nci/se.c
index c3e10b6ab3a4d..f25f1ec5f9e97 100644
--- a/drivers/nfc/st-nci/se.c
+++ b/drivers/nfc/st-nci/se.c
@@ -333,6 +333,8 @@ static int st_nci_hci_connectivity_event_received(struct nci_dev *ndev,
 
 		transaction = (struct nfc_evt_transaction *)devm_kzalloc(dev,
 					    skb->len - 2, GFP_KERNEL);
+		if (!transaction)
+			return -ENOMEM;
 
 		transaction->aid_len = skb->data[1];
 		memcpy(transaction->aid, &skb->data[2], transaction->aid_len);
-- 
2.20.1

