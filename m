Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABEEC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 19:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C80232071C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 19:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DfMVZ0FA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfKVTNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 14:13:32 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41314 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbfKVTNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 14:13:31 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAMJDR4C075675;
        Fri, 22 Nov 2019 13:13:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574450007;
        bh=/UE78adoj5jfmn5s0/pawIXnBxu/CSqkZM2E28jJp4Q=;
        h=From:To:CC:Subject:Date;
        b=DfMVZ0FAdIQLQFoNtEN+jiLma4oIRpzR9utWKYX7T6Ct1HWgeJgOvNuQFPUK1lauu
         F3l2GbWXmCPPrRfQtH0K105yspfI0N5lMqW9xqemoRC7JSHx7NIz6uphbTjrfhUIK0
         gGviVnCdqgNDb8ymXzuXge8+Yp/hWpdGYMBguCwU=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAMJDRdu025466
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Nov 2019 13:13:27 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 22
 Nov 2019 13:13:26 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 22 Nov 2019 13:13:26 -0600
Received: from uda0869644b.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAMJDQTs103737;
        Fri, 22 Nov 2019 13:13:26 -0600
From:   Benoit Parrot <bparrot@ti.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Maxime Ripard <maxime.ripard@bootlin.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jyri Sarha <jsarha@ti.com>, Benoit Parrot <bparrot@ti.com>
Subject: [PATCH] dtc: checks: check_graph_port: skip node name check in overlay case
Date:   Fri, 22 Nov 2019 13:16:31 -0600
Message-ID: <20191122191631.2382-1-bparrot@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In check_graph_port() we need to skip the node name check in the overlay
case as it causes a false positive warning.

Signed-off-by: Benoit Parrot <bparrot@ti.com>
---
 checks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/checks.c b/checks.c
index 756f0fa9203f..6b6712da146a 100644
--- a/checks.c
+++ b/checks.c
@@ -1707,7 +1707,8 @@ static void check_graph_port(struct check *c, struct dt_info *dti,
 	if (node->bus != &graph_port_bus)
 		return;
 
-	if (!strprefixeq(node->name, node->basenamelen, "port"))
+	if (!strprefixeq(node->name, node->basenamelen, "port") &&
+	    !(dti->dtsflags & DTSF_PLUGIN))
 		FAIL(c, dti, node, "graph port node name should be 'port'");
 
 	check_graph_reg(c, dti, node);
-- 
2.17.1

