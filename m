Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A59DC43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E1AA21823
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574141103;
	bh=yZHetACKVRtNetBPPdhjKthBtWVOXjiKVm+J2t0m8xk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MvHvkpxitcCzfUJgdwwJjf8eolccW1dgPJ4tZ4U3O1zfZV5TiITtTWYiDeaUrt60D
	 bwuRb863rDQtGO8BSJXohfDihD65PUAEZKbMAzoud6aWHh3hTA72mlo/MClaJdgdEt
	 zSDsOy4bo3RkOjWwfZhWuxAAyIp2M5iaji9/0zrw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfKSFZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:25:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:41586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727604AbfKSFY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:24:59 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E72C121783;
        Tue, 19 Nov 2019 05:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141098;
        bh=yZHetACKVRtNetBPPdhjKthBtWVOXjiKVm+J2t0m8xk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oE3zvbEDu4PNl/B83ZzkiAgr2QvPL/pS3Jz2IZKR/RufZxC5zDe0OjvGTwbiy5GY4
         28CQjg2LJCt4dy9UWZCQU+VXy93ZtbIo9n2MFSwtwhvW/PozBGBnVEdDRpo6s+jJ06
         phHEeO5DQTHK8WD3uXTcqxYbEJcy9LK9Tjlg7R7g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 043/422] ALSA: pcm: signedness bug in snd_pcm_plug_alloc()
Date:   Tue, 19 Nov 2019 06:14:00 +0100
Message-Id: <20191119051402.709547687@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 6f128fa41f310e1f39ebcea9621d2905549ecf52 ]

The "frames" variable is unsigned so the error handling doesn't work
properly.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/oss/pcm_plugin.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/oss/pcm_plugin.c b/sound/core/oss/pcm_plugin.c
index 71571d9921598..31cb2acf8afcc 100644
--- a/sound/core/oss/pcm_plugin.c
+++ b/sound/core/oss/pcm_plugin.c
@@ -111,7 +111,7 @@ int snd_pcm_plug_alloc(struct snd_pcm_substream *plug, snd_pcm_uframes_t frames)
 		while (plugin->next) {
 			if (plugin->dst_frames)
 				frames = plugin->dst_frames(plugin, frames);
-			if (snd_BUG_ON(frames <= 0))
+			if (snd_BUG_ON((snd_pcm_sframes_t)frames <= 0))
 				return -ENXIO;
 			plugin = plugin->next;
 			err = snd_pcm_plugin_alloc(plugin, frames);
@@ -123,7 +123,7 @@ int snd_pcm_plug_alloc(struct snd_pcm_substream *plug, snd_pcm_uframes_t frames)
 		while (plugin->prev) {
 			if (plugin->src_frames)
 				frames = plugin->src_frames(plugin, frames);
-			if (snd_BUG_ON(frames <= 0))
+			if (snd_BUG_ON((snd_pcm_sframes_t)frames <= 0))
 				return -ENXIO;
 			plugin = plugin->prev;
 			err = snd_pcm_plugin_alloc(plugin, frames);
-- 
2.20.1



