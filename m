Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E23C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D0C22CEA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620063;
	bh=BfhlLiLUo+otcdw2PhxmxNxKrM1EJHiwJIqAWc5ijxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LWb9EW0sSHgJC+acqqCtbn+g6uF1cwFp2StLs+KLo4z0WV/Lsq0cpUpuXGKkRV3Ex
	 VbPrjoZ9vELvaRSMEPCqWeCYO4n3wFFSJU/ivfl0b0IFsgKx257Su7gkNnPb1QzeFO
	 g8sMLI08Ta/ZWxynzs3zqp+C0Y/wbrtVXq97fYts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387921AbfIDSBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:01:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:40370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387777AbfIDSA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:00:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D99721883;
        Wed,  4 Sep 2019 18:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620057;
        bh=BfhlLiLUo+otcdw2PhxmxNxKrM1EJHiwJIqAWc5ijxc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GQVvVxE+uQqK0KUMvJ/3qNr2D81LH9x35XoD2bsg1us8ys52AZfGHx53Sk8x7nCd6
         r2ShakgSAbd/KsB2zNn3a+zEFfBR0wWSWWFRxIG2KD1i+c5eW3e9sJEv2rVFF4UBxv
         7s00dNKAJm4AjwbfOadXEBHfeZI/N2QXKvGRl46c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hui Peng <benquike@gmail.com>,
        Mathias Payer <mathias.payer@nebelwelt.net>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 57/83] ALSA: usb-audio: Fix an OOB bug in parse_audio_mixer_unit
Date:   Wed,  4 Sep 2019 19:53:49 +0200
Message-Id: <20190904175308.585489773@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175303.488266791@linuxfoundation.org>
References: <20190904175303.488266791@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hui Peng <benquike@gmail.com>

commit daac07156b330b18eb5071aec4b3ddca1c377f2c upstream.

The `uac_mixer_unit_descriptor` shown as below is read from the
device side. In `parse_audio_mixer_unit`, `baSourceID` field is
accessed from index 0 to `bNrInPins` - 1, the current implementation
assumes that descriptor is always valid (the length  of descriptor
is no shorter than 5 + `bNrInPins`). If a descriptor read from
the device side is invalid, it may trigger out-of-bound memory
access.

```
struct uac_mixer_unit_descriptor {
	__u8 bLength;
	__u8 bDescriptorType;
	__u8 bDescriptorSubtype;
	__u8 bUnitID;
	__u8 bNrInPins;
	__u8 baSourceID[];
}
```

This patch fixes the bug by add a sanity check on the length of
the descriptor.

Reported-by: Hui Peng <benquike@gmail.com>
Reported-by: Mathias Payer <mathias.payer@nebelwelt.net>
Cc: <stable@vger.kernel.org>
Signed-off-by: Hui Peng <benquike@gmail.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/mixer.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1713,6 +1713,7 @@ static int parse_audio_mixer_unit(struct
 	int pin, ich, err;
 
 	if (desc->bLength < 11 || !(input_pins = desc->bNrInPins) ||
+	    desc->bLength < sizeof(*desc) + desc->bNrInPins ||
 	    !(num_outs = uac_mixer_unit_bNrChannels(desc))) {
 		usb_audio_err(state->chip,
 			      "invalid MIXER UNIT descriptor %d\n",


