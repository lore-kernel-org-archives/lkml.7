Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DC2C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6171F20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551687938;
	bh=TyNEEtGClMYdlBeERxTUXo02LsMNgiWkup9Nby89Kxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YsncFq62kKMD91vd4PV/TzRAc0uNAVHDNjKaSC361LSkPdZk8GaZBfXsULXtUowHa
	 m76KVFCL81tBirkESpPHWAzoEZGst5K1Cytqzr8OkP1sdqaJzNrBHBy8tjTZyX145+
	 XN1/OuXjuOcEQeuIkT13VpcbNk6LfnjkC4qdOpaU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfCDIZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:25:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:45694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727029AbfCDIZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:25:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CA1520823;
        Mon,  4 Mar 2019 08:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551687934;
        bh=TyNEEtGClMYdlBeERxTUXo02LsMNgiWkup9Nby89Kxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rlAoY78J3eOy1XB3uHOGK8SKeWs/AwIArdVR+trzIyERNhErZ1i1oZX63fx+O61F7
         VhtNa2VBdfBokrT0/mCU1c4Fv4nHMiSt1UfiyS3urClUsWonzxjZAqCsTNd1cf48/2
         amY0CZguHxWJQIqT89O51YRHm7Ap/ivYtfaJWm0k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Atsushi Nemoto <atsushi.nemoto@sord.co.jp>,
        Thor Thayer <thor.thayer@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 34/52] net: altera_tse: fix connect_local_phy error path
Date:   Mon,  4 Mar 2019 09:22:32 +0100
Message-Id: <20190304081619.111581436@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081617.159014799@linuxfoundation.org>
References: <20190304081617.159014799@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
index 527908c7e3845..84def1ff6cb64 100644
--- a/drivers/net/ethernet/altera/altera_tse_main.c
+++ b/drivers/net/ethernet/altera/altera_tse_main.c
@@ -714,8 +714,10 @@ static struct phy_device *connect_local_phy(struct net_device *dev)
 
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



