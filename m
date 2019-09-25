Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CEEC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 18:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C8721655
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 18:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443201AbfIYSeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 14:34:13 -0400
Received: from inva021.nxp.com ([92.121.34.21]:41344 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437947AbfIYSeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 14:34:13 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 51CFD200090;
        Wed, 25 Sep 2019 20:34:11 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 45014200043;
        Wed, 25 Sep 2019 20:34:11 +0200 (CEST)
Received: from fsr-ub1864-103.ea.freescale.net (fsr-ub1864-103.ea.freescale.net [10.171.82.17])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id D458F20634;
        Wed, 25 Sep 2019 20:34:10 +0200 (CEST)
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ranjani.sridharan@intel.com,
        pierre-louis.bossart@intel.com, linux-imx@nxp.com,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH] ASoC: core: Clarify usage of ignore_machine
Date:   Wed, 25 Sep 2019 21:33:58 +0300
Message-Id: <20190925183358.11955-1-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For a sound card ignore_machine means that existing FEs links should be
ignored and existing BEs links should be overridden with some information
from the matching component driver.

Current code make some confusions about this so fix it!

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/soc-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 88978a3036c4..e32a45f6bd88 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1853,7 +1853,7 @@ static void soc_check_tplg_fes(struct snd_soc_card *card)
 
 	for_each_component(component) {
 
-		/* does this component override FEs ? */
+		/* does this component override BEs ? */
 		if (!component->driver->ignore_machine)
 			continue;
 
@@ -1874,7 +1874,7 @@ static void soc_check_tplg_fes(struct snd_soc_card *card)
 				continue;
 			}
 
-			dev_info(card->dev, "info: override FE DAI link %s\n",
+			dev_info(card->dev, "info: override BE DAI link %s\n",
 				 card->dai_link[i].name);
 
 			/* override platform component */
-- 
2.17.1

