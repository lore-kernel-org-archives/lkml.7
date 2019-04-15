Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C0DC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D62E20880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355220;
	bh=EgYgkLnUqtVpIAwaB9qjdHKIqfOCQFk2iDa5+b95ydg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=inQVrQ9VeLYnYliBffioWpCQSz8pWdVF8CR+SJrgaWghsT/8o4EOKdIlRtb9PcQBG
	 ZK1d5oPDRxfGabnjnzTLVZNFECEOovdws/SV7nGN7hMIOw94eBu2h8pnfUUDJztBcu
	 6VJK30XHzEBb2S7BudlrWc4Q/86CYKfsaKQAfpKM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbfDOTG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:06:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:41514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730058AbfDOTGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:06:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36FEE20880;
        Mon, 15 Apr 2019 19:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355211;
        bh=EgYgkLnUqtVpIAwaB9qjdHKIqfOCQFk2iDa5+b95ydg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fm/xtMSjFOtmZqCXvlnB+pHRTblBKnMXSa5duQP28Vq0j6IEQ9GMj/Ey5w2F0ebA9
         H6cFOFAirg3nxzwR481p+lA5Bg+ml1nX/KdYhJRoh8lfSy49wdN7/8wH18CZPpB0f2
         OXGrjqAX3e1XryJAQevDTRPvbOQ6RcqWQ505sVq0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huy Nguyen <huyn@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 035/101] net/mlx5e: Update xoff formula
Date:   Mon, 15 Apr 2019 20:58:33 +0200
Message-Id: <20190415183742.320063071@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
References: <20190415183740.341577907@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 5ec983e924c7978aaec3cf8679ece9436508bb20 ]

Set minimum speed in xoff threshold formula to 40Gbps

Fixes: 0696d60853d5 ("net/mlx5e: Receive buffer configuration")
Signed-off-by: Huy Nguyen <huyn@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/mellanox/mlx5/core/en/port_buffer.c  | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c b/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
index eac245a93f91..f00de0c987cd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
@@ -122,7 +122,9 @@ static int port_set_buffer(struct mlx5e_priv *priv,
 	return err;
 }
 
-/* xoff = ((301+2.16 * len [m]) * speed [Gbps] + 2.72 MTU [B]) */
+/* xoff = ((301+2.16 * len [m]) * speed [Gbps] + 2.72 MTU [B])
+ * minimum speed value is 40Gbps
+ */
 static u32 calculate_xoff(struct mlx5e_priv *priv, unsigned int mtu)
 {
 	u32 speed;
@@ -130,10 +132,9 @@ static u32 calculate_xoff(struct mlx5e_priv *priv, unsigned int mtu)
 	int err;
 
 	err = mlx5e_port_linkspeed(priv->mdev, &speed);
-	if (err) {
-		mlx5_core_warn(priv->mdev, "cannot get port speed\n");
-		return 0;
-	}
+	if (err)
+		speed = SPEED_40000;
+	speed = max_t(u32, speed, SPEED_40000);
 
 	xoff = (301 + 216 * priv->dcbx.cable_len / 100) * speed / 1000 + 272 * mtu / 100;
 
-- 
2.19.1



