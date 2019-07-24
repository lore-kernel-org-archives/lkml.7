Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F4CC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DBD422ADF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563998464;
	bh=gr+fh92xGUPJDzZvbxxX5CaJ2QI9hu3dRDLsBqNr1g0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ErGQmQrNV5053oeiNEcqzRm9dHIU0kHdNxHvkIbVsnfGPy95l7TeNdQ4q6tgZPEAo
	 cqIh7llAZ6bLU1SKNd4HtV0psRU7jPcSR/eI2ffFk1KvlvWcBu7OjUlJ2a6E244/o7
	 7urFB5Sb+uxm2JmxCXAtbEDZVrxoQTy+I5m9YNNg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405326AbfGXUBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:01:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:49420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405309AbfGXUBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 16:01:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88EE8205C9;
        Wed, 24 Jul 2019 20:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563998459;
        bh=gr+fh92xGUPJDzZvbxxX5CaJ2QI9hu3dRDLsBqNr1g0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OHpKGNQl1+0XYIeSLcIOls4E7gr/D0puijwcxI+jzRQDxXEuHgS/MSLb8ucpZPYTn
         sSDKaodBFPJ+vo7DTpzqlEroMmHSn698u76z8gS4qHGakU4BgKQ1BDh9z/frxLMYRq
         VXeO36m5m5flXKQCVhaGCVEB7yKGckI1wB3V68/E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Junxiao Bi <junxiao.bi@oracle.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 5.1 371/371] dm bufio: fix deadlock with loop device
Date:   Wed, 24 Jul 2019 21:22:03 +0200
Message-Id: <20190724191752.330914116@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
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
@@ -1602,9 +1602,7 @@ dm_bufio_shrink_scan(struct shrinker *sh
 	unsigned long freed;
 
 	c = container_of(shrink, struct dm_bufio_client, shrinker);
-	if (sc->gfp_mask & __GFP_FS)
-		dm_bufio_lock(c);
-	else if (!dm_bufio_trylock(c))
+	if (!dm_bufio_trylock(c))
 		return SHRINK_STOP;
 
 	freed  = __scan(c, sc->nr_to_scan, sc->gfp_mask);


