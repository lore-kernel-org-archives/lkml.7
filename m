Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78ABAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48838206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553713307;
	bh=muq2VKf6O7YsjH3w9qb7tTBtwzD1JKs9NHjP5995QJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r/giR2CDXAxgTHjEZ+eC4sFRpO3w/7OCc0cKeX8TKLHAqAFTiLWQiif0wvQahSkwT
	 ij3uNElLcJVaLpDzJuhCmpTE3qaiW480SfqaIpwj+EVvgyyERGEklM+pcZMh6tIQUg
	 YLE3XhM4QtYQlp0000UTep5nunM5Jkspn48/dXYw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389830AbfC0TBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:01:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:56966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389273AbfC0SOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:14:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8B522147C;
        Wed, 27 Mar 2019 18:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710444;
        bh=muq2VKf6O7YsjH3w9qb7tTBtwzD1JKs9NHjP5995QJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kXbOPpFG+oIMxfsGDCcXga6V6+EpiN4IuKAVK0uKGEHLVAy7lY0ncqWcZT4Q6HcOg
         oYe6zLPxw2cSihgdzsF0rloipQolOQlx3NJgmuiAoqVlj3dKUo/uqXEKfFLF3GLrcu
         4ReQihyu832/sfnqzf3+yhVAo1nFVLA3w0q9Dveg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Julia Lawall <julia.lawall@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 123/192] drm: rcar-du: add missing of_node_put
Date:   Wed, 27 Mar 2019 14:09:15 -0400
Message-Id: <20190327181025.13507-123-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julia Lawall <julia.lawall@lip6.fr>

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

