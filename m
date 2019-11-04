Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CC9CA9ED3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1952321850
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572904098;
	bh=77sS3w03X92A9bu2jxWTB2qmu2JAV6Xtx2HzEp2RtYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oyoTywuRA/SJZddJBA63ArEDFAuRhIvTuIi20JIUpXrZb2vAP7liTcxaPwJ3UO+Gc
	 zG/L8uERgpRtBox0QdWbCe37/1dbCDuRBmnoPtS2D2zksMTNHrIpQdcFcm7PSFA6aH
	 f/cwYNnieu0zKYbGBfIV/sf9oeDpHz71WSX8QSo8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbfKDVsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:48:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:38378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729954AbfKDVsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:48:14 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89E28222CF;
        Mon,  4 Nov 2019 21:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572904094;
        bh=77sS3w03X92A9bu2jxWTB2qmu2JAV6Xtx2HzEp2RtYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G9FhLtyRMUdi/a7uE1UiLNSYML9R6EG0P5lMB5hgP0gIjcistYT2lCcUNWyoW/kfb
         pjlrTbx2oA3sE9F7AQKJTAU1oczOlotWT4SbJGZNh2yKVWLNu958cbJdjPLwGsB/PK
         1JrHXDfRDSshTkuRrcqkST1Ck3Nx+sbRkSQG/Y/E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Nikos Tsironis <ntsironis@arrikto.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 02/46] dm snapshot: introduce account_start_copy() and account_end_copy()
Date:   Mon,  4 Nov 2019 22:44:33 +0100
Message-Id: <20191104211833.227226439@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104211830.912265604@linuxfoundation.org>
References: <20191104211830.912265604@linuxfoundation.org>
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
index 7c8b5fdf4d4e5..2437ca7e43687 100644
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -1400,6 +1400,16 @@ static void snapshot_dtr(struct dm_target *ti)
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
@@ -1584,7 +1594,7 @@ static void copy_callback(int read_err, unsigned long write_err, void *context)
 		}
 		list_add(&pe->out_of_order_entry, lh);
 	}
-	up(&s->cow_count);
+	account_end_copy(s);
 }
 
 /*
@@ -1608,7 +1618,7 @@ static void start_copy(struct dm_snap_pending_exception *pe)
 	dest.count = src.count;
 
 	/* Hand over to kcopyd */
-	down(&s->cow_count);
+	account_start_copy(s);
 	dm_kcopyd_copy(s->kcopyd_client, &src, 1, &dest, 0, copy_callback, pe);
 }
 
@@ -1629,7 +1639,7 @@ static void start_full_bio(struct dm_snap_pending_exception *pe,
 	pe->full_bio_end_io = bio->bi_end_io;
 	pe->full_bio_private = bio->bi_private;
 
-	down(&s->cow_count);
+	account_start_copy(s);
 	callback_data = dm_kcopyd_prepare_callback(s->kcopyd_client,
 						   copy_callback, pe);
 
-- 
2.20.1



