Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCA8C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B03320659
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563996823;
	bh=3uFTwaDHAmJ73S7JmU9w0woFrRgrA8PUMRkK9FBCeew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ryyo+uG7mDED+izvV8Qbzjrtgs3RYlDKpIqAklAwAzIiCaQyvk/fbvHvSB0zB+VGC
	 L0gj+INi3W7ExELLZOMnOjDZX/cTQETq8pA2EwBh33Nk+MMkh6nc8rsD8VAtifsCU9
	 Gvp1rib7VMXCBEk/8a4kYlLHgZlw1wz8BdF9moGA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388898AbfGXTdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:33:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388846AbfGXTdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:33:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38638229FA;
        Wed, 24 Jul 2019 19:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563996815;
        bh=3uFTwaDHAmJ73S7JmU9w0woFrRgrA8PUMRkK9FBCeew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oaYHBNkU6lTFpP4psXvfXZrNo+j9vwUjBHWXCcl2a+1TtZLMgexzXLNNJUhVLOUGX
         sNEmE47XA2OwX0Szvc/uDyEIInr/XMkVuPS4BxrbOhxLjEYzgB4VroJH2Q4y2GMl53
         7C8sTEGeyNvNys92EjEcM1+hj6+TLPlu86ly2p7s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Rander Wang <rander.wang@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 209/413] ALSA: hda: Fix a headphone detection issue when using SOF
Date:   Wed, 24 Jul 2019 21:18:20 +0200
Message-Id: <20190724191749.456916644@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 7c2b3629d09ddec810dc4c1d3a6657c32def8f71 ]

To save power, the hda hdmi driver in ASoC invokes snd_hdac_ext_bus_link_put
to disable CORB/RIRB buffers DMA if there is no user of bus and invokes
snd_hdac_ext_bus_link_get to set up CORB/RIRB buffers when it is used.
Unsolicited responses is disabled in snd_hdac_bus_stop_cmd_io called by
snd_hdac_ext_bus_link_put , but it is not enabled in snd_hdac_bus_init_cmd_io
called by snd_hdac_ext_bus_link_get. So for put-get sequence, Unsolicited
responses is disabled and headphone can't be detected by hda codecs.

Now unsolicited responses is only enabled in snd_hdac_bus_reset_link
which resets controller. The function is only called for setup of
controller. This patch enables Unsolicited responses after RIRB is
initialized in snd_hdac_bus_init_cmd_io which works together with
snd_hdac_bus_reset_link to set up controller.

Tested legacy hda driver and SOF driver on intel whiskeylake.

Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/hdac_controller.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/hda/hdac_controller.c b/sound/hda/hdac_controller.c
index b02f74528b66..812dc144fb5b 100644
--- a/sound/hda/hdac_controller.c
+++ b/sound/hda/hdac_controller.c
@@ -79,6 +79,8 @@ void snd_hdac_bus_init_cmd_io(struct hdac_bus *bus)
 	snd_hdac_chip_writew(bus, RINTCNT, 1);
 	/* enable rirb dma and response irq */
 	snd_hdac_chip_writeb(bus, RIRBCTL, AZX_RBCTL_DMA_EN | AZX_RBCTL_IRQ_EN);
+	/* Accept unsolicited responses */
+	snd_hdac_chip_updatel(bus, GCTL, AZX_GCTL_UNSOL, AZX_GCTL_UNSOL);
 	spin_unlock_irq(&bus->reg_lock);
 }
 EXPORT_SYMBOL_GPL(snd_hdac_bus_init_cmd_io);
@@ -415,9 +417,6 @@ int snd_hdac_bus_reset_link(struct hdac_bus *bus, bool full_reset)
 		return -EBUSY;
 	}
 
-	/* Accept unsolicited responses */
-	snd_hdac_chip_updatel(bus, GCTL, AZX_GCTL_UNSOL, AZX_GCTL_UNSOL);
-
 	/* detect codecs */
 	if (!bus->codec_mask) {
 		bus->codec_mask = snd_hdac_chip_readw(bus, STATESTS);
-- 
2.20.1



