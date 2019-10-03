Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2812C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC5120700
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570119331;
	bh=oC1urmdw4QoCX5MWmgFlKQJ7lWgAiWRCofIv0yEI+vk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M7WjNXtGyPiGpziv9MtkKZ+qNQ8PEKI1fVotNT12QHSsaUh3OOWOuIlnyJhpzBnFW
	 vSjg104CkKai/hPBMZTRNXf+JnucpXcnMZmSY/mQhp9G/I5c6priq9BOq9RUIrLlRI
	 pU+4rudM1ndQ2NTZYq7uiQ/K5+R/Xl1ylGO1Yh70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfJCQPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:15:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:39554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388246AbfJCQPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:15:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5E7B20865;
        Thu,  3 Oct 2019 16:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119325;
        bh=oC1urmdw4QoCX5MWmgFlKQJ7lWgAiWRCofIv0yEI+vk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=msPW4/27RYCidrIqn9aavqu/4gUIjPcXGcTMLcrhvZGCvVeJqfaWjw6PWe1yi/KPp
         ene9h+0DitmtvTS+YNmj4Quv2HLlGvA9AaYW1tLNNIpXo18mKPtRvWSJDhLw8kEIFt
         BDl5553OvWmyavAXyCznb20M5TS451bTqsNEvyIU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 023/211] nfp: flower: prevent memory leak in nfp_flower_spawn_phy_reprs
Date:   Thu,  3 Oct 2019 17:51:29 +0200
Message-Id: <20191003154452.365145518@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154447.010950442@linuxfoundation.org>
References: <20191003154447.010950442@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

[ Upstream commit 8572cea1461a006bce1d06c0c4b0575869125fa4 ]

In nfp_flower_spawn_phy_reprs, in the for loop over eth_tbl if any of
intermediate allocations or initializations fail memory is leaked.
requiered releases are added.

Fixes: b94524529741 ("nfp: flower: add per repr private data for LAG offload")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/netronome/nfp/flower/main.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/ethernet/netronome/nfp/flower/main.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/main.c
@@ -259,6 +259,7 @@ nfp_flower_spawn_vnic_reprs(struct nfp_a
 		repr_priv = kzalloc(sizeof(*repr_priv), GFP_KERNEL);
 		if (!repr_priv) {
 			err = -ENOMEM;
+			nfp_repr_free(repr);
 			goto err_reprs_clean;
 		}
 
@@ -291,6 +292,7 @@ nfp_flower_spawn_vnic_reprs(struct nfp_a
 		err = nfp_repr_init(app, repr,
 				    port_id, port, priv->nn->dp.netdev);
 		if (err) {
+			kfree(repr_priv);
 			nfp_port_free(port);
 			nfp_repr_free(repr);
 			goto err_reprs_clean;
@@ -389,6 +391,7 @@ nfp_flower_spawn_phy_reprs(struct nfp_ap
 		}
 		err = nfp_port_init_phy_port(app->pf, app, port, i);
 		if (err) {
+			kfree(repr_priv);
 			nfp_port_free(port);
 			nfp_repr_free(repr);
 			goto err_reprs_clean;


