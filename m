Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26754C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8FEB21873
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553259430;
	bh=PMG4qo4SNX0Ew8xTdVFqlB1EYOSCwtpezuaXj9sdLq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r8ZyfT2TnyHn74xWhs7k/vgFoS1xg8OJ+E6NaHAYuKAZV5iRZh5qorvPRRRRpbox2
	 i6nFB3xTOTSYsvVhHhhgJrPga/XT0crDDPqNunBT+oI7C/J1LPBiGu0G356w1pr8Rq
	 DlkE6kx/VUO8CkQofvbZMienfQKyn065jpxyTpdc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732527AbfCVM5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:57:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731636AbfCVLsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:48:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60031218B0;
        Fri, 22 Mar 2019 11:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255302;
        bh=PMG4qo4SNX0Ew8xTdVFqlB1EYOSCwtpezuaXj9sdLq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ToB4JBHp2gPqXf0UPZTVfrfdRARmqY0aEM28W77qvxmYNLbqRs04RuX998J7zDLMN
         64RakKEjzZJ/6eS6skEELhQpc0x59NJqwODo/vpVYwqx08xkmdtTZhjbNF4rX0HBWw
         Hz3S9k1q618GYMh5XsxsUOwVcZWnJvpzcLNoWlc4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 048/183] net: mv643xx_eth: disable clk on error path in mv643xx_eth_shared_probe()
Date:   Fri, 22 Mar 2019 12:14:36 +0100
Message-Id: <20190322111245.195704428@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
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

[ Upstream commit e928b5d6b75e239feb9c6d5488974b6646a0ebc8 ]

If mv643xx_eth_shared_of_probe() fails, mv643xx_eth_shared_probe()
leaves clk enabled.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/mv643xx_eth.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index 81c1fac00d33..2434409f84b2 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -2886,7 +2886,7 @@ static int mv643xx_eth_shared_probe(struct platform_device *pdev)
 
 	ret = mv643xx_eth_shared_of_probe(pdev);
 	if (ret)
-		return ret;
+		goto err_put_clk;
 	pd = dev_get_platdata(&pdev->dev);
 
 	msp->tx_csum_limit = (pd != NULL && pd->tx_csum_limit) ?
@@ -2894,6 +2894,11 @@ static int mv643xx_eth_shared_probe(struct platform_device *pdev)
 	infer_hw_params(msp);
 
 	return 0;
+
+err_put_clk:
+	if (!IS_ERR(msp->clk))
+		clk_disable_unprepare(msp->clk);
+	return ret;
 }
 
 static int mv643xx_eth_shared_remove(struct platform_device *pdev)
-- 
2.19.1



