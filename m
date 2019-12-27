Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,NO_DNS_FOR_FROM,SIGNED_OFF_BY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED66C2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 298B920740
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577468535;
	bh=M7HQ865n/QAKmQEHDY5qkcuhxcXhnjjq5IZ81ggnCXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tnVPdB5KeIbpM9P2UrVRqTkXhAlj+/CyBSXI0uHNjJOuK4KG/yczI13gzvqndrZPN
	 qUAmUMvpdQFydyTWz44902ZOD6/byEvE6aX9f/oqnOb+OScKf5ikdW857lgzl6M6OY
	 p0dMScWVAvIAx4fvZQl13YLDb4Vykg3n4K7dk+Ic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfL0RmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 12:42:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:38878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727733AbfL0RmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 12:42:11 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2219321D7E;
        Fri, 27 Dec 2019 17:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577468530;
        bh=M7HQ865n/QAKmQEHDY5qkcuhxcXhnjjq5IZ81ggnCXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ROoYZrvaqqZkK4x6RtS/Lx/rkDjdz4TvRUZsyPnSFH6gnNg1sx3C13xRQJ20nk+Yl
         rnHHOeHtgEMnivgXZPV/qfF1bkWwnxs0CqaPsNSPqPi+krpV6fE1t05l4j7uP+ury5
         qMAgT0r4aC9RuaDheUPKJrUodppTj+HKPCMupJO4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dragos Tarcatu <dragos_tarcatu@mentor.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.4 061/187] ASoC: topology: Check return value for soc_tplg_pcm_create()
Date:   Fri, 27 Dec 2019 12:38:49 -0500
Message-Id: <20191227174055.4923-61-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227174055.4923-1-sashal@kernel.org>
References: <20191227174055.4923-1-sashal@kernel.org>
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
index c92e360d27b8..fd2d22ddc81b 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -2031,6 +2031,7 @@ static int soc_tplg_pcm_elems_load(struct soc_tplg *tplg,
 	int size;
 	int i;
 	bool abi_match;
+	int ret;
 
 	count = le32_to_cpu(hdr->count);
 
@@ -2072,7 +2073,12 @@ static int soc_tplg_pcm_elems_load(struct soc_tplg *tplg,
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

