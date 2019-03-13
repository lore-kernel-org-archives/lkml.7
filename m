Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703BBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E2EF2184C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552504275;
	bh=fevIuAiKjrqsifqHv9nuVlqfBUelnUXxxO5PPa5RYFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gdMCoWJeQ2Oqip7J+UFvPMCXU8WkjFPIdAVCIEKWHenjlU7lLgAzGYLPLvQ3QxZdD
	 Feku6KgDTd66KJIpzFUUrZRCzaqPa/I595Q3anDyMsCoNURxyi2FJbuuy1BdwxSp1G
	 tfrzlhsuUWcLXa6MWGsIU6DXvSK8/YwUwRHkYmWM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfCMTLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:11:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727352AbfCMTLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:11:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AF032177E;
        Wed, 13 Mar 2019 19:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504269;
        bh=fevIuAiKjrqsifqHv9nuVlqfBUelnUXxxO5PPa5RYFc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i44fms35Iq8eT+uCg9tx8DjZrmAzpWZWhfaZWf8TB/4oLpeJb3Pe73GJRuDGEsDC4
         7DnJ3qQdBaAFplx8g4xUhzm3/QWsGURj67wB1PjHnYdbIbTU71007S27cR/99Fyv86
         BOta/RRc6wlyarKQpk8Oy3qFWYk8x/+BI5WLcHM0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bard liao <yung-chuan.liao@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 23/60] ASoC: topology: free created components in tplg load error
Date:   Wed, 13 Mar 2019 15:09:44 -0400
Message-Id: <20190313191021.158171-23-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191021.158171-1-sashal@kernel.org>
References: <20190313191021.158171-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bard liao <yung-chuan.liao@linux.intel.com>

[ Upstream commit 304017d31df36fb61eb2ed3ebf65fb6870b3c731 ]

Topology resources are no longer needed if any element failed to load.

Signed-off-by: Bard liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-topology.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 045ef136903d..82b3274e408b 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -2482,6 +2482,7 @@ int snd_soc_tplg_component_load(struct snd_soc_component *comp,
 	struct snd_soc_tplg_ops *ops, const struct firmware *fw, u32 id)
 {
 	struct soc_tplg tplg;
+	int ret;
 
 	/* setup parsing context */
 	memset(&tplg, 0, sizeof(tplg));
@@ -2495,7 +2496,12 @@ int snd_soc_tplg_component_load(struct snd_soc_component *comp,
 	tplg.bytes_ext_ops = ops->bytes_ext_ops;
 	tplg.bytes_ext_ops_count = ops->bytes_ext_ops_count;
 
-	return soc_tplg_load(&tplg);
+	ret = soc_tplg_load(&tplg);
+	/* free the created components if fail to load topology */
+	if (ret)
+		snd_soc_tplg_component_remove(comp, SND_SOC_TPLG_INDEX_ALL);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_tplg_component_load);
 
-- 
2.19.1

