Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861BBC2D0DE
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 00:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD4120848
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 00:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mf6oJFqD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbgABA3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 19:29:05 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43937 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbgABA3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 19:29:05 -0500
Received: by mail-pl1-f193.google.com with SMTP id p27so17181388pli.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 16:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9GJYS2xwYL6+Da0JsxP8DsSxNZ3j5TIjH/wHBFm0PRA=;
        b=mf6oJFqDXwxAXyg4aXPM84cAGHIdCVNqcZT5aleGPlTquh+FLh1f+dyPgxcXX5RXfM
         Qce0ahB7vz5jMsconZUcEGtyAUQ+lv75rMVTUlh+62VKKOT94OENioubYP82GLE24SkO
         y5wTcSP8uunA6ljabFPF+vsqwVSuabg6vh9ZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9GJYS2xwYL6+Da0JsxP8DsSxNZ3j5TIjH/wHBFm0PRA=;
        b=Sj1VqRPL2LUjvNIxvLguCfnGo5fp58vCMcucGtqwIVYO3f+L6xXdlZORpwPWJ+VQTZ
         5feP73ZSFOBEf0tvBp/ix20Xq4mipyOGSqtrXYh5btx8xiz+3JOpp2HXlm01BYslxO6/
         g2iCw2RDdEKDVzRqjvNXDNc+U7cX/FtVtzOTUgHLucCTsOP2cPyy5pu3ukycdvcw4zB0
         IYeccRo7kS2sHWHl4oli8IyptL1csBss649aPw7rQimpYZglS2gq/ef1POum82HmoXU8
         epRhxZzDJXqLNPJuv2tVTu6RPaeYgxDXGE8VqXtoSefvyeRjf9ocjS0IOGpxNWwlgm2m
         q+hg==
X-Gm-Message-State: APjAAAVB2k4XMAAyxwUXylBtce3l5AYaShFsTN16J88YB6XxwFYxpW6i
        gH7diSak3z3mMdlJ5F3WxX2/SXS97/g=
X-Google-Smtp-Source: APXvYqxneFpTHIfgl2F/2i+m025oRgDpA8vNciUpijln22SYxjPjYXhMkW/DNF5QacCVeiX0ZzX2DA==
X-Received: by 2002:a17:90b:3c9:: with SMTP id go9mr16175122pjb.7.1577924944088;
        Wed, 01 Jan 2020 16:29:04 -0800 (PST)
Received: from localhost ([2401:fa00:9:15:c479:b58e:61d1:15d5])
        by smtp.gmail.com with ESMTPSA id b65sm58498229pgc.18.2020.01.01.16.28.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jan 2020 16:29:03 -0800 (PST)
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
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
Subject: [PATCH] ASoC: Intel: sof_rt5682: Ignore the speaker amp when there isn't one.
Date:   Thu,  2 Jan 2020 11:28:12 +1100
Message-Id: <20200102112558.1.Ib87c4a7fbb3fc818ea12198e291b87dc2d5bc8c2@changeid>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some members of the Google_Hatch family include a rt5682, but not a
speaker amp. When a speaker amp is also present, it matches MX98357A
as well, resulting in the quirk_data field in the snd_soc_acpi_mach
being non-null. When only the rt5682 is present, quirk_data is left
null.

The sof_rt5682 driver's DMI data matching identifies that a speaker amp
is present for all Google_Hatch family devices. Detect cases where there
is no speaker amp by checking for a null quirk_data in the
snd_soc_acpi_mach and remove the speaker amp bit in that case.

Signed-off-by: Sam McNally <sammc@chromium.org>
---

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

