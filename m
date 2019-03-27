Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAC2C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D72E21741
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553713981;
	bh=3ctWvtXHwfad4c0NepgnJRbv4myj51QEQatkQQG1QV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NhanFncJ9Yp21yjR7PiPnn1gphqWTMeA4o2EmnMDLYfGtp1hsjQYuLQKFacatEKkf
	 Un60uz+aoHIbOcBD0StsiU/4xP6OYGXTmIx4hOaI2/0J/Jo6bWC3DACkhdOV2HhfZY
	 TrVGloroqSViZaB1LUzy5i8oJDx3kymKWHTBkp/g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388774AbfC0SKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:10:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:52206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732739AbfC0SKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:10:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 099262147C;
        Wed, 27 Mar 2019 18:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710213;
        bh=3ctWvtXHwfad4c0NepgnJRbv4myj51QEQatkQQG1QV8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AXDWRNNbQ+RMUg5R6GjygxvGMipkhpuSFZl/5QBUTkciLDlhupwnDo3mqsdzeTELB
         4RdyjFw0BPrAmqMSZ/k1sAIxdJSNSkybgemZZA3L//mz26XbUGhZJj5V9rYpRHqBFH
         IhepK1bD6LpwiDF6rUEI99OkRJWnlviL8dZrgBAo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 255/262] ASoC: simple-card-utils: check "reg" property on asoc_simple_card_get_dai_id()
Date:   Wed, 27 Mar 2019 14:01:50 -0400
Message-Id: <20190327180158.10245-255-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[ Upstream commit a0c426fe143328760c9fd565cd203a37a7b4fde8 ]

We will get DAI ID from "reg" property if it has on DT, otherwise get
it by counting port/endpoint.

But in below case, we need to get DAI ID = 0 via port reg = <0>, but
current implementation returns ID = 1, because it can't judge ID = 0 was
from "non reg" or "reg = <0>".
Thus, it will count port/endpoint number as "non reg" case.

of_graph_parse_endpoint() implementation itself is not a problem,
but because asoc_simple_card_get_dai_id() need to count port/endpoint
number when "non reg" case, it need to know ID = 0 was from
"non reg" or "reg = <0>".
This patch fix this issue.

	port {
		reg = <0>;
		xxxx: endpoint@0 {
		};
=>		xxxx: endpoint@1 {
		};
	};

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/generic/simple-card-utils.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index b807a47515eb..336895f7fd1e 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -283,12 +283,20 @@ static int asoc_simple_card_get_dai_id(struct device_node *ep)
 	/* use endpoint/port reg if exist */
 	ret = of_graph_parse_endpoint(ep, &info);
 	if (ret == 0) {
-		if (info.id)
+		/*
+		 * Because it will count port/endpoint if it doesn't have "reg".
+		 * But, we can't judge whether it has "no reg", or "reg = <0>"
+		 * only of_graph_parse_endpoint().
+		 * We need to check "reg" property
+		 */
+		if (of_get_property(ep,   "reg", NULL))
 			return info.id;
-		if (info.port)
+
+		node = of_get_parent(ep);
+		of_node_put(node);
+		if (of_get_property(node, "reg", NULL))
 			return info.port;
 	}
-
 	node = of_graph_get_port_parent(ep);
 
 	/*
-- 
2.19.1

