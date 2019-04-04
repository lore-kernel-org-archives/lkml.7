Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1CEC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C6A721850
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368663;
	bh=0Jud5Nh/Vdv45lDXuUCMCtmE07O1Wdz6ghktKJvGbeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oWMV7nIoSRIpdMg7QxvCZHvWR0AbQmil61eb3PXe9fxJzGQS7X0X7uGxccA/CfqhU
	 ml06QNPlksYIe8C9GjVsqxrlxLKoOtyJ8ycHiZqooNa8jMmvtRKZ/6ufbygWQT8Fbl
	 Plq72uUSIjwCRpexx8J1qdz/KIPpUhi+Mrk5JaiI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731955AbfDDJEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:04:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:42098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731502AbfDDJEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:04:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21BEC2147C;
        Thu,  4 Apr 2019 09:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368659;
        bh=0Jud5Nh/Vdv45lDXuUCMCtmE07O1Wdz6ghktKJvGbeU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XGm4m81nao+Wod4RMNMLDY969ynirNb1C4/rBPyLWNlqxwMaE995Xv8UbyQHZHDrR
         W7U7YFYwk2456rlm20MUyuRZ7uG97C9o6Eg8F2mG3PnPFFCP6YIkh59eFPiZwcNjxJ
         NYV/hroZaghCaytjTamKhdOOPlocpKJ7xZ3wXk3I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 121/187] drm: rcar-du: add missing of_node_put
Date:   Thu,  4 Apr 2019 10:47:38 +0200
Message-Id: <20190404084608.942573298@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 4c6d8fc20b09f9684743afd72e4dbc3f15524479 ]

Add an of_node_put when the result of of_graph_get_remote_port_parent is
not available.

Add a second of_node_put if no encoder is selected (encoder remains NULL).

The semantic match that finds the first problem is as follows
(http://coccinelle.lip6.fr):

// <smpl>
@r exists@
local idexpression e;
expression x;
@@
e = of_graph_get_remote_port_parent(...);
... when != x = e
    when != true e == NULL
    when != of_node_put(e)
    when != of_fwnode_handle(e)
(
return e;
|
*return ...;
)
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/rcar-du/rcar_du_kms.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index fb46df56f0c4..0386b454e221 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -300,6 +300,7 @@ static int rcar_du_encoders_init_one(struct rcar_du_device *rcdu,
 		dev_dbg(rcdu->dev,
 			"connected entity %pOF is disabled, skipping\n",
 			entity);
+		of_node_put(entity);
 		return -ENODEV;
 	}
 
@@ -335,6 +336,7 @@ static int rcar_du_encoders_init_one(struct rcar_du_device *rcdu,
 		dev_warn(rcdu->dev,
 			 "no encoder found for endpoint %pOF, skipping\n",
 			 ep->local_node);
+		of_node_put(entity);
 		return -ENODEV;
 	}
 
-- 
2.19.1



