Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12221C17441
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D112173B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573499335;
	bh=jbszZ+pK438idjmG/hhKzxYfkMI4SQrnmhW1whPaf/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GhGl9Z4jJvCBbeaU0FfZ0ygphuC2AEanStYq4cEonoBw/UIk5vIZ0XVciSkEyoHmb
	 YeyNl3BGU6J8bCE6ks0rqKsJaVulLk/BT7wa9LqLMJxnHrSNczR7JUBNzlMDu1pLl7
	 rLIFRd7X9wTMB8gej4zdi8sqkLolBqCwIRSNE8O0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfKKSfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:35:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:52770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728447AbfKKSe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:34:58 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E41252190F;
        Mon, 11 Nov 2019 18:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573497298;
        bh=jbszZ+pK438idjmG/hhKzxYfkMI4SQrnmhW1whPaf/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sg7lLxvApHI8XS0kyRxlnWDpjUb9g3MmzxaG4Kw55ZzXMnEeDBAqqJTnUtpenHI02
         +cGfmtSqvQkE5jqe5680PHC3Va1RInYYh4yRsRv3SrO63M4JVLoXWyZMljTq1/JWy4
         iGLjBmHLrRgVIfb6qg+/INpT8ykImxoxkdeIL/xk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 57/65] net: ethernet: arc: add the missed clk_disable_unprepare
Date:   Mon, 11 Nov 2019 19:28:57 +0100
Message-Id: <20191111181353.785421590@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181331.917659011@linuxfoundation.org>
References: <20191111181331.917659011@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>

[ Upstream commit 4202e219edd6cc164c042e16fa327525410705ae ]

The remove misses to disable and unprepare priv->macclk like what is done
when probe fails.
Add the missed call in remove.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/arc/emac_rockchip.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/arc/emac_rockchip.c b/drivers/net/ethernet/arc/emac_rockchip.c
index c770ca37c9b21..a7d30731d376f 100644
--- a/drivers/net/ethernet/arc/emac_rockchip.c
+++ b/drivers/net/ethernet/arc/emac_rockchip.c
@@ -261,6 +261,9 @@ static int emac_rockchip_remove(struct platform_device *pdev)
 	if (priv->regulator)
 		regulator_disable(priv->regulator);
 
+	if (priv->soc_data->need_div_macclk)
+		clk_disable_unprepare(priv->macclk);
+
 	free_netdev(ndev);
 	return err;
 }
-- 
2.20.1



