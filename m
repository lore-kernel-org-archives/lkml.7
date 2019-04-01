Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9E4C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B7E62063F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139637;
	bh=1igucC/NJ6Bx8n3Fy0lJQe2NnovLdcBFWQHVDSFbFIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yIlRImQhgXDB1sGPr2X8uDl4/LCOYnezQ0p1+iQnRaY5kpmw65cN7JMyTVzP94pE9
	 FuPN/RBBg0vde1jZL508RmBf/RhW87959Pu5y8/N54zo4MY6WIDYO5aVsB+/Zk4D2l
	 pZKJyyQdxZMHDx26tFnM1Gh/7gq0T7/AxjfXEdZ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732650AbfDAR1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:27:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:59838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732643AbfDAR1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:27:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4427720830;
        Mon,  1 Apr 2019 17:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139631;
        bh=1igucC/NJ6Bx8n3Fy0lJQe2NnovLdcBFWQHVDSFbFIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IA2gGqIX+CVMxAgYhaOrvvILpQH1de2fQ7unTtcEs9LxT9QXQWhwYb9hyZ0xOkK7y
         RTpBxV4EqBYq1Mzt3ADi1qn5h1FyH68XmZTO0Q3HWav5Zc0O2p3/VRi4otBCl+6T7b
         2bVVf/MoKlgHVSciXvcFPJ8aWV9azMwmNq3k40/s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 24/56] ALSA: seq: oss: Fix Spectre v1 vulnerability
Date:   Mon,  1 Apr 2019 19:02:40 +0200
Message-Id: <20190401170105.296694968@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170103.398401360@linuxfoundation.org>
References: <20190401170103.398401360@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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


