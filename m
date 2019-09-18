Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90AFC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830F8218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568788357;
	bh=YI6gIsrLXa5biKkEtXE4kviKkjkvPlGBKxKYfmv7/i0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dnxnZajfz5biVd9spScv5T1+wZDCh4u2iswN2K7jKOWTzYASE2JZmbjX32+kfrnXD
	 dX4yk+7APzHVO18kORYM/UIadiRoR49J9tV7RgIhcJ6wX/PGbRL2ffhxm0aUtR0ItV
	 cipAgAFPZG38ouFPwewth+Emp+JzBPiUhGrCnq6k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbfIRGVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 02:21:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728061AbfIRGVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 02:21:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D4D521D56;
        Wed, 18 Sep 2019 06:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568787704;
        bh=YI6gIsrLXa5biKkEtXE4kviKkjkvPlGBKxKYfmv7/i0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bVEOKMO37bgIHcnL7dzhh20Wje7fR1NErU5Ywp1TLyVNTkA+Dbc1GQqSv/w0R9zPy
         w8QZqkc3gLGpAx/DW1GwjOHaKMrw4uCV5jOUw0e53Ciub8D+ACm8a6eZ9dNGWH7zZy
         GvQh/5fyC8JfRIwVOZra7ZJxZr59t3PZfWCGuTDI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nishka Dasgupta <nishkadg.linux@gmail.com>,
        CK Hu <ck.hu@mediatek.com>
Subject: [PATCH 4.14 41/45] drm/mediatek: mtk_drm_drv.c: Add of_node_put() before goto
Date:   Wed, 18 Sep 2019 08:19:19 +0200
Message-Id: <20190918061227.834898065@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190918061222.854132812@linuxfoundation.org>
References: <20190918061222.854132812@linuxfoundation.org>
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
@@ -504,12 +504,15 @@ static int mtk_drm_probe(struct platform
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


