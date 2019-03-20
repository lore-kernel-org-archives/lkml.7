Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F9DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 21:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2054218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 21:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbfCTVPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 17:15:33 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.46]:40055 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727623AbfCTVPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 17:15:33 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 96EC8397F5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 16:15:32 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 6iYehWDLLdnCe6iYehOEPZ; Wed, 20 Mar 2019 16:15:32 -0500
X-Authority-Reason: nr=8
Received: from [189.250.100.204] (port=39396 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1h6iYd-004MDE-Nc; Wed, 20 Mar 2019 16:15:31 -0500
Date:   Wed, 20 Mar 2019 16:15:24 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ALSA: rawmidi: Fix potential Spectre v1 vulnerability
Message-ID: <20190320211524.GA20363@embeddedor>
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
X-Exim-ID: 1h6iYd-004MDE-Nc
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.100.204]:39396
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

info->stream is indirectly controlled by user-space, hence leading to
a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

sound/core/rawmidi.c:604 __snd_rawmidi_info_select() warn: potential spectre issue 'rmidi->streams' [r] (local cap)

Fix this by sanitizing info->stream before using it to index
rmidi->streams.

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://lore.kernel.org/lkml/20180423164740.GY17484@dhcp22.suse.cz/

Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/core/rawmidi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index ee601d7f0926..c0690d1ecd55 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -30,6 +30,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/mm.h>
+#include <linux/nospec.h>
 #include <sound/rawmidi.h>
 #include <sound/info.h>
 #include <sound/control.h>
@@ -601,6 +602,7 @@ static int __snd_rawmidi_info_select(struct snd_card *card,
 		return -ENXIO;
 	if (info->stream < 0 || info->stream > 1)
 		return -EINVAL;
+	info->stream = array_index_nospec(info->stream, 2);
 	pstr = &rmidi->streams[info->stream];
 	if (pstr->substream_count == 0)
 		return -ENOENT;
-- 
2.21.0

