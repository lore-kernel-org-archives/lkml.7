Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E3EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C44472084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552334251;
	bh=kwr5WqNGdZ6sSQBLyzKNgLfcWv6ILu4dnq43xyD99Kc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K2HfBPB2qJJFFinWUTwq5uAbaHyi8AHvUaIXGkHuri5EcDKaaaCwP3EdZCNEZ6Yp1
	 hGwA5LKSeWMGTl3iPDq8e0MSSZFX/SWs/l0fiGwlR0MdpWJTlFNmorO4CP0+Cvjv3l
	 5P3B6s/IBrnYo3EQpdjcFrmbOWQj3gpZM/aNVFa8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbfCKT5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:57:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:34876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729068AbfCKT52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:57:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBF7D2087C;
        Mon, 11 Mar 2019 19:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334247;
        bh=kwr5WqNGdZ6sSQBLyzKNgLfcWv6ILu4dnq43xyD99Kc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ub4chYi3x5gE/g5zs4UOc22sbcOevEgTcWBxhmyoouxIiBWDRJyENjycW/3fgmpeG
         NWig1hfZ6aiYdfm/l89QevBiy61/B295fvcyLAIca7TgsSwLarnnhfLeBuiCz/TGKS
         uggmoMeMfNCS1jmpjWDQtdOvfBMEXRvmIHow+bgQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 14/44] ASoC: dapm: fix out-of-bounds accesses to DAPM lookup tables
Date:   Mon, 11 Mar 2019 15:56:30 -0400
Message-Id: <20190311195700.138462-14-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190311195700.138462-1-sashal@kernel.org>
References: <20190311195700.138462-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit c16e12010060c6c7a31f08b4a99513064cb53b7d ]

KASAN reports and additional traces point to out-of-bounds accesses to
the dapm_up_seq and dapm_down_seq lookup tables. The indices used are
larger than the array definition.

Fix by adding missing entries for the new widget types in these two
lookup tables, and align them with PGA values.

Also the sequences for the following widgets were not defined. Since
their values defaulted to zero, assign them explicitly

 snd_soc_dapm_input
 snd_soc_dapm_output
 snd_soc_dapm_vmid
 snd_soc_dapm_siggen
 snd_soc_dapm_sink

Fixes: 8a70b4544ef4 ('ASoC: dapm: Add new widget type for constructing DAPM graphs on DSPs.').
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-dapm.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 461d951917c0..0a2cf09cac92 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -71,12 +71,16 @@ static int dapm_up_seq[] = {
 	[snd_soc_dapm_clock_supply] = 1,
 	[snd_soc_dapm_supply] = 2,
 	[snd_soc_dapm_micbias] = 3,
+	[snd_soc_dapm_vmid] = 3,
 	[snd_soc_dapm_dai_link] = 2,
 	[snd_soc_dapm_dai_in] = 4,
 	[snd_soc_dapm_dai_out] = 4,
 	[snd_soc_dapm_aif_in] = 4,
 	[snd_soc_dapm_aif_out] = 4,
 	[snd_soc_dapm_mic] = 5,
+	[snd_soc_dapm_siggen] = 5,
+	[snd_soc_dapm_input] = 5,
+	[snd_soc_dapm_output] = 5,
 	[snd_soc_dapm_mux] = 6,
 	[snd_soc_dapm_demux] = 6,
 	[snd_soc_dapm_dac] = 7,
@@ -84,11 +88,19 @@ static int dapm_up_seq[] = {
 	[snd_soc_dapm_mixer] = 8,
 	[snd_soc_dapm_mixer_named_ctl] = 8,
 	[snd_soc_dapm_pga] = 9,
+	[snd_soc_dapm_buffer] = 9,
+	[snd_soc_dapm_scheduler] = 9,
+	[snd_soc_dapm_effect] = 9,
+	[snd_soc_dapm_src] = 9,
+	[snd_soc_dapm_asrc] = 9,
+	[snd_soc_dapm_encoder] = 9,
+	[snd_soc_dapm_decoder] = 9,
 	[snd_soc_dapm_adc] = 10,
 	[snd_soc_dapm_out_drv] = 11,
 	[snd_soc_dapm_hp] = 11,
 	[snd_soc_dapm_spk] = 11,
 	[snd_soc_dapm_line] = 11,
+	[snd_soc_dapm_sink] = 11,
 	[snd_soc_dapm_kcontrol] = 12,
 	[snd_soc_dapm_post] = 13,
 };
@@ -101,13 +113,25 @@ static int dapm_down_seq[] = {
 	[snd_soc_dapm_spk] = 3,
 	[snd_soc_dapm_line] = 3,
 	[snd_soc_dapm_out_drv] = 3,
+	[snd_soc_dapm_sink] = 3,
 	[snd_soc_dapm_pga] = 4,
+	[snd_soc_dapm_buffer] = 4,
+	[snd_soc_dapm_scheduler] = 4,
+	[snd_soc_dapm_effect] = 4,
+	[snd_soc_dapm_src] = 4,
+	[snd_soc_dapm_asrc] = 4,
+	[snd_soc_dapm_encoder] = 4,
+	[snd_soc_dapm_decoder] = 4,
 	[snd_soc_dapm_switch] = 5,
 	[snd_soc_dapm_mixer_named_ctl] = 5,
 	[snd_soc_dapm_mixer] = 5,
 	[snd_soc_dapm_dac] = 6,
 	[snd_soc_dapm_mic] = 7,
+	[snd_soc_dapm_siggen] = 7,
+	[snd_soc_dapm_input] = 7,
+	[snd_soc_dapm_output] = 7,
 	[snd_soc_dapm_micbias] = 8,
+	[snd_soc_dapm_vmid] = 8,
 	[snd_soc_dapm_mux] = 9,
 	[snd_soc_dapm_demux] = 9,
 	[snd_soc_dapm_aif_in] = 10,
-- 
2.19.1

