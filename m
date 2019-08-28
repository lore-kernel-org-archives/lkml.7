Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9929BC3A5A6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7133922DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="LdiAWQz8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfH1Kce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:32:34 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44265 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbfH1Kcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:32:33 -0400
Received: by mail-ed1-f66.google.com with SMTP id a21so2399070edt.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 03:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=42lKVdjnjP4y6DAxlLSWlI9cd0CLM9DFEKL56/c6DVw=;
        b=LdiAWQz8Af5L8jx+Wh3U4VqhqVfqQ2nc41g+8FcxYVXCVZgUhXbvRt4IkV8itEgTBW
         gWFgViHvq+lZ9XXK7aoa9BEnyC+qauttQ/X34wCpfVIVMgf96bcioED+1DFVG6apguD4
         AVpgddIDLb87Or3hp/EnVICZa3P1EsEx1sabaUWZQqJksQ1jHVZhpmquwmb10/Rhj/N8
         tJ7arB02huszVrlcJtqiyIwF10FNfBxFNJSk26FXUdsPlH9Y/qsezyKWZXQ+2yLEYH8H
         DdVYHdquI9Xu/lcf9SDLdVl9EFm8NhN5j4WM+wbL0e6zvmN0lUjIus1My77l9d9ihuhD
         QpEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=42lKVdjnjP4y6DAxlLSWlI9cd0CLM9DFEKL56/c6DVw=;
        b=nA68B1V0QIYAhbYJy1j6BB99bOJtGep1Mpgif1V7SvKUEhw8qVdFMuHNudOr3/9+uc
         v4qJFpVvw0i2av7Ygf6+dm7t0tHaFXCGGVBtqKshPMC0V54enMuM2Q+H422k1spNhbWO
         11D+xeZBxJj/r/dfpeLI6EsVV1fdtuCc4O5XFIRg975b9ux+iswzv6Tihmwi7nnORfWx
         POu1XHF//vBVLRL3to03j8dOSp1MDox0avnGFuptkhp5GVkMZbndhEFdLmIfY2UddKGU
         63uuriUMMg+vT5Ic6To0f2SZqkYyDW5Eo1p66ssrWj4xKtPLTqyONvWqu3RwrBOTbpYk
         zzLQ==
X-Gm-Message-State: APjAAAVX2WxUwU+zI0ejVBM8KygA8D3VB1l2HWca7KvaMu39/eo4OzVk
        63Vz63t40X4NPDJnNFmELK1a8A==
X-Google-Smtp-Source: APXvYqxtYAhqfsawL7tpy/qloMqvOXRgeb+f/jy3T/I1yom2OrgxLgDW7GEBfCJaXBk5T0R3jZNceg==
X-Received: by 2002:a17:906:1944:: with SMTP id b4mr2528225eje.44.1566988351953;
        Wed, 28 Aug 2019 03:32:31 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id z9sm366543edr.54.2019.08.28.03.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 03:32:31 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundatio.org, kernel-team@android.com,
        narayan@google.com, dariofreni@google.com, ioffe@google.com,
        jiyong@google.com, maco@google.com,
        Martijn Coenen <maco@android.com>
Subject: [PATCH] loop: change queue block size to match when using DIO.
Date:   Wed, 28 Aug 2019 12:32:29 +0200
Message-Id: <20190828103229.191853-1-maco@android.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The loop driver assumes that if the passed in fd is opened with
O_DIRECT, the caller wants to use direct I/O on the loop device.
However, if the underlying filesystem has a different block size than
the loop block queue, direct I/O can't be enabled. Instead of requiring
userspace to manually change the blocksize and re-enable direct I/O,
just change the queue block size to match.

Signed-off-by: Martijn Coenen <maco@android.com>
---
 drivers/block/loop.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index ab7ca5989097a..1138162ff6c4d 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -994,6 +994,12 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	if (!(lo_flags & LO_FLAGS_READ_ONLY) && file->f_op->fsync)
 		blk_queue_write_cache(lo->lo_queue, true, false);
 
+	if (io_is_direct(lo->lo_backing_file) && inode->i_sb->s_bdev) {
+		/* In case of direct I/O, match underlying block size */
+		blk_queue_logical_block_size(lo->lo_queue,
+				bdev_logical_block_size(inode->i_sb->s_bdev));
+	}
+
 	loop_update_rotational(lo);
 	loop_update_dio(lo);
 	set_capacity(lo->lo_disk, size);
-- 
2.23.0.187.g17f5b7556c-goog

