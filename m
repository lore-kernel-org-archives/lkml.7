Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3DFC4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6AD82168B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568380584;
	bh=A1OEtCB6vF6AkWgRcCleL1BEUoTuRzPNYoc/GZtwK1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Bb4sKkbt8bJdI8sO/k6dCD3rzEmr+QWc9ZOZoBRIlYdr4M18vK0oBKboyOzQieMGT
	 dAgWd8FC//DTtBAOfpj7sbRYyUE7ETj2oYOR731ZEbO+XA9Yx8QAiIuRyey70b3Znm
	 zBtYGtm+w1N/tJHoYep6HJirtZmCeRBmh9Wy+JyA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389835AbfIMNQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:16:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:42912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389825AbfIMNQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:16:16 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D0BF20717;
        Fri, 13 Sep 2019 13:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380575;
        bh=A1OEtCB6vF6AkWgRcCleL1BEUoTuRzPNYoc/GZtwK1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WDf3l8xot3JAKdYXkM0MDwS7Qc06XTJqXtHXcMQY2FoJkPvRyEitR09IQWrG7yqXe
         6Qu0vAq7bQU+Nuy/ALwgXZhZK8O+GFE+oaVtxye3PuKL/C7Wozk2RysBOVu9zFyfbo
         EKG0Kt6xnb7ElhJgv604klNRZfGcVv48c0LWY4iw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 091/190] mt76: fix corrupted software generated tx CCMP PN
Date:   Fri, 13 Sep 2019 14:05:46 +0100
Message-Id: <20190913130606.900459859@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913130559.669563815@linuxfoundation.org>
References: <20190913130559.669563815@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 906d2d3f874a54183df5a609fda180adf0462428 ]

Since ccmp_pn is u8 *, the second half needs to start at array index 4
instead of 0. Fixes a connection stall after a certain amount of traffic

Fixes: 23405236460b9 ("mt76: fix transmission of encrypted management frames")
Cc: stable@vger.kernel.org
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76x2_mac_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2_mac_common.c b/drivers/net/wireless/mediatek/mt76/mt76x2_mac_common.c
index 6542644bc3259..cec31f0c3017b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2_mac_common.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2_mac_common.c
@@ -402,7 +402,7 @@ void mt76x2_mac_write_txwi(struct mt76x2_dev *dev, struct mt76x2_txwi *txwi,
 		ccmp_pn[6] = pn >> 32;
 		ccmp_pn[7] = pn >> 40;
 		txwi->iv = *((__le32 *)&ccmp_pn[0]);
-		txwi->eiv = *((__le32 *)&ccmp_pn[1]);
+		txwi->eiv = *((__le32 *)&ccmp_pn[4]);
 	}
 
 	spin_lock_bh(&dev->mt76.lock);
-- 
2.20.1



