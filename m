Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BB3C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E77206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329907;
	bh=zBKPeTHLx+7gHS1gVcB9ZzU79/NDSGtAcXE7MyrHUk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BOrSinNUPwJy0T+TshZqgrfaAKb7shw91ZDLoLbAIbdgYf0WGSk4P0ogNWP+8uxCn
	 HDdSuRCVh4mTXU4GrpI9I3MCixL/e6s7sLEvFeIZA+LhQy6PZJhyAwT30ayVx0WDSM
	 6kvphfVcBmV97YSB+h5nLgiLgJFd8KX/tDAtjej0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbfD0Bvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:51:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:44816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728150AbfD0BlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:41:03 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2B4220B7C;
        Sat, 27 Apr 2019 01:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329262;
        bh=zBKPeTHLx+7gHS1gVcB9ZzU79/NDSGtAcXE7MyrHUk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2a1Vf8h5EDa/3Z8MUMwJALibBQ8rTo9T6vbK/ATxFcZXfi5VsVfYN7Mo6yuBxBz4M
         RNmR8maAYPZiymB0S6L83OzaHu/bnEtsEoAK8cRpHYJcvN6Tg+UJb47NAaeXSODEaG
         AYgVlumnu39SdrToHOMGmhJ8GQCPzGeRX6E0DHIw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rander Wang <rander.wang@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 07/53] ASoC:intel:skl:fix a simultaneous playback & capture issue on hda platform
Date:   Fri, 26 Apr 2019 21:40:04 -0400
Message-Id: <20190427014051.7522-7-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427014051.7522-1-sashal@kernel.org>
References: <20190427014051.7522-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rander Wang <rander.wang@linux.intel.com>

[ Upstream commit c899df3e9b0bf7b76e642aed1a214582ea7012d5 ]

If playback and capture are enabled concurrently, when the capture stops
the output becomes inaudile. The playback application will become stuck
and underrun after a timeout.

This is caused by mistaken use of the stream_id, which should only be
set for playback and not for capture

Tested on Apollolake and Kabylake with SST driver.

Signed-off-by: Rander Wang <rander.wang@linux.intel.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/skylake/skl-pcm.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 823e39103edd..6b2c8c6e7a00 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -180,6 +180,7 @@ int skl_pcm_link_dma_prepare(struct device *dev, struct skl_pipe_params *params)
 	struct hdac_stream *hstream;
 	struct hdac_ext_stream *stream;
 	struct hdac_ext_link *link;
+	unsigned char stream_tag;
 
 	hstream = snd_hdac_get_stream(bus, params->stream,
 					params->link_dma_id + 1);
@@ -198,10 +199,13 @@ int skl_pcm_link_dma_prepare(struct device *dev, struct skl_pipe_params *params)
 
 	snd_hdac_ext_link_stream_setup(stream, format_val);
 
-	list_for_each_entry(link, &bus->hlink_list, list) {
-		if (link->index == params->link_index)
-			snd_hdac_ext_link_set_stream_id(link,
-					hstream->stream_tag);
+	stream_tag = hstream->stream_tag;
+	if (stream->hstream.direction == SNDRV_PCM_STREAM_PLAYBACK) {
+		list_for_each_entry(link, &bus->hlink_list, list) {
+			if (link->index == params->link_index)
+				snd_hdac_ext_link_set_stream_id(link,
+								stream_tag);
+		}
 	}
 
 	stream->link_prepared = 1;
@@ -640,6 +644,7 @@ static int skl_link_hw_free(struct snd_pcm_substream *substream,
 	struct hdac_ext_stream *link_dev =
 				snd_soc_dai_get_dma_data(dai, substream);
 	struct hdac_ext_link *link;
+	unsigned char stream_tag;
 
 	dev_dbg(dai->dev, "%s: %s\n", __func__, dai->name);
 
@@ -649,7 +654,11 @@ static int skl_link_hw_free(struct snd_pcm_substream *substream,
 	if (!link)
 		return -EINVAL;
 
-	snd_hdac_ext_link_clear_stream_id(link, hdac_stream(link_dev)->stream_tag);
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		stream_tag = hdac_stream(link_dev)->stream_tag;
+		snd_hdac_ext_link_clear_stream_id(link, stream_tag);
+	}
+
 	snd_hdac_ext_stream_release(link_dev, HDAC_EXT_STREAM_TYPE_LINK);
 	return 0;
 }
-- 
2.19.1

