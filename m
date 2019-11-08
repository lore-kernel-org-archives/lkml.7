Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEB9FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD19222C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573213519;
	bh=rsIFastpJJlICg4cAEuQV+rAu0HcIDPMReFk86IgpQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I3VhRaLU1MO0YaHgFg9U4HI/CVu8kwRh/Zum6r3geoG0V5t1aczCW9BgiTcEpRJjh
	 MYw62f3Hw3cQiNlIJh4XkNUxT1Fusm5TbfFI6QcEFvL0Ti9Xu+9GLw/pcOpQX9xlrY
	 5djSkfQF6eX3AzKSMQaxqktLaN8rad87PyVb8v2w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391082AbfKHLpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:45:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:60350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388365AbfKHLpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:45:11 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 187A620656;
        Fri,  8 Nov 2019 11:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213510;
        bh=rsIFastpJJlICg4cAEuQV+rAu0HcIDPMReFk86IgpQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rR/RHiWFWM6xFOV2jX+PiRgfb3tXEmaYWRniEuNZaZ79IEm/K/qHKcKUWM209Tt+v
         1VCuNQSrUxb7LK3jFzXn7eW+7GiKISXqXhJji5LVB57A5zjM5okNm258SpCaEm6Uvh
         vAdBc0YzmpOZ84h/KFp8STM/DdiHzySPWsddWGm8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 083/103] ALSA: intel8x0m: Register irq handler after register initializations
Date:   Fri,  8 Nov 2019 06:42:48 -0500
Message-Id: <20191108114310.14363-83-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108114310.14363-1-sashal@kernel.org>
References: <20191108114310.14363-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 7064f376d4a10686f51c879401a569bb4babf9c6 ]

The interrupt handler has to be acquired after the other resource
initialization when allocated with IRQF_SHARED.  Otherwise it's
triggered before the resource gets ready, and may lead to unpleasant
behavior.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/intel8x0m.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/pci/intel8x0m.c b/sound/pci/intel8x0m.c
index 3a4769a97d290..a626ee18628ea 100644
--- a/sound/pci/intel8x0m.c
+++ b/sound/pci/intel8x0m.c
@@ -1171,16 +1171,6 @@ static int snd_intel8x0m_create(struct snd_card *card,
 	}
 
  port_inited:
-	if (request_irq(pci->irq, snd_intel8x0m_interrupt, IRQF_SHARED,
-			KBUILD_MODNAME, chip)) {
-		dev_err(card->dev, "unable to grab IRQ %d\n", pci->irq);
-		snd_intel8x0m_free(chip);
-		return -EBUSY;
-	}
-	chip->irq = pci->irq;
-	pci_set_master(pci);
-	synchronize_irq(chip->irq);
-
 	/* initialize offsets */
 	chip->bdbars_count = 2;
 	tbl = intel_regs;
@@ -1224,11 +1214,21 @@ static int snd_intel8x0m_create(struct snd_card *card,
 	chip->int_sta_reg = ICH_REG_GLOB_STA;
 	chip->int_sta_mask = int_sta_masks;
 
+	pci_set_master(pci);
+
 	if ((err = snd_intel8x0m_chip_init(chip, 1)) < 0) {
 		snd_intel8x0m_free(chip);
 		return err;
 	}
 
+	if (request_irq(pci->irq, snd_intel8x0m_interrupt, IRQF_SHARED,
+			KBUILD_MODNAME, chip)) {
+		dev_err(card->dev, "unable to grab IRQ %d\n", pci->irq);
+		snd_intel8x0m_free(chip);
+		return -EBUSY;
+	}
+	chip->irq = pci->irq;
+
 	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
 		snd_intel8x0m_free(chip);
 		return err;
-- 
2.20.1

