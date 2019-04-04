Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12270C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D20662054F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369503;
	bh=n1eSbOFubPJbrdns4g9N5OXl47tZJRTp54wLxM+dZTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b6QRqaTBc7ETr67vrV2oRHoAET8EmyhTHw0KmuAcnN+icJvaoFScOJKbrTnP5Z9ky
	 Jsyvs3Eyu7nxa7qrtTEQm/2Xn+lQ7nIAi16DQky/b/uhBXlOOXC22q/KmkQbDQHTz5
	 odh0wBv5KVNbWOuWNFS1g0QZhrLgjIdonAQXIbpI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388356AbfDDJSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:18:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727108AbfDDJSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:18:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AC4E20652;
        Thu,  4 Apr 2019 09:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369499;
        bh=n1eSbOFubPJbrdns4g9N5OXl47tZJRTp54wLxM+dZTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=doZjhzVSg6bdN1h/fNIGJOQDRKF75ROBVqnDgYMXprpX3M/G7VDyyoxoz+hulNDWc
         qTgY2BHm5blyft0f+DF0DXq6CXqHf19bjiG/7hnjibgBcSOrHUVjs1V+JQCHVO/FhU
         nmqETHOhyGNsQ55SxWiPzdcFNtwh4k1GXFZbbZ+4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 239/246] ASoC: simple-card-utils: check "reg" property on asoc_simple_card_get_dai_id()
Date:   Thu,  4 Apr 2019 10:48:59 +0200
Message-Id: <20190404084627.662480505@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

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



