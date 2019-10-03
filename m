Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7DBC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E2220865
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570123804;
	bh=hLXlgvEYlx29ykXAvEEcccUqURw5gnfziaZ5PdEBuPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1VCUY2gFGocZLESKi6tHrFcE6e8hWL/DIlyF4vGq14GjRXqxjt7UEypxde/ZY00bh
	 fCvLoMNaKUwz/WWb6ezyLGfJAoEApDKIzkg/x4cYRxFJcy79xT+BmcjJjVB23R1Ito
	 oJA8+I1eQVgZSSB5dVfcYRbWbtYQQqbQmyZ8HYrw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731090AbfJCRaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:30:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:34128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387973AbfJCQMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:12:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 764602054F;
        Thu,  3 Oct 2019 16:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119126;
        bh=hLXlgvEYlx29ykXAvEEcccUqURw5gnfziaZ5PdEBuPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=szTVtqQK6Xg/7ujSwbtbxkYF2l2azrScf3lOU7Yw87egLAY+ZAIUJpXa6IRhNQywe
         nTpGzEIkg9tn44IgekC52vRIvXJLgIBHV5KuIjhdeBHdAmE+HBBe9kDu5Kk/Zr+tYI
         K1iyS3rc0mQG5wdHpdJq9e6UGImX91AAXCRLogkw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 136/185] ALSA: hda/realtek - Blacklist PC beep for Lenovo ThinkCentre M73/93
Date:   Thu,  3 Oct 2019 17:53:34 +0200
Message-Id: <20191003154508.410993699@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154437.541662648@linuxfoundation.org>
References: <20191003154437.541662648@linuxfoundation.org>
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
index 6deb96a301d3d..4f35ac2606708 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -977,6 +977,9 @@ static const struct snd_pci_quirk beep_white_list[] = {
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



