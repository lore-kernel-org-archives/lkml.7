Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6331EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 293692192B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138404;
	bh=Ld0ofWyevPKuxn6nLqso1LwjCwBZP/ZQ5ZtLkxHZ798=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=drkEThUlQt9GAdPHfX0pjPJpajhSXy6vrdsSA+KhDSPByeHVUQ2GLZRUcfNzQQCfT
	 ylD78p/R+iunsFzUBiahDMmMlICHVM4KaH+r2B3rl//0gJMzcJh/GBizwllNg4iP9W
	 Nh1LVK8x4bipTAZpeaXTQyeKsahzOKKMbUbdp5WI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbfDARGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:06:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:52272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728841AbfDARGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:06:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82C7321929;
        Mon,  1 Apr 2019 17:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138398;
        bh=Ld0ofWyevPKuxn6nLqso1LwjCwBZP/ZQ5ZtLkxHZ798=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kg76abdYRgDk8RGVJCFrPIUEpXWIGglplSnH+aGwOwKer3E2Gv9U3KSB11GXr88Ph
         YEpKKzDF3mzg3D06Abg2g5Ml7pNPrAyRtDDVxziOyEIZquwCtlsBvN2L7FjGDwQGEB
         kasQzelkxyzYIP2qFB/ficiBt7i4V/Q2faTjNdQA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.0 055/146] ALSA: seq: oss: Fix Spectre v1 vulnerability
Date:   Mon,  1 Apr 2019 19:01:07 +0200
Message-Id: <20190401170053.287295547@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit c709f14f0616482b67f9fbcb965e1493a03ff30b upstream.

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
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/seq/oss/seq_oss_synth.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

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


