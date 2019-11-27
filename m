Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB0FC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB360216F4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574889223;
	bh=sDzY29B+fqQFh7q2y2OrABZsUQVM1JjkS1wKHq8bNn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q5JHPx5LQ/V9RgqE1sUXKXBDodPPsMcbzzpAuLiOGf8+ocB6MTU/9wtFt0zJkDkqs
	 RVtwmb4dyORm2quIrkFloHTc7HbPdG2jNOLkfUaz5gtqFeWCegNeS6DRrjJZmWgs6/
	 59vXroMdAitw0O0y9HP7v73lKMg9FRrpbyMicAHQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732973AbfK0VNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:13:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:45744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387464AbfK0VN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:13:28 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E180217F9;
        Wed, 27 Nov 2019 21:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574889207;
        bh=sDzY29B+fqQFh7q2y2OrABZsUQVM1JjkS1wKHq8bNn0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UKvfx44figNk8HrWm9QJ72p86nFnuhF5d2N2bwlf19vf5MpL1LJ6i8zepNm6MFpL+
         umesWmuGdCSIsGMO7h8Zz/6+Vpu5ZX0v5H1kXYwP5JsQFvodSHYKgrz9HEKw8Cdm3t
         z8uxpXVI0PjReSYiBPpIvdbJ1XEIeWyUtacvhXw0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+a36ab65c6653d7ccdd62@syzkaller.appspotmail.com,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.4 29/66] ALSA: usb-audio: Fix NULL dereference at parsing BADD
Date:   Wed, 27 Nov 2019 21:32:24 +0100
Message-Id: <20191127202701.883158414@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127202632.536277063@linuxfoundation.org>
References: <20191127202632.536277063@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 9435f2bb66874a0c4dd25e7c978957a7ca2c93b1 upstream.

snd_usb_mixer_controls_badd() that parses UAC3 BADD profiles misses a
NULL check for the given interfaces.  When a malformed USB descriptor
is passed, this may lead to an Oops, as spotted by syzkaller.
Skip the iteration if the interface doesn't exist for avoiding the
crash.

Fixes: 17156f23e93c ("ALSA: usb: add UAC3 BADD profiles support")
Reported-by: syzbot+a36ab65c6653d7ccdd62@syzkaller.appspotmail.com
Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20191122112840.24797-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/mixer.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -2930,6 +2930,9 @@ static int snd_usb_mixer_controls_badd(s
 			continue;
 
 		iface = usb_ifnum_to_if(dev, intf);
+		if (!iface)
+			continue;
+
 		num = iface->num_altsetting;
 
 		if (num < 2)


