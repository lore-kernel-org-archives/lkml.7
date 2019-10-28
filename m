Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF0DCA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 07:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C2C20679
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 07:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="xWHIGGQZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732417AbfJ1HTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 03:19:21 -0400
Received: from gateway20.websitewelcome.com ([192.185.53.25]:20950 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730751AbfJ1HTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 03:19:20 -0400
X-Greylist: delayed 1363 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Oct 2019 03:19:20 EDT
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 6B6F9400D0068
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 00:48:29 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id OyxAi0Et4BnGaOyxAieeqj; Mon, 28 Oct 2019 01:56:36 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oCTskRlbgqD+J7aWayjsVtQZcA0SIwA4npc4QiguN5o=; b=xWHIGGQZ1Iab0c2jpYjZZ0O1Oy
        idQhgFCv+VHyiZt9qhZtSPdqDV6XWoIjQ9LD9elLoup1AYbW8Td72bRF5lr0kkTihUp9DFdPudO0w
        KilHebfPbteyYM7s9JyCgKXe6/ElNoP+cG7dRzqIL1av6S0RlGiwAw9u/tNY93aU9rsixr8gzgC58
        d9XboNFx4FZBVoAi7BKsnMhiX1fqZqBhQf0s5TLXo0rPGmRIKAWt/7DM9p3HQu3YiVKUoXYUiW4V9
        ZNmCDkfOgd5NUgYkoeyuMfUpp9/IE/PiVxJiM1ix1ElIS4MotV1xg2ioyWlJqbnSE88n/uPSbEkS2
        cPVkDtwA==;
Received: from [187.192.2.30] (port=58438 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1iOyx9-0040bs-6Y; Mon, 28 Oct 2019 01:56:35 -0500
Date:   Mon, 28 Oct 2019 01:56:33 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Igor Russkikh <igor.russkikh@aquantia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Bezrukov <dmitry.bezrukov@aquantia.com>,
        Nikita Danilov <nikita.danilov@aquantia.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH net-next] net: aquantia: fix error handling in aq_nic_init
Message-ID: <20191028065633.GA2412@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.2.30
X-Source-L: No
X-Exim-ID: 1iOyx9-0040bs-6Y
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.2.30]:58438
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix currenty ignored returned error by properly error checking
aq_phy_init().

Addresses-Coverity-ID: 1487376 ("Unused value")
Fixes: dbcd6806af42 ("net: aquantia: add support for Phy access")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
index 433adc099e44..1914aa0a19d0 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
@@ -341,7 +341,8 @@ int aq_nic_init(struct aq_nic_s *self)
 
 	if (self->aq_nic_cfg.aq_hw_caps->media_type == AQ_HW_MEDIA_TYPE_TP) {
 		self->aq_hw->phy_id = HW_ATL_PHY_ID_MAX;
-		err = aq_phy_init(self->aq_hw);
+		if (!aq_phy_init(self->aq_hw))
+			goto err_exit;
 	}
 
 	for (i = 0U, aq_vec = self->aq_vec[0];
-- 
2.23.0

