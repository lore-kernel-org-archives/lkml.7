Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A271FC41514
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FD8E20828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566892627;
	bh=I2smVJliUFII8oEaC9GY5BqS7YV28ykYbm5vJwOO2Xw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bp7F724JsaQzvef2hTRDNtgSw2TPXVzPol99BcU2uaDuXL92neiKG8EWJRZCimhaR
	 n7AEVewc0vrFjq49Wv0HFxSNS0w3bn0TvN608devpQ9l17fYkkU2fYL8xTIr3aAKx/
	 Owt5gUuZ/Z3U3MiMJ47pzcZizmRyAZGWtm8zT/dA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730749AbfH0H5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 03:57:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:49196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730731AbfH0H5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:57:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B989206BA;
        Tue, 27 Aug 2019 07:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566892621;
        bh=I2smVJliUFII8oEaC9GY5BqS7YV28ykYbm5vJwOO2Xw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mbEFoNq1qt0oA0gXXWELfWdvKIYODchcB3BXd4q/9b+g+dlCZXWRxTHSCnDt3mRoC
         8kxayvOrT9mrprEJfGIurGn4EeH9mdnTT6Zl31/u8Jvh5JB9+k+3MTO4ZgddWiZaHX
         gTVep+8qQ+GenoYqBKWlpJ6//mlhdkFaV+WmAOU8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 16/98] st_nci_hci_connectivity_event_received: null check the allocation
Date:   Tue, 27 Aug 2019 09:49:55 +0200
Message-Id: <20190827072719.170733598@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827072718.142728620@linuxfoundation.org>
References: <20190827072718.142728620@linuxfoundation.org>
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
index f55d082ace715..5d6e7e931bc6c 100644
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



