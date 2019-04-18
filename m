Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384E5C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED9B92186A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610673;
	bh=wWvtbD23n4dvYoYR4yRLnipuZkPo6kHWv3YjYvZCcag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GLPi7Cz9mR5k4hTmqRc6GSf/gZ5BqIfd1Ke/A4U6K5U2+8UZjZLdEq+f5E2DSupbx
	 v/j+sx2JzQ9K3pa0eW6tZSDE+PIuXgO/kS8t5B/9Sm8xA594gM4+vdWMrIOvdYrxUp
	 wl4VLWG6v7kmL6nurjSESLLAtplan2HTWHL4zcho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391159AbfDRSEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:04:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:33374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391108AbfDRSEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:04:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72895206B6;
        Thu, 18 Apr 2019 18:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610664;
        bh=wWvtbD23n4dvYoYR4yRLnipuZkPo6kHWv3YjYvZCcag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KFEIQpL6Mnyqc8YbckA39wOJVYCd0a6fnu/Xu+dUhlrdf15MnRKpfcUKZ83qigZ6A
         mjBEqfRhzJu68S1dSfCDfQ1exWTrhUij4QM07/BH6cTyESkMUF9Q8kasiu/FeFVa8/
         wEr6RUCBJPrP0lhhlE8oSCRjtSnUFaiwa2RdU1es=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 06/92] ALSA: echoaudio: add a check for ioremap_nocache
Date:   Thu, 18 Apr 2019 19:56:24 +0200
Message-Id: <20190418160431.015356253@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160430.325165109@linuxfoundation.org>
References: <20190418160430.325165109@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index d68f99e076a8..e1f0bcd45c37 100644
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



