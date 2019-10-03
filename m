Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D421C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3409A20865
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570122851;
	bh=WIctwk9L72Om2Ui1kbxR8vV1p8YYAz6Te+AeYjGT+5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mmAWDWPnt9yb0Pc/bzuziBQOVfF/dM3n/maHoi8M01hCeMDXnbugh7x7GW9C9AE79
	 NNJZ4lXfJox3gzTLABW4D6CRUxZG3t3Vf+4ysduv0EdQ9kf5waPdIVVWwopjBbNUEy
	 9XXl3CUo9IpAyRZTh8g+4nZyLlfhYgn84oRRFUoA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391287AbfJCQ1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:27:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:59232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391239AbfJCQ1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:27:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F69F21A4C;
        Thu,  3 Oct 2019 16:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570120041;
        bh=WIctwk9L72Om2Ui1kbxR8vV1p8YYAz6Te+AeYjGT+5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FOw8o6oyh5A0RvGcriTOqC626VGAoivuo7GT0leW9WPxMino5YAlL9uVReHuovGuA
         cz0xh601Y/4QwHXqytFhR9C3GY5U7ddKkHdSR/bTQn12x7mUR6LCAj8oJg8A+8Xu+C
         smsWYMHN2v9Y0cYFSULc+04ZvcnJTGTSK/y1jsWE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yufen Yu <yuyufen@huawei.com>,
        Song Liu <songliubraving@fb.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 074/313] md/raid1: end bio when the device faulty
Date:   Thu,  3 Oct 2019 17:50:52 +0200
Message-Id: <20191003154540.129667554@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154533.590915454@linuxfoundation.org>
References: <20191003154533.590915454@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yufen Yu <yuyufen@huawei.com>

[ Upstream commit eeba6809d8d58908b5ed1b5ceb5fcb09a98a7cad ]

When write bio return error, it would be added to conf->retry_list
and wait for raid1d thread to retry write and acknowledge badblocks.

In narrow_write_error(), the error bio will be split in the unit of
badblock shift (such as one sector) and raid1d thread issues them
one by one. Until all of the splited bio has finished, raid1d thread
can go on processing other things, which is time consuming.

But, there is a scene for error handling that is not necessary.
When the device has been set faulty, flush_bio_list() may end
bios in pending_bio_list with error status. Since these bios
has not been issued to the device actually, error handlding to
retry write and acknowledge badblocks make no sense.

Even without that scene, when the device is faulty, badblocks info
can not be written out to the device. Thus, we also no need to
handle the error IO.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/raid1.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 2aa36e570e049..a26731a9b38e7 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -426,19 +426,21 @@ static void raid1_end_write_request(struct bio *bio)
 		    /* We never try FailFast to WriteMostly devices */
 		    !test_bit(WriteMostly, &rdev->flags)) {
 			md_error(r1_bio->mddev, rdev);
-			if (!test_bit(Faulty, &rdev->flags))
-				/* This is the only remaining device,
-				 * We need to retry the write without
-				 * FailFast
-				 */
-				set_bit(R1BIO_WriteError, &r1_bio->state);
-			else {
-				/* Finished with this branch */
-				r1_bio->bios[mirror] = NULL;
-				to_put = bio;
-			}
-		} else
+		}
+
+		/*
+		 * When the device is faulty, it is not necessary to
+		 * handle write error.
+		 * For failfast, this is the only remaining device,
+		 * We need to retry the write without FailFast.
+		 */
+		if (!test_bit(Faulty, &rdev->flags))
 			set_bit(R1BIO_WriteError, &r1_bio->state);
+		else {
+			/* Finished with this branch */
+			r1_bio->bios[mirror] = NULL;
+			to_put = bio;
+		}
 	} else {
 		/*
 		 * Set R1BIO_Uptodate in our master bio, so that we
-- 
2.20.1



