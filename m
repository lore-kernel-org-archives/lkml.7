Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D46EC3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 19:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6EA421726
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 19:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="WGF7By/r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729888AbfIDTtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 15:49:23 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36380 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbfIDTtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 15:49:21 -0400
Received: by mail-ed1-f67.google.com with SMTP id g24so157383edu.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 12:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p3ti1HdGzDfG7e4V9OD2Hs5bYpayMdTpXw6CUesGjzU=;
        b=WGF7By/r82zxfwrvtxjIPqHi7WfUP2SSSKagzTSy+zsrpZjjA68hjPiI7CwjD+Z/tL
         0uARq2xzla325ykv1nr3LVnwf+XLmkEi5FoeCnLEk3+nTuzgzQwe47r03gz5i8+5o3Zz
         pYaM0Z0+pq5+kQMiuR0UqZ1dg3Pk1BRY48uOCfiwiLnqVHeJ1CKmJrCy5jAtm1iZn43w
         ZcDJojQHU5VHjdC9LyY63gcpBrDNh9M9kvZgvQJhgaNXTGcgvXqD6ODARSiasycL8HRZ
         XyTvj9fAjKSic0JHctTEOxObx9S6dg8HHwVEhSJ2fwOrV+8MCzlOcbOaQSo9lTDOANj6
         /xMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p3ti1HdGzDfG7e4V9OD2Hs5bYpayMdTpXw6CUesGjzU=;
        b=RzZTv2WagvEjjmFffMSvo6WoV64ugquiNG7OUZGNGe9G8hkHJb577x99JBCiPIxERQ
         zWdpewyBjTiDwI9gEm+1mEKDeIGvnKZsLIxDNOopG6nhCqpeTQ/LZGz3X0quviochDgg
         9mkwlr+FHy/u9TiDUiitwac/aG9jBRv3cAuZblknzcj4BkrNUQY0cgct8UrRMc90eyhp
         UQhvAop7zIceyl5AvSD6rh1a5HDcU9VrfKBCIA08gFQ+pbb3s01b7b4ScG9K0Lllfm49
         4/6/LyB4k2E+6oEExJYvqPvPg/oCpxY7naX4dP+dv2/jFtixKEa8DEbWyJCvdt/2Qe5F
         wkwQ==
X-Gm-Message-State: APjAAAXxIdCKTic7n+DuwbGGwX8k6g/heGcq8Kzg5ECd1gpN+APQNBu8
        0ApE6hMtvTzVlKBps6nNL4LQaw==
X-Google-Smtp-Source: APXvYqxtAzvSc/H2oP33RR3xHp2NnQqFDwRCw+eWBFQQXARvNRyRV1QmaEMsX1Gcij/9cfDb+50tjg==
X-Received: by 2002:a50:e04b:: with SMTP id g11mr15269701edl.302.1567626559684;
        Wed, 04 Sep 2019 12:49:19 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id i1sm11137edi.13.2019.09.04.12.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 12:49:18 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@infradead.org, ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, kernel-team@android.com,
        narayan@google.com, dariofreni@google.com, ioffe@google.com,
        jiyong@google.com, maco@google.com,
        Martijn Coenen <maco@android.com>
Subject: [PATCH v2] loop: change queue block size to match when using DIO.
Date:   Wed,  4 Sep 2019 21:49:01 +0200
Message-Id: <20190904194901.165883-1-maco@android.com>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
In-Reply-To: <20190828103229.191853-1-maco@android.com>
References: <20190828103229.191853-1-maco@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The loop driver assumes that if the passed in fd is opened with
O_DIRECT, the caller wants to use direct I/O on the loop device.
However, if the underlying block device has a different block size than
the loop block queue, direct I/O can't be enabled. Instead of requiring
userspace to manually change the blocksize and re-enable direct I/O,
just change the queue block sizes to match, as well as the io_min size.

Signed-off-by: Martijn Coenen <maco@android.com>
---
v2 changes:
- Fixed commit message to say the block size must match the underlying
  block device, not the underlying filesystem.
- Also set physical blocksize and minimal io size correspondingly.

 drivers/block/loop.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index ab7ca5989097a..b547182037af2 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -994,6 +994,16 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	if (!(lo_flags & LO_FLAGS_READ_ONLY) && file->f_op->fsync)
 		blk_queue_write_cache(lo->lo_queue, true, false);
 
+	if (io_is_direct(lo->lo_backing_file) && inode->i_sb->s_bdev) {
+		/* In case of direct I/O, match underlying block size */
+		unsigned short bsize = bdev_logical_block_size(
+			inode->i_sb->s_bdev);
+
+		blk_queue_logical_block_size(lo->lo_queue, bsize);
+		blk_queue_physical_block_size(lo->lo_queue, bsize);
+		blk_queue_io_min(lo->lo_queue, bsize);
+	}
+
 	loop_update_rotational(lo);
 	loop_update_dio(lo);
 	set_capacity(lo->lo_disk, size);
-- 
2.23.0.187.g17f5b7556c-goog

