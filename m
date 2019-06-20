Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF81C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B6DB21530
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561054544;
	bh=bsYg6yzNVST13QE08prWSj+y7Mh7O3QmbE7OEgqDCbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rfQDNyOUyC2GDX12lp0Ak/ESVX0mqOpBkr/VlQUmpM40IXJjcgR4diRpq5qPrAFRe
	 CEgl4EzqJe2In2G+TWqL6dI09tYJpeIlAZ+RuZEPeylnxho6KYCJmGDRC8vqr3CS6i
	 9VLCq9rP2JesxZ3+ckWJlwXRG6gCsdOAKIkBacRA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbfFTSPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:15:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:44544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728828AbfFTSPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:15:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E782B2082C;
        Thu, 20 Jun 2019 18:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561054539;
        bh=bsYg6yzNVST13QE08prWSj+y7Mh7O3QmbE7OEgqDCbM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aRvGjXEizrwUzlsmlf/WJOssP0tFSMYprYSKctpMWSgvQP2s42nQnV15SHkDBqIYo
         mgGimvZ7LGY8WdbwTQ0PVx71E8dlNGyuw+lUWDP8s39JzD0usqbxSO/bU9n2qnzmy+
         bUpUcXMTDctEoiiJ7k6fcQmFaC4Hlg777XB/x3zs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 64/98] ALSA: hda - Force polling mode on CNL for fixing codec communication
Date:   Thu, 20 Jun 2019 19:57:31 +0200
Message-Id: <20190620174352.328906616@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174349.443386789@linuxfoundation.org>
References: <20190620174349.443386789@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit fa763f1b2858752e6150ffff46886a1b7faffc82 ]

We observed the same issue as reported by commit a8d7bde23e7130686b7662
("ALSA: hda - Force polling mode on CFL for fixing codec communication")
We don't have a better solution. So apply the same workaround to CNL.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/hda_intel.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 789308f54785..5c29d6490a18 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -375,6 +375,7 @@ enum {
 
 #define IS_BXT(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0x5a98)
 #define IS_CFL(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0xa348)
+#define IS_CNL(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0x9dc8)
 
 static char *driver_short_names[] = {
 	[AZX_DRIVER_ICH] = "HDA Intel",
@@ -1700,8 +1701,8 @@ static int azx_create(struct snd_card *card, struct pci_dev *pci,
 	else
 		chip->bdl_pos_adj = bdl_pos_adj[dev];
 
-	/* Workaround for a communication error on CFL (bko#199007) */
-	if (IS_CFL(pci))
+	/* Workaround for a communication error on CFL (bko#199007) and CNL */
+	if (IS_CFL(pci) || IS_CNL(pci))
 		chip->polling_mode = 1;
 
 	err = azx_bus_init(chip, model[dev], &pci_hda_io_ops);
-- 
2.20.1



