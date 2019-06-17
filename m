Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5701C31E5E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9616B20657
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560806700;
	bh=8AZXDN5az/P3ZHNDwkQykMB35CKW4NUB8QoKxRQ8Qrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xD1WN0HHYJbuRvWIN6UDRcT/FMkRJnvQ893sGo18Ln8uaTs7Yxp/z86x7nUv6rFvN
	 KLlRmWsiQaTpYlyYVW67KV2cx/3DzdnT88KgDjafsHUV+IxvGchE7myFa+1yEzl+zD
	 R3vAVdtlVQ38WtDMWhSPKo/X7vsK0i3c261oc4i8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbfFQVYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:24:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729592AbfFQVYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:24:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43C602063F;
        Mon, 17 Jun 2019 21:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560806686;
        bh=8AZXDN5az/P3ZHNDwkQykMB35CKW4NUB8QoKxRQ8Qrk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cxt9Xi6iiWiK+GB04B0uN/gXEFcef2DVe8aCEnL+9/NjrXBozsPE0vVcmBFOTQHNR
         CNf2F9ZdHYZNP+9wHU4YMkmimX12t2twD5JRizsWcyTmaMRzFyStIcNkmgg1cLSqNf
         Ho161SJEx8zYRI7ufpgsIcq+WJTbQEAJfWsgmwJ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Bj=C3=B8rn=20Forsman?= <bjorn.forsman@gmail.com>,
        Coly Li <colyli@suse.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.19 22/75] bcache: only set BCACHE_DEV_WB_RUNNING when cached device attached
Date:   Mon, 17 Jun 2019 23:09:33 +0200
Message-Id: <20190617210753.709500958@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190617210752.799453599@linuxfoundation.org>
References: <20190617210752.799453599@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Coly Li <colyli@suse.de>

commit 1f0ffa67349c56ea54c03ccfd1e073c990e7411e upstream.

When people set a writeback percent via sysfs file,
  /sys/block/bcache<N>/bcache/writeback_percent
current code directly sets BCACHE_DEV_WB_RUNNING to dc->disk.flags
and schedules kworker dc->writeback_rate_update.

If there is no cache set attached to, the writeback kernel thread is
not running indeed, running dc->writeback_rate_update does not make
sense and may cause NULL pointer deference when reference cache set
pointer inside update_writeback_rate().

This patch checks whether the cache set point (dc->disk.c) is NULL in
sysfs interface handler, and only set BCACHE_DEV_WB_RUNNING and
schedule dc->writeback_rate_update when dc->disk.c is not NULL (it
means the cache device is attached to a cache set).

This problem might be introduced from initial bcache commit, but
commit 3fd47bfe55b0 ("bcache: stop dc->writeback_rate_update properly")
changes part of the original code piece, so I add 'Fixes: 3fd47bfe55b0'
to indicate from which commit this patch can be applied.

Fixes: 3fd47bfe55b0 ("bcache: stop dc->writeback_rate_update properly")
Reported-by: Bjørn Forsman <bjorn.forsman@gmail.com>
Signed-off-by: Coly Li <colyli@suse.de>
Reviewed-by: Bjørn Forsman <bjorn.forsman@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/bcache/sysfs.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -393,8 +393,13 @@ STORE(bch_cached_dev)
 	if (attr == &sysfs_writeback_running)
 		bch_writeback_queue(dc);
 
+	/*
+	 * Only set BCACHE_DEV_WB_RUNNING when cached device attached to
+	 * a cache set, otherwise it doesn't make sense.
+	 */
 	if (attr == &sysfs_writeback_percent)
-		if (!test_and_set_bit(BCACHE_DEV_WB_RUNNING, &dc->disk.flags))
+		if ((dc->disk.c != NULL) &&
+		    (!test_and_set_bit(BCACHE_DEV_WB_RUNNING, &dc->disk.flags)))
 			schedule_delayed_work(&dc->writeback_rate_update,
 				      dc->writeback_rate_update_seconds * HZ);
 


