Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAF0C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3804D20643
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611675;
	bh=QOPhOtsI890217ZLprqm3dHIJaVXc4IHks0T7uj9qLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EkZEqo0ijB2DdIG+zLPW3HfMybBJBGoU+BRggBZg4yLYuEx04LvWXWkh0pMQUOMPl
	 xjmmrs1synVmPQQP+PZC0udcIT80Kpw5OwYY6pasxCxzr60GmcjJUCv2OJuZia9o6t
	 +r5vZQP9WT0tPDsjTlGYoLxAc2CXdKppB0RiSOhU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391699AbfDRSH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:07:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:38930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389862AbfDRSH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:07:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 964B5217FA;
        Thu, 18 Apr 2019 18:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610876;
        bh=QOPhOtsI890217ZLprqm3dHIJaVXc4IHks0T7uj9qLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HhhmvCSh/oRuUewyOmKd+Bg5NRqawk6+rAsZBQyoiPtVlEVR3b6VNTqUZi6Y966HY
         LOQea0iUUbsd5PkqYdWDERLAImM4xxRUT8CxfVRhNKFe/JRQ5xtYbo+KhW86m1Fj/l
         fxWTuSNCKSXz3EezoI6TuAA1vAY3SVlSBhEZlFtU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 05/50] ALSA: echoaudio: add a check for ioremap_nocache
Date:   Thu, 18 Apr 2019 19:57:16 +0200
Message-Id: <20190418160423.565942478@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160422.455656724@linuxfoundation.org>
References: <20190418160422.455656724@linuxfoundation.org>
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



