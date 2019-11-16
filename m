Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEAFC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF0E208CE
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573919465;
	bh=iUY5tR8dvDKK3APmd9zDwxM/JsNhSxWuwvIjRWP0ESk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qf40TDdPfFzNjaNOLNKpuJka+JZYsXyUw0imD3wd+Rn6qBJODeZmDo1fvpgdjskWy
	 N+Mcv3IGLTMogGAWSfcJP+KSTfo434J1N6KNe74PtFXu5N+Qo+dpXWs1ynSyhr+EVu
	 hYxVJsyWMxfAqxVomKpQ1ns3o/ZjUh5GKummOHJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbfKPPvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:51:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:58912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730587AbfKPPuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:50:40 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 417AD20891;
        Sat, 16 Nov 2019 15:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919439;
        bh=iUY5tR8dvDKK3APmd9zDwxM/JsNhSxWuwvIjRWP0ESk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ice6k4Wl9829U2QHU3eZMkaCURnDtpHZB4pUX57HOy+NnJUs6CZRmzmtrLGCWCrf4
         riAJR7xGta04+/YuHcrbSDj/fEtX+mum+gSu17AtbiTpiqEiemEQfr5MVvPZdtsdjT
         iedbCRgvgEeC12FnvpYJOVmp5U2jODnh5QBW6UcU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 138/150] net: bcmgenet: return correct value 'ret' from bcmgenet_power_down
Date:   Sat, 16 Nov 2019 10:47:16 -0500
Message-Id: <20191116154729.9573-138-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154729.9573-1-sashal@kernel.org>
References: <20191116154729.9573-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 0db55093b56618088b9a1d445eb6e43b311bea33 ]

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/net/ethernet/broadcom/genet/bcmgenet.c: In function 'bcmgenet_power_down':
drivers/net/ethernet/broadcom/genet/bcmgenet.c:1136:6: warning:
 variable 'ret' set but not used [-Wunused-but-set-variable]

bcmgenet_power_down should return 'ret' instead of 0.

Fixes: ca8cf341903f ("net: bcmgenet: propagate errors from bcmgenet_power_down")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 1cc4fb27c13b3..b6af286fa5c7e 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1138,7 +1138,7 @@ static int bcmgenet_power_down(struct bcmgenet_priv *priv,
 		break;
 	}
 
-	return 0;
+	return ret;
 }
 
 static void bcmgenet_power_up(struct bcmgenet_priv *priv,
-- 
2.20.1

