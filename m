Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F84C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 22:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD2A20868
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 22:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388351AbfEWWXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 18:23:38 -0400
Received: from gateway22.websitewelcome.com ([192.185.46.187]:23679 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388104AbfEWWXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 18:23:38 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 8F9015EAC
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 17:23:36 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id Tw7chWQekYTGMTw7chWxxT; Thu, 23 May 2019 17:23:36 -0500
X-Authority-Reason: nr=8
Received: from [189.250.47.159] (port=44754 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hTw7b-001I7r-DQ; Thu, 23 May 2019 17:23:35 -0500
Date:   Thu, 23 May 2019 17:23:33 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ASoC: Intel: Skylake: Use struct_size() helper
Message-ID: <20190523222333.GA22695@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.47.159
X-Source-L: No
X-Exim-ID: 1hTw7b-001I7r-DQ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.47.159]:44754
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes, in particular in the
context in which this code is being used.

So, replace the following form:

uuid_params->num_modules * sizeof(struct skl_mod_inst_map) + sizeof(uuid_params->num_modules)

with:

struct_size(params, u.map, uuid_params->num_modules)

and so on...

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/soc/intel/skylake/skl-topology.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 389f1862bc43..c69d999d7bf1 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -941,9 +941,7 @@ static int skl_tplg_find_moduleid_from_uuid(struct skl *skl,
 
 	if (bc->set_params == SKL_PARAM_BIND && bc->max) {
 		uuid_params = (struct skl_kpb_params *)bc->params;
-		size = uuid_params->num_modules *
-			sizeof(struct skl_mod_inst_map) +
-			sizeof(uuid_params->num_modules);
+		size = struct_size(params, u.map, uuid_params->num_modules);
 
 		params = devm_kzalloc(bus->dev, size, GFP_KERNEL);
 		if (!params)
@@ -3315,7 +3313,7 @@ static int skl_tplg_get_int_tkn(struct device *dev,
 		struct snd_soc_tplg_vendor_value_elem *tkn_elem,
 		struct skl *skl)
 {
-	int tkn_count = 0, ret, size;
+	int tkn_count = 0, ret;
 	static int mod_idx, res_val_idx, intf_val_idx, dir, pin_idx;
 	struct skl_module_res *res = NULL;
 	struct skl_module_iface *fmt = NULL;
@@ -3323,6 +3321,7 @@ static int skl_tplg_get_int_tkn(struct device *dev,
 	static struct skl_astate_param *astate_table;
 	static int astate_cfg_idx, count;
 	int i;
+	size_t size;
 
 	if (skl->modules) {
 		mod = skl->modules[mod_idx];
@@ -3366,8 +3365,8 @@ static int skl_tplg_get_int_tkn(struct device *dev,
 			return -EINVAL;
 		}
 
-		size = tkn_elem->value * sizeof(struct skl_astate_param) +
-				sizeof(count);
+		size = struct_size(skl->cfg.astate_cfg, astate_table,
+				   tkn_elem->value);
 		skl->cfg.astate_cfg = devm_kzalloc(dev, size, GFP_KERNEL);
 		if (!skl->cfg.astate_cfg)
 			return -ENOMEM;
-- 
2.21.0

