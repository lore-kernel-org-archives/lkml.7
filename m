Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC51C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6119521773
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="kj1oNjD2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730492AbfC2VvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 17:51:08 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:36344 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730235AbfC2VvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 17:51:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1553896260; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tlbkIOQ5hS1fjnjXAqiNDsugpMlSUzjW1M2TjH/MOSI=;
        b=kj1oNjD2w3xqoQvxCAAo452fiWEUHw+vZB5Fx8yvppGUDsbC7m1xc3092W63IMKADuhNf3
        PuuRd76jOswWeUODTJBUOQH+SaZYBZRlIHqDYvaU6pypjLc1CA6qVn2Jl7ufSu+vYrNub+
        zllEpEoEKi5lLcUJey+Vvx20VOi+EKA=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jie Yang <yang.jie@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 3/3] ASoC: Intel: bytcht_es8316: Add quirk for the Teclast X98+ II
Date:   Fri, 29 Mar 2019 22:50:45 +0100
Message-Id: <20190329215045.6254-3-paul@crapouillou.net>
In-Reply-To: <20190329215045.6254-1-paul@crapouillou.net>
References: <20190329215045.6254-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Teclast X98+ II is a Cherrytrail tablet, which require two quirks:
- it has stereo speakers,
- its jack detection mechanism is inverted.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 sound/soc/intel/boards/bytcht_es8316.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index e59ef61e1fd0..4d0f8eb560d0 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -22,6 +22,7 @@
 #include <linux/acpi.h>
 #include <linux/clk.h>
 #include <linux/device.h>
+#include <linux/dmi.h>
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
@@ -441,11 +442,25 @@ static const struct acpi_gpio_mapping byt_cht_es8316_gpios[] = {
 	{ },
 };
 
+/* Please keep this list alphabetically sorted */
+static const struct dmi_system_id byt_cht_es8316_quirk_table[] = {
+	{	/* Teclast X98 Plus II */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "TECLAST"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "X98 Plus II"),
+		},
+		.driver_data = (void *)(BYT_CHT_ES8316_INTMIC_IN1_MAP
+					| BYT_CHT_ES8316_JD_INVERTED),
+	},
+	{}
+};
+
 static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 {
 	static const char * const mic_name[] = { "in1", "in2" };
 	struct property_entry props[MAX_NO_PROPS] = {};
 	struct byt_cht_es8316_private *priv;
+	const struct dmi_system_id *dmi_id;
 	struct device *dev = &pdev->dev;
 	struct snd_soc_acpi_mach *mach;
 	const char *platform_name;
@@ -487,7 +502,10 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 		return ret;
 
 	/* Check for BYTCR or other platform and setup quirks */
-	if (x86_match_cpu(baytrail_cpu_ids) &&
+	dmi_id = dmi_first_match(byt_cht_es8316_quirk_table);
+	if (dmi_id) {
+		quirk = (int)dmi_id->driver_data;
+	} else if (x86_match_cpu(baytrail_cpu_ids) &&
 	    mach->mach_params.acpi_ipc_irq_index == 0) {
 		/* On BYTCR default to SSP0, internal-mic-in2-map, mono-spk */
 		quirk = BYT_CHT_ES8316_SSP0 | BYT_CHT_ES8316_INTMIC_IN2_MAP |
-- 
2.11.0

