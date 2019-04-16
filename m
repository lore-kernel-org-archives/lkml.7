Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE47C282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C60B2176F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555458829;
	bh=vgcxtuCPX9kB1FwZOjifTAB2VBX5/eLXBF+Q9TGOyME=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=TPTYhyzv3QuZ5o/EL6I8tzuasj1o31ISYl8Wd2T8mRcVOGfb1xSgUU5AUgiC+tLXw
	 sxMECSQGxQFbcXkFg1jzNQ85ccDdEu6boHXGqPAQXeBFFUJ2IRRKPKmjXBOp5G1DDG
	 LYvczLuxSN2lgkLGORIizjBDZiBDPWXuyIFVW5mk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730999AbfDPXxs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 19:53:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41232 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728856AbfDPXxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 19:53:48 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E4847B49;
        Tue, 16 Apr 2019 23:53:46 +0000 (UTC)
Date:   Tue, 16 Apr 2019 16:53:45 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] zram: pass down the bvec we need to read into in the
 work struct
Message-Id: <20190416165345.df90a7491b94f4e9eea9978d@linux-foundation.org>
In-Reply-To: <20190410194350.GA25351@redhat.com>
References: <20190408183219.26377-1-jglisse@redhat.com>
        <20190410194350.GA25351@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Apr 2019 15:43:50 -0400 Jerome Glisse <jglisse@redhat.com> wrote:

> Adding more Cc and stable (i thought this was 5.1 addition). Note that
> without this patch on arch/kernel where PAGE_SIZE != 4096 userspace
> could read random memory through a zram block device (thought userspace
> probably would have no control on the address being read).

Looks good to me.

Minchan & Sergey, can you please review?


From: Jérôme Glisse <jglisse@redhat.com>
Subject: zram: pass down the bvec we need to read into in the work struct

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
Cc: Minchan Kim <minchan@kernel.org>
Cc: Nitin Gupta <ngupta@vflare.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/block/zram/zram_drv.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/block/zram/zram_drv.c~zram-pass-down-the-bvec-we-need-to-read-into-in-the-work-struct
+++ a/drivers/block/zram/zram_drv.c
@@ -774,18 +774,18 @@ struct zram_work {
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
@@ -798,6 +798,7 @@ static int read_from_bdev_sync(struct zr
 {
 	struct zram_work work;
 
+	work.bvec = *bvec;
 	work.zram = zram;
 	work.entry = entry;
 	work.bio = bio;
_

