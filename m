Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CFEC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1822A2184B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368580;
	bh=+1KlLDM8bPlxwxjTFr8APLBnXvi87mEFfJbc9S1ue+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ny3FmDTlhNxWuxbvY7yJi2xp25bG4SzUP62Gteo0bILpk6AzB5ILj+8nseTdqCmut
	 U8qI5E37yW92CWyiajpEJCwRLtu1uSXR/G6sfZSFAtC4sCc1v/PJrzXhk1YgexJJd2
	 K9efF5eQSLx/ix4VJIqwztgdXeOMd4Kfm/cI3SiY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731248AbfDDJC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:02:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731706AbfDDJCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:02:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EC322177E;
        Thu,  4 Apr 2019 09:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368573;
        bh=+1KlLDM8bPlxwxjTFr8APLBnXvi87mEFfJbc9S1ue+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IBQLvPLRObtFPJOF1x6YT92HJLOQ1jl4qclBQW8LK6fKpMxa7+WUroQj26aEV59BB
         7rjpoknzicwFsFVTzhwUPd5chIv1jjtJvh3XAA0tFYIG5gTbOrhomaH0UP9kzR+5zR
         kThtgim2yOkvxcevPVRvA0c1VgRtUpTB2xYOesAE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 073/187] ASoC: qcom: Fix of-node refcount unbalance in qcom_snd_parse_of()
Date:   Thu,  4 Apr 2019 10:46:50 +0200
Message-Id: <20190404084606.489340270@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



