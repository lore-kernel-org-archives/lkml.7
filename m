Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EC5C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA072087F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbfFQLfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 07:35:00 -0400
Received: from mga12.intel.com ([192.55.52.136]:54390 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727755AbfFQLe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 07:34:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jun 2019 04:34:56 -0700
X-ExtLoop1: 1
Received: from xxx.igk.intel.com ([10.237.93.170])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jun 2019 04:34:54 -0700
From:   =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH v2 02/11] ALSA: hdac: Fix codec name after machine driver is unloaded and reloaded
Date:   Mon, 17 Jun 2019 13:36:35 +0200
Message-Id: <20190617113644.25621-3-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190617113644.25621-1-amadeuszx.slawinski@linux.intel.com>
References: <20190617113644.25621-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently on each driver reload internal counter is being increased. It
causes failure to enumerate driver devices, as they have hardcoded:
.codec_name = "ehdaudio0D2",
As there is currently no devices with multiple hda codecs and there is
currently no established way to reliably differentiate, between them,
always assign bus->idx = 0;

This fixes a problem when we unload and reload machine driver idx gets
incremented, so .codec_name would've needed to be set to "ehdaudio1D2"
after first reload and so on.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/hda/ext/hdac_ext_bus.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/hda/ext/hdac_ext_bus.c b/sound/hda/ext/hdac_ext_bus.c
index a3a113ef5d56..4f9f1d2a2ec5 100644
--- a/sound/hda/ext/hdac_ext_bus.c
+++ b/sound/hda/ext/hdac_ext_bus.c
@@ -85,7 +85,6 @@ int snd_hdac_ext_bus_init(struct hdac_bus *bus, struct device *dev,
 			const struct hdac_ext_bus_ops *ext_ops)
 {
 	int ret;
-	static int idx;
 
 	/* check if io ops are provided, if not load the defaults */
 	if (io_ops == NULL)
@@ -96,7 +95,12 @@ int snd_hdac_ext_bus_init(struct hdac_bus *bus, struct device *dev,
 		return ret;
 
 	bus->ext_ops = ext_ops;
-	bus->idx = idx++;
+	/* FIXME:
+	 * Currently only one bus is supported, if there is device with more
+	 * buses, bus->idx should be greater than 0, but there needs to be a
+	 * reliable way to always assign same number.
+	 */
+	bus->idx = 0;
 	bus->cmd_dma_state = true;
 
 	return 0;
-- 
2.17.1

