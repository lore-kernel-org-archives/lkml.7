Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945BBCA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A5420B7C
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572210853;
	bh=BQkvAnAqGQMKSBoNnU79DGm9X/VGdKDSVN3+IwOkyJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pYLhBFWc9hPOJVM894i8FhtMkTIBmpIYl+62bWLKZYaJGvrgY2PXV466jnfGqgXrU
	 UEGm+4U5VQwmYmLxrwBiR3yFtytSVN3GzCQY2oTzDZcjoF2DGi42ctId0cIgP6p50u
	 TYKy2m/2v41MFV9eaR9xHbNsIRzq78lu4WGfNHqM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730408AbfJ0VOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:14:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:33068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729402AbfJ0VOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:14:09 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9432320B7C;
        Sun, 27 Oct 2019 21:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572210849;
        bh=BQkvAnAqGQMKSBoNnU79DGm9X/VGdKDSVN3+IwOkyJI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XWq29y/L6+UlM9tvcA3A7F17mXqfYICepwpS/V0fVj6pHxrR/oWJggn1/21i4nyPU
         3R9kyhAVVCcyAXlnkN4db7hEhPUo5/KJ7KoFsFY+87+BgzkAPtDuEHD0tyk0o+Hw2x
         6BV+sOdGMEEIHWZ2yuakIW3a9wzPlgPaTCV7XY7E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Szabolcs=20Sz=C5=91ke?= <szszoke.code@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 39/93] ALSA: usb-audio: Disable quirks for BOSS Katana amplifiers
Date:   Sun, 27 Oct 2019 22:00:51 +0100
Message-Id: <20191027203258.297714007@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203251.029297948@linuxfoundation.org>
References: <20191027203251.029297948@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Szabolcs Szőke <szszoke.code@gmail.com>

commit 7571b6a17fcc5e4f6903f065a82d0e38011346ed upstream.

BOSS Katana amplifiers cannot be used for recording or playback if quirks
are applied

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=195223
Signed-off-by: Szabolcs Szőke <szszoke.code@gmail.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20191011171937.8013-1-szszoke.code@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/pcm.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -355,6 +355,9 @@ static int set_sync_ep_implicit_fb_quirk
 		ep = 0x81;
 		ifnum = 1;
 		goto add_sync_ep_from_ifnum;
+	case USB_ID(0x0582, 0x01d8): /* BOSS Katana */
+		/* BOSS Katana amplifiers do not need quirks */
+		return 0;
 	}
 
 	if (attr == USB_ENDPOINT_SYNC_ASYNC &&


