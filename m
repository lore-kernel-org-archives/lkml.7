Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFB7C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 900FB20637
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574888818;
	bh=TsHlTSdvhxWTQ1hfq+x90Y74xridxkUGzUUUPZWjXMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BqcnOCDRP1bOx1DSo+GCpr+ipAkfqiZ87B7aV6OxlH/kWa2W3F5KdbgYg2XPRzMkp
	 dtst9PmAjiywUoNpQOX6RkR4aUTVMzjtIh2IJ+SMPP3fNPVQ6ltV+zLkIdCZTT8zeG
	 id6oHanL22Dr9t1YqNLirmEdrGaWfZB+dlD94374=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732523AbfK0VG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:06:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:32926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732497AbfK0VGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:06:54 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2010F215F2;
        Wed, 27 Nov 2019 21:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888814;
        bh=TsHlTSdvhxWTQ1hfq+x90Y74xridxkUGzUUUPZWjXMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=htiQf4hmQzWUHFhJOXSJ7Gp/BLY+BVWlILP7cdboBi4Wf56Qu2H3FEZ7ilbbZSCdY
         tPxssYDiPeAhKX83P+rAkR0OVqKNJD8vTyb6u0g1zRLmm5okpRlxQWkw8E9vJLtMsW
         rEBdGa1Dbvs9HBUxzbTGUoodMUS4AfMeO+HGxPTo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 238/306] net: bcmgenet: return correct value ret from bcmgenet_power_down
Date:   Wed, 27 Nov 2019 21:31:28 +0100
Message-Id: <20191127203132.379611382@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index bb60104b4f805..338d223804343 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1169,7 +1169,7 @@ static int bcmgenet_power_down(struct bcmgenet_priv *priv,
 		break;
 	}
 
-	return 0;
+	return ret;
 }
 
 static void bcmgenet_power_up(struct bcmgenet_priv *priv,
-- 
2.20.1



