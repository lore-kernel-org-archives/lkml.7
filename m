Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698C8C41514
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39CC322C7C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564033449;
	bh=0E4DbpNziFF5TT1Yhr8r5i2JsWFoSRYRS5q2wDKAeQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Sa8z7nMo9LFfDArRQYX9bK7dcP8O+KUw1zehFpjCi/K/Ioo8i8ZRFmGBRELB7iiBs
	 lmIrr/RBsqcAVxn3++ZugF9SerGTQumRU9EkXVFa8ESVUIYs5kmEBuBKPUeUOuz44l
	 cJ8z3BsUPrBvHAtRBRGB41MUED6EuAUsxtyadlYY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391177AbfGYFoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 01:44:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:59138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391160AbfGYFoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 01:44:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AA5221850;
        Thu, 25 Jul 2019 05:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564033443;
        bh=0E4DbpNziFF5TT1Yhr8r5i2JsWFoSRYRS5q2wDKAeQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vGGN8Av4MlHmDUj5hkK+adj56zH6G4D9hkylEVhbmd0wLv4mhPnmcJ+pql/NAzyMq
         vsc+s+ZfcE2JEt86y70V5Wl70p3WWUSud8RYj4BCDjwkR8cjj6QmM/1fDIXbMPT1Ek
         GD9Gkw5WGbS/E9WpXUv0XCgAt42l9/VI/keqLXEg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hui Wang <hui.wang@canonical.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 208/271] ALSA: hda/realtek: apply ALC891 headset fixup to one Dell machine
Date:   Wed, 24 Jul 2019 21:21:17 +0200
Message-Id: <20190724191712.898430299@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191655.268628197@linuxfoundation.org>
References: <20190724191655.268628197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hui Wang <hui.wang@canonical.com>

commit 4b4e0e32e4b09274dbc9d173016c1a026f44608c upstream.

Without this patch, the headset-mic and headphone-mic don't work.

Cc: <stable@vger.kernel.org>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8657,6 +8657,11 @@ static const struct snd_hda_pin_quirk al
 		{0x18, 0x01a19030},
 		{0x1a, 0x01813040},
 		{0x21, 0x01014020}),
+	SND_HDA_PIN_QUIRK(0x10ec0867, 0x1028, "Dell", ALC891_FIXUP_DELL_MIC_NO_PRESENCE,
+		{0x16, 0x01813030},
+		{0x17, 0x02211010},
+		{0x18, 0x01a19040},
+		{0x21, 0x01014020}),
 	SND_HDA_PIN_QUIRK(0x10ec0662, 0x1028, "Dell", ALC662_FIXUP_DELL_MIC_NO_PRESENCE,
 		{0x14, 0x01014010},
 		{0x18, 0x01a19020},


