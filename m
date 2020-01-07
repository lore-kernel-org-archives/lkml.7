Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205FCC282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D0A20880
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578431735;
	bh=cHe9SCBf2/64VelU+oDMeWRNqTLDK6Y5/aXciAJSRdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ma4GUAROLKMR+ggq0E6yJpGoAYwv4KBFVzP8g8+5A2EacLXbeXwkLfJ29KRxy1At/
	 iw/cvMlHJaOMV65rXTmA7y90Q/eecrRtrfKq/xu98oA2tTQp0W3YHkxzhaBqJOONet
	 sHXWdqg41sOGdlZqQ1v725kdbCjzbhjLrOhPrhic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbgAGVPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:15:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:59826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729618AbgAGVIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:08:02 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADBDA2072A;
        Tue,  7 Jan 2020 21:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578431282;
        bh=cHe9SCBf2/64VelU+oDMeWRNqTLDK6Y5/aXciAJSRdM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ylUSMcrKZv3tHnALlls+EfuWPmtGT4fuu4XbUB0sWWI299cIqTCiVKR47TuOO1GcW
         CuSvCKz4o+Cf6Haeti5c0FK8/ho52y5mrEiBpWJO5X/ZW07toCj3XGcAhPeYwQM5uO
         0C+wqDhiS6izOQCfy3e/TlMRehyi4JWn9hUv8bxM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masashi Honma <masashi.honma@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 108/115] ath9k_htc: Modify byte order for an error message
Date:   Tue,  7 Jan 2020 21:55:18 +0100
Message-Id: <20200107205309.314026822@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205240.283674026@linuxfoundation.org>
References: <20200107205240.283674026@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masashi Honma <masashi.honma@gmail.com>

[ Upstream commit e01fddc19d215f6ad397894ec2a851d99bf154e2 ]

rs_datalen is be16 so we need to convert it before printing.

Signed-off-by: Masashi Honma <masashi.honma@gmail.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath9k/htc_drv_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
index 799010ed04e0..baacbd11eb43 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
@@ -986,7 +986,7 @@ static bool ath9k_rx_prepare(struct ath9k_htc_priv *priv,
 	    (skb->len - HTC_RX_FRAME_HEADER_SIZE) != 0) {
 		ath_err(common,
 			"Corrupted RX data len, dropping (dlen: %d, skblen: %d)\n",
-			rxstatus->rs_datalen, skb->len);
+			be16_to_cpu(rxstatus->rs_datalen), skb->len);
 		goto rx_next;
 	}
 
-- 
2.20.1



