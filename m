Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7333AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 438352192B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138440;
	bh=ODkujbqrL/Kk+3n1KHEs17VOnhKZXeNUeH8EVBgsKkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w6eMNDCXA2e8xmQ7mFYnVmGgD3nQTeYiyuPEEIUp82yFicXOhXO4ycR04swbw7N/l
	 MieYTEH1DODbtvQmB3uuS/pBz7LfW2+GBlPgasvWuTLdt+5OZ3C10AozGTXWObj08I
	 6pdWBIR+Ullx5exCN1VilAI8zJplNSzW6kPdoGyA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbfDARHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:07:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:53262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728937AbfDARHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:07:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 442A72192C;
        Mon,  1 Apr 2019 17:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138434;
        bh=ODkujbqrL/Kk+3n1KHEs17VOnhKZXeNUeH8EVBgsKkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p8y9EPSYWoE1sHx8L/ogLjgYzuYsW5ITQFFJLNZWA95PvNhkwKPNQ1oWHzDZUorOi
         /cJ5FCRdvqxC2eGuC7sqTdsbdwpVAYUyduyuE2+IYEmm48H7n+3InTGrSLtBlvwgQy
         9es0Wmbik2QZA8sgfsQANysXxBlthVhD/2qbfWFw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Chiu <chiu@endlessm.com>,
        Daniel Drake <drake@endlessm.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.0 065/146] ALSA: hda/realtek: Enable ASUS X441MB and X705FD headset MIC with ALC256
Date:   Mon,  1 Apr 2019 19:01:17 +0200
Message-Id: <20190401170054.155203034@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jian-Hong Pan <jian-hong@endlessm.com>

commit e1037354a0a75acdea2b27043c0a371ed85cf262 upstream.

The ASUS laptop X441MB and X705FD with ALC256 cannot detect the headset
MIC until ALC256_FIXUP_ASUS_MIC_NO_PRESENCE quirk applied.

Signed-off-by: Chris Chiu <chiu@endlessm.com>
Signed-off-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5686,6 +5686,7 @@ enum {
 	ALC225_FIXUP_WYSE_AUTO_MUTE,
 	ALC225_FIXUP_WYSE_DISABLE_MIC_VREF,
 	ALC286_FIXUP_ACER_AIO_HEADSET_MIC,
+	ALC256_FIXUP_ASUS_MIC_NO_PRESENCE,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -6694,6 +6695,15 @@ static const struct hda_fixup alc269_fix
 		.chained = true,
 		.chain_id = ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE
 	},
+	[ALC256_FIXUP_ASUS_MIC_NO_PRESENCE] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x19, 0x04a11120 }, /* use as headset mic, without its own jack detect */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC256_FIXUP_ASUS_HEADSET_MODE
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -7332,6 +7342,10 @@ static const struct snd_hda_pin_quirk al
 		{0x14, 0x90170110},
 		{0x1b, 0x90a70130},
 		{0x21, 0x03211020}),
+	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1043, "ASUS", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE,
+		{0x1a, 0x90a70130},
+		{0x1b, 0x90170110},
+		{0x21, 0x03211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0274, 0x1028, "Dell", ALC274_FIXUP_DELL_AIO_LINEOUT_VERB,
 		{0x12, 0xb7a60130},
 		{0x13, 0xb8a61140},


