Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422F2C606C2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EA5020665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562599826;
	bh=EnjuQiri8fxKmmSfNGNWGp7FDP1+lvBIO/dhJrFiXVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tLYmNbhWM0MVUp8Jw5ehbNf4UoHGC3AyaFAfxXipFseFSfIcm5TK3jh94dML0L0Vc
	 QlT0Bfq5BfqhNSnR+Hfn2SuzsYyfPRFidmb7dfr99KXJYpjesNHW3YN4CRnhGjzS9B
	 rMn+NAs38V1D/bqAw0+9IMdXIx3URLgByy06Z1PM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389609AbfGHPaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:30:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:59312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389558AbfGHPaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:30:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA15F20665;
        Mon,  8 Jul 2019 15:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599820;
        bh=EnjuQiri8fxKmmSfNGNWGp7FDP1+lvBIO/dhJrFiXVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fJZrS3ngWOqGRzilI8W3KW4AX1odMzvA+2OlAzrCEe5OcNrwIlFY8nM5VzjMkDGj/
         EnCD7vTf9e7X9+aX+ShVI3KsiYEmevHwYVmAdLvzBCWcqMi0M5S5AetpkwxCEFuF2r
         jhX861oFqtWR2QCEbSgJHsCHU/O2Lk0/hqCM6zog=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+219f00fb49874dcaea17@syzkaller.appspotmail.com,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 46/90] ALSA: line6: Fix write on zero-sized buffer
Date:   Mon,  8 Jul 2019 17:13:13 +0200
Message-Id: <20190708150524.894237413@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150521.829733162@linuxfoundation.org>
References: <20190708150521.829733162@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 3450121997ce872eb7f1248417225827ea249710 upstream.

LINE6 drivers allocate the buffers based on the value returned from
usb_maxpacket() calls.  The manipulated device may return zero for
this, and this results in the kmalloc() with zero size (and it may
succeed) while the other part of the driver code writes the packet
data with the fixed size -- which eventually overwrites.

This patch adds a simple sanity check for the invalid buffer size for
avoiding that problem.

Reported-by: syzbot+219f00fb49874dcaea17@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/line6/pcm.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/sound/usb/line6/pcm.c
+++ b/sound/usb/line6/pcm.c
@@ -560,6 +560,11 @@ int line6_init_pcm(struct usb_line6 *lin
 	line6pcm->max_packet_size_out =
 		usb_maxpacket(line6->usbdev,
 			usb_sndisocpipe(line6->usbdev, ep_write), 1);
+	if (!line6pcm->max_packet_size_in || !line6pcm->max_packet_size_out) {
+		dev_err(line6pcm->line6->ifcdev,
+			"cannot get proper max packet size\n");
+		return -EINVAL;
+	}
 
 	spin_lock_init(&line6pcm->out.lock);
 	spin_lock_init(&line6pcm->in.lock);


