Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE56C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5429D21881
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566893020;
	bh=1KOunPuokLRF00R6WfX4KEPxteQidVVs3eZ39euy99g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sHA1hP+CAt6erqJNemZJ9fakbjsxuGTKHdmqKBMnOqN7vL0uzeXN7b5SjvONFqS/Q
	 0g/pcgIzrRXLFmoR1GN90QeAHo1bBbwKv6Fv4UgNC/WmscR6rl+/jG8X9R2XX9//Hu
	 2xFe8G2LNQ74YztXI8x0d67KiFLslrD08fy6LrYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732316AbfH0IDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:03:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:60994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732276AbfH0IDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:03:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F9A02189D;
        Tue, 27 Aug 2019 08:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566893013;
        bh=1KOunPuokLRF00R6WfX4KEPxteQidVVs3eZ39euy99g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KwAGke2zL7txTPRquX/ew/RqZ7VMfCuNxzx4aQnFm17pCrRHQb4jV6jKyeJ7R4DBq
         gXpu838n5GzM1g3CF+RKe7EIx+vFKXqJ8kQC8UTp1JvRDmrwRoD8ULD5dQUdwo58Z7
         zSw1bUjmBZjz/JMNb3ddd/i0DvryPuOnf+y79SKo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 089/162] net: cxgb3_main: Fix a resource leak in a error path in init_one()
Date:   Tue, 27 Aug 2019 09:50:17 +0200
Message-Id: <20190827072741.255456016@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827072738.093683223@linuxfoundation.org>
References: <20190827072738.093683223@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit debea2cd3193ac868289e8893c3a719c265b0612 ]

A call to 'kfree_skb()' is missing in the error handling path of
'init_one()'.
This is already present in 'remove_one()' but is missing here.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
index 1e82b9efe4471..58f89f6a040fe 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
@@ -3269,7 +3269,7 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (!adapter->regs) {
 		dev_err(&pdev->dev, "cannot map device registers\n");
 		err = -ENOMEM;
-		goto out_free_adapter;
+		goto out_free_adapter_nofail;
 	}
 
 	adapter->pdev = pdev;
@@ -3397,6 +3397,9 @@ out_free_dev:
 		if (adapter->port[i])
 			free_netdev(adapter->port[i]);
 
+out_free_adapter_nofail:
+	kfree_skb(adapter->nofail_skb);
+
 out_free_adapter:
 	kfree(adapter);
 
-- 
2.20.1



