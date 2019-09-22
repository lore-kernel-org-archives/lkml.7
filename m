Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229BCC3A5A6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E989D20644
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569181096;
	bh=Efrs07DtXo6dlB5edLomXEd/SCJQyQCva1c9N4iPxMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y+2Gv+QE2+YaHiHzrBk5U8LbTvLgkEiouW/0Slc/vY//EK6obpEmReB/aSQ142Nni
	 OI/JQNZ8c/bHcSnq0nbm7K67QIBt9y/m2IrXPldAm9p31ls6aAPDfygLsbH84H8KSg
	 jZhBhx9U/+fCnTNGPSswh8zPY3LT7cUJVue3Z52c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393565AbfIVTiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 15:38:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:41286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389363AbfIVSpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:45:36 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFB74214D9;
        Sun, 22 Sep 2019 18:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569177935;
        bh=Efrs07DtXo6dlB5edLomXEd/SCJQyQCva1c9N4iPxMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gkQuUuMNptp2VFpmhg8HmwIYCRZNdRXd09KG7TgNPu8m4bRkNlZHfathxdWK5HGLN
         4wjF8d+udq29p2YIBRoXAqhtAgV2maPeBiyq/CZd1dmZoHY0Q8usvzpeRu+hI5bMf7
         jIr+ajiKGdGGQupoezCyo7CwTO82gK0dOKz9wcuM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ard van Breemen <ard@kwaak.net>, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.3 045/203] ALSA: usb-audio: Skip bSynchAddress endpoint check if it is invalid
Date:   Sun, 22 Sep 2019 14:41:11 -0400
Message-Id: <20190922184350.30563-45-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922184350.30563-1-sashal@kernel.org>
References: <20190922184350.30563-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

