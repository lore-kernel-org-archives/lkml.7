Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E94C73C68
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 05:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE0E20861
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 05:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfGJFFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 01:05:12 -0400
Received: from smtprelay0233.hostedemail.com ([216.40.44.233]:61000 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726844AbfGJFE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 01:04:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id C1E6E180A68D1;
        Wed, 10 Jul 2019 05:04:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: pain10_e348f2364e1f
X-Filterd-Recvd-Size: 1743
Received: from joe-laptop.perches.com (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Wed, 10 Jul 2019 05:04:57 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: [PATCH 12/12] ASoC: wcd9335: Fix misuse of GENMASK macro
Date:   Tue,  9 Jul 2019 22:04:25 -0700
Message-Id: <92e31a9f321fe731d428ec3ec9d4654ea8a16d1b.1562734889.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1562734889.git.joe@perches.com>
References: <cover.1562734889.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arguments are supposed to be ordered high then low.

Signed-off-by: Joe Perches <joe@perches.com>
---
 sound/soc/codecs/wcd-clsh-v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wcd-clsh-v2.c b/sound/soc/codecs/wcd-clsh-v2.c
index c397d713f01a..cc5a9c9b918b 100644
--- a/sound/soc/codecs/wcd-clsh-v2.c
+++ b/sound/soc/codecs/wcd-clsh-v2.c
@@ -65,7 +65,7 @@ struct wcd_clsh_ctrl {
 #define WCD9XXX_FLYBACK_EN_PWDN_WITH_DELAY			0
 #define WCD9XXX_RX_BIAS_FLYB_BUFF			WCD9335_REG(0x6, 0xC7)
 #define WCD9XXX_RX_BIAS_FLYB_VNEG_5_UA_MASK		GENMASK(7, 4)
-#define WCD9XXX_RX_BIAS_FLYB_VPOS_5_UA_MASK		GENMASK(0, 3)
+#define WCD9XXX_RX_BIAS_FLYB_VPOS_5_UA_MASK		GENMASK(3, 0)
 #define WCD9XXX_HPH_L_EN				WCD9335_REG(0x6, 0xD3)
 #define WCD9XXX_HPH_CONST_SEL_L_MASK			GENMASK(7, 3)
 #define WCD9XXX_HPH_CONST_SEL_BYPASS			0
-- 
2.15.0

