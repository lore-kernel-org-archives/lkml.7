Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF37C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A84A620665
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574890405;
	bh=iUY5tR8dvDKK3APmd9zDwxM/JsNhSxWuwvIjRWP0ESk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SRyKzNX1EeJ4wtui3c6Cg2Jgt5bowa2sgF1umHflnWMJTw4WX0udE0Li0cj6wklsn
	 rnCMF1JLm+s7Pgki91UsaKSo0+I4c0d2gHnZglmnu/lJycx0pH4vm/CMLyw+qUM4Hp
	 WZp9e18bVLexvMCf02Moaiaxfrdf/cnKaVFTIb7g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730585AbfK0VdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:33:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:39542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730583AbfK0UwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:52:13 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0DBA21871;
        Wed, 27 Nov 2019 20:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887931;
        bh=iUY5tR8dvDKK3APmd9zDwxM/JsNhSxWuwvIjRWP0ESk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iuAVrOkML9vvq1jiywSWfNDtdCofCm28wM3JBeMh2a+fuZtzBTXvHVyJtOUuKactA
         xSbJuOoCHuhN0Sm9wdMpa4i954qQNSCH1lqSafF1WY1m4Hs6hQ6rhjr+0bNSPp6cnd
         s4N4WDeDtds638TCmQRB19hxEmMlgIWAGIj/su/8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 151/211] net: bcmgenet: return correct value ret from bcmgenet_power_down
Date:   Wed, 27 Nov 2019 21:31:24 +0100
Message-Id: <20191127203108.284325180@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203049.431810767@linuxfoundation.org>
References: <20191127203049.431810767@linuxfoundation.org>
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



