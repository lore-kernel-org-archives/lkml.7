Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FC0C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78AE021655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564430441;
	bh=w0GuBMuaQl17zfa8FY0kwHgVAdFRg6KpuFNW7q5+UDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F/5jv1XEaJKodYGOJvb3p6diuY8PG0Gn7uVmGwqyOmh5UWWZTUQYSgNw52kWPQasD
	 eEGxUm+79YG0/zZUkOkw5Uw2It+uHlvv86pt0hO4ou7z79zQrL6YQRVe417vIXjpon
	 BLbEOe9tP7xZ595VqpKLHBvvvKElCAf/qu2oRNfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391055AbfG2UAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 16:00:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:44350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390121AbfG2Twc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:52:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9817A204EC;
        Mon, 29 Jul 2019 19:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564429952;
        bh=w0GuBMuaQl17zfa8FY0kwHgVAdFRg6KpuFNW7q5+UDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=azzjUBHZKG0ubkAwKSu7wOD028EkZtucD5glSEl4pvke9eBdfNIJG2uXfebwS68vB
         aalZTx68nsDw0Zr8OjnoiQsvxMOLV0pA5v4nKa+VipPBL2DO3ZKeax24YpmDcK4ZUB
         OVNIWfaM7q7/HvYZAxQfnUDNK9Mz3CrW10alymeA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Wenwen Wang <wenwen@cs.uga.edu>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 147/215] block/bio-integrity: fix a memory leak bug
Date:   Mon, 29 Jul 2019 21:22:23 +0200
Message-Id: <20190729190805.209329734@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190739.971253303@linuxfoundation.org>
References: <20190729190739.971253303@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit e7bf90e5afe3aa1d1282c1635a49e17a32c4ecec ]

In bio_integrity_prep(), a kernel buffer is allocated through kmalloc() to
hold integrity metadata. Later on, the buffer will be attached to the bio
structure through bio_integrity_add_page(), which returns the number of
bytes of integrity metadata attached. Due to unexpected situations,
bio_integrity_add_page() may return 0. As a result, bio_integrity_prep()
needs to be terminated with 'false' returned to indicate this error.
However, the allocated kernel buffer is not freed on this execution path,
leading to a memory leak.

To fix this issue, free the allocated buffer before returning from
bio_integrity_prep().

Reviewed-by: Ming Lei <ming.lei@redhat.com>
Acked-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bio-integrity.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 4db620849515..fb95dbb21dd8 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -276,8 +276,12 @@ bool bio_integrity_prep(struct bio *bio)
 		ret = bio_integrity_add_page(bio, virt_to_page(buf),
 					     bytes, offset);
 
-		if (ret == 0)
-			return false;
+		if (ret == 0) {
+			printk(KERN_ERR "could not attach integrity payload\n");
+			kfree(buf);
+			status = BLK_STS_RESOURCE;
+			goto err_end_io;
+		}
 
 		if (ret < bytes)
 			break;
-- 
2.20.1



