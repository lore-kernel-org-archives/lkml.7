Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C2BC31E4D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D72321841
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560544186;
	bh=QD3QsZcOuxunLR89FwyqxzdkeWTv4iaFXo6tE1I7r3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gj9oRHJvMX2rfbq08fahhNYon5CQTKUNdQmfenZVnl1hXPDbyBP52dRFQw9C0yzSD
	 LalWR87f5JPSkZraAy4k+UOUrHleOEziLYnYxCRkqW6cacqE9ygrsXGanPg2pslPAH
	 uNK0vbfy2bDbrj5NZxWl9h7TCWQf1PXKKWB8L8dc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfFNU3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 16:29:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:51830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727058AbfFNU3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 16:29:39 -0400
Received: from sasha-vm.mshome.net (unknown [131.107.159.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41C4521841;
        Fri, 14 Jun 2019 20:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560544179;
        bh=QD3QsZcOuxunLR89FwyqxzdkeWTv4iaFXo6tE1I7r3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NRMTjknED47yIRDA1NQB8cv9lcAaDxyYXzzhxuz60XZDgHbOhj71cMpEC5D7cG3Hv
         dc2u3v+Qp1glwFnp/M3LITy0jT+lYpEe0NempmsOp17GsJZ29j0WuiGtt8zUT2Limf
         ie37vIlpqAkyjRfNDtf4upAyfTddOOXb8mm90XK8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Gen Zhang <blackgod016574@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, sparclinux@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 36/59] mdesc: fix a missing-check bug in get_vdev_port_node_info()
Date:   Fri, 14 Jun 2019 16:28:20 -0400
Message-Id: <20190614202843.26941-36-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614202843.26941-1-sashal@kernel.org>
References: <20190614202843.26941-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gen Zhang <blackgod016574@gmail.com>

[ Upstream commit 80caf43549e7e41a695c6d1e11066286538b336f ]

In get_vdev_port_node_info(), 'node_info->vdev_port.name' is allcoated
by kstrdup_const(), and it returns NULL when fails. So
'node_info->vdev_port.name' should be checked.

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sparc/kernel/mdesc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
index 9a26b442f820..8e645ddac58e 100644
--- a/arch/sparc/kernel/mdesc.c
+++ b/arch/sparc/kernel/mdesc.c
@@ -356,6 +356,8 @@ static int get_vdev_port_node_info(struct mdesc_handle *md, u64 node,
 
 	node_info->vdev_port.id = *idp;
 	node_info->vdev_port.name = kstrdup_const(name, GFP_KERNEL);
+	if (!node_info->vdev_port.name)
+		return -1;
 	node_info->vdev_port.parent_cfg_hdl = *parent_cfg_hdlp;
 
 	return 0;
-- 
2.20.1

