Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E171C04AA6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50EAC217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556624550;
	bh=Alltshhmleeo79lGPima7tw7bD8yYJrwgbk9RpaWPEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Po28rJIlQBJ4KDaizBNUbUtNBYbXjCgcIFDDKfPHKnH5Y7P75rc7sJQPDgu2zPFXB
	 j7HmVNc4wwARANZJDHfiWNvYpguayuQgX9qfOt5GvCOexb5CXwe1k7NQpnUBwKZ7Xp
	 YrUnw+8qggrhIcpcI8zKh5UFsQkb53EvWBOKMODI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbfD3Lm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:42:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:51340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728270AbfD3LmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:42:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AF0D21670;
        Tue, 30 Apr 2019 11:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556624544;
        bh=Alltshhmleeo79lGPima7tw7bD8yYJrwgbk9RpaWPEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s4VzjmEky134rRF/NOGImTBlALaxLVOLMHzGgXNAlpstypqZbo3cj8TrsXgPymcvj
         vgO+aBN8gJbRlm0ncukKKGZx84C67eu3oq8BXvs+UAsuo1gHutvRwQ1frBTTQwvSvB
         BlBBR2XcnauKVvEoSs52c/KTzT8BUdqes98Wn8C0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 05/53] zram: pass down the bvec we need to read into in the work struct
Date:   Tue, 30 Apr 2019 13:38:12 +0200
Message-Id: <20190430113550.605154212@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430113549.400132183@linuxfoundation.org>
References: <20190430113549.400132183@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

commit e153abc0739ff77bd89c9ba1688cdb963464af97 upstream.

When scheduling work item to read page we need to pass down the proper
bvec struct which points to the page to read into.  Before this patch it
uses a randomly initialized bvec (only if PAGE_SIZE != 4096) which is
wrong.

Note that without this patch on arch/kernel where PAGE_SIZE != 4096
userspace could read random memory through a zram block device (thought
userspace probably would have no control on the address being read).

Link: http://lkml.kernel.org/r/20190408183219.26377-1-jglisse@redhat.com
Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Acked-by: Minchan Kim <minchan@kernel.org>
Cc: Nitin Gupta <ngupta@vflare.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/zram/zram_drv.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -488,18 +488,18 @@ struct zram_work {
 	struct zram *zram;
 	unsigned long entry;
 	struct bio *bio;
+	struct bio_vec bvec;
 };
 
 #if PAGE_SIZE != 4096
 static void zram_sync_read(struct work_struct *work)
 {
-	struct bio_vec bvec;
 	struct zram_work *zw = container_of(work, struct zram_work, work);
 	struct zram *zram = zw->zram;
 	unsigned long entry = zw->entry;
 	struct bio *bio = zw->bio;
 
-	read_from_bdev_async(zram, &bvec, entry, bio);
+	read_from_bdev_async(zram, &zw->bvec, entry, bio);
 }
 
 /*
@@ -512,6 +512,7 @@ static int read_from_bdev_sync(struct zr
 {
 	struct zram_work work;
 
+	work.bvec = *bvec;
 	work.zram = zram;
 	work.entry = entry;
 	work.bio = bio;


