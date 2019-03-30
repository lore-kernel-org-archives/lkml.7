Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EEBC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBEB22064A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553908052;
	bh=BCZTI8lB5BBNy2e4lIxEPcWkl+s2OsRLAbkfFcuNc5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XlMZyAmMREmS+aMqTiSpctUYBrBpkzNztDahvJojAepcN5RfI59lUMCYsvfZ5o4Tq
	 Stv4Ac7fXAreH64ULa38+fA/vaC59UK2rLZ046RpSa1ix6S1ZTLhGyXHHjE46DjGUu
	 CUCsO3hGljNyYvqZ9jXSEaIii5P5rOttDYqHZE6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731507AbfC3BHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:07:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731233AbfC3AxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:53:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC019218CD;
        Sat, 30 Mar 2019 00:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907197;
        bh=BCZTI8lB5BBNy2e4lIxEPcWkl+s2OsRLAbkfFcuNc5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z1vwgQmPFkv2nUPKjxZgxLetQ8vdmxwM1QAhufDhMNJzBjQIjU4HyBiVYjyhm+zBY
         50FIOqSerajwiOGu3yQTlGdZyQ3m3vXbhQgDWDpq6AHT3phbZvr7WLqAHrsH6OPdpg
         OdLtzGLHnynolS7MUPrqF5i02MTGl9RLM91BmvsY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 10/52] ALSA: sb8: add a check for request_region
Date:   Fri, 29 Mar 2019 20:52:17 -0400
Message-Id: <20190330005301.26868-10-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005301.26868-1-sashal@kernel.org>
References: <20190330005301.26868-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>

[ Upstream commit dcd0feac9bab901d5739de51b3f69840851f8919 ]

In case request_region fails, the fix returns an error code to
avoid NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/isa/sb/sb8.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/isa/sb/sb8.c b/sound/isa/sb/sb8.c
index d77dcba276b5..1eb8b61a185b 100644
--- a/sound/isa/sb/sb8.c
+++ b/sound/isa/sb/sb8.c
@@ -111,6 +111,10 @@ static int snd_sb8_probe(struct device *pdev, unsigned int dev)
 
 	/* block the 0x388 port to avoid PnP conflicts */
 	acard->fm_res = request_region(0x388, 4, "SoundBlaster FM");
+	if (!acard->fm_res) {
+		err = -EBUSY;
+		goto _err;
+	}
 
 	if (port[dev] != SNDRV_AUTO_PORT) {
 		if ((err = snd_sbdsp_create(card, port[dev], irq[dev],
-- 
2.19.1

