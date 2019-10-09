Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BF8ECE58E
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC9B621848
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731133AbfJIPgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 11:36:19 -0400
Received: from inva021.nxp.com ([92.121.34.21]:42650 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729883AbfJIPgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 11:36:19 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C8BB92001E1;
        Wed,  9 Oct 2019 17:36:17 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BB4D12001D5;
        Wed,  9 Oct 2019 17:36:17 +0200 (CEST)
Received: from fsr-ub1864-103.ea.freescale.net (fsr-ub1864-103.ea.freescale.net [10.171.82.17])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 289AC2060B;
        Wed,  9 Oct 2019 17:36:17 +0200 (CEST)
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     perex@perex.cz, tiwai@suse.com, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kuninori.morimoto.gx@renesas.com,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 1/2] ASoC: simple_card_utils.h: Add missing include
Date:   Wed,  9 Oct 2019 18:36:14 +0300
Message-Id: <20191009153615.32105-2-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191009153615.32105-1-daniel.baluta@nxp.com>
References: <20191009153615.32105-1-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When debug is enabled compiler cannot find the definition of
clk_get_rate resulting in the following error:

./include/sound/simple_card_utils.h:168:40: note: previous implicit
declaration of ‘clk_get_rate’ was here
   dev_dbg(dev, "%s clk %luHz\n", name, clk_get_rate(dai->clk));
./include/sound/simple_card_utils.h:168:3: note: in expansion of macro
‘dev_dbg’
   dev_dbg(dev, "%s clk %luHz\n", name, clk_get_rate(dai->clk));

Fix this by including the appropriate header.

Fixes: 0580dde59438686d ("ASoC: simple-card-utils: add asoc_simple_debug_info()")
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 include/sound/simple_card_utils.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index 985a5f583de4..293ff8115960 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -8,6 +8,7 @@
 #ifndef __SIMPLE_CARD_UTILS_H
 #define __SIMPLE_CARD_UTILS_H
 
+#include <linux/clk.h>
 #include <sound/soc.h>
 
 #define asoc_simple_init_hp(card, sjack, prefix) \
-- 
2.17.1

