Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D88C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E7921847
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574888891;
	bh=S8kGG9p6HSMDgtKASDhnwxvtfT614CVOtoxaHvrPciw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zkdBTGnKwjlMPdyhB02dtEqUz9dwAVf+4KLGcIKgT5j/PuSZl6lN0E34cFk9Q0C10
	 JIhX0pjDl7YKzkEmXC/fYk8pqT5A0Vf6un8GWxqpspPHscE7L+QTuk71im5ta9SUVN
	 N5gL61e2JD8JK1xz5mTKpZEeZ8jZUgWd+L7hz/VQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732716AbfK0VIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:08:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:34416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732695AbfK0VIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:08:04 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E169D20637;
        Wed, 27 Nov 2019 21:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888884;
        bh=S8kGG9p6HSMDgtKASDhnwxvtfT614CVOtoxaHvrPciw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nx1J9nCIQ4cSVwZADfWa0Mb86oW97YZ3iBSj9l1cyytEafjv9QWZBvxUYhmGbJKWF
         +ZwzsLOfsddKrxRM3LpTqRXdeMi6v68fyNZBNFx77Hm1rWphr1jjsNGhabTPWH/U1a
         OwOuRQDwHJMM6T2Cd1KzlDuR/6KuhYldPKzMsC4o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
        "David S. Miller" <davem@davemloft.net>,
        syzbot+711468aa5c3a1eabf863@syzkaller.appspotmail.com
Subject: [PATCH 4.19 281/306] nfc: port100: handle command failure cleanly
Date:   Wed, 27 Nov 2019 21:32:11 +0100
Message-Id: <20191127203135.311115248@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Neukum <oneukum@suse.com>

commit 5f9f0b11f0816b35867f2cf71e54d95f53f03902 upstream.

If starting the transfer of a command suceeds but the transfer for the reply
fails, it is not enough to initiate killing the transfer for the
command may still be running. You need to wait for the killing to finish
before you can reuse URB and buffer.

Reported-and-tested-by: syzbot+711468aa5c3a1eabf863@syzkaller.appspotmail.com
Signed-off-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nfc/port100.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/nfc/port100.c
+++ b/drivers/nfc/port100.c
@@ -792,7 +792,7 @@ static int port100_send_frame_async(stru
 
 	rc = port100_submit_urb_for_ack(dev, GFP_KERNEL);
 	if (rc)
-		usb_unlink_urb(dev->out_urb);
+		usb_kill_urb(dev->out_urb);
 
 exit:
 	mutex_unlock(&dev->out_urb_lock);


