Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB08CA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C832184C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572904468;
	bh=rYBP9i4imPsXK8XDuA0lcxALZkLP9yyjhkhdTDFv5LI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FsTqb7z0lFRWIfx2Q3+LRVe3kdoBu5FWTg/7b9KhJUCK99B8cLHSNbP7EqtzwMdgb
	 ktrN/99DkULPU/u+PpvaPD/yVH3XAw3SNJekQ22Vi+4JiX1Dtl0u/hyH9Zs1Y/LHbQ
	 Le1PLfM7Ji8YClMUOYcRVFDNSatLhraGohoMjQXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387938AbfKDVy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:54:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:49120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387921AbfKDVyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:54:23 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE127217F5;
        Mon,  4 Nov 2019 21:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572904462;
        bh=rYBP9i4imPsXK8XDuA0lcxALZkLP9yyjhkhdTDFv5LI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lNqGEgdALRygvooupRbCSVAMQTWBUn638vvK5lHQEloZRfZfAUAUKiRt8MkOO6DqN
         5O78I047fN+oM84RXJWyD1qG2KMWEK77ImujzHmc4RBhl5dhQ3S4dP3PHWK4u+Zy9m
         1RmsRPWlXlt0chBHbNvEfXWNDf0ACA8tBsaS3RaE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Nikos Tsironis <ntsironis@arrikto.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 03/95] dm snapshot: introduce account_start_copy() and account_end_copy()
Date:   Mon,  4 Nov 2019 22:44:01 +0100
Message-Id: <20191104212039.349667948@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104212038.056365853@linuxfoundation.org>
References: <20191104212038.056365853@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>

[ Upstream commit a2f83e8b0c82c9500421a26c49eb198b25fcdea3 ]

This simple refactoring moves code for modifying the semaphore cow_count
into separate functions to prepare for changes that will extend these
methods to provide for a more sophisticated mechanism for COW
throttling.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Reviewed-by: Nikos Tsironis <ntsironis@arrikto.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-snap.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
index 8b1556e77a0a0..a9575122a0c6e 100644
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -1399,6 +1399,16 @@ static void snapshot_dtr(struct dm_target *ti)
 	kfree(s);
 }
 
+static void account_start_copy(struct dm_snapshot *s)
+{
+	down(&s->cow_count);
+}
+
+static void account_end_copy(struct dm_snapshot *s)
+{
+	up(&s->cow_count);
+}
+
 /*
  * Flush a list of buffers.
  */
@@ -1581,7 +1591,7 @@ static void copy_callback(int read_err, unsigned long write_err, void *context)
 		}
 		list_add(&pe->out_of_order_entry, lh);
 	}
-	up(&s->cow_count);
+	account_end_copy(s);
 }
 
 /*
@@ -1605,7 +1615,7 @@ static void start_copy(struct dm_snap_pending_exception *pe)
 	dest.count = src.count;
 
 	/* Hand over to kcopyd */
-	down(&s->cow_count);
+	account_start_copy(s);
 	dm_kcopyd_copy(s->kcopyd_client, &src, 1, &dest, 0, copy_callback, pe);
 }
 
@@ -1625,7 +1635,7 @@ static void start_full_bio(struct dm_snap_pending_exception *pe,
 	pe->full_bio = bio;
 	pe->full_bio_end_io = bio->bi_end_io;
 
-	down(&s->cow_count);
+	account_start_copy(s);
 	callback_data = dm_kcopyd_prepare_callback(s->kcopyd_client,
 						   copy_callback, pe);
 
-- 
2.20.1



