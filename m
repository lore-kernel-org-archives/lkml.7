Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC3DC3276C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 00:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2204A2085B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 00:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NqzpcO36"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgACAWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 19:22:19 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44391 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgACAWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 19:22:19 -0500
Received: by mail-pg1-f193.google.com with SMTP id x7so22643446pgl.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 16:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tUxq8i1QoyN076FNd9no9rm0JfBtqoMlndPucVdwL+Q=;
        b=NqzpcO36JT0r16vm2kcKH+pdauNyQQsUIyYJUhYlvwWBIhP3Z7RwiQn+rEob1LSmIJ
         EHgZH319tZBynp9cwUiYu7c25RRgTa3chhWSfbqGv2Emm5LQXtQg3KK7pPCXCYZAeyk3
         YRqWfrp07i9FKtXMYxREunS7kK4YIr1T2p9JU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tUxq8i1QoyN076FNd9no9rm0JfBtqoMlndPucVdwL+Q=;
        b=GjiI/knRpfYOIkEhJ5IE7aF+P3Noz6GDiwX7NP9nrYce6EpiKeTxvNFUnUIl1FXpHd
         +fL2ZaqmqzrpJkKFN4Xir1EuOKqUhnJW6LjHMP+XG+/UCFQ2cShFMNzkV7hZmGYDs9Kz
         MmIDWNuYcrwFyjYHA21YTja6tFY8p1qBi/ywaWCuvHeI35bvk9Mb+3ZuJGci2F+c6w8e
         q38vXJ40/rbCyvHHqUyZ1SGA2KQUZRF9UW8Au8smGrKHI47pWtjuQFU9uSt0C75Felcb
         NIB9wZlCz97soFTD0ffiEknEt8xZFnL+uDoi0FKf2/QWh2dJg/MyqN6toi/WzATR02TC
         LfCg==
X-Gm-Message-State: APjAAAV1tTHg9x1vFIox3FyKXw2Z1lLDbyrODsJx+KjYkoqDWz5cWyCU
        1h/6AP4vMFKo4AJyuk1eDWBLpi8UvqA=
X-Google-Smtp-Source: APXvYqzwQpEwtXV4Yw2vqM2WQoqggfsEW7PCxIzkquBQ9xCQStVJl8j6EU9668hHmqiPC2+AojsYdg==
X-Received: by 2002:a63:1b49:: with SMTP id b9mr92068426pgm.258.1578010938307;
        Thu, 02 Jan 2020 16:22:18 -0800 (PST)
Received: from localhost ([2401:fa00:9:15:c479:b58e:61d1:15d5])
        by smtp.gmail.com with ESMTPSA id z64sm64784446pfz.23.2020.01.02.16.22.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2020 16:22:17 -0800 (PST)
From:   Sam McNally <sammc@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Sam McNally <sammc@chromium.org>, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        alsa-devel@alsa-project.org,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sathya Prakash M R <sathya.prakash.m.r@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jairaj Arava <jairaj.arava@intel.com>,
        Xun Zhang <xun2.zhang@intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
Subject: [PATCH v2] ASoC: Intel: sof_rt5682: Ignore the speaker amp when there isn't one.
Date:   Fri,  3 Jan 2020 11:22:06 +1100
Message-Id: <20200103112158.v2.1.Ib87c4a7fbb3fc818ea12198e291b87dc2d5bc8c2@changeid>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some members of the Google_Hatch family include a rt5682, but not a
speaker amp. When a speaker amp is also present, the first 10EC5682
entry in snd_soc_acpi_intel_cml_machines[] matches, finding the
MX98357A as well, resulting in the quirk_data field in the
snd_soc_acpi_mach being non-null. When only the rt5682 is present, the
second 10EC5682 entry is matched instead and quirk_data is left null.

The sof_rt5682 driver's DMI data matching identifies that a speaker amp
is present for all Google_Hatch family devices. Detect cases where there
is no speaker amp by checking for a null quirk_data in the
snd_soc_acpi_mach and remove the speaker amp bit in that case.

Signed-off-by: Sam McNally <sammc@chromium.org>
---

Changes in v2:
- Added details about the relevant ACPI matches to the description

 sound/soc/intel/boards/sof_rt5682.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index ad8a2b4bc709..8a13231dee15 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -603,6 +603,14 @@ static int sof_audio_probe(struct platform_device *pdev)
 
 	dmi_check_system(sof_rt5682_quirk_table);
 
+	mach = (&pdev->dev)->platform_data;
+
+	/* A speaker amp might not be present when the quirk claims one is.
+	 * Detect this via whether the machine driver match includes quirk_data.
+	 */
+	if ((sof_rt5682_quirk & SOF_SPEAKER_AMP_PRESENT) && !mach->quirk_data)
+		sof_rt5682_quirk &= ~SOF_SPEAKER_AMP_PRESENT;
+
 	if (soc_intel_is_byt() || soc_intel_is_cht()) {
 		is_legacy_cpu = 1;
 		dmic_be_num = 0;
@@ -663,7 +671,6 @@ static int sof_audio_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&ctx->hdmi_pcm_list);
 
 	sof_audio_card_rt5682.dev = &pdev->dev;
-	mach = (&pdev->dev)->platform_data;
 
 	/* set platform name for each dailink */
 	ret = snd_soc_fixup_dai_links_platform_name(&sof_audio_card_rt5682,
-- 
2.24.1.735.g03f4e72817-goog

