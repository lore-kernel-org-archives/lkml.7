Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DE2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D131320828
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfCVQX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:23:59 -0400
Received: from mga04.intel.com ([192.55.52.120]:16427 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbfCVQX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 12:23:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Mar 2019 09:23:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="329760961"
Received: from plaxmina-desktop.iind.intel.com ([10.66.245.186])
  by fmsmga006.fm.intel.com with ESMTP; 22 Mar 2019 09:23:56 -0700
From:   Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org,
        pankaj.laxminarayan.bharadiya@intel.com
Subject: [PATCH] ASoC: dapm: Initialize private_value in snd_soc_dapm_new_dai
Date:   Fri, 22 Mar 2019 21:53:39 +0530
Message-Id: <1553271819-24576-1-git-send-email-pankaj.laxminarayan.bharadiya@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of single config, private_value is left uninitialized.

The private_value does need to be initialized or in
snd_soc_dapm_new_control_unlocked() call failure case, it leads to a
bogus free in snd_soc_dapm_free_kcontrol()

Signed-off-by: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
---
 sound/soc/soc-dapm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 67b032c..665a6b1 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -4042,7 +4042,7 @@ snd_soc_dapm_new_dai(struct snd_soc_card *card, struct snd_soc_pcm_runtime *rtd,
 	struct snd_soc_dapm_widget template;
 	struct snd_soc_dapm_widget *w;
 	const char **w_param_text;
-	unsigned long private_value;
+	unsigned long private_value = 0;
 	char *link_name;
 	int ret;
 
-- 
2.7.4

