Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C040C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E94582173E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576077866;
	bh=+RVT294GfV3zOhipHZpslrwPFzsbEJZ38KMDY4LXNwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r3x5XOcSk64bggFKP8IgYLWhIChTo4PCexXelMzCQLuyVwNJNlqBs9NyEjoJCnhOc
	 udvtRy6q4W1EM9kRu9AKWZq+mPCJoR7Mbed7u1CsMLd9JtEHze3rJHbJSG88VqrZ44
	 3ZPY0MCnMkMpVhHIgMkWNBUicRyvqtElZl0p67NI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732846AbfLKPYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:24:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:55660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732824AbfLKPYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:24:22 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8586E2173E;
        Wed, 11 Dec 2019 15:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077862;
        bh=+RVT294GfV3zOhipHZpslrwPFzsbEJZ38KMDY4LXNwU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tOgPSKVQpKl46t5MvxFArVMvqsM2xwzzxBDyDhIxsy7O0+WG5zHK7cEhfoGefy/w1
         qRDw4+H6wpTDqmnOjYmhL76Euy3VRMA2vaqQTsZEDaGozWaBOy6ewuHvfiB5yIFYxv
         cX3Xh82FNctaaQtm0EIG4XD+vKF3S8pAslPiwlqg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hui Wang <hui.wang@canonical.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 200/243] ALSA: hda/realtek - Enable the headset-mic on a Xiaomis laptop
Date:   Wed, 11 Dec 2019 16:06:02 +0100
Message-Id: <20191211150352.683457247@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150339.185439726@linuxfoundation.org>
References: <20191211150339.185439726@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hui Wang <hui.wang@canonical.com>

commit 695d1ec3994f9de2cefae80ee2087c95d2e5a2f3 upstream.

The headset on this machine is not defined, after applying the quirk
ALC256_FIXUP_ASUS_HEADSET_MIC, the headset-mic works well

BugLink: https://bugs.launchpad.net/bugs/1846148
Cc: <stable@vger.kernel.org>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
Link: https://lore.kernel.org/r/20191121025427.8856-1-hui.wang@canonical.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7038,6 +7038,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x17aa, 0x9e54, "LENOVO NB", ALC269_FIXUP_LENOVO_EAPD),
 	SND_PCI_QUIRK(0x19e5, 0x3204, "Huawei MBXP", ALC256_FIXUP_HUAWEI_MBXP_PINS),
 	SND_PCI_QUIRK(0x1b7d, 0xa831, "Ordissimo EVE2 ", ALC269VB_FIXUP_ORDISSIMO_EVE2), /* Also known as Malata PC-B1303 */
+	SND_PCI_QUIRK(0x1d72, 0x1901, "RedmiBook 14", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x10ec, 0x118c, "Medion EE4254 MD62100", ALC256_FIXUP_MEDION_HEADSET_NO_PRESENCE),
 
 #if 0


