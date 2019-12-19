Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A743AC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C25E227BF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576782377;
	bh=YOOKKu7KZKalCYc9fcrbvluf+Q6hWobR9h7/kUaryYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RIaDdT9/IAuGUpJ5SiGGFWsMHMK/bKTlmf6HRelCfLIE6UrtrUkVb2VgHVRzWlW8X
	 Zxf3WN0a355HeHU8Q79CZ7UYLXurwPMBNWzUPARBERxvkQju/zFcVXcXlWvCytKnMk
	 cIs7YeaD07q8K9m/0WvlEY8WDQ3V4gkWXls0+3zM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbfLSTGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 14:06:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:36838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729040AbfLSSon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:44:43 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31D9D24672;
        Thu, 19 Dec 2019 18:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781082;
        bh=YOOKKu7KZKalCYc9fcrbvluf+Q6hWobR9h7/kUaryYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0NGuWEa2+NK/AP/ACPc2Uud8u0m+5FOzwnGKa+F9Y4RuKEOZNsoc6Eiq/vHrZZ57n
         zGRkQw5xlsq4VeeDzCpioT21rn4CRwC4OU3wI5bd+CA/Z+VvOXZ0VC1MIHmJMFaJBw
         g0jL+J79lcJOcH3Vc9y0zCft8CIN/PZYQVTg6rUQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+f153bde47a62e0b05f83@syzkaller.appspotmail.com,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 074/199] ALSA: pcm: oss: Avoid potential buffer overflows
Date:   Thu, 19 Dec 2019 19:32:36 +0100
Message-Id: <20191219183219.079341521@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183214.629503389@linuxfoundation.org>
References: <20191219183214.629503389@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 4cc8d6505ab82db3357613d36e6c58a297f57f7c upstream.

syzkaller reported an invalid access in PCM OSS read, and this seems
to be an overflow of the internal buffer allocated for a plugin.
Since the rate plugin adjusts its transfer size dynamically, the
calculation for the chained plugin might be bigger than the given
buffer size in some extreme cases, which lead to such an buffer
overflow as caught by KASAN.

Fix it by limiting the max transfer size properly by checking against
the destination size in each plugin transfer callback.

Reported-by: syzbot+f153bde47a62e0b05f83@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20191204144824.17801-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/oss/linear.c |    2 ++
 sound/core/oss/mulaw.c  |    2 ++
 sound/core/oss/route.c  |    2 ++
 3 files changed, 6 insertions(+)

--- a/sound/core/oss/linear.c
+++ b/sound/core/oss/linear.c
@@ -107,6 +107,8 @@ static snd_pcm_sframes_t linear_transfer
 		}
 	}
 #endif
+	if (frames > dst_channels[0].frames)
+		frames = dst_channels[0].frames;
 	convert(plugin, src_channels, dst_channels, frames);
 	return frames;
 }
--- a/sound/core/oss/mulaw.c
+++ b/sound/core/oss/mulaw.c
@@ -269,6 +269,8 @@ static snd_pcm_sframes_t mulaw_transfer(
 		}
 	}
 #endif
+	if (frames > dst_channels[0].frames)
+		frames = dst_channels[0].frames;
 	data = (struct mulaw_priv *)plugin->extra_data;
 	data->func(plugin, src_channels, dst_channels, frames);
 	return frames;
--- a/sound/core/oss/route.c
+++ b/sound/core/oss/route.c
@@ -57,6 +57,8 @@ static snd_pcm_sframes_t route_transfer(
 		return -ENXIO;
 	if (frames == 0)
 		return 0;
+	if (frames > dst_channels[0].frames)
+		frames = dst_channels[0].frames;
 
 	nsrcs = plugin->src_format.channels;
 	ndsts = plugin->dst_format.channels;


