Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB546C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B77215EA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570120913;
	bh=Efrs07DtXo6dlB5edLomXEd/SCJQyQCva1c9N4iPxMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GtaVs4gu70+0bQ8N4HDFqAQF8soE+06uVbMV0doqaTQ8ywIO/Cofa9Nu7Jdx7em5r
	 xsCLMwb9SiYAEvIUnSM+pgNZ52pFguh918thQCr2hMmTvmLqSAckOzOcck/UbJxJHT
	 nrVO8mI7TycdXQC6Zx/brlPlUzU4oU/n26PAJZCM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391818AbfJCQlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:41:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:52244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404660AbfJCQln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:41:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 077522054F;
        Thu,  3 Oct 2019 16:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570120902;
        bh=Efrs07DtXo6dlB5edLomXEd/SCJQyQCva1c9N4iPxMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jcn+AXWpETztasE22oApNPadyrizxm8ngl/rte3xwvj9oAHcVHTcEqKnDeKoa4a2t
         g6sXtBrqFytLFUmMPf5oBBA9YGq/r+pVl79wy8HQzw+gvnr+pQJbTmhiNZ/5TIaKDo
         tZBAbVgWUfoR1jK/8Nbhl6CBHo6QeG5nly2P2x2E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard van Breemen <ard@kwaak.net>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 081/344] ALSA: usb-audio: Skip bSynchAddress endpoint check if it is invalid
Date:   Thu,  3 Oct 2019 17:50:46 +0200
Message-Id: <20191003154548.132056513@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154540.062170222@linuxfoundation.org>
References: <20191003154540.062170222@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard van Breemen <ard@kwaak.net>

[ Upstream commit 1b34121d9f26d272b0b2334209af6b6fc82d4bf1 ]

The Linux kernel assumes that get_endpoint(alts,0) and
get_endpoint(alts,1) are eachothers feedback endpoints.
To reassure that validity it will test bsynchaddress to comply with that
assumption. But if the bsyncaddress is 0 (invalid), it will flag that as
a wrong assumption and return an error.
Fix: Skip the test if bSynchAddress is 0.
Note: those with a valid bSynchAddress should have a code quirck added.

Signed-off-by: Ard van Breemen <ard@kwaak.net>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/pcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index e4bbf79de956e..33cd26763c0ee 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -457,6 +457,7 @@ static int set_sync_endpoint(struct snd_usb_substream *subs,
 	}
 	ep = get_endpoint(alts, 1)->bEndpointAddress;
 	if (get_endpoint(alts, 0)->bLength >= USB_DT_ENDPOINT_AUDIO_SIZE &&
+	    get_endpoint(alts, 0)->bSynchAddress != 0 &&
 	    ((is_playback && ep != (unsigned int)(get_endpoint(alts, 0)->bSynchAddress | USB_DIR_IN)) ||
 	     (!is_playback && ep != (unsigned int)(get_endpoint(alts, 0)->bSynchAddress & ~USB_DIR_IN)))) {
 		dev_err(&dev->dev,
-- 
2.20.1



