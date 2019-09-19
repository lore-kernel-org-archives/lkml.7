Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815B3C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5335121920
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568931574;
	bh=1JWXgRogTJAd1INSvWFNUJy3p0qKjgwc8OowBdOpFPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DDP30+TVr1R36LrrUSBWuFTz31ZIm6DdevSo0f0fAyKnqNDKm9TkB0SyCb4SmaFcN
	 i4bPCNMUhwPOX/uNGjLfMrjjSGBNsHo7f4ryCc0mGEeplv1DfiLXETZJUYJzIPq5yC
	 mVUeQfTe+FdSVzgPzFiczGNMrD0zdBXVnR8a8l/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392804AbfISWTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:19:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:33166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392760AbfISWT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:19:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 107C621924;
        Thu, 19 Sep 2019 22:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931567;
        bh=1JWXgRogTJAd1INSvWFNUJy3p0qKjgwc8OowBdOpFPg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vlTS96aDkMehrCpNqB0s8WNdmuvIJHrfKwOiyHeAoyxg3ov4FOFsgKLwthmR2BHCv
         4Cgw0jr0pTrd+43VIFxqz69A2v2Jad7J5aX1KKydxqEmrvR7qyZCt1YU+0cGueRBUN
         EEKkuvMntMntFgwc/0G3it1K+no85GnvyunVh2gU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nishka Dasgupta <nishkadg.linux@gmail.com>,
        CK Hu <ck.hu@mediatek.com>
Subject: [PATCH 4.9 32/74] drm/mediatek: mtk_drm_drv.c: Add of_node_put() before goto
Date:   Fri, 20 Sep 2019 00:03:45 +0200
Message-Id: <20190919214808.152703553@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214800.519074117@linuxfoundation.org>
References: <20190919214800.519074117@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nishka Dasgupta <nishkadg.linux@gmail.com>

commit 165d42c012be69900f0e2f8545626cb9e7d4a832 upstream.

Each iteration of for_each_child_of_node puts the previous
node, but in the case of a goto from the middle of the loop, there is
no put, thus causing a memory leak. Hence add an of_node_put before the
goto in two places.
Issue found with Coccinelle.

Fixes: 119f5173628a (drm/mediatek: Add DRM Driver for Mediatek SoC MT8173)

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
Signed-off-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -423,12 +423,15 @@ static int mtk_drm_probe(struct platform
 			comp = devm_kzalloc(dev, sizeof(*comp), GFP_KERNEL);
 			if (!comp) {
 				ret = -ENOMEM;
+				of_node_put(node);
 				goto err_node;
 			}
 
 			ret = mtk_ddp_comp_init(dev, node, comp, comp_id, NULL);
-			if (ret)
+			if (ret) {
+				of_node_put(node);
 				goto err_node;
+			}
 
 			private->ddp_comp[comp_id] = comp;
 		}


