Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607F1C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38820206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569181065;
	bh=wHCe2eLqeBayLHrTaC81ulGiWcK3ZH12sxzE0bgkK5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CrbNSbAcBN0y1jE5+OHpCIqvTsPioq8ipTsw0WAP3DHQ+VbR+Bxj8iE3IwHMocE9D
	 EWRBArAjdgj1kMO+XKc5LInjqekNqe7IrhsWSbhcp9jU5AbCJh/T71wDc7k4rw/+Yq
	 hAQqSMCXsyKxJmjCs03gkTSyqQY2v7a4UZ5Fd8WI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406810AbfIVThn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 15:37:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389541AbfIVSpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:45:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08FEE222C2;
        Sun, 22 Sep 2019 18:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569177941;
        bh=wHCe2eLqeBayLHrTaC81ulGiWcK3ZH12sxzE0bgkK5E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=meLW7Odhl6RqRgZk2CrTSO1dBjADj/TKyMDGeka5XDUVmLZd8mdvz0XtMUrJwJEHT
         +krwcrhebrjJ12dA8apB6nka62liAeUVmoUWgP5mmqc8H9C98HW9Ry4Qd4NEq/XPjW
         JMFyeujDWj6aU3aoYPpU81N3Xc8Mwpk7M/x/SWnc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yufen Yu <yuyufen@huawei.com>, Song Liu <songliubraving@fb.com>,
        Sasha Levin <sashal@kernel.org>, linux-raid@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 050/203] md/raid1: end bio when the device faulty
Date:   Sun, 22 Sep 2019 14:41:16 -0400
Message-Id: <20190922184350.30563-50-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922184350.30563-1-sashal@kernel.org>
References: <20190922184350.30563-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 34e26834ad28b..501a3b4d82f33 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -447,19 +447,21 @@ static void raid1_end_write_request(struct bio *bio)
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

