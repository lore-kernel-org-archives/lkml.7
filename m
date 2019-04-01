Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD98C10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3261E2084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554141695;
	bh=CzOb3mdfa/vohCEPzorAGSaorm8Cl3tgk6adbPVH3kE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gw73R5Ay9JKQeveb/g4B9Yjd5OJyf7zs+2n44ZMMxPMqLylJoKNA19hM0KDkw7nX1
	 /XdYLi3uplWFJAKytBw5RzHT+69V3NjIUggyEnNhKq1enBSme16MWVp9Z6xkKTE9x8
	 xmnx4ndubwPobRdoc2wVSbJTJPSdhn/ydceiZBtw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730956AbfDARP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:15:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:40552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730772AbfDARPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:15:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98C4C206C0;
        Mon,  1 Apr 2019 17:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138953;
        bh=CzOb3mdfa/vohCEPzorAGSaorm8Cl3tgk6adbPVH3kE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C5dZaynezTZFqzM7akr4tkbuARlTP2J4USOYCYlNH3lX04/JpnQXeIQUokF8ojaOZ
         oe5wvYmXocLrq6yYcU6fgZihQpQoOKdRN5u1WWLTWPS/6j3bASo0A8xru9EKgMxD9y
         moOHvoUB+N2jDIC4VjC4Arv7TR0YkXZgWP/yjR7w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jian-Hong Pan <jian-hong@endlessm.com>,
        Daniel Drake <drake@endlessm.com>, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 068/134] ALSA: hda/realtek: Enable headset MIC of ASUS X430UN and X512DK with ALC256
Date:   Mon,  1 Apr 2019 19:01:44 +0200
Message-Id: <20190401170050.833602098@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jian-Hong Pan <jian-hong@endlessm.com>

commit 6ac371aa1a74240fb910c98aa3484d5ece8473d3 upstream.

The ASUS X430UN and X512DK with ALC256 cannot detect the headset MIC
until ALC256_FIXUP_ASUS_MIC_NO_PRESENCE quirk applied.

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Signed-off-by: Daniel Drake <drake@endlessm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7252,6 +7252,10 @@ static const struct snd_hda_pin_quirk al
 		{0x14, 0x90170110},
 		{0x21, 0x03211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1043, "ASUS", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE,
+		{0x12, 0x90a60130},
+		{0x14, 0x90170110},
+		{0x21, 0x04211020}),
+	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1043, "ASUS", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE,
 		{0x1a, 0x90a70130},
 		{0x1b, 0x90170110},
 		{0x21, 0x03211020}),


