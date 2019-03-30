Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700E1C4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB0E206DD
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553907461;
	bh=673JYqqIyOEBEsU9wGI5YcdbRXPaiqzoOxN8tlZJqH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l3Kvg+oa1+nUSnRXaxWQZ1kjWi8vC12VUAhd7RkY8COUK85SS7G951bkcAJzKbe4Q
	 vMXZKhZzNgELtDdf/2co5eMcObMnGmjoOIFVwJd2zic8V9WrijWQL9J7WUpJ2ph9rg
	 vaUKVlCI0cv2Q/gl5Ym2dd6yiA0Zwnd3zZELMo40=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732161AbfC3A5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:57:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:37940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732150AbfC3A5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:57:36 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A9052184C;
        Sat, 30 Mar 2019 00:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907456;
        bh=673JYqqIyOEBEsU9wGI5YcdbRXPaiqzoOxN8tlZJqH8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qkf+c9byRpcSV2ebof2xS47SKoySIm528/ZkE+EOBAO0z7pnOn+Xtf4YyJv9wH7VT
         rZY6OFNKVOuhGLK3jlE00vz7hNLvm6a7OhcjZuuSeGgZ0cgJyi+CKUfC0UO9Evf60V
         QGWnoxQL++LrZAJjY1ZmSg2xes8JOWTAXFo7YCuA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 03/15] ALSA: echoaudio: add a check for ioremap_nocache
Date:   Fri, 29 Mar 2019 20:57:18 -0400
Message-Id: <20190330005730.28777-3-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005730.28777-1-sashal@kernel.org>
References: <20190330005730.28777-1-sashal@kernel.org>
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
index 3a1fe2c79b4a..c07bf03a07bc 100644
--- a/sound/pci/echoaudio/echoaudio.c
+++ b/sound/pci/echoaudio/echoaudio.c
@@ -1990,6 +1990,11 @@ static int snd_echo_create(struct snd_card *card,
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

