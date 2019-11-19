Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8396FC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB3D214DE
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574141871;
	bh=GoZOEk//ETXD6J0deAkiRjiiaR686w21jUnxlJ4hgm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l/ibPaEyojJmTLhs2LmVBcdgpyvrxXEwXzgU5bn2jjxKDC0iXpcDrzUotfNWDvFKl
	 Y9kFRNVxuB0AvtIQoJGYkEKkrq+py6c4VxDS7pbJW6hIDPGBzGVPNA5qjokVqwrn3u
	 PX3/3zNv8B+4jcR6YYMH7gswmBhiQDOlwUcfPSFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730132AbfKSFhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:37:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:59718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730123AbfKSFht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:37:49 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21006206EC;
        Tue, 19 Nov 2019 05:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141868;
        bh=GoZOEk//ETXD6J0deAkiRjiiaR686w21jUnxlJ4hgm4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jv09rGIjNZjEJYXbN2d8/HwbrP6LpmlRjCseJ2yfeUVHpcGZnudbMVeFtk+A7BdEW
         kO4OXreQW1LXCWS24pItEIefqayRjbf47PTz06uUzoRSY0dDAoXMdttVZLj51F+29+
         ztIWt5OW35Ie/+FOGf+WZ64Mj+mGm93UfxiSQnw0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 271/422] power: supply: twl4030_charger: fix charging current out-of-bounds
Date:   Tue, 19 Nov 2019 06:17:48 +0100
Message-Id: <20191119051416.548212950@linuxfoundation.org>
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

From: Andreas Kemnade <andreas@kemnade.info>

[ Upstream commit 8314c212f995bc0d06b54ad02ef0ab4089781540 ]

the charging current uses unsigned int variables, if we step back
if the current is still low, we would run into negative which
means setting the target to a huge value.
Better add checks here.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/twl4030_charger.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/supply/twl4030_charger.c
index b6a7d9f74cf30..adcaa0a10a6f4 100644
--- a/drivers/power/supply/twl4030_charger.c
+++ b/drivers/power/supply/twl4030_charger.c
@@ -420,7 +420,8 @@ static void twl4030_current_worker(struct work_struct *data)
 
 	if (v < USB_MIN_VOLT) {
 		/* Back up and stop adjusting. */
-		bci->usb_cur -= USB_CUR_STEP;
+		if (bci->usb_cur >= USB_CUR_STEP)
+			bci->usb_cur -= USB_CUR_STEP;
 		bci->usb_cur_target = bci->usb_cur;
 	} else if (bci->usb_cur >= bci->usb_cur_target ||
 		   bci->usb_cur + USB_CUR_STEP > USB_MAX_CURRENT) {
-- 
2.20.1



