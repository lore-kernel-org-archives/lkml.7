Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044C0C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE9282231E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574140896;
	bh=0/AeRMMTLdI47ZTTlBvfhPXjRx1Tkw9f1EoaDyFPxBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YQYGDYVHy3XanSiLRGtpQ8rkdi8LK5uMM7kCBYBII5V5aGQeKULwgc3CdFs780yYM
	 KG46fR8EDKa7itdGKbYeCDmjqcH9XFTIzA+mRApJy6Smt7w0eJKudeMXC+TRoLURea
	 9UOzOM05q8fOuYzbj27CMyQTWCeOxDCbFsjGa+Lc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfKSFVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:21:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:36446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727385AbfKSFV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:21:29 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1ED992235D;
        Tue, 19 Nov 2019 05:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574140887;
        bh=0/AeRMMTLdI47ZTTlBvfhPXjRx1Tkw9f1EoaDyFPxBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kDzz+3+8usttTiP9TNJ3C8/mD175PAZRYg9KEQe1UjxRnVQU1UyCXEm+mGn8jpp8i
         l/PNj40RVyqFIFjnwZvNIWGptLPoyUvOMMjqeKgV2sFC52DN2TFwtCewXGmibadnGj
         gd9dHPej0Y/RXHO5EExZOxeyuHer145ba3A5/EKk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        syzbot+b6c55daa701fc389e286@syzkaller.appspotmail.com
Subject: [PATCH 5.3 20/48] Input: ff-memless - kill timer in destroy()
Date:   Tue, 19 Nov 2019 06:19:40 +0100
Message-Id: <20191119051003.893735938@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119050946.745015350@linuxfoundation.org>
References: <20191119050946.745015350@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Neukum <oneukum@suse.com>

commit fa3a5a1880c91bb92594ad42dfe9eedad7996b86 upstream.

No timer must be left running when the device goes away.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Reported-and-tested-by: syzbot+b6c55daa701fc389e286@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/1573726121.17351.3.camel@suse.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/ff-memless.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/input/ff-memless.c
+++ b/drivers/input/ff-memless.c
@@ -489,6 +489,15 @@ static void ml_ff_destroy(struct ff_devi
 {
 	struct ml_device *ml = ff->private;
 
+	/*
+	 * Even though we stop all playing effects when tearing down
+	 * an input device (via input_device_flush() that calls into
+	 * input_ff_flush() that stops and erases all effects), we
+	 * do not actually stop the timer, and therefore we should
+	 * do it here.
+	 */
+	del_timer_sync(&ml->timer);
+
 	kfree(ml->private);
 }
 


