Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472CFC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 185A02064A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553907716;
	bh=2rWYJvhuNuUnH+vJBk8D51hT1wy7nXgnOojCXjyMeGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EX5lDT5UMNjp33v6rs1fpLOGg03dmZWr6zkaoHlKSKv04sUKm2ezsw2qd5+HrifFP
	 TdAU/6+IkmOOABh6gd8HLVss0OUzmn7V46s6EDJ/crnQgi7glGUpSOJAKLNzowzl3f
	 bsuo/R58A0Nsx2EkSuj/FuVK4egHXjohLH/LcBUE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731998AbfC3BBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:01:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:35502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731391AbfC3A4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:56:03 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93ED32064A;
        Sat, 30 Mar 2019 00:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907363;
        bh=2rWYJvhuNuUnH+vJBk8D51hT1wy7nXgnOojCXjyMeGU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cd8Y7uYylBUH8Kxj3DrvLK1bdclr19eNks/VD5TGrxIrLXhirmJCDkT9xBhuQfO5W
         QlbVbiMnXfeEEAbQRjAoAZ5L977k/KqZIZ2BN+o0SJsHew79ul9yG1bMgwI33eKBDy
         dBTpXp2pT1fhx+GMI6Q+pn+gJ/9dkM9ZI4QbuX0k=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 05/27] ALSA: echoaudio: add a check for ioremap_nocache
Date:   Fri, 29 Mar 2019 20:55:31 -0400
Message-Id: <20190330005555.28087-5-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005555.28087-1-sashal@kernel.org>
References: <20190330005555.28087-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>

[ Upstream commit 6ade657d6125ec3ec07f95fa51e28138aef6208f ]

In case ioremap_nocache fails, the fix releases chip and returns
an error code upstream to avoid NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/echoaudio/echoaudio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/pci/echoaudio/echoaudio.c b/sound/pci/echoaudio/echoaudio.c
index 286f5e3686a3..d73ee11a32bd 100644
--- a/sound/pci/echoaudio/echoaudio.c
+++ b/sound/pci/echoaudio/echoaudio.c
@@ -1953,6 +1953,11 @@ static int snd_echo_create(struct snd_card *card,
 	}
 	chip->dsp_registers = (volatile u32 __iomem *)
 		ioremap_nocache(chip->dsp_registers_phys, sz);
+	if (!chip->dsp_registers) {
+		dev_err(chip->card->dev, "ioremap failed\n");
+		snd_echo_free(chip);
+		return -ENOMEM;
+	}
 
 	if (request_irq(pci->irq, snd_echo_interrupt, IRQF_SHARED,
 			KBUILD_MODNAME, chip)) {
-- 
2.19.1

