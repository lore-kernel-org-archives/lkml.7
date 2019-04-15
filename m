Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B042C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56090218FF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355501;
	bh=mkosKMjaoKJVu9sCR0VqVsCeG4P79RozpKSaigGgDUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BX1htlTpvtRMmvZtKbiBU/dtDOmn6i1imT4RFgfaX4AORhRlxkAP/+gGG9FbDSkoY
	 NTFK276Bh7Lem9po1X0RwNjZc/07RVvl8h0pRY1StK8OaLgkRhAPLjJU4PShdqnesz
	 R+riEfKPOq0ndJhDeHj6e0LbHklNlAijmtOYLkKA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731275AbfDOTLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:11:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:48648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730727AbfDOTLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:11:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B15A9218FF;
        Mon, 15 Apr 2019 19:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355496;
        bh=mkosKMjaoKJVu9sCR0VqVsCeG4P79RozpKSaigGgDUA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kZR2S0jzRP9rXNdW8vj9/WJuQKO71bBlZ///GWglpztNY7+oYRxVJHAjoWq08kzff
         LV0NMC0SWMI59iz4tnXN7n4b1ZReNWL72R1eeN0TUuKMAJhAP9yfCH6N6kxiSlqekX
         L2PBicWZxC5w2D6tooYvmVmVc5q41itaYX9FmKSU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hui Wang <hui.wang@canonical.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.0 057/117] ALSA: hda - Add two more machines to the power_save_blacklist
Date:   Mon, 15 Apr 2019 21:00:27 +0200
Message-Id: <20190415183747.825879847@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hui Wang <hui.wang@canonical.com>

commit cae30527901d9590db0e12ace994c1d58bea87fd upstream.

Recently we set CONFIG_SND_HDA_POWER_SAVE_DEFAULT to 1 when
configuring the kernel, then two machines were reported to have noise
after installing the new kernel. Put them in the blacklist, the
noise disappears.

https://bugs.launchpad.net/bugs/1821663
Cc: <stable@vger.kernel.org>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/hda_intel.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2142,6 +2142,8 @@ static struct snd_pci_quirk power_save_b
 	SND_PCI_QUIRK(0x8086, 0x2040, "Intel DZ77BH-55K", 0),
 	/* https://bugzilla.kernel.org/show_bug.cgi?id=199607 */
 	SND_PCI_QUIRK(0x8086, 0x2057, "Intel NUC5i7RYB", 0),
+	/* https://bugs.launchpad.net/bugs/1821663 */
+	SND_PCI_QUIRK(0x8086, 0x2064, "Intel SDP 8086:2064", 0),
 	/* https://bugzilla.redhat.com/show_bug.cgi?id=1520902 */
 	SND_PCI_QUIRK(0x8086, 0x2068, "Intel NUC7i3BNB", 0),
 	/* https://bugzilla.kernel.org/show_bug.cgi?id=198611 */
@@ -2150,6 +2152,8 @@ static struct snd_pci_quirk power_save_b
 	SND_PCI_QUIRK(0x17aa, 0x367b, "Lenovo IdeaCentre B550", 0),
 	/* https://bugzilla.redhat.com/show_bug.cgi?id=1572975 */
 	SND_PCI_QUIRK(0x17aa, 0x36a7, "Lenovo C50 All in one", 0),
+	/* https://bugs.launchpad.net/bugs/1821663 */
+	SND_PCI_QUIRK(0x1631, 0xe017, "Packard Bell NEC IMEDIA 5204", 0),
 	{}
 };
 #endif /* CONFIG_PM */


