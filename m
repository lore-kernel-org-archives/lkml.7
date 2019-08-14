Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF803C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5370214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565802825;
	bh=3cjpLCQ8fn6p6DHotHg4R+SHQOC6BSFZW4EWspyAYNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z3SJAgaOSTwdSBiORDYIAGTO/afCwkAvTZ+4o5alR//KU7XnGCi+GCJijE1ryZMhn
	 LhBKEyiNq02+2XHyQVfJj2k20mTChffDIkBbmI4OtJAttfGpkcW8o2M81Rwilb+45C
	 nNyaMw91ju1urD7FPg0JgUEoHbuHTGjQ1osJxdQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbfHNRNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:13:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:37992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728433AbfHNRNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:13:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3349920665;
        Wed, 14 Aug 2019 17:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802820;
        bh=3cjpLCQ8fn6p6DHotHg4R+SHQOC6BSFZW4EWspyAYNw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pRTXCm1f9RO/vXt1N1AB1ae9b9pV8cfUxB+SYKUW3MwHp2VZtdSD/LsKc132ZzqKx
         DreZajpwymN+3KGOKKLLQM2AEdjzcQmODvxR2hUjlnxCOgkpU42ZNuSpWAAZseSdrY
         QDeD9XfLhZ9VEgDIJq27Ouzsy3E/HzYBCRPvw2co=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Vinod Koul <vkoul@kernel.org>, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 38/69] ALSA: compress: Dont allow paritial drain operations on capture streams
Date:   Wed, 14 Aug 2019 19:01:36 +0200
Message-Id: <20190814165748.056978822@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814165744.822314328@linuxfoundation.org>
References: <20190814165744.822314328@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit a70ab8a8645083f3700814e757f2940a88b7ef88 ]

Partial drain and next track are intended for gapless playback and
don't really have an obvious interpretation for a capture stream, so
makes sense to not allow those operations on capture streams.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/compress_offload.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 1538fbc7562b8..b4f1536b17cb5 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -835,6 +835,10 @@ static int snd_compr_next_track(struct snd_compr_stream *stream)
 	if (stream->runtime->state != SNDRV_PCM_STATE_RUNNING)
 		return -EPERM;
 
+	/* next track doesn't have any meaning for capture streams */
+	if (stream->direction == SND_COMPRESS_CAPTURE)
+		return -EPERM;
+
 	/* you can signal next track if this is intended to be a gapless stream
 	 * and current track metadata is set
 	 */
@@ -862,6 +866,10 @@ static int snd_compr_partial_drain(struct snd_compr_stream *stream)
 		break;
 	}
 
+	/* partial drain doesn't have any meaning for capture streams */
+	if (stream->direction == SND_COMPRESS_CAPTURE)
+		return -EPERM;
+
 	/* stream can be drained only when next track has been signalled */
 	if (stream->next_track == false)
 		return -EPERM;
-- 
2.20.1



