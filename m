Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F700C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17FF0218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbfCUKLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 06:11:49 -0400
Received: from mga18.intel.com ([134.134.136.126]:63573 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfCUKLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 06:11:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 03:11:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,252,1549958400"; 
   d="scan'208";a="142578744"
Received: from plaxmina-desktop.iind.intel.com ([10.66.245.186])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Mar 2019 03:11:45 -0700
From:   Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org,
        pankaj.laxminarayan.bharadiya@intel.com
Subject: [PATCH] ASoC: dapm: Fix NULL pointer dereference in snd_soc_dapm_new_dai
Date:   Thu, 21 Mar 2019 15:41:25 +0530
Message-Id: <1553163085-16845-1-git-send-email-pankaj.laxminarayan.bharadiya@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of single config, w_param_text is NULL.
In snd_soc_dapm_new_control_unlocked() call failure case, it will end
up calling snd_soc_dapm_free_kcontrol() unconditionally and result in
NULL pointer dereference.

Signed-off-by: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
---
 sound/soc/soc-dapm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 1ec06ef..ba6cb37 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -4094,8 +4094,9 @@ snd_soc_dapm_new_dai(struct snd_soc_card *card, struct snd_soc_pcm_runtime *rtd,
 
 outfree_kcontrol_news:
 	devm_kfree(card->dev, (void *)template.kcontrol_news);
-	snd_soc_dapm_free_kcontrol(card, &private_value,
-				   rtd->dai_link->num_params, w_param_text);
+	if (w_param_text)
+		snd_soc_dapm_free_kcontrol(card, &private_value,
+				rtd->dai_link->num_params, w_param_text);
 param_fail:
 	devm_kfree(card->dev, link_name);
 	return ERR_PTR(ret);
-- 
2.7.4

