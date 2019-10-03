Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02608C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD672215EA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570119940;
	bh=Yx32O/FASWryut3zSopKobWDl/d+oEGu/42QV5SLQBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aZsXzwsQWucV/LntjblnDjV4owC0L7N53ndQt56B5BorCnTC7/aiSA7h2i1NYg2eH
	 KaVav2F8GdDY/fMub5PSimPy6j94A0Dono8y2ZDpHtuNw0rQJo4M7sfuLodfAXi1tw
	 QEa0l7NP3x9PTHcrTygz9amKRB9eWvy/9WW4KsK4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390949AbfJCQZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:25:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:55842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390912AbfJCQZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:25:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E98A215EA;
        Thu,  3 Oct 2019 16:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119934;
        bh=Yx32O/FASWryut3zSopKobWDl/d+oEGu/42QV5SLQBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RoJCTKslc/UmqRNsxTstBZI94tKZuIoXsoF4wFm7VdzadK+c+eIN4iASv2YpqbURX
         Sw139VYP9jPB3c4/0XfpyIKr57DI51yKeI+qMqrq3IxM/UFzbMBFdeVQxOenxM95jj
         VejtbrmS+DOmN4yvGdMYjqCBLUFwWVJGENeJIlyQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Libin Yang <libin.yang@intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 034/313] ASoC: SOF: Intel: hda: Make hdac_device device-managed
Date:   Thu,  3 Oct 2019 17:50:12 +0200
Message-Id: <20191003154536.639181298@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154533.590915454@linuxfoundation.org>
References: <20191003154533.590915454@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

[ Upstream commit ef9bec27485fefb6b93168fea73fda0dc9638046 ]

snd_hdac_ext_bus_device_exit() has been recently modified
to no longer free the hdac device. SOF allocates memory for
hdac_device and hda_hda_priv with kzalloc. Make them
device-managed instead so that they will be freed when the
SOF driver is unloaded.

Because of the above change, hda_codec is device-managed and
it will be freed when the ASoC device is removed. Freeing
the codec in snd_hda_codec_dev_release() leads to kernel
panic while unloading and reloading the ASoC driver. So,
avoid freeing the hda_codec for ASoC driver. This is done in
the same patch to avoid bisect failure.

Signed-off-by: Libin Yang <libin.yang@intel.com>
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/r/20190626070450.7229-1-ranjani.sridharan@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/hda_codec.c       | 8 +++++++-
 sound/soc/sof/intel/hda-codec.c | 6 ++----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 106328584998f..c2a6554c98776 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -846,7 +846,13 @@ static void snd_hda_codec_dev_release(struct device *dev)
 	snd_hda_sysfs_clear(codec);
 	kfree(codec->modelname);
 	kfree(codec->wcaps);
-	kfree(codec);
+
+	/*
+	 * In the case of ASoC HD-audio, hda_codec is device managed.
+	 * It will be freed when the ASoC device is removed.
+	 */
+	if (codec->core.type == HDA_DEV_LEGACY)
+		kfree(codec);
 }
 
 #define DEV_NAME_LEN 31
diff --git a/sound/soc/sof/intel/hda-codec.c b/sound/soc/sof/intel/hda-codec.c
index b8b37f0823094..0d8437b080bfa 100644
--- a/sound/soc/sof/intel/hda-codec.c
+++ b/sound/soc/sof/intel/hda-codec.c
@@ -62,8 +62,7 @@ static int hda_codec_probe(struct snd_sof_dev *sdev, int address)
 		address, resp);
 
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC)
-	/* snd_hdac_ext_bus_device_exit will use kfree to free hdev */
-	hda_priv = kzalloc(sizeof(*hda_priv), GFP_KERNEL);
+	hda_priv = devm_kzalloc(sdev->dev, sizeof(*hda_priv), GFP_KERNEL);
 	if (!hda_priv)
 		return -ENOMEM;
 
@@ -82,8 +81,7 @@ static int hda_codec_probe(struct snd_sof_dev *sdev, int address)
 
 	return 0;
 #else
-	/* snd_hdac_ext_bus_device_exit will use kfree to free hdev */
-	hdev = kzalloc(sizeof(*hdev), GFP_KERNEL);
+	hdev = devm_kzalloc(sdev->dev, sizeof(*hdev), GFP_KERNEL);
 	if (!hdev)
 		return -ENOMEM;
 
-- 
2.20.1



