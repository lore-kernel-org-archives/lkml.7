Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3889DC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 034CB20880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355598;
	bh=OGCjcwwUE6yUWX7TXna0h7NpYQo8eu6j3g2NnIDb4kQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hV+eWWnkjtUwHpAzPYOOdQwCw+yjnhtIW082ReO2FTXWkj1ulFwmrvPh/AIOEXL0K
	 v35boBfUi7k3pVEyXUTGUmFKJvnNHK8q1AkRsfqiNQ11xPq4mj4kYIH2j7QrtjAa2r
	 wIrC1UNjiFGE1RX6+4UsGO1nmhT8PZt5frTTQR38=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731537AbfDOTNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:13:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:50868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728252AbfDOTNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:13:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A805520880;
        Mon, 15 Apr 2019 19:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355594;
        bh=OGCjcwwUE6yUWX7TXna0h7NpYQo8eu6j3g2NnIDb4kQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lATQiVY3OH46WRT68f4IENHSz+bhchQHJ7v8Xdlnzq8mFPXJ51nyMrXwG3ng31l6e
         wtWUpQjBzpZ7sKhXOG2ROkcq+jG5AkbWdsvBllAGvFsruMzjt6AgeZhAfzjSWqdH94
         qqDUlFuTBKm+2oDXHsvK0lRCBzA6Oan6z/oTbai8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Jason Yan <yanaijie@huawei.com>
Subject: [PATCH 5.0 080/117] block: fix the return errno for direct IO
Date:   Mon, 15 Apr 2019 21:00:50 +0200
Message-Id: <20190415183749.023039069@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Yan <yanaijie@huawei.com>

commit a89afe58f1a74aac768a5eb77af95ef4ee15beaa upstream.

If the last bio returned is not dio->bio, the status of the bio will
not assigned to dio->bio if it is error. This will cause the whole IO
status wrong.

    ksoftirqd/21-117   [021] ..s.  4017.966090:   8,0    C   N 4883648 [0]
          <idle>-0     [018] ..s.  4017.970888:   8,0    C  WS 4924800 + 1024 [0]
          <idle>-0     [018] ..s.  4017.970909:   8,0    D  WS 4935424 + 1024 [<idle>]
          <idle>-0     [018] ..s.  4017.970924:   8,0    D  WS 4936448 + 321 [<idle>]
    ksoftirqd/21-117   [021] ..s.  4017.995033:   8,0    C   R 4883648 + 336 [65475]
    ksoftirqd/21-117   [021] d.s.  4018.001988: myprobe1: (blkdev_bio_end_io+0x0/0x168) bi_status=7
    ksoftirqd/21-117   [021] d.s.  4018.001992: myprobe: (aio_complete_rw+0x0/0x148) x0=0xffff802f2595ad80 res=0x12a000 res2=0x0

We always have to assign bio->bi_status to dio->bio.bi_status because we
will only check dio->bio.bi_status when we return the whole IO to
the upper layer.

Fixes: 542ff7bf18c6 ("block: new direct I/O implementation")
Cc: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/block_dev.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -298,10 +298,10 @@ static void blkdev_bio_end_io(struct bio
 	struct blkdev_dio *dio = bio->bi_private;
 	bool should_dirty = dio->should_dirty;
 
-	if (dio->multi_bio && !atomic_dec_and_test(&dio->ref)) {
-		if (bio->bi_status && !dio->bio.bi_status)
-			dio->bio.bi_status = bio->bi_status;
-	} else {
+	if (bio->bi_status && !dio->bio.bi_status)
+		dio->bio.bi_status = bio->bi_status;
+
+	if (!dio->multi_bio || atomic_dec_and_test(&dio->ref)) {
 		if (!dio->is_sync) {
 			struct kiocb *iocb = dio->iocb;
 			ssize_t ret;


