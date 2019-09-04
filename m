Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130BBC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D32CE20882
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567621487;
	bh=fi+kolDLinVLp769w8IN7noDpuUcqcKOXvDbumYGMhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VJUEwbwauRRDxlvPTGu9RQgIWIEDmFKi1D8cdtnuSL6atN03XIg1uO2fQHVA1oy6Z
	 iDlJiUjPGkKlSho3XCSlhK+3f3zKJPw6msGe5krXNMqT6BfuboFlKLfxzoRBw5Daz2
	 qN/d/JK0+zeHIXvIfPrBEl6BHtvFAPURha6QjlSY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388626AbfIDSYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:24:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388490AbfIDSBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:01:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B66022CF7;
        Wed,  4 Sep 2019 18:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620065;
        bh=fi+kolDLinVLp769w8IN7noDpuUcqcKOXvDbumYGMhA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NUCSmvTjgGy7cUUOBs+uWG3Y569dwjncsW7NTd8PBWku11eB/VMZ38dNW8AUfoZfN
         zZCXQ1e+vb3uIsnYvL8ZSSJBC95KEiZRV1HP+ina9OVG4gnKXA954Esxu7bx/0Rvzd
         CmX19NbfMSEws6TccqbZHBYXdRovINtT3AhGS+Ag=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 59/83] ALSA: line6: Fix memory leak at line6_init_pcm() error path
Date:   Wed,  4 Sep 2019 19:53:51 +0200
Message-Id: <20190904175308.776163002@linuxfoundation.org>
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

From: Takashi Iwai <tiwai@suse.de>

commit 1bc8d18c75fef3b478dbdfef722aae09e2a9fde7 upstream.

I forgot to release the allocated object at the early error path in
line6_init_pcm().  For addressing it, slightly shuffle the code so
that the PCM destructor (pcm->private_free) is assigned properly
before all error paths.

Fixes: 3450121997ce ("ALSA: line6: Fix write on zero-sized buffer")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/line6/pcm.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- a/sound/usb/line6/pcm.c
+++ b/sound/usb/line6/pcm.c
@@ -552,6 +552,15 @@ int line6_init_pcm(struct usb_line6 *lin
 	line6pcm->volume_monitor = 255;
 	line6pcm->line6 = line6;
 
+	spin_lock_init(&line6pcm->out.lock);
+	spin_lock_init(&line6pcm->in.lock);
+	line6pcm->impulse_period = LINE6_IMPULSE_DEFAULT_PERIOD;
+
+	line6->line6pcm = line6pcm;
+
+	pcm->private_data = line6pcm;
+	pcm->private_free = line6_cleanup_pcm;
+
 	line6pcm->max_packet_size_in =
 		usb_maxpacket(line6->usbdev,
 			usb_rcvisocpipe(line6->usbdev, ep_read), 0);
@@ -564,15 +573,6 @@ int line6_init_pcm(struct usb_line6 *lin
 		return -EINVAL;
 	}
 
-	spin_lock_init(&line6pcm->out.lock);
-	spin_lock_init(&line6pcm->in.lock);
-	line6pcm->impulse_period = LINE6_IMPULSE_DEFAULT_PERIOD;
-
-	line6->line6pcm = line6pcm;
-
-	pcm->private_data = line6pcm;
-	pcm->private_free = line6_cleanup_pcm;
-
 	err = line6_create_audio_out_urbs(line6pcm);
 	if (err < 0)
 		return err;


