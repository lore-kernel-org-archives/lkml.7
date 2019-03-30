Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496EAC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE24218FC
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553907200;
	bh=aclzHnXw0vF3n7o18XRRxm8pAwVuQ6q7u69bzums1Fk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HjpjEPSqTivB8Kp7k9u7BCJS27MlSjeUy/22NYWkbML1tQDkEDZ1FrKlailHEQ/5Y
	 J7nird0TWGWMuUHq6Oie1K7f7XeW9TFPodQ1857O20TF5be9fflCUq/I2Sv+i5cSIB
	 /jNXbzKluVx7uxlX9crQOM68buDBYanb+5Pzya4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731239AbfC3AxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:53:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:60088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731202AbfC3AxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:53:15 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5A03218EA;
        Sat, 30 Mar 2019 00:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907195;
        bh=aclzHnXw0vF3n7o18XRRxm8pAwVuQ6q7u69bzums1Fk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fFGpWhFZq2FlXdpE+jNuWn/nQkxNc+B3NPIpWqbcPt5iPNZBt6wIsCplXta18MQ0f
         hwJ+7vq6kDOYrkr3hz4VzDoneLFH5exnVP46AYL0z4Bz0B6617L1wjw/7fqt0cwEMx
         XNQAO00yEmHjV4ptx2/5aBUAYI3wna+HXeeqcjB0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 09/52] ALSA: echoaudio: add a check for ioremap_nocache
Date:   Fri, 29 Mar 2019 20:52:16 -0400
Message-Id: <20190330005301.26868-9-sashal@kernel.org>
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
index 907cf1a46712..3ef2b27ebbe8 100644
--- a/sound/pci/echoaudio/echoaudio.c
+++ b/sound/pci/echoaudio/echoaudio.c
@@ -1954,6 +1954,11 @@ static int snd_echo_create(struct snd_card *card,
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

