Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3641C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD82F208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620449;
	bh=dmIY4MI5nRV3458Hlg43Lu6F7bl7Es0zc7njEiOF6zc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uYf8L5uBsMeFBTgcfrrHJu8y/H73ckEvPSr/pTo4LiSsk6eUvaUkGtdrnGon1jdxv
	 dDQSfCIE6zpYXHSsU6/DT+T0mMDCSwNcZYJ0lNGqsx4mkC7K4SMiwfRSaUip4sEr91
	 nmeTbzND6O5z95+mQIGinYpXa3y/ORB1MzckOue8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389651AbfIDSH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:07:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:49788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389635AbfIDSHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:07:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFD472087E;
        Wed,  4 Sep 2019 18:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620443;
        bh=dmIY4MI5nRV3458Hlg43Lu6F7bl7Es0zc7njEiOF6zc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zdnfuz63YYWOvOCqAxw/eIpdmhq6TdqJA4Bx9LHVnkj6l+gkMls6MjyEIM52Bu6tH
         A72bJaJfRCo9eaAgY9PajlA0gaAA3Q3My/glooAltvVvbaINC28F4K7qKpDrxmLy+N
         AL2975MuNLkwsThaqyMTjPFkCPzwNQjD5CPfOT6M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+4a75454b9ca2777f35c7@syzkaller.appspotmail.com,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 43/93] ALSA: seq: Fix potential concurrent access to the deleted pool
Date:   Wed,  4 Sep 2019 19:53:45 +0200
Message-Id: <20190904175306.879812405@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175302.845828956@linuxfoundation.org>
References: <20190904175302.845828956@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 75545304eba6a3d282f923b96a466dc25a81e359 upstream.

The input pool of a client might be deleted via the resize ioctl, the
the access to it should be covered by the proper locks.  Currently the
only missing place is the call in snd_seq_ioctl_get_client_pool(), and
this patch papers over it.

Reported-by: syzbot+4a75454b9ca2777f35c7@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/seq/seq_clientmgr.c |    3 +--
 sound/core/seq/seq_fifo.c      |   17 +++++++++++++++++
 sound/core/seq/seq_fifo.h      |    2 ++
 3 files changed, 20 insertions(+), 2 deletions(-)

--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1818,8 +1818,7 @@ static int snd_seq_ioctl_get_client_pool
 	if (cptr->type == USER_CLIENT) {
 		info->input_pool = cptr->data.user.fifo_pool_size;
 		info->input_free = info->input_pool;
-		if (cptr->data.user.fifo)
-			info->input_free = snd_seq_unused_cells(cptr->data.user.fifo->pool);
+		info->input_free = snd_seq_fifo_unused_cells(cptr->data.user.fifo);
 	} else {
 		info->input_pool = 0;
 		info->input_free = 0;
--- a/sound/core/seq/seq_fifo.c
+++ b/sound/core/seq/seq_fifo.c
@@ -280,3 +280,20 @@ int snd_seq_fifo_resize(struct snd_seq_f
 
 	return 0;
 }
+
+/* get the number of unused cells safely */
+int snd_seq_fifo_unused_cells(struct snd_seq_fifo *f)
+{
+	unsigned long flags;
+	int cells;
+
+	if (!f)
+		return 0;
+
+	snd_use_lock_use(&f->use_lock);
+	spin_lock_irqsave(&f->lock, flags);
+	cells = snd_seq_unused_cells(f->pool);
+	spin_unlock_irqrestore(&f->lock, flags);
+	snd_use_lock_free(&f->use_lock);
+	return cells;
+}
--- a/sound/core/seq/seq_fifo.h
+++ b/sound/core/seq/seq_fifo.h
@@ -68,5 +68,7 @@ int snd_seq_fifo_poll_wait(struct snd_se
 /* resize pool in fifo */
 int snd_seq_fifo_resize(struct snd_seq_fifo *f, int poolsize);
 
+/* get the number of unused cells safely */
+int snd_seq_fifo_unused_cells(struct snd_seq_fifo *f);
 
 #endif


