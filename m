Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E3BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B378C21924
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138443;
	bh=u+zyAGA4HyZqRxcCRjUclCw0/s49Ry/UscvcQomBmsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wE9IUZvAfamT+5ixqru2dpSnMBhRpEsdHZuXDOVynB7Z4jUPJbMe5ADiwKws+Nc73
	 nXg05Tp3dYYQIJ1kVupS5J8kvcdwbDyMke7Mm1gDByyDbw8ibJ65XypyezgsHEMck9
	 POzHaO2SmQxSx+yp1R2UHNoh3jWnXQIi3exxpooc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbfDARHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:07:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:53352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728937AbfDARHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:07:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DAFA21924;
        Mon,  1 Apr 2019 17:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138438;
        bh=u+zyAGA4HyZqRxcCRjUclCw0/s49Ry/UscvcQomBmsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Aa2zSIEMGZiO5qJvuF1BGORqajhduB17YupBKGfRFsOTiS9fIfVZGbnk6s8nYiAY9
         o3DRFMZzH7YZyqZaL7bxJHTBYI2PBYHOmeJP/L6PR7xe+6p8927nQdlB1P94mFV+ko
         f3vuBoi3NS1Zcne/55RsR066ZyBfpW6VnE6zUBgs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Chiu <chiu@endlessm.com>,
        Daniel Drake <drake@endlessm.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.0 066/146] ALSA: hda/realtek: Enable headset mic of ASUS P5440FF with ALC256
Date:   Mon,  1 Apr 2019 19:01:18 +0200
Message-Id: <20190401170054.249112423@linuxfoundation.org>
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

From: Chris Chiu <chiu@endlessm.com>

commit a806ef1cf3bbc0baadc6cdeb11f12b5dd27e91c2 upstream.

The ASUS laptop P5440FF with ALC256 can't detect the headset microphone
until ALC256_FIXUP_ASUS_MIC_NO_PRESENCE quirk applied.

Signed-off-by: Chris Chiu <chiu@endlessm.com>
Signed-off-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7343,6 +7343,10 @@ static const struct snd_hda_pin_quirk al
 		{0x1b, 0x90a70130},
 		{0x21, 0x03211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1043, "ASUS", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE,
+		{0x12, 0x90a60130},
+		{0x14, 0x90170110},
+		{0x21, 0x03211020}),
+	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1043, "ASUS", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE,
 		{0x1a, 0x90a70130},
 		{0x1b, 0x90170110},
 		{0x21, 0x03211020}),


