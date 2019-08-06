Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645E4C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 17:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3980D20B1F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 17:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CZTMF4p4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730959AbfHFR7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 13:59:43 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45044 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfHFR7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 13:59:43 -0400
Received: by mail-pg1-f195.google.com with SMTP id i18so41990447pgl.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 10:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iGsntDZpOimrecz1+mcPXqzMsFWapOrrKVLJor/Xhk0=;
        b=CZTMF4p4qzDuGkqF4qaSCfhkMg2nUn1BP5BunO5paXaKilbH3bNH8CeI/5jC5zJHBc
         4GQAyYPa63FOXkGNgCgBhAF04B9+H2t7clpoN3/CUIXJlstIec6oOfzATE774zvoKbgw
         z9HkQ8A1YHBBUqCo9crJqRCSPvqPmywGpF3nc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iGsntDZpOimrecz1+mcPXqzMsFWapOrrKVLJor/Xhk0=;
        b=VsuBUcse+ApRS2VsWWGU+4Vx5zsW9Usen7w3F6GqSGtrP6jk3Ox+ISBs7UtyddnExH
         0w5JKgHEDpOd/xamjtTQzoOeope1qxrG34H3jHl45jfunqbtd1YckpirDflw5CLp47Co
         IK/hJnwVVfEWOsEmkfZe3sOcIreYZhv9yxnO4mi/n6DAPesZo5o5VHwV9UDHXweqsxs5
         zsNpZzkZNX0T+TU2ssrxgSOJ5GTtOyK/1PHBUmf0ERxAwKNXMPDaMidAt3T97U1CDB60
         l+0NwbdU75XOsWVJmItlRv/X1THZVAjhFIFlYC+Ed6z+vaNm7YpN9vTjc9f6uKRR8Qg3
         fagg==
X-Gm-Message-State: APjAAAX2q5qskyKYrWhrbFsYDaDWcEMEH5qQDwiLnznQ27BjU3WMg2zt
        Pyq4zXmrqlGzCaQGC339G8KEAA==
X-Google-Smtp-Source: APXvYqx/U4HYVbYf3P0ormkFK+H8jcLkKqwNe85vod3curm/4VtQFCmyXUWrWspLpRWyvPLKuR6xew==
X-Received: by 2002:a17:90a:32ec:: with SMTP id l99mr4480249pjb.44.1565114382119;
        Tue, 06 Aug 2019 10:59:42 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id x25sm118229090pfa.90.2019.08.06.10.59.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 10:59:41 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 4.19] Revert "initramfs: free initrd memory if opening /initrd.image fails"
Date:   Tue,  6 Aug 2019 10:59:40 -0700
Message-Id: <20190806175940.156412-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 25511676362d8f7d4b8805730a3d29484ceab1ec in the 4.19
stable trees. From what I can tell this commit doesn't do anything to
improve the situation, mostly just reordering code to call free_initrd()
from one place instead of many. In doing that, it causes free_initrd()
to be called even in the case when there isn't an initrd present. That
leads to virtual memory bugs that manifest on arm64 devices.

The fix has been merged upstream in commit 5d59aa8f9ce9 ("initramfs:
don't free a non-existent initrd"), but backporting that here is more
complicated because the patch is stacked upon this patch being reverted
along with more patches that rewrites the logic in this area.

Let's just revert the patch from the stable tree instead of trying to
backport a collection of fixes to get the final fix from upstream.

Cc: Sasha Levin <sashal@kernel.org>
Cc: Steven Price <steven.price@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

This patch is for 4.19 stable series.

 init/initramfs.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index cd5fb00fcb54..f6f4a1e4cd54 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -612,12 +612,13 @@ static int __init populate_rootfs(void)
 		printk(KERN_INFO "Trying to unpack rootfs image as initramfs...\n");
 		err = unpack_to_rootfs((char *)initrd_start,
 			initrd_end - initrd_start);
-		if (!err)
+		if (!err) {
+			free_initrd();
 			goto done;
-
-		clean_rootfs();
-		unpack_to_rootfs(__initramfs_start, __initramfs_size);
-
+		} else {
+			clean_rootfs();
+			unpack_to_rootfs(__initramfs_start, __initramfs_size);
+		}
 		printk(KERN_INFO "rootfs image is not initramfs (%s)"
 				"; looks like an initrd\n", err);
 		fd = ksys_open("/initrd.image",
@@ -631,6 +632,7 @@ static int __init populate_rootfs(void)
 				       written, initrd_end - initrd_start);
 
 			ksys_close(fd);
+			free_initrd();
 		}
 	done:
 		/* empty statement */;
@@ -640,9 +642,9 @@ static int __init populate_rootfs(void)
 			initrd_end - initrd_start);
 		if (err)
 			printk(KERN_EMERG "Initramfs unpacking failed: %s\n", err);
+		free_initrd();
 #endif
 	}
-	free_initrd();
 	flush_delayed_fput();
 	/*
 	 * Try loading default modules from initramfs.  This gives
-- 
Sent by a computer through tubes

