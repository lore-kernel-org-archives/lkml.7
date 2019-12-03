Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA4BC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E24DE2064B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575414638;
	bh=DGfUc6OPcdg+selrsf0vCRMAyp9NIYMTOzMVaFuB3xs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=in0J/PgmpWmSWQtpbmsnuGK4ph6vtMExrTW2ncK4qthsb49YdsFU6bvOzoauDmUlF
	 Q9k6jKVktNeOsjm2tNnQJAJ0UBEMhN56d18DHBWQCLmpUtMIbL0M8SU06GpDZNyejt
	 LDxNXGmHUsXStYrleX/6bZSLyVGQQDA6Kogezc0U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbfLCWmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:42:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:57138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728626AbfLCWmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:42:17 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE17E2073C;
        Tue,  3 Dec 2019 22:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575412936;
        bh=DGfUc6OPcdg+selrsf0vCRMAyp9NIYMTOzMVaFuB3xs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pG07fZ7XRAjsg+o6P/4Ae7J0hjEPm2KmLUkTQ2a9dBWOgiUusck31L/TlTsl6BTqC
         w+f6ahzBA0N0O7a7HA2muSZJlfM3pZnAkAig7OA98fAi7GL34udtlrl+DYS9YfA80w
         MdSXO4bx2+hEHduwFQU9Y+7PmxLYCxe6mo95YAmc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jaska Uimonen <jaska.uimonen@intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Dragos Tarcatu <dragos_tarcatu@mentor.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 072/135] ASoC: SOF: topology: Fix bytes control size checks
Date:   Tue,  3 Dec 2019 23:35:12 +0100
Message-Id: <20191203213026.735283478@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203213005.828543156@linuxfoundation.org>
References: <20191203213005.828543156@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dragos Tarcatu <dragos_tarcatu@mentor.com>

[ Upstream commit 9508ef5a980f5d847cad9b932b6ada8f2a3466c1 ]

When using the example SOF amp widget topology, KASAN dumps this
when the AMP bytes kcontrol gets loaded:

[ 9.579548] BUG: KASAN: slab-out-of-bounds in
sof_control_load+0x8cc/0xac0 [snd_sof]
[ 9.588194] Write of size 40 at addr ffff8882314559dc by task
systemd-udevd/2411

Fix that by rejecting the topology if the bytes data size > max_size

Fixes: 311ce4fe7637d ("ASoC: SOF: Add support for loading topologies")
Reviewed-by: Jaska Uimonen <jaska.uimonen@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Dragos Tarcatu <dragos_tarcatu@mentor.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20191106145816.9367-1-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/topology.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 96230329e678f..355f04663f576 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -533,15 +533,16 @@ static int sof_control_load_bytes(struct snd_soc_component *scomp,
 	struct soc_bytes_ext *sbe = (struct soc_bytes_ext *)kc->private_value;
 	int max_size = sbe->max;
 
-	if (le32_to_cpu(control->priv.size) > max_size) {
+	/* init the get/put bytes data */
+	scontrol->size = sizeof(struct sof_ipc_ctrl_data) +
+		le32_to_cpu(control->priv.size);
+
+	if (scontrol->size > max_size) {
 		dev_err(sdev->dev, "err: bytes data size %d exceeds max %d.\n",
-			control->priv.size, max_size);
+			scontrol->size, max_size);
 		return -EINVAL;
 	}
 
-	/* init the get/put bytes data */
-	scontrol->size = sizeof(struct sof_ipc_ctrl_data) +
-		le32_to_cpu(control->priv.size);
 	scontrol->control_data = kzalloc(max_size, GFP_KERNEL);
 	cdata = scontrol->control_data;
 	if (!scontrol->control_data)
-- 
2.20.1



