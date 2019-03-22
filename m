Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984C3C10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6093521925
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254194;
	bh=zMhOiDvpN4rQulZds7W7sTipGzxrfZhdziXvvXTS6+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jZbPNvhI//QLSuzNYuqkOXxdLhFC7NAoKjEGiG1+K90EaV0J0QS5Uf4wBuRodR+YK
	 7rkGLTkkSs2dYRSdzRUGS+/sp4SBxe0jmMUBFHTLf65ge5NBxbA3tyaTyUt5ahzq+7
	 Lz/r5nVz+SWXq+k2nuZBPDNmmbmCqBuv/XXXfVcc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbfCVL3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:29:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:57750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729007AbfCVL3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:29:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48AE9218B0;
        Fri, 22 Mar 2019 11:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254190;
        bh=zMhOiDvpN4rQulZds7W7sTipGzxrfZhdziXvvXTS6+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C0mB31GmRrHXQEJdGO2xB6lkP6aufi/WxOTDvzXqktg6PZD1yl0U8Ao6fk0mO1XxK
         2kNdT9mjHynwweWu5pbIynYskzYK6AZWiMp3kIccvrvO75nuIu45mvIOsnV+tWjHUm
         Cc4ohWaDMyYEQOq8Viog3mc/zjPrEFIn1On6sL10=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Atsushi Nemoto <atsushi.nemoto@sord.co.jp>,
        Thor Thayer <thor.thayer@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 044/230] net: altera_tse: fix connect_local_phy error path
Date:   Fri, 22 Mar 2019 12:13:02 +0100
Message-Id: <20190322111239.804335955@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 17b42a20d7ca59377788c6a2409e77569570cc10 ]

The connect_local_phy should return NULL (not negative errno) on
error, since its caller expects it.

Signed-off-by: Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
Acked-by: Thor Thayer <thor.thayer@linux.intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/altera/altera_tse_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/altera/altera_tse_main.c b/drivers/net/ethernet/altera/altera_tse_main.c
index fe644823ceaf9..bb51f124d8c7d 100644
--- a/drivers/net/ethernet/altera/altera_tse_main.c
+++ b/drivers/net/ethernet/altera/altera_tse_main.c
@@ -716,8 +716,10 @@ static struct phy_device *connect_local_phy(struct net_device *dev)
 
 		phydev = phy_connect(dev, phy_id_fmt, &altera_tse_adjust_link,
 				     priv->phy_iface);
-		if (IS_ERR(phydev))
+		if (IS_ERR(phydev)) {
 			netdev_err(dev, "Could not attach to PHY\n");
+			phydev = NULL;
+		}
 
 	} else {
 		int ret;
-- 
2.19.1



