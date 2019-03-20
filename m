Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A8DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 00:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A45F8218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 00:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbfCUADm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 20:03:42 -0400
Received: from gateway34.websitewelcome.com ([192.185.148.200]:45862 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726983AbfCUADm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 20:03:42 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 3F6B01116C61
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 18:42:05 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 6kqThYPoednCe6kqThQPQL; Wed, 20 Mar 2019 18:42:05 -0500
X-Authority-Reason: nr=8
Received: from [189.250.100.204] (port=43236 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1h6kqS-001BBG-AJ; Wed, 20 Mar 2019 18:42:04 -0500
Date:   Wed, 20 Mar 2019 18:42:01 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ALSA: seq: oss: Fix Spectre v1 vulnerability
Message-ID: <20190320234201.GA24574@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.100.204
X-Source-L: No
X-Exim-ID: 1h6kqS-001BBG-AJ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.100.204]:43236
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 12
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev is indirectly controlled by user-space, hence leading to
a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

sound/core/seq/oss/seq_oss_synth.c:626 snd_seq_oss_synth_make_info() warn: potential spectre issue 'dp->synths' [w] (local cap)

Fix this by sanitizing dev before using it to index dp->synths.

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://lore.kernel.org/lkml/20180423164740.GY17484@dhcp22.suse.cz/

Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/core/seq/oss/seq_oss_synth.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/core/seq/oss/seq_oss_synth.c b/sound/core/seq/oss/seq_oss_synth.c
index 278ebb993122..c93945917235 100644
--- a/sound/core/seq/oss/seq_oss_synth.c
+++ b/sound/core/seq/oss/seq_oss_synth.c
@@ -617,13 +617,14 @@ int
 snd_seq_oss_synth_make_info(struct seq_oss_devinfo *dp, int dev, struct synth_info *inf)
 {
 	struct seq_oss_synth *rec;
+	struct seq_oss_synthinfo *info = get_synthinfo_nospec(dp, dev);
 
-	if (dev < 0 || dev >= dp->max_synthdev)
+	if (!info)
 		return -ENXIO;
 
-	if (dp->synths[dev].is_midi) {
+	if (info->is_midi) {
 		struct midi_info minf;
-		snd_seq_oss_midi_make_info(dp, dp->synths[dev].midi_mapped, &minf);
+		snd_seq_oss_midi_make_info(dp, info->midi_mapped, &minf);
 		inf->synth_type = SYNTH_TYPE_MIDI;
 		inf->synth_subtype = 0;
 		inf->nr_voices = 16;
-- 
2.21.0

