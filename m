Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3DEC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 13:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5802D2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 13:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfF0Nc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 09:32:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53331 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfF0NcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 09:32:25 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hgUVU-0004av-RA; Thu, 27 Jun 2019 13:32:08 +0000
From:   Colin King <colin.king@canonical.com>
To:     =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ASoC: topology: fix memory leaks on sm, se and sbe
Date:   Thu, 27 Jun 2019 14:32:08 +0100
Message-Id: <20190627133208.9550-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently when a kstrdup fails the error exit paths don't free
the allocations for sm, se and sbe.  This can be fixed by assigning
kc[i].private_value to these before doing the ksrtdup so that the error
exit path will be able to free these objects.

Addresses-Coverity: ("Resource leak")
Fixes: 9f90af3a9952 ("ASoC: topology: Consolidate and fix asoc_tplg_dapm_widget_*_create flow")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/soc-topology.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index fc1f1d6f9e92..dc463f1a9e24 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1326,10 +1326,10 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_dmixer_create(
 		dev_dbg(tplg->dev, " adding DAPM widget mixer control %s at %d\n",
 			mc->hdr.name, i);
 
+		kc[i].private_value = (long)sm;
 		kc[i].name = kstrdup(mc->hdr.name, GFP_KERNEL);
 		if (kc[i].name == NULL)
 			goto err_sm;
-		kc[i].private_value = (long)sm;
 		kc[i].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 		kc[i].access = mc->hdr.access;
 
@@ -1412,10 +1412,10 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_denum_create(
 		dev_dbg(tplg->dev, " adding DAPM widget enum control %s\n",
 			ec->hdr.name);
 
+		kc[i].private_value = (long)se;
 		kc[i].name = kstrdup(ec->hdr.name, GFP_KERNEL);
 		if (kc[i].name == NULL)
 			goto err_se;
-		kc[i].private_value = (long)se;
 		kc[i].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 		kc[i].access = ec->hdr.access;
 
@@ -1524,10 +1524,10 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_dbytes_create(
 			"ASoC: adding bytes kcontrol %s with access 0x%x\n",
 			be->hdr.name, be->hdr.access);
 
+		kc[i].private_value = (long)sbe;
 		kc[i].name = kstrdup(be->hdr.name, GFP_KERNEL);
 		if (kc[i].name == NULL)
 			goto err_sbe;
-		kc[i].private_value = (long)sbe;
 		kc[i].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 		kc[i].access = be->hdr.access;
 
-- 
2.20.1

