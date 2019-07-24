Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0D3C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A47F221873
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563997375;
	bh=GHmAGkLOrHLzPUBhHXMeYPkixSMgbRwCjktYV+PyNWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ld1PlHu3n9R2fc8XVIzNXK/mQ2JaZwGJAokP+bUELRtWAot6NI0qNY6mGaBSkjI6D
	 ARjnidjuFB1zi5fsmZnB70vJJDsB+o71vL8UWH6ZJ7lnNqAx6QNgNwLFz47xolazPh
	 KPzjfPDSqrkOqX8JsYMp7OyNHjpJIDRoziGhU7pM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390431AbfGXTmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:42:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:44700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389203AbfGXTmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:42:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DAF920665;
        Wed, 24 Jul 2019 19:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563997370;
        bh=GHmAGkLOrHLzPUBhHXMeYPkixSMgbRwCjktYV+PyNWc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=09ID5DDzGpd4269YO+75JzNPAq5s+d0tIIjj1ndGrUdsEZ4LEvzljHSjU+8DeqkG3
         397YZ8rbxBsQ2OnqoZZW0uwEyQeoN5nw5zHoKatwfc54GbsRelwX+yBKb6/w46CYkq
         7Wen/6RNWBw21WquukaRZdwjlV+f/2zApOKdW1xg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Junxiao Bi <junxiao.bi@oracle.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 5.2 413/413] dm bufio: fix deadlock with loop device
Date:   Wed, 24 Jul 2019 21:21:44 +0200
Message-Id: <20190724191804.013853130@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Junxiao Bi <junxiao.bi@oracle.com>

commit bd293d071ffe65e645b4d8104f9d8fe15ea13862 upstream.

When thin-volume is built on loop device, if available memory is low,
the following deadlock can be triggered:

One process P1 allocates memory with GFP_FS flag, direct alloc fails,
memory reclaim invokes memory shrinker in dm_bufio, dm_bufio_shrink_scan()
runs, mutex dm_bufio_client->lock is acquired, then P1 waits for dm_buffer
IO to complete in __try_evict_buffer().

But this IO may never complete if issued to an underlying loop device
that forwards it using direct-IO, which allocates memory using
GFP_KERNEL (see: do_blockdev_direct_IO()).  If allocation fails, memory
reclaim will invoke memory shrinker in dm_bufio, dm_bufio_shrink_scan()
will be invoked, and since the mutex is already held by P1 the loop
thread will hang, and IO will never complete.  Resulting in ABBA
deadlock.

Cc: stable@vger.kernel.org
Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-bufio.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -1599,9 +1599,7 @@ dm_bufio_shrink_scan(struct shrinker *sh
 	unsigned long freed;
 
 	c = container_of(shrink, struct dm_bufio_client, shrinker);
-	if (sc->gfp_mask & __GFP_FS)
-		dm_bufio_lock(c);
-	else if (!dm_bufio_trylock(c))
+	if (!dm_bufio_trylock(c))
 		return SHRINK_STOP;
 
 	freed  = __scan(c, sc->nr_to_scan, sc->gfp_mask);


