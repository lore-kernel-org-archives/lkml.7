Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5759FCA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FAF1214AF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572210666;
	bh=t/wq/WZPF0b75fqr10+zFJOVGpK2Dc4F7FNpxG8v3bI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Jp7Xm1Zh5hdPKZmumyLeaz1ApcCHVnjKKXQgMkdS8twngTgIOZSydSMcOozy/v9Sd
	 t4fvzHILKioicqHcbj5GDrOLW4VRMes3qaW7auwA9ZvqFKP6vjpu+Em64qNA2weeJg
	 HT2jO8rx4a+mjHtVsstw+tN12uF0OeD8E1VPuxnk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbfJ0VLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:11:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:57490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729814AbfJ0VLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:11:00 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C589214E0;
        Sun, 27 Oct 2019 21:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572210659;
        bh=t/wq/WZPF0b75fqr10+zFJOVGpK2Dc4F7FNpxG8v3bI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bzxS1LnUIxdoIRZqfIfuJZoCSf8mABIKElKH8qZUuZeyTzLEmyfgaMq3YWpMTTHs5
         NC4rVFgqakg8/PMunHbBIvdP4N8VGX54X/qVFso5KoerIfWGh4PpP7+XxcfOMOCd82
         fahNf43fgEnXTPd+WDbmaQkg+CxnbZwXDEp998VI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Rob Turk <robtu@rtist.nl>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 090/119] scsi: ch: Make it possible to open a ch device multiple times again
Date:   Sun, 27 Oct 2019 22:01:07 +0100
Message-Id: <20191027203348.205230988@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203259.948006506@linuxfoundation.org>
References: <20191027203259.948006506@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bart Van Assche <bvanassche@acm.org>

commit 6a0990eaa768dfb7064f06777743acc6d392084b upstream.

Clearing ch->device in ch_release() is wrong because that pointer must
remain valid until ch_remove() is called. This patch fixes the following
crash the second time a ch device is opened:

BUG: kernel NULL pointer dereference, address: 0000000000000790
RIP: 0010:scsi_device_get+0x5/0x60
Call Trace:
 ch_open+0x4c/0xa0 [ch]
 chrdev_open+0xa2/0x1c0
 do_dentry_open+0x13a/0x380
 path_openat+0x591/0x1470
 do_filp_open+0x91/0x100
 do_sys_open+0x184/0x220
 do_syscall_64+0x5f/0x1a0
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Fixes: 085e56766f74 ("scsi: ch: add refcounting")
Cc: Hannes Reinecke <hare@suse.de>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20191009173536.247889-1-bvanassche@acm.org
Reported-by: Rob Turk <robtu@rtist.nl>
Suggested-by: Rob Turk <robtu@rtist.nl>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/ch.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/scsi/ch.c
+++ b/drivers/scsi/ch.c
@@ -578,7 +578,6 @@ ch_release(struct inode *inode, struct f
 	scsi_changer *ch = file->private_data;
 
 	scsi_device_put(ch->device);
-	ch->device = NULL;
 	file->private_data = NULL;
 	kref_put(&ch->ref, ch_destroy);
 	return 0;


