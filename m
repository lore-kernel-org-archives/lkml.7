Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9950CC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A29E20B7C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556810943;
	bh=yyMPE9cEVt9Iu1b2UKe0SrMnndHzDIif32M3JP+1pk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TqhDQmCIOojVQnRRX5Nr0hOD1ih8dMSlo9C4Xm+5zd6xo+0u5iT9xXrtEZBwFis6L
	 OWm6sxoCLxkJiLEISLpSMpwQfR1BhOr0HlugBEV1xp0cpbn1Yb8IHp75YC87FiIuuw
	 OUyfbaB9DmkLo/zMhExbXJszMIxogGoYYbTRIl/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbfEBP3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:29:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:46412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728322AbfEBP26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:28:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1050E20C01;
        Thu,  2 May 2019 15:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556810937;
        bh=yyMPE9cEVt9Iu1b2UKe0SrMnndHzDIif32M3JP+1pk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ycZzoNYKrK1IMqga6VRhkW1FFjYRnEgYbITnVXYkgfy0/2uYLaPsaKOUyd6Xq3uUB
         dknGMOjit11rm8DnCZs80pbgBjs2x83Ue0OyjXaDNG70ABJIBiS2A9pZrsvR9XFBur
         KrqG/eY6qucxIYGNjTO+xIX8PfHOh80kY3FucJ64=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 5.0 014/101] net: ieee802154: fix a potential NULL pointer dereference
Date:   Thu,  2 May 2019 17:20:16 +0200
Message-Id: <20190502143341.081097405@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190502143339.434882399@linuxfoundation.org>
References: <20190502143339.434882399@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 2795e8c251614ac0784c9d41008551109f665716 ]

In case alloc_ordered_workqueue fails, the fix releases
sources and returns -ENOMEM to avoid NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/net/ieee802154/adf7242.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ieee802154/adf7242.c b/drivers/net/ieee802154/adf7242.c
index cd1d8faccca5..cd6b95e673a5 100644
--- a/drivers/net/ieee802154/adf7242.c
+++ b/drivers/net/ieee802154/adf7242.c
@@ -1268,6 +1268,10 @@ static int adf7242_probe(struct spi_device *spi)
 	INIT_DELAYED_WORK(&lp->work, adf7242_rx_cal_work);
 	lp->wqueue = alloc_ordered_workqueue(dev_name(&spi->dev),
 					     WQ_MEM_RECLAIM);
+	if (unlikely(!lp->wqueue)) {
+		ret = -ENOMEM;
+		goto err_hw_init;
+	}
 
 	ret = adf7242_hw_init(lp);
 	if (ret)
-- 
2.19.1



