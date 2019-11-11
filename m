Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A223C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3246821655
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573498337;
	bh=VIQSG7glfoUTAKYUaH51Z9lnqPzkGWvFKJyxBPJD8pI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tys5SLZAqHB5g6Fd+dCiA6vmqGtn0RllxChvjyp9/+Ixr6m5f9+ZHyxaUo7SOhXIw
	 xdY7l4LKZFIB4EOHs/oXy11mZlnIFKJ0cyEbx+ubDV6II9NwkfmqeEmTCRbY+al2OG
	 6bPy75Zf4b9pz1aEvmr0MFXEleJ/E5krDh0QPFY4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbfKKSwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:52:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:46492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730476AbfKKSwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:52:11 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 682DA204EC;
        Mon, 11 Nov 2019 18:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573498331;
        bh=VIQSG7glfoUTAKYUaH51Z9lnqPzkGWvFKJyxBPJD8pI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GYbIIzo0ZOwwiWFSm2X/6L9gsaOnYpGBvY/Myp227sFG0UEpi4O3ujaTiSIuv+NhG
         UUIaEonzTmzHBGkLSOe/rze/WbDLDyfpwvEZ682fj/FVzD0gbxU/J4wg3PvzqHDZI+
         sHUClxxbPJKUam2ENfCpNXkHYYI4vHCeJlXzOPKc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+0620f79a1978b1133fd7@syzkaller.appspotmail.com,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.3 089/193] ALSA: usb-audio: Fix copy&paste error in the validator
Date:   Mon, 11 Nov 2019 19:27:51 +0100
Message-Id: <20191111181507.720931448@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181459.850623879@linuxfoundation.org>
References: <20191111181459.850623879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit ba8bf0967a154796be15c4983603aad0b05c3138 upstream.

The recently introduced USB-audio descriptor validator had a stupid
copy&paste error that may lead to an unexpected overlook of too short
descriptors for processing and extension units.  It's likely the cause
of the report triggered by syzkaller fuzzer.  Let's fix it.

Fixes: 57f8770620e9 ("ALSA: usb-audio: More validations of descriptor units")
Reported-by: syzbot+0620f79a1978b1133fd7@syzkaller.appspotmail.com
Link: https://lore.kernel.org/r/s5hsgnkdbsl.wl-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/validate.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/usb/validate.c
+++ b/sound/usb/validate.c
@@ -75,7 +75,7 @@ static bool validate_processing_unit(con
 
 	if (d->bLength < sizeof(*d))
 		return false;
-	len = d->bLength < sizeof(*d) + d->bNrInPins;
+	len = sizeof(*d) + d->bNrInPins;
 	if (d->bLength < len)
 		return false;
 	switch (v->protocol) {


