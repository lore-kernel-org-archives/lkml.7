Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924E1C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD282064A
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566495230;
	bh=DTcBYyr8NGbTdWPT9hVXwPCximMsjizRF2mTgYqENgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zeJtLj0d61ZL1pReOGHKiq3Z2jvQE6VfdNdH8DaY2R043lj4DKCs0CQV2XUjT5ZTc
	 UCazv1SyeRTeb99IzVwuZqwh0XDOUXFU3OaMztNsgwZOkunw/EuVAOZVqIjfTHvAMl
	 FN7tP8BZqc8JX8VlBkdxTvN7AigpPFyHQLTr5LnU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392436AbfHVRdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:33:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:48860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404412AbfHVRZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:25:25 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2844A2064A;
        Thu, 22 Aug 2019 17:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494724;
        bh=DTcBYyr8NGbTdWPT9hVXwPCximMsjizRF2mTgYqENgQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SDRg1dApxXnWUDGRimNL1HpOk1B0Xqx3wyWHIF8XIE3aV3ek+AjTzZne6pvTFCKLm
         CUgppKyB5KG3vN45cF8WDUl+ykAsZfqcbo7ygJh5SPPWYp2ldF8h8+vCcKLvjySz3r
         dP27fXslFwS2hCj1n3OyibK+i41+5W/YmFohqSuE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hui Peng <benquike@gmail.com>,
        Mathias Payer <mathias.payer@nebelwelt.net>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 13/85] ALSA: usb-audio: Fix an OOB bug in parse_audio_mixer_unit
Date:   Thu, 22 Aug 2019 10:18:46 -0700
Message-Id: <20190822171731.662885183@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171731.012687054@linuxfoundation.org>
References: <20190822171731.012687054@linuxfoundation.org>
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
 sound/usb/mixer.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -760,6 +760,8 @@ static int uac_mixer_unit_get_channels(s
 		return -EINVAL;
 	if (!desc->bNrInPins)
 		return -EINVAL;
+	if (desc->bLength < sizeof(*desc) + desc->bNrInPins)
+		return -EINVAL;
 
 	switch (state->mixer->protocol) {
 	case UAC_VERSION_1:


