Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7F3C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C183205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569948069;
	bh=H1nrnkt44PLeur88B5tlQvgD/Hp4H1avEpbWadrLVH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dG9T67V/BTNOWg4y2SUSodXsjzzc/7sdAt16PjF4fU51/siRoCiHPSPs/u+9os2gb
	 PS3WLjULsOJQMBM/OLuJovCRbIvSGFZib2ymzsvI641w08Rhe3pzC21TvRTrBH/rT+
	 UqK+wUqXOqWfCvSUO+5kefQrumKCk5S4faYxUL8s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730697AbfJAQlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:41:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:52486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730536AbfJAQlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:41:03 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 612A020B7C;
        Tue,  1 Oct 2019 16:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569948063;
        bh=H1nrnkt44PLeur88B5tlQvgD/Hp4H1avEpbWadrLVH0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F1XZhlkC0SLpNY2nIR/Z3UEwdBOoFN/KyBW0FOZeK2faXSzAwEF7vwlTp6xOfQI8/
         VVuv4SWwnkugolxAXr12Vtc9i76PsFaqV8VyCWQFLulDVVXv/e/jTVDgsbmgVTJBT8
         Y7pxfr2Z5lH8PU3rnnMGJj+/dFG/PCNJVMn2i5Ik=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, oss-drivers@netronome.com,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 60/71] nfp: flower: fix memory leak in nfp_flower_spawn_vnic_reprs
Date:   Tue,  1 Oct 2019 12:39:10 -0400
Message-Id: <20191001163922.14735-60-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191001163922.14735-1-sashal@kernel.org>
References: <20191001163922.14735-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

[ Upstream commit 8ce39eb5a67aee25d9f05b40b673c95b23502e3e ]

In nfp_flower_spawn_vnic_reprs in the loop if initialization or the
allocations fail memory is leaked. Appropriate releases are added.

Fixes: b94524529741 ("nfp: flower: add per repr private data for LAG offload")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/netronome/nfp/flower/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/netronome/nfp/flower/main.c b/drivers/net/ethernet/netronome/nfp/flower/main.c
index eb846133943b2..5331e01f373e0 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/main.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/main.c
@@ -400,6 +400,7 @@ nfp_flower_spawn_vnic_reprs(struct nfp_app *app,
 		repr_priv = kzalloc(sizeof(*repr_priv), GFP_KERNEL);
 		if (!repr_priv) {
 			err = -ENOMEM;
+			nfp_repr_free(repr);
 			goto err_reprs_clean;
 		}
 
@@ -413,6 +414,7 @@ nfp_flower_spawn_vnic_reprs(struct nfp_app *app,
 		port = nfp_port_alloc(app, port_type, repr);
 		if (IS_ERR(port)) {
 			err = PTR_ERR(port);
+			kfree(repr_priv);
 			nfp_repr_free(repr);
 			goto err_reprs_clean;
 		}
@@ -433,6 +435,7 @@ nfp_flower_spawn_vnic_reprs(struct nfp_app *app,
 		err = nfp_repr_init(app, repr,
 				    port_id, port, priv->nn->dp.netdev);
 		if (err) {
+			kfree(repr_priv);
 			nfp_port_free(port);
 			nfp_repr_free(repr);
 			goto err_reprs_clean;
-- 
2.20.1

