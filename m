Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E843BC468BD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A4B205ED
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560100118;
	bh=0CDsZGJsbvenEgYhZqeAPddmeN3X4HrfnFrWCK1XvY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2iVvCHm8l8Bh6nbaoqe4Q7rxW80+BL9v0mCwDcmZZ2CKTsIApfqeDhoO7/9yUnb1K
	 WF5pJyVrUnK1GCspZx5nEQ6xFHr830cW7tMLIGEmtKo4TniqHSNY2iOi2sMP4I7u+2
	 ZmCOxJCcvi/vk04XN3zV2icEPU/qYIm/St+1PU08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729814AbfFIRFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 13:05:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387698AbfFIRFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 13:05:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39510204EC;
        Sun,  9 Jun 2019 17:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099901;
        bh=0CDsZGJsbvenEgYhZqeAPddmeN3X4HrfnFrWCK1XvY4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gj/ygOtb7m9KpzhETuPUSnLI7ZJjBZdiXl5HQEtnX+MTZbmt7iwAMiB9BIls9QU3/
         QoEl9AKv84MdB+FWbg1w4DYMR0DemLKS7JikEEtvSKDAHG0R4vC9746cMiliIcGa9z
         ceK/XPSx4xRyUiRubjjzjKfot8WvNUNCZNim6u8E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 207/241] ALSA: hda/realtek - Set default power save node to 0
Date:   Sun,  9 Jun 2019 18:42:29 +0200
Message-Id: <20190609164154.623282378@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164147.729157653@linuxfoundation.org>
References: <20190609164147.729157653@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kailang Yang <kailang@realtek.com>

commit 317d9313925cd8388304286c0d3c8dda7f060a2d upstream.

I measured power consumption between power_save_node=1 and power_save_node=0.
It's almost the same.
Codec will enter to runtime suspend and suspend.
That pin also will enter to D3. Don't need to enter to D3 by single pin.
So, Disable power_save_node as default. It will avoid more issues.
Windows Driver also has not this option at runtime PM.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6236,7 +6236,7 @@ static int patch_alc269(struct hda_codec
 
 	spec = codec->spec;
 	spec->gen.shared_mic_vref_pin = 0x18;
-	codec->power_save_node = 1;
+	codec->power_save_node = 0;
 
 #ifdef CONFIG_PM
 	codec->patch_ops.suspend = alc269_suspend;


