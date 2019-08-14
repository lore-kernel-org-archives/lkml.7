Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0274CC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C43032133F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565750413;
	bh=eB7YhVPUizWg8v7xJrnxSGJjFSBOrQI3RZ69wlXaMVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S1rlE4vkMI3H9JsQzU/qqyJP4898EAw87IaPwXIToUFJdEKxu82jLIBIC1p/5Gn1O
	 u0PcEBYrq7U/sEfA1HFkFzzXMXeG7hb75Oei4S1zhtJ48R7BekGA9RKxHtTC0JciPY
	 zUdkfOkQP+Sxegf8EulW1y01Adegaz43WdNqq96I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfHNCLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 22:11:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbfHNCK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:10:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 965B82084F;
        Wed, 14 Aug 2019 02:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565748658;
        bh=eB7YhVPUizWg8v7xJrnxSGJjFSBOrQI3RZ69wlXaMVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ccHGzwy9AMb5hctfJTd0KfmGAaLfTLZB9iSxhk5wFkC2oDxUg8mPX0Zpey6pRcUGp
         SsqSkHsjKF33PKqJs1yqaONzcmYv2dQACieQ6N6VS9W9awGPVh4sKT0LhfO5FHS8bn
         l8F9ZPAOuA9zOlG9jUC9oG7eQMKooCa4niEknrpI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wen Yang <wen.yang99@zte.com.cn>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 005/123] ASoC: audio-graph-card: fix an use-after-free in graph_get_dai_id()
Date:   Tue, 13 Aug 2019 22:08:49 -0400
Message-Id: <20190814021047.14828-5-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814021047.14828-1-sashal@kernel.org>
References: <20190814021047.14828-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Yang <wen.yang99@zte.com.cn>

[ Upstream commit c152f8491a8d9a4b25afd65a86eb5e55e2a8c380 ]

After calling of_node_put() on the node variable, it is still being
used, which may result in use-after-free.
Fix this issue by calling of_node_put() after the last usage.

Fixes: a0c426fe1433 ("ASoC: simple-card-utils: check "reg" property on asoc_simple_card_get_dai_id()")
Link: https://lore.kernel.org/r/1562743509-30496-5-git-send-email-wen.yang99@zte.com.cn
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/generic/audio-graph-card.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index d5188a179378f..a681ea443fc16 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -63,6 +63,7 @@ static int graph_get_dai_id(struct device_node *ep)
 	struct device_node *endpoint;
 	struct of_endpoint info;
 	int i, id;
+	u32 *reg;
 	int ret;
 
 	/* use driver specified DAI ID if exist */
@@ -83,8 +84,9 @@ static int graph_get_dai_id(struct device_node *ep)
 			return info.id;
 
 		node = of_get_parent(ep);
+		reg = of_get_property(node, "reg", NULL);
 		of_node_put(node);
-		if (of_get_property(node, "reg", NULL))
+		if (reg)
 			return info.port;
 	}
 	node = of_graph_get_port_parent(ep);
-- 
2.20.1

