Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653B0C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F6F521848
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731392AbfJIPgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 11:36:23 -0400
Received: from inva020.nxp.com ([92.121.34.13]:49886 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730546AbfJIPgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 11:36:20 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 523FB1A01A2;
        Wed,  9 Oct 2019 17:36:18 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 463731A0084;
        Wed,  9 Oct 2019 17:36:18 +0200 (CEST)
Received: from fsr-ub1864-103.ea.freescale.net (fsr-ub1864-103.ea.freescale.net [10.171.82.17])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id D2A8B2060B;
        Wed,  9 Oct 2019 17:36:17 +0200 (CEST)
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     perex@perex.cz, tiwai@suse.com, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kuninori.morimoto.gx@renesas.com,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 2/2] ASoC: simple_card_utils.h: Fix potential multiple redefinition error
Date:   Wed,  9 Oct 2019 18:36:15 +0300
Message-Id: <20191009153615.32105-3-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191009153615.32105-1-daniel.baluta@nxp.com>
References: <20191009153615.32105-1-daniel.baluta@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

asoc_simple_debug_info and asoc_simple_debug_dai must be static
otherwise we might a compilation error if the compiler decides
not to inline the given function.

Fixes: 0580dde59438686d ("ASoC: simple-card-utils: add asoc_simple_debug_info()")
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 include/sound/simple_card_utils.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index 293ff8115960..bbdd1542d6f1 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -136,9 +136,9 @@ int asoc_simple_init_priv(struct asoc_simple_priv *priv,
 			       struct link_info *li);
 
 #ifdef DEBUG
-inline void asoc_simple_debug_dai(struct asoc_simple_priv *priv,
-				  char *name,
-				  struct asoc_simple_dai *dai)
+static inline void asoc_simple_debug_dai(struct asoc_simple_priv *priv,
+					 char *name,
+					 struct asoc_simple_dai *dai)
 {
 	struct device *dev = simple_priv_to_dev(priv);
 
@@ -168,7 +168,7 @@ inline void asoc_simple_debug_dai(struct asoc_simple_priv *priv,
 		dev_dbg(dev, "%s clk %luHz\n", name, clk_get_rate(dai->clk));
 }
 
-inline void asoc_simple_debug_info(struct asoc_simple_priv *priv)
+static inline void asoc_simple_debug_info(struct asoc_simple_priv *priv)
 {
 	struct snd_soc_card *card = simple_priv_to_card(priv);
 	struct device *dev = simple_priv_to_dev(priv);
-- 
2.17.1

