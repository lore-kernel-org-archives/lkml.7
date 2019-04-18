Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F34C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71690217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610309;
	bh=3e9iaK1NdEqCCMOCMT6b7kwJCt0ejbGbBUhp04VCO6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1usZxfC1ni2ei/P6phd8fqBsGbDCMb0LrflNdfA8/kwzc02tV8KM2pATbivwQsV1Z
	 vjmhomzqhUfbgCGDyubd9Vg9dI1uAY1rdhVxItcxUeWB5sVqImx8c+MT1VdsdFDJeL
	 xiR1VtG1OSH8yp/GR2FGCbY2ZN8mDM/DXM98Z6XI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389840AbfDRR62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 13:58:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:52544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388299AbfDRR60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 13:58:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24DB32186A;
        Thu, 18 Apr 2019 17:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610305;
        bh=3e9iaK1NdEqCCMOCMT6b7kwJCt0ejbGbBUhp04VCO6k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bLBOrJabrvo+kOeJFg3q5IJxEpVCDjq4Z5T4PfwSW3w073sMnYZczG+Hj8CzraNjz
         scGa2jMO4DPH24WLDx2JFp7hCH7+p8eTgfYlfXt8Qfw/2UKbcFvwxBN79bAvQK21FG
         DxQQCf33zJXNNQ4hQVMmjnC/h0/oj+VMWeNVfYjE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 010/110] ALSA: sb8: add a check for request_region
Date:   Thu, 18 Apr 2019 19:55:59 +0200
Message-Id: <20190418160438.361867472@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160437.484158340@linuxfoundation.org>
References: <20190418160437.484158340@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



