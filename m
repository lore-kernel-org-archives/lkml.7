Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375ADC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 017FA20650
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573239885;
	bh=Q20vSiNZNOz4YiE2NlHcH9OoJldhsBbNcjgKqyF9u1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JjxMDH5w4y3qlQ2qqfF+u/dXA+WEhcwVWh8E3jQ0JE/YJeM0GJFRRjufkUJFAVQ7U
	 VvymDxk3gUq6xsPsnjt05nVpiL7JY+/a4032rdiMQeDfzIGxxNdY+Mxr2vfSux5hyV
	 NO6Bq9TPLAgsOKtaxrXjDvcUtczjMzJ42WSj7IQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391064AbfKHTEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:04:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:34756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391052AbfKHTEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:04:41 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0195D215EA;
        Fri,  8 Nov 2019 19:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239880;
        bh=Q20vSiNZNOz4YiE2NlHcH9OoJldhsBbNcjgKqyF9u1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MDsC9HcTwCzUXtNd9xRdjqXd7DM8mC2a7i4dO+wNZgidxhYWARNbOPztYR28PMdl9
         lsv4IrUkFcdsyEJXFGKJtcuwZoOrmJY4Zgr5T7peTFWQZe+UB16Cr1MgDjwpttrwSN
         T12a8Ny8mIH3UTDUSgmxiFBdIHJHvVGYw8lofgVU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 014/140] ASoC: SOF: Intel: hda: fix warnings during FW load
Date:   Fri,  8 Nov 2019 19:49:02 +0100
Message-Id: <20191108174903.015841981@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174900.189064908@linuxfoundation.org>
References: <20191108174900.189064908@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai Vehmanen <kai.vehmanen@linux.intel.com>

[ Upstream commit 4ff5f6439fe69624e8f7d559915e9b54a6477684 ]

The "snd_pcm_substream" handle was not initialized properly
in hda-loader.c for firmware load.

When the HDA DMAs were used to load the firmware,
the interrupts related to firmware load also triggered
calls to snd_sof_pcm_period_elapsed() on a non-existent ALSA
PCM stream.

This caused runtime kernel warnings from
pcm_lib.c:snd_pcm_period_elapsed().

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20190927200538.660-11-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/intel/hda-loader.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sof/intel/hda-loader.c b/sound/soc/sof/intel/hda-loader.c
index 6427f0b3a2f11..65c2af3fcaab7 100644
--- a/sound/soc/sof/intel/hda-loader.c
+++ b/sound/soc/sof/intel/hda-loader.c
@@ -44,6 +44,7 @@ static int cl_stream_prepare(struct snd_sof_dev *sdev, unsigned int format,
 		return -ENODEV;
 	}
 	hstream = &dsp_stream->hstream;
+	hstream->substream = NULL;
 
 	/* allocate DMA buffer */
 	ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV_SG, &pci->dev, size, dmab);
-- 
2.20.1



