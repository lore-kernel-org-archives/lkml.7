Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D51C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F08420717
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568380904;
	bh=ZHa7rEENihqV/0KTMZkFZicFXDV49RlTYVZmkEMkbR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PC8fljKj0wWjbAHRa/tjOkxCD/ceRDFsy1Dd6ItA+86e2fww/dhgnFiW42k6GCqtz
	 dCUd6eKGoZdQh9l4SgmhzkWEGPvJ/InuR7x9MMCuf5+IS1tSi4q1EFZxF7kMAG2vrx
	 Y4Mr8FAr4XGLECO9zUwyIMd/sEqvbjj6G41RIF+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389876AbfIMNVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:21:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:51484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390868AbfIMNVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:21:40 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66E6620830;
        Fri, 13 Sep 2019 13:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380899;
        bh=ZHa7rEENihqV/0KTMZkFZicFXDV49RlTYVZmkEMkbR0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KfQPabEIqjBWxpYdmKPJesDXLw0Wxt+BjaKWpJKycSXB3W9GHOYrochyBrUFvEj4U
         U765Cz/0BFFzU/ZGrtxaZOl20FZfz7qt5CH5+wdk82/t5Amwth4LpFCOICU3HnRtzu
         vbH8d9Ezz8GsJxHGBv8OTCFcbD1c9ZssccOw/PZ8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sam Bazley <sambazley@fastmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.2 05/37] ALSA: hda/realtek - Add quirk for HP Pavilion 15
Date:   Fri, 13 Sep 2019 14:07:10 +0100
Message-Id: <20190913130512.071594930@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913130510.727515099@linuxfoundation.org>
References: <20190913130510.727515099@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Bazley <sambazley@fastmail.com>

commit d33cd42d86671bed870827aa399aeb9f1da74119 upstream.

HP Pavilion 15 (AMD Ryzen-based model) with 103c:84e7 needs the same
quirk like HP Envy/Spectre x360 for enabling the mute LED over Mic3 pin.

[ rearranged in the SSID number order by tiwai ]

Signed-off-by: Sam Bazley <sambazley@fastmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6981,6 +6981,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x103c, 0x82c0, "HP G3 mini premium", ALC221_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x83b9, "HP Spectre x360", ALC269_FIXUP_HP_MUTE_LED_MIC3),
 	SND_PCI_QUIRK(0x103c, 0x8497, "HP Envy x360", ALC269_FIXUP_HP_MUTE_LED_MIC3),
+	SND_PCI_QUIRK(0x103c, 0x84e7, "HP Pavilion 15", ALC269_FIXUP_HP_MUTE_LED_MIC3),
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300", ALC282_FIXUP_ASUS_TX300),
 	SND_PCI_QUIRK(0x1043, 0x106d, "Asus K53BE", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),


