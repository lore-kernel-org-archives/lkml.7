Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC28C43141
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD5E921845
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573920333;
	bh=yaJoh/7AyG+itmJ2dxC94svgjgemr1sqw9xtDGBeWVA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=tvabFVuodMFeegf34ATe+y2+cQZ7DM3sAPCHtcwqxvGIBerkLhH4iq5bvKUr4sWAY
	 hYYHrb+Muzwfp0KzUKLzYq0AScmRU8uKTzQoLoHC7H0Di+5s7d+XIeiISoTTPMOwAi
	 w++RO8/G/k44sXxheuKsIK8+A2UpFE8Hl8LIcRqA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbfKPPvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:51:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:59534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730587AbfKPPvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:51:04 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C65F620885;
        Sat, 16 Nov 2019 15:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919464;
        bh=yaJoh/7AyG+itmJ2dxC94svgjgemr1sqw9xtDGBeWVA=;
        h=From:To:Cc:Subject:Date:From;
        b=0h/Aj0PnerJ9cIVHFgeCtcmItK5BcoFavHXKWHVDS3WL4IqXiniUC3/Vfdeo7ey1e
         bsz8DvButf96O3qnZVZStQyLSUmS2hCrtK2b/2VQ6ZIvDrSjjtjdZg5xyOvo+o98NE
         dYE74uvb5L6nxDOYLiC0XiW9zLmejyDPHwqfLU5Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 01/99] ALSA: isight: fix leak of reference to firewire unit in error path of .probe callback
Date:   Sat, 16 Nov 2019 10:49:24 -0500
Message-Id: <20191116155103.10971-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

[ Upstream commit 51e68fb0929c29e47e9074ca3e99ffd6021a1c5a ]

In some error paths, reference count of firewire unit is not decreased.
This commit fixes the bug.

Fixes: 5b14ec25a79b('ALSA: firewire: release reference count of firewire unit in .remove callback of bus driver')
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/firewire/isight.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/firewire/isight.c b/sound/firewire/isight.c
index 48d6dca471c6b..6c8daf5b391ff 100644
--- a/sound/firewire/isight.c
+++ b/sound/firewire/isight.c
@@ -639,7 +639,7 @@ static int isight_probe(struct fw_unit *unit,
 	if (!isight->audio_base) {
 		dev_err(&unit->device, "audio unit base not found\n");
 		err = -ENXIO;
-		goto err_unit;
+		goto error;
 	}
 	fw_iso_resources_init(&isight->resources, unit);
 
@@ -668,12 +668,12 @@ static int isight_probe(struct fw_unit *unit,
 	dev_set_drvdata(&unit->device, isight);
 
 	return 0;
-
-err_unit:
-	fw_unit_put(isight->unit);
-	mutex_destroy(&isight->mutex);
 error:
 	snd_card_free(card);
+
+	mutex_destroy(&isight->mutex);
+	fw_unit_put(isight->unit);
+
 	return err;
 }
 
-- 
2.20.1

