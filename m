Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929D6C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 08:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5466220708
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 08:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="FIsqbZuN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfKVI76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 03:59:58 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54383 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfKVI76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 03:59:58 -0500
Received: by mail-wm1-f66.google.com with SMTP id x26so6276819wmk.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 00:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pdAlM/qy2J9mgq8W7ib6NaoDdjV1KLoho6CJMqImWIo=;
        b=FIsqbZuNR/tGKYTPm/IecDxhZ8w+w0s6fYOCwGn+lqZvrAWYx1Zx3SfljyluNSmFv5
         iQnRPUjHUmlHGNc4ouyyfdjOHZFV3ZtRG7FuXGbQ46yID4KX41+UKxBEqEddgRu5ATcf
         06S/L/GWhFkXR5k9Clp/TGEiNDLLPPkk5CPR2UbIAFD8OREh0AB8j4gqroPacKJk42Uk
         tvjresCi8wlRKLTjRxM3AJldL8homsZstfBUzMrMtUxR2hSE0S7soLdDX3nL1od5uZWB
         flHmSY/jHRr8nyGnyefVm33etQFJM6Y/9VixgCixy4OPUlwVM6zEFmsN9m689LGliL06
         Igyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pdAlM/qy2J9mgq8W7ib6NaoDdjV1KLoho6CJMqImWIo=;
        b=gQvRnShL5iWm40iKrnjJIaFXihpdPlzp2EAP8Ddoirps5O4RanEwWEJi38ranV+Jtc
         4ayP6fdovFbZUqMYuaO88Vo99DlhYfXUIwB2v/AYJlgf4sO7UTJwLIcBtbIUcFADLcV5
         pP4ktlqD7ISJ6q5iQCLOBRJKUcjbkbhUP4ZltX2/Q4E+UkPLaNiC/4Uz5zUdn/jynkCC
         bx5BSd9WJfZIjXOfvykkuFqsZ+rV1MjFvg6WhFTZXApEYgkqIGGNsSztH4KTK/ZBWfiC
         Egwl0yab7mras7k/tHZirYZFnwqoYhjiV6BtvzEcHRgJE5Pcl/jDXcCz322XftUQ8NnP
         aAuQ==
X-Gm-Message-State: APjAAAWLmvFTJhlmvDRwBAUuOwgwKEVjRqev2sXEuPUEUQoO0y56iyMY
        42KsZSMzxiBttIkmtiNAmd6LP9Xx8bm0rAiq
X-Google-Smtp-Source: APXvYqzJU5TQAoSpS0htblZXsf3FjM/E+GXif2igGH4hvMNEEyJXqpxWT6wWXUNXxiCSm0L5NBeAxg==
X-Received: by 2002:a7b:cd13:: with SMTP id f19mr10003555wmj.101.1574413195764;
        Fri, 22 Nov 2019 00:59:55 -0800 (PST)
Received: from MacBook-Pro.gnusmas ([194.62.217.57])
        by smtp.gmail.com with ESMTPSA id f19sm7406825wrf.23.2019.11.22.00.59.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Nov 2019 00:59:55 -0800 (PST)
From:   =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>
To:     jaegeuk@kernel.org, yuchao0@huawei.com
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, damien.lemoal@wdc.com,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>
Subject: [PATCH] f2fs: disble physical prealloc in LSF mount
Date:   Fri, 22 Nov 2019 09:59:52 +0100
Message-Id: <20191122085952.12754-1-javier@javigon.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Javier González <javier.gonz@samsung.com>

Fix file system corruption when using LFS mount (e.g., in zoned
devices). Seems like the fallback into buffered I/O creates an
inconsistency if the application is assuming both read and write DIO. I
can easily reproduce a corruption with a simple RocksDB test.

Might be that the f2fs_forced_buffered_io path brings some problems too,
but I have not seen other failures besides this one.

Problem reproducible without a zoned block device, simply by forcing
LFS mount:

  $ sudo mkfs.f2fs -f -m /dev/nvme0n1
  $ sudo mount /dev/nvme0n1 /mnt/f2fs
  $ sudo  /opt/rocksdb/db_bench  --benchmarks=fillseq --use_existing_db=0
  --use_direct_reads=true --use_direct_io_for_flush_and_compaction=true
  --db=/mnt/f2fs --num=5000 --value_size=1048576 --verify_checksum=1
  --block_size=65536

Note that the options that cause the problem are:
  --use_direct_reads=true --use_direct_io_for_flush_and_compaction=true

Fixes: f9d6d0597698 ("f2fs: fix out-place-update DIO write")

Signed-off-by: Javier González <javier.gonz@samsung.com>
---
 fs/f2fs/data.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 5755e897a5f0..b045dd6ab632 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1081,9 +1081,6 @@ int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
 			return err;
 	}
 
-	if (direct_io && allow_outplace_dio(inode, iocb, from))
-		return 0;
-
 	if (is_inode_flag_set(inode, FI_NO_PREALLOC))
 		return 0;
 
-- 
2.17.1

