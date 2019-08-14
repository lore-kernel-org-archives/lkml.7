Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E33FC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D07720665
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565750417;
	bh=5CbHaWA4pPlQGT5osSB1fwo4tu8bfwW8MhI9pWYmO14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qqYGhv5x2RRe9zQ0RhTMdjjSgmc7vw0cejExrIKTybHYxzNGLXZxo0JMAzLYSz4Mn
	 sv72LHhmLo9vA5gt2q/CMTIUuW+cRaxKw6l/ddeLqfSHKORTVx2E4MnVeLVfvITiBo
	 3fmgR9ypO3NXnaCmuAaJWfAy6hzikLW3SpZYtyr0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfHNCLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 22:11:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:43196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727128AbfHNCLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:11:01 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBE7420842;
        Wed, 14 Aug 2019 02:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565748660;
        bh=5CbHaWA4pPlQGT5osSB1fwo4tu8bfwW8MhI9pWYmO14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0milqljLfnLaBjyahrG9XapEaZtko7LVPzgYdD5/9+HdWJyN+QWQ6HTa+SC+WiO+O
         e9WIVQ7C59umUglAJwAoR0rHHHYucXvEZpGpMeTrTSGY6HluopljnrlGGIilasRyg/
         st5uhATwS59RgHPpaOL4KFnpGPXIrUd+w249l07A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 006/123] ASoC: audio-graph-card: add missing const at graph_get_dai_id()
Date:   Tue, 13 Aug 2019 22:08:50 -0400
Message-Id: <20190814021047.14828-6-sashal@kernel.org>
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

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[ Upstream commit ec3042ad39d4e2ddbc3a3344f90bb10d8feb53bc ]

commit c152f8491a8d9 ("ASoC: audio-graph-card: fix an use-after-free in
graph_get_dai_id()") fixups use-after-free issue,
but, it need to use "const" for reg. This patch adds it.

We will have below without this patch

LINUX/sound/soc/generic/audio-graph-card.c: In function 'graph_get_dai_id':
LINUX/sound/soc/generic/audio-graph-card.c:87:7: warning: assignment discards\
 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
   reg = of_get_property(node, "reg", NULL);

Fixes: c152f8491a8d9 ("ASoC: audio-graph-card: fix an use-after-free in graph_get_dai_id()")
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Wen Yang <wen.yang99@zte.com.cn>
Link: https://lore.kernel.org/r/87sgrd43ja.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/generic/audio-graph-card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index a681ea443fc16..6398741ebd0ef 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -63,7 +63,7 @@ static int graph_get_dai_id(struct device_node *ep)
 	struct device_node *endpoint;
 	struct of_endpoint info;
 	int i, id;
-	u32 *reg;
+	const u32 *reg;
 	int ret;
 
 	/* use driver specified DAI ID if exist */
-- 
2.20.1

