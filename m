Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB540C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0ED20830
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570120463;
	bh=Q/NK56j/ghdmHEJTxu2BwpA78enXAjTw55znvF1Vb/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Sy3E3l7QiMfCZVGFK2Ipbr7ORnXkES+D73SB4abgJ/I176xBV4TWOwJo4CpxeqlyC
	 Iz1TW3FaPH+bTk1zJbTzOtq9NpFgghYNTYa4bDTvC/Z7YFKFsmCiw3H0D2ZuiaD385
	 7IIbcTvawVOxkKqjdSuYhp6pE6S+yYScbe9LAWuA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404165AbfJCQeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:34:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:42872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392122AbfJCQeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:34:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 198A92086A;
        Thu,  3 Oct 2019 16:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570120459;
        bh=Q/NK56j/ghdmHEJTxu2BwpA78enXAjTw55znvF1Vb/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fgPaC9C8UFwMcRjQOZl2pmt7IdDlyAGk75p7p8oMNSpSldF5CwOd++t9LivlBBe/a
         MlR/aF/juTLwugyJFpIztu/NlF11FyStVWQYxE5/n2bRFZmMVWOMwcXon8HEhZI0MI
         LgDaimMAAowNb/piswkWtf2S/7bzXvUThwf5/B0k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 203/313] ALSA: hda/realtek - Blacklist PC beep for Lenovo ThinkCentre M73/93
Date:   Thu,  3 Oct 2019 17:53:01 +0200
Message-Id: <20191003154552.986364854@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154533.590915454@linuxfoundation.org>
References: <20191003154533.590915454@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 051c78af14fcd74a22b5af45548ad9d588247cc7 ]

Lenovo ThinkCentre M73 and M93 don't seem to have a proper beep
although the driver tries to probe and set up blindly.
Blacklist these machines for suppressing the beep creation.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204635
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1bec62720374d..d223a79ac934f 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1058,6 +1058,9 @@ static const struct snd_pci_quirk beep_white_list[] = {
 	SND_PCI_QUIRK(0x1043, 0x834a, "EeePC", 1),
 	SND_PCI_QUIRK(0x1458, 0xa002, "GA-MA790X", 1),
 	SND_PCI_QUIRK(0x8086, 0xd613, "Intel", 1),
+	/* blacklist -- no beep available */
+	SND_PCI_QUIRK(0x17aa, 0x309e, "Lenovo ThinkCentre M73", 0),
+	SND_PCI_QUIRK(0x17aa, 0x30a3, "Lenovo ThinkCentre M93", 0),
 	{}
 };
 
-- 
2.20.1



