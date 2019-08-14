Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A159AC32750
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F4DE20679
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565749738;
	bh=A959iDBz6axkDGYmFedeS7BeuaZ4FIDNHH7HQ1vGz1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=taIoVz2V/hG70ZHhaBKLimbLU1Q7Ch2k1CuR7LCG3yZnKoz9qps0qX5YrDSy3rjSD
	 dWQAcaiv3Ki1jEKzkCccBY4iSxtTgMh7AFB86ZBFazzAXwgFbSjMvDVcR8KwjKOeHE
	 5C3+EeFINck6s3FC7Cm0mAGwnbq4YqytDF+eWSTE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbfHNCXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 22:23:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:52642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729890AbfHNCXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:23:38 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DA7820679;
        Wed, 14 Aug 2019 02:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565749417;
        bh=A959iDBz6axkDGYmFedeS7BeuaZ4FIDNHH7HQ1vGz1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z9R0Iwi10Djq3nYv/jkbXMRRk8HZhL8E5hvZKPfUJmMgn5TdSWGfscEMylPIqRAvZ
         Frho5wbb+ATJz3Bd4BXV0gkird2057tPcsmnEbwtHF9uLTLN2BqZ8SV2w8Exj7+yNI
         k8tIKDf+1SZRVdRgibHyjjW/fs2MRS6jF8eW3xqk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 09/33] st_nci_hci_connectivity_event_received: null check the allocation
Date:   Tue, 13 Aug 2019 22:22:59 -0400
Message-Id: <20190814022323.17111-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814022323.17111-1-sashal@kernel.org>
References: <20190814022323.17111-1-sashal@kernel.org>
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
index 56f2112e0cd84..85df2e0093109 100644
--- a/drivers/nfc/st-nci/se.c
+++ b/drivers/nfc/st-nci/se.c
@@ -344,6 +344,8 @@ static int st_nci_hci_connectivity_event_received(struct nci_dev *ndev,
 
 		transaction = (struct nfc_evt_transaction *)devm_kzalloc(dev,
 					    skb->len - 2, GFP_KERNEL);
+		if (!transaction)
+			return -ENOMEM;
 
 		transaction->aid_len = skb->data[1];
 		memcpy(transaction->aid, &skb->data[2], transaction->aid_len);
-- 
2.20.1

