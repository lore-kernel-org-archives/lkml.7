Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BF4C2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE51921D7E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577468971;
	bh=0ef4R91hDWE4O4cgP2m+U+Frfl8u+9MVu8EB+owp2iI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jDk1ZWnjTraU1Wp9rWHMcgODae2WSizvs3GVc5s8mz/IsbkY1nk5eoirKPJqZUNOg
	 DirOePjYeWWwXH3xo/4s+dPLepgwezoi6z9WRpFz/TUjJ22mMCxT6HUbyqFiCPwqx7
	 zL88O0z9PfG4Wk/z+mxLGXvFAgZRCMXOT7DzJYGM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbfL0Rt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 12:49:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:42644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728466AbfL0Roa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 12:44:30 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14F2F24125;
        Fri, 27 Dec 2019 17:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577468669;
        bh=0ef4R91hDWE4O4cgP2m+U+Frfl8u+9MVu8EB+owp2iI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rAtnKYuoHQlDTd3A+aG6GgTUYIIF4Gs2HXQsoHnWFxT+FKx2ZMJKFB4frgwJanZPx
         nw8fEnMF62Mk+OBfHQKJ7PVockvg5X+1egpBrDOvhYZt5F2Ovpqxpx47ldn9VRTHR9
         FM74XQnUku5CXVk+HDA25sRr2rvCNSzoSYU+bwfc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dragos Tarcatu <dragos_tarcatu@mentor.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 4.19 30/84] ASoC: topology: Check return value for soc_tplg_pcm_create()
Date:   Fri, 27 Dec 2019 12:42:58 -0500
Message-Id: <20191227174352.6264-30-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227174352.6264-1-sashal@kernel.org>
References: <20191227174352.6264-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dragos Tarcatu <dragos_tarcatu@mentor.com>

[ Upstream commit a3039aef52d9ffeb67e9211899cd3e8a2953a01f ]

The return value of soc_tplg_pcm_create() is currently not checked
in soc_tplg_pcm_elems_load(). If an error is to occur there, the
topology ignores it and continues loading.

Fix that by checking the status and rejecting the topology on error.

Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Dragos Tarcatu <dragos_tarcatu@mentor.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20191210003939.15752-3-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-topology.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 88a7e860b175..069f38fbf07b 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1890,6 +1890,7 @@ static int soc_tplg_pcm_elems_load(struct soc_tplg *tplg,
 	int count = hdr->count;
 	int i;
 	bool abi_match;
+	int ret;
 
 	if (tplg->pass != SOC_TPLG_PASS_PCM_DAI)
 		return 0;
@@ -1926,7 +1927,12 @@ static int soc_tplg_pcm_elems_load(struct soc_tplg *tplg,
 		}
 
 		/* create the FE DAIs and DAI links */
-		soc_tplg_pcm_create(tplg, _pcm);
+		ret = soc_tplg_pcm_create(tplg, _pcm);
+		if (ret < 0) {
+			if (!abi_match)
+				kfree(_pcm);
+			return ret;
+		}
 
 		/* offset by version-specific struct size and
 		 * real priv data size
-- 
2.20.1

