Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8FBC3A5A6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 18:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8243321D6C
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 18:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569178173;
	bh=Q/NK56j/ghdmHEJTxu2BwpA78enXAjTw55znvF1Vb/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ak6yj1AqLIt5b1tEWuOahdhcmBnlHQbiiTTC5IzpDrtoiVe/LUwPegOee1hh/xVrd
	 +B7s8WP5akZ8GEUiuP4uSwI+AxocUrG1b4nZx0YsgMZhb2GDHt8kkQ9tgDRmM3hcu6
	 bM2gUEJeN0L4mNEjd6PymE9JMOs/vZAjx5FOwyGM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392414AbfIVStc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 14:49:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:46152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392058AbfIVStJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:49:09 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 899AB208C2;
        Sun, 22 Sep 2019 18:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178149;
        bh=Q/NK56j/ghdmHEJTxu2BwpA78enXAjTw55znvF1Vb/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=afMR9HfeL//kfpcuB7ihLl3C6Cq30j7dMy3Nb6yZgOYPzMsMvPpdEdOJlS9nIct+H
         OthwL0vD5NuL/n81Newv9Mf+KwOJ6XV8VeNdWbPdwDwviPX3KeZ3/dDHpFbQcG5ikb
         yGFNBXViXSzhh9qOSmCUOl/iNzlUPtt5Jckr4/QY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.3 196/203] ALSA: hda/realtek - Blacklist PC beep for Lenovo ThinkCentre M73/93
Date:   Sun, 22 Sep 2019 14:43:42 -0400
Message-Id: <20190922184350.30563-196-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922184350.30563-1-sashal@kernel.org>
References: <20190922184350.30563-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

