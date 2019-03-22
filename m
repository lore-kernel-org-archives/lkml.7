Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AC3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7885121916
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255267;
	bh=QZsY0QbLZBhgy0803PU90rdGTgy/ax13e4eP6hcZjPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ShOBKiHRPRHP8wkoIRbJl00HLyMrbyH08qyOqdLH6ZcpCYd/cxdYdtr6CUZKzR8L3
	 Gv4Vf0mByP9/L6RJbyGMolhjkVewl5AS4ioeaDjDB7jvYYxbvR23muVQCoLI8n17wb
	 a5oh9HSV8m2JRqPdoZAmdl212Xrg+g/0X6V7+P5o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732214AbfCVLrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:47:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729276AbfCVLro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:47:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 962252075E;
        Fri, 22 Mar 2019 11:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255263;
        bh=QZsY0QbLZBhgy0803PU90rdGTgy/ax13e4eP6hcZjPg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZzUHyF4RCH68wdA0SPYn0RuQADlQfWYoBLz9GBMYjYx8pS5MoIeYjjouETzlvHX9E
         rYL0jS6CjMr1UeiBYO7YlKXhYvCTmVam875FnHiXhUvqqjM6SSYfDBj0M0i4HxG9YU
         zonjZkjxRjgg+qlwQtRmjLyB7alBlTffBO1F02VM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 018/183] ASoC: dapm: fix out-of-bounds accesses to DAPM lookup tables
Date:   Fri, 22 Mar 2019 12:14:06 +0100
Message-Id: <20190322111243.084066399@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index bba6a917cd02..e9f7c6287376 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -75,12 +75,16 @@ static int dapm_up_seq[] = {
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
@@ -88,11 +92,19 @@ static int dapm_up_seq[] = {
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
@@ -105,13 +117,25 @@ static int dapm_down_seq[] = {
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



