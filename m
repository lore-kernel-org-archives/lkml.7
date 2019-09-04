Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F827C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E725122CEA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620001;
	bh=QFhZUAq6CUY2ejbNoS/Xrn+mjYw8ZHmVgo0Cfwif+tc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FelDP5FNd0ACML/e2RHIA9Dz3ChlsjyGTgX6La5Is9bp5jbeHF9SjCKxCrm56E+G/
	 D4oB+F/UfTY2NbWuPOc6+6iRtOl/vBiSNIbRG4sj23oSJ48TJiY26qI+jzMLet19hj
	 VhOf/CJHQU2E00yDUl5HrEgyQybn+0jiygC0yumc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388330AbfIDR77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 13:59:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:38980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387925AbfIDR75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 13:59:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E181208E4;
        Wed,  4 Sep 2019 17:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567619996;
        bh=QFhZUAq6CUY2ejbNoS/Xrn+mjYw8ZHmVgo0Cfwif+tc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jpzvhgVyVPitBcqjpmm0gLV8fUGOAUle2JopEeuUb1fewHh8IB/uw3mM7Bke9wGTn
         NVXI8+cFTc1jzXxjJdj3gGUvYXInYeLnpzvVjWivBc5/Wbo2k1HzBXyxggIlzcNq4N
         ZGcVrPBFd90OTvBFr09xcviNuXDcqI2HbkCrelVQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 09/83] st_nci_hci_connectivity_event_received: null check the allocation
Date:   Wed,  4 Sep 2019 19:53:01 +0200
Message-Id: <20190904175304.671792079@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175303.488266791@linuxfoundation.org>
References: <20190904175303.488266791@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



