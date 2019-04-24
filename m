Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8D5C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0860218FE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126026;
	bh=D7d+j648//GwSXzLWyt0IGJJDB8ZLR145XLwulb7riA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=II7Jdr5S533IBnggQK9irfajiS6lIa5CYMiW1vEFwTr6mDIHTsVlS2rrySKAZJ6OS
	 q8eUFwcWvI4cyPPU+z+LpxATcPJ8IModeXgiDt/tdMn5L/GXMWuEdpfwJZZ0RkZmdV
	 1+mqLSxI5OyHDzaIyQINHmRHXNZXO/Pvt4Sq00aU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387933AbfDXRNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:13:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:37750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387904AbfDXRNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:13:40 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A937121909;
        Wed, 24 Apr 2019 17:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126020;
        bh=D7d+j648//GwSXzLWyt0IGJJDB8ZLR145XLwulb7riA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w74iWrtyV5HczBtztnh2G+DZE7sMv8CuKs4P6RFslM5r1i3or2O1jWSs+vvIh2Q7e
         C5Ui3bs7ld48y1Ui7qi9RVBk6raWopnCdfLrLPm5tqWRNL4YsLOTNmoH8BuSSp6iJj
         AFalVqsOhcZXESnkAib77WLkRhckZOb6TKEvd9IY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 064/104] ALSA: sb8: add a check for request_region
Date:   Wed, 24 Apr 2019 19:09:21 +0200
Message-Id: <20190424170904.489603044@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170839.996641496@linuxfoundation.org>
References: <20190424170839.996641496@linuxfoundation.org>
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
index 6c32b3aa34af..938262d3aa7b 100644
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



