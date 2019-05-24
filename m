Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D53DC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 16:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08AF620675
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 16:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390613AbfEXQK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 12:10:57 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.114]:34245 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389588AbfEXQK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 12:10:57 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id EDB43B463C8
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 11:10:55 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id UCmVhFzoF4FKpUCmVhcBNx; Fri, 24 May 2019 11:10:55 -0500
X-Authority-Reason: nr=8
Received: from [189.250.47.159] (port=47748 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hUCmS-001c1Z-RV; Fri, 24 May 2019 11:10:55 -0500
Date:   Fri, 24 May 2019 11:10:51 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ASoC: SOF: topology: Use struct_size() helper
Message-ID: <20190524161051.GA26061@embeddedor>
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
X-Exim-ID: 1hUCmS-001c1Z-RV
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.47.159]:47748
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
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

sizeof(struct sof_ipc_ctrl_data) + sizeof(struct sof_ipc_ctrl_value_chan) *
	le32_to_cpu(mc->num_channels)

with:

struct_size(scontrol->control_data, chanv, le32_to_cpu(mc->num_channels))

and so on...

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/soc/sof/topology.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index c88afa872a58..745cb875863c 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -442,9 +442,8 @@ static int sof_control_load_volume(struct snd_soc_component *scomp,
 		return -EINVAL;
 
 	/* init the volume get/put data */
-	scontrol->size = sizeof(struct sof_ipc_ctrl_data) +
-			 sizeof(struct sof_ipc_ctrl_value_chan) *
-			 le32_to_cpu(mc->num_channels);
+	scontrol->size = struct_size(scontrol->control_data, chanv,
+				     le32_to_cpu(mc->num_channels));
 	scontrol->control_data = kzalloc(scontrol->size, GFP_KERNEL);
 	if (!scontrol->control_data)
 		return -ENOMEM;
@@ -501,9 +500,8 @@ static int sof_control_load_enum(struct snd_soc_component *scomp,
 		return -EINVAL;
 
 	/* init the enum get/put data */
-	scontrol->size = sizeof(struct sof_ipc_ctrl_data) +
-			 sizeof(struct sof_ipc_ctrl_value_chan) *
-			 le32_to_cpu(ec->num_channels);
+	scontrol->size = struct_size(scontrol->control_data, chanv,
+				     le32_to_cpu(ec->num_channels));
 	scontrol->control_data = kzalloc(scontrol->size, GFP_KERNEL);
 	if (!scontrol->control_data)
 		return -ENOMEM;
-- 
2.21.0

