Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7293BC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43624206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556330230;
	bh=aNnO9KjwSi+rXD9Zfk73M4FcsvxaGB5d7VpjGs+Sd18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GLI6JTmQrphO85Wwoy9onfwBw4TsuO/4hmNLL4ed6RPAwqme9c4vNlQdbUoF5UBa9
	 ES8pFt2Cn/SlAOgXTEbPVH19tsUghDzMKYJAQ+Iakbb51h7fIy2/lajrbFcsIXE6xx
	 NvFm+AVeUZf0AbgjNzKd0xHAJKVooyT2OMB8r/M8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfD0B5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:57:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:41766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727343AbfD0Bit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:38:49 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF380212F5;
        Sat, 27 Apr 2019 01:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329128;
        bh=aNnO9KjwSi+rXD9Zfk73M4FcsvxaGB5d7VpjGs+Sd18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V3hzIE4n4Oref0haWZ8H3EWtiGs5/KfStqw8ssbWXFOiwqNcdvt8hfjpirZ9Nx0sW
         cEobqh52+0iGxbj89Z07ZRbsNafs+xfgasAoHbMKQ0AgS8PrmS+IzqfN9KVId2o+7Z
         ywsXWoYUb05f52LXBDj6dPTgSPUyLdY2+Fyfl8CI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rander Wang <rander.wang@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 09/79] ASoC:intel:skl:fix a simultaneous playback & capture issue on hda platform
Date:   Fri, 26 Apr 2019 21:37:28 -0400
Message-Id: <20190427013838.6596-9-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427013838.6596-1-sashal@kernel.org>
References: <20190427013838.6596-1-sashal@kernel.org>
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
index 557f80c0bfe5..5cd308d622f6 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -181,6 +181,7 @@ int skl_pcm_link_dma_prepare(struct device *dev, struct skl_pipe_params *params)
 	struct hdac_stream *hstream;
 	struct hdac_ext_stream *stream;
 	struct hdac_ext_link *link;
+	unsigned char stream_tag;
 
 	hstream = snd_hdac_get_stream(bus, params->stream,
 					params->link_dma_id + 1);
@@ -199,10 +200,13 @@ int skl_pcm_link_dma_prepare(struct device *dev, struct skl_pipe_params *params)
 
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
@@ -645,6 +649,7 @@ static int skl_link_hw_free(struct snd_pcm_substream *substream,
 	struct hdac_ext_stream *link_dev =
 				snd_soc_dai_get_dma_data(dai, substream);
 	struct hdac_ext_link *link;
+	unsigned char stream_tag;
 
 	dev_dbg(dai->dev, "%s: %s\n", __func__, dai->name);
 
@@ -654,7 +659,11 @@ static int skl_link_hw_free(struct snd_pcm_substream *substream,
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

