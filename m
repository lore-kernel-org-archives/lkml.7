Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E366C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF59521841
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564752310;
	bh=GBkxAE6ZenMIaib6Hgv4wKxi80SCOK4Va/wOiXJWcHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y7QlIlUGT7vuz3t7j2u1N5RKDP4fzgrbZkQnhsTRth8QT+FEN0X52ZbOjAag4TMEp
	 y4O31ujMXXUAazAjImdDAdCPCj+IXkvXW+xO87SSNZxbQx8FsIEVDcP5d1J28+bwT+
	 H5M1VCgwkZSMLXU0PB+B6lRDk/8FMLcC5UdPFgik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394323AbfHBNZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:25:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:35680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394295AbfHBNY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:24:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98219217D4;
        Fri,  2 Aug 2019 13:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564752296;
        bh=GBkxAE6ZenMIaib6Hgv4wKxi80SCOK4Va/wOiXJWcHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TH47K7WypP+53IE9QVTuWDrMuKYmThmXW8MKD+5Pqgrx8hbvDfk5cEZ86g1bYwLOw
         /sR9h964uE3ld1V69ieweuzIjbz/vcWmNxO0L4hzxUXxZAF8lS7JyDrAz7n4tJVx8n
         Or3De9eci7RFMk3LiWmYpO8TXx7twC1tgPRxSwKs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Vinod Koul <vkoul@kernel.org>, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 18/30] ALSA: compress: Be more restrictive about when a drain is allowed
Date:   Fri,  2 Aug 2019 09:24:10 -0400
Message-Id: <20190802132422.13963-18-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802132422.13963-1-sashal@kernel.org>
References: <20190802132422.13963-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charles Keepax <ckeepax@opensource.cirrus.com>

[ Upstream commit 3b8179944cb0dd53e5223996966746cdc8a60657 ]

Draining makes little sense in the situation of hardware overrun, as the
hardware will have consumed all its available samples. Additionally,
draining whilst the stream is paused would presumably get stuck as no
data is being consumed on the DSP side.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/compress_offload.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index b4f1536b17cb5..2e2d184684911 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -812,7 +812,10 @@ static int snd_compr_drain(struct snd_compr_stream *stream)
 	case SNDRV_PCM_STATE_OPEN:
 	case SNDRV_PCM_STATE_SETUP:
 	case SNDRV_PCM_STATE_PREPARED:
+	case SNDRV_PCM_STATE_PAUSED:
 		return -EPERM;
+	case SNDRV_PCM_STATE_XRUN:
+		return -EPIPE;
 	default:
 		break;
 	}
@@ -861,7 +864,10 @@ static int snd_compr_partial_drain(struct snd_compr_stream *stream)
 	case SNDRV_PCM_STATE_OPEN:
 	case SNDRV_PCM_STATE_SETUP:
 	case SNDRV_PCM_STATE_PREPARED:
+	case SNDRV_PCM_STATE_PAUSED:
 		return -EPERM;
+	case SNDRV_PCM_STATE_XRUN:
+		return -EPIPE;
 	default:
 		break;
 	}
-- 
2.20.1

