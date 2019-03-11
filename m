Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8B7C10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F28BE214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552335191;
	bh=tbxKn7I5O5Y7nr/25fdh6dPFJpzBIQ6AgSfZ9NH11dU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tct9PD+VGjqSxKXkp1butWq3OE3amW76EFzEq3eP3Z/pHblVM0RIJBRin15KjXGPC
	 c0iZTQBRqo68zBv5gCDmPomzm2lz3oWTPqCTCG/SUImlUBv2VACQmAb4su+KA4gmKB
	 kJGjnNGlwhxmJAznKXSZ1W6IJEcWLci0MzNk6a5M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbfCKTzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:55:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:33084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728381AbfCKTzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:55:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD1162177E;
        Mon, 11 Mar 2019 19:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334149;
        bh=tbxKn7I5O5Y7nr/25fdh6dPFJpzBIQ6AgSfZ9NH11dU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hW8iRMfPkb+LnaTTtPyosO4OiXC5S8nTE825Evb/66a0oPjxoKR3gdUFvzRKlbKp8
         gG0zeH+rvBXFe1vplPFVHp41zGiimjT5aFIg2DXp3qfpK+0cPdEaEMnVPV9nCxpZ0a
         HC34VrZaSBjICFF7WhLsRD1MPw9KOS71M4z3VM0U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 15/52] ASoC: topology: fix oops/use-after-free case with dai driver
Date:   Mon, 11 Mar 2019 15:54:39 -0400
Message-Id: <20190311195516.137772-15-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190311195516.137772-1-sashal@kernel.org>
References: <20190311195516.137772-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>

[ Upstream commit 52abe6cc1866ac3d54612f5d80563e6608c0ddfc ]

rmmod/modprobe tests expose a kernel oops when accessing the dai
driver pointer. This comes from the topology design which operates in
multiple passes. Each object removal happens at a specific iteration,
and the code checks for the iteration (order) number after the memory
containing the order was freed.

Fix this be clearing a reference to the dai driver and check its
validity to avoid dereferences.

Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-core.c     | 2 +-
 sound/soc/soc-topology.c | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 2d49492d6069..c8c6c5a6de8f 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -951,7 +951,7 @@ static void soc_remove_dai(struct snd_soc_dai *dai, int order)
 {
 	int err;
 
-	if (!dai || !dai->probed ||
+	if (!dai || !dai->probed || !dai->driver ||
 	    dai->driver->remove_order != order)
 		return;
 
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 045ef136903d..fc79ec6927e3 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -502,6 +502,7 @@ static void remove_dai(struct snd_soc_component *comp,
 {
 	struct snd_soc_dai_driver *dai_drv =
 		container_of(dobj, struct snd_soc_dai_driver, dobj);
+	struct snd_soc_dai *dai;
 
 	if (pass != SOC_TPLG_PASS_PCM_DAI)
 		return;
@@ -509,6 +510,10 @@ static void remove_dai(struct snd_soc_component *comp,
 	if (dobj->ops && dobj->ops->dai_unload)
 		dobj->ops->dai_unload(comp, dobj);
 
+	list_for_each_entry(dai, &comp->dai_list, list)
+		if (dai->driver == dai_drv)
+			dai->driver = NULL;
+
 	kfree(dai_drv->name);
 	list_del(&dobj->list);
 	kfree(dai_drv);
-- 
2.19.1

