Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1043AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D44F22063F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553709919;
	bh=nwtcJiy1x6Yub+yReLQSqksrZ2yXAUeHHdwgOl5CP2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LVVyitl2bdZWV7o/uk1t9WBZQ+zVpGSM6il+onXQr5urQx2uRiUZS84MgV5/pNHlW
	 YRSTJSJUD4wEXjIY9kPAqHJzNrOjDqDltUvdP0sptKRzGDpTga9Y3PZluLDAqT9LLM
	 u2lfOdyCd2igXQ9ReGoQiJC6xnWvLD5JnncZXG1A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387661AbfC0SFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:05:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:46282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387618AbfC0SFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:05:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37A5221738;
        Wed, 27 Mar 2019 18:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709913;
        bh=nwtcJiy1x6Yub+yReLQSqksrZ2yXAUeHHdwgOl5CP2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rf2ZN2fwb7UFjcTQ3Zoak3ABeEn6rbdgV00wOIV+byn/HX0rq8/mzs4e545tuHfnO
         6MQ7K5wt2vzI1TnQYsMe9kzZ/M5TG7BK/AwJQB1XCwkKDSL3kGn7Fg/+Tk/uIg++mG
         HuqTF5Vz6n7KQMZ7tzFuaxpvKxtASwxEXRsUIJhs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.de>, Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 108/262] ASoC: qcom: Fix of-node refcount unbalance in qcom_snd_parse_of()
Date:   Wed, 27 Mar 2019 13:59:23 -0400
Message-Id: <20190327180158.10245-108-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 70b773219a32c7b8f3e53e041bc023ad99fd81f4 ]

Although qcom_snd_parse_of() tries to manage the of-node refcount,
there are still a few places that lead to the unblanced refcount in
the error code path.  Namely,

- for_each_child_of_node() needs to unreference the iterator node if
  aborting the loop in the middle,
- cpu, codec and platform node objects have to be unreferenced at each
  iteration,
- platform and codec node objects have to be referred before jumping
  to the error handling code that unreference them unconditionally.

This patch tries to address these by moving the assignment of platform
and codec node objects to the beginning of the loop and adding the
of_node_put() calls adequately.

Fixes: c25e295cd77b ("ASoC: qcom: Add support to parse common audio device nodes")
Cc: Patrick Lai <plai@codeaurora.org>
Cc: Banajit Goswami <bgoswami@codeaurora.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/qcom/common.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/common.c b/sound/soc/qcom/common.c
index 4715527054e5..5661025e8cec 100644
--- a/sound/soc/qcom/common.c
+++ b/sound/soc/qcom/common.c
@@ -42,6 +42,9 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 	link = card->dai_link;
 	for_each_child_of_node(dev->of_node, np) {
 		cpu = of_get_child_by_name(np, "cpu");
+		platform = of_get_child_by_name(np, "platform");
+		codec = of_get_child_by_name(np, "codec");
+
 		if (!cpu) {
 			dev_err(dev, "Can't find cpu DT node\n");
 			ret = -EINVAL;
@@ -63,8 +66,6 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 			goto err;
 		}
 
-		platform = of_get_child_by_name(np, "platform");
-		codec = of_get_child_by_name(np, "codec");
 		if (codec && platform) {
 			link->platform_of_node = of_parse_phandle(platform,
 					"sound-dai",
@@ -100,10 +101,15 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 		link->dpcm_capture = 1;
 		link->stream_name = link->name;
 		link++;
+
+		of_node_put(cpu);
+		of_node_put(codec);
+		of_node_put(platform);
 	}
 
 	return 0;
 err:
+	of_node_put(np);
 	of_node_put(cpu);
 	of_node_put(codec);
 	of_node_put(platform);
-- 
2.19.1

