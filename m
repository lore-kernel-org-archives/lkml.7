Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A989C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49B2D20684
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbfFENmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 09:42:37 -0400
Received: from mga14.intel.com ([192.55.52.115]:51941 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728127AbfFENmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 09:42:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jun 2019 06:42:33 -0700
X-ExtLoop1: 1
Received: from xxx.igk.intel.com ([10.237.93.170])
  by orsmga004.jf.intel.com with ESMTP; 05 Jun 2019 06:42:31 -0700
From:   =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH 06/14] ASoC: Intel: Skylake: Remove static table index when parsing topology
Date:   Wed,  5 Jun 2019 15:45:48 +0200
Message-Id: <20190605134556.10322-7-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190605134556.10322-1-amadeuszx.slawinski@linux.intel.com>
References: <20190605134556.10322-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently when we remove and reload driver we use previous ref_count
value to start iterating over skl->modules which leads to out of table
access. To fix this just inline the function and calculate indexes
everytime we parse UUID token.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 35 ++++++++++----------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index c69d999d7bf1..44f3b29a7210 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -3477,25 +3477,6 @@ static int skl_tplg_get_int_tkn(struct device *dev,
 	return tkn_count;
 }
 
-static int skl_tplg_get_manifest_uuid(struct device *dev,
-				struct skl *skl,
-				struct snd_soc_tplg_vendor_uuid_elem *uuid_tkn)
-{
-	static int ref_count;
-	struct skl_module *mod;
-
-	if (uuid_tkn->token == SKL_TKN_UUID) {
-		mod = skl->modules[ref_count];
-		memcpy(&mod->uuid, &uuid_tkn->uuid, sizeof(uuid_tkn->uuid));
-		ref_count++;
-	} else {
-		dev_err(dev, "Not an UUID token tkn %d\n", uuid_tkn->token);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 /*
  * Fill the manifest structure by parsing the tokens based on the
  * type.
@@ -3506,6 +3487,7 @@ static int skl_tplg_get_manifest_tkn(struct device *dev,
 {
 	int tkn_count = 0, ret;
 	int off = 0, tuple_size = 0;
+	u8 uuid_index = 0;
 	struct snd_soc_tplg_vendor_array *array;
 	struct snd_soc_tplg_vendor_value_elem *tkn_elem;
 
@@ -3528,9 +3510,18 @@ static int skl_tplg_get_manifest_tkn(struct device *dev,
 			continue;
 
 		case SND_SOC_TPLG_TUPLE_TYPE_UUID:
-			ret = skl_tplg_get_manifest_uuid(dev, skl, array->uuid);
-			if (ret < 0)
-				return ret;
+			if (array->uuid->token != SKL_TKN_UUID) {
+				dev_err(dev, "Not an UUID token: %d\n",
+					array->uuid->token);
+				return -EINVAL;
+			}
+			if (uuid_index >= skl->nr_modules) {
+				dev_err(dev, "Too many UUID tokens\n");
+				return -EINVAL;
+			}
+			memcpy(&skl->modules[uuid_index++]->uuid,
+			       &array->uuid->uuid,
+			       sizeof(array->uuid->uuid));
 
 			tuple_size += sizeof(*array->uuid);
 			continue;
-- 
2.17.1

