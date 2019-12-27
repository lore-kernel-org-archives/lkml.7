Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A409C2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67CE9206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577469344;
	bh=ZWtIO+a0vaQunMSWxVY3ld+/seCZC51wG2H3XXUbHJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kI6iFfmigI4wwXwMlG4lH7Q/e91/R41Cpq42jJc6gmZmseqr8gbuSdeY0h2IvOaAO
	 grJtdM8kmzYVD5ItdvMlipu/YxTdxhhbh4EGee29CXNg4bIFxsZpr6P5T3GU4LDWbR
	 tLhvZs9UtWhtY3GU6AiHXV5c+iK7THx+1JSc6/gI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbfL0RmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 12:42:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:38856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727768AbfL0RmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 12:42:10 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E96FA22B48;
        Fri, 27 Dec 2019 17:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577468529;
        bh=ZWtIO+a0vaQunMSWxVY3ld+/seCZC51wG2H3XXUbHJ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E3DEXgk96m8hbXUGTOgHqQ+MMy5eMyKtmu1IWXV57J390muTo7IYjlasq/9qUsYwH
         pLtZ8wLuM1+QiRsrDWmsIMjzbgQzoLByG6oyIf6Ndkee3pZslNxsAUdWhHy7MuUf9n
         qTygd1HY3YSBOmA43oGh6PC9Ec1DUpDaweecLwGY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dragos Tarcatu <dragos_tarcatu@mentor.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.4 060/187] ASoC: topology: Check return value for snd_soc_add_dai_link()
Date:   Fri, 27 Dec 2019 12:38:48 -0500
Message-Id: <20191227174055.4923-60-sashal@kernel.org>
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

[ Upstream commit 76d2703649321c296df7ec0dafd50add96215de4 ]

snd_soc_add_dai_link() might fail. This situation occurs for
instance in a very specific use case where a PCM device and a
Back End DAI link are given identical names in the topology.
When this happens, soc_new_pcm_runtime() fails and then
snd_soc_add_dai_link() returns -ENOMEM when called from
soc_tplg_fe_link_create(). Because of that, the link will not
get added into the card list, so any attempt to remove it later
ends up in a panic.

Fix that by checking the return status and free the memory in case
of an error.

Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Dragos Tarcatu <dragos_tarcatu@mentor.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20191210003939.15752-2-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-topology.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 0fd032914a31..c92e360d27b8 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1918,11 +1918,13 @@ static int soc_tplg_fe_link_create(struct soc_tplg *tplg,
 	ret = soc_tplg_dai_link_load(tplg, link, NULL);
 	if (ret < 0) {
 		dev_err(tplg->comp->dev, "ASoC: FE link loading failed\n");
-		kfree(link->name);
-		kfree(link->stream_name);
-		kfree(link->cpus->dai_name);
-		kfree(link);
-		return ret;
+		goto err;
+	}
+
+	ret = snd_soc_add_dai_link(tplg->comp->card, link);
+	if (ret < 0) {
+		dev_err(tplg->comp->dev, "ASoC: adding FE link failed\n");
+		goto err;
 	}
 
 	link->dobj.index = tplg->index;
@@ -1930,8 +1932,13 @@ static int soc_tplg_fe_link_create(struct soc_tplg *tplg,
 	link->dobj.type = SND_SOC_DOBJ_DAI_LINK;
 	list_add(&link->dobj.list, &tplg->comp->dobj_list);
 
-	snd_soc_add_dai_link(tplg->comp->card, link);
 	return 0;
+err:
+	kfree(link->name);
+	kfree(link->stream_name);
+	kfree(link->cpus->dai_name);
+	kfree(link);
+	return ret;
 }
 
 /* create a FE DAI and DAI link from the PCM object */
-- 
2.20.1

