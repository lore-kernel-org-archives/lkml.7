Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF18FC6194
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC6EF222C5
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573213466;
	bh=VxBVNK0fulYKD1DbXnpRW+WbwkKSHcNlDDODLj71v08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U7xo5r3Ud/AHwYuNsapzA8roo5PFYbaDA1FOxQkBVTuPXs2nHwydv6IWGqMIOyIne
	 XN6YCb08NfLjxRwh4C9q6OmGtZ+4QbAwKE6bt2YTbPeoDg0PrMFmwpakz8YprRZ6ke
	 eq9ac6E7z9BIN1h3gQIkL7nVeQcl03OtJtgKjhBc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390758AbfKHLoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:44:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:59248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389174AbfKHLoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:44:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B6DE21D82;
        Fri,  8 Nov 2019 11:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213461;
        bh=VxBVNK0fulYKD1DbXnpRW+WbwkKSHcNlDDODLj71v08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C72p9qeRz0G0budke87Vnrf0T6E/I0rg59+ZwQEbQBlIew+GknMATzrNt25UOWM6h
         RbdUKBi4IgHoWFadO07yQXqKdvscQuY0WTU/2ajNmGaPLTyFX1qi1bR7FldtqXEmCQ
         oywLexNkwnjBjroSfsJuBS1vnNbKM9CWwybyY4L0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yong Zhi <yong.zhi@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 047/103] ASoC: Intel: hdac_hdmi: Limit sampling rates at dai creation
Date:   Fri,  8 Nov 2019 06:42:12 -0500
Message-Id: <20191108114310.14363-47-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108114310.14363-1-sashal@kernel.org>
References: <20191108114310.14363-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yong Zhi <yong.zhi@intel.com>

[ Upstream commit 3b857472f34faa7d11001afa5e158833812c98d7 ]

Playback of 44.1Khz contents with HDMI plugged returns
"Invalid pipe config" because HDMI paths in the FW
topology are configured to operate at 48Khz.

This patch filters out sampling rates not supported
at hdac_hdmi_create_dais() to let user space SRC
to do the converting.

Signed-off-by: Yong Zhi <yong.zhi@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index e824d47cc22b0..1c3626347e12b 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1408,6 +1408,12 @@ static int hdac_hdmi_create_dais(struct hdac_device *hdac,
 		if (ret)
 			return ret;
 
+		/* Filter out 44.1, 88.2 and 176.4Khz */
+		rates &= ~(SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_88200 |
+			   SNDRV_PCM_RATE_176400);
+		if (!rates)
+			return -EINVAL;
+
 		sprintf(dai_name, "intel-hdmi-hifi%d", i+1);
 		hdmi_dais[i].name = devm_kstrdup(&hdac->dev,
 					dai_name, GFP_KERNEL);
-- 
2.20.1

