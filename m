Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DCEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 22:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C7E920896
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 22:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PkCJFz4g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731798AbfCZWFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 18:05:52 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:43784 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731483AbfCZWFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 18:05:52 -0400
Received: by mail-qk1-f201.google.com with SMTP id m8so12922855qka.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 15:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=5OS7MeeQZkVjDOMphKCQJrQLOTO9o+8UDZ4EUYnvOds=;
        b=PkCJFz4gIUUzxfFMy4dd9OumgOl5iHmWHQdrsah8NR6wKkHmArUqJsjoTnRlHoLjU9
         kZ1NHsaUAbUyuxT7QzvshppCC33sPT2qlAOinWw0eWFQzvgLDRodVsQ6vh4vPgimjjqL
         losIMDyUQN94ZsYUe3up5iCmUwZDBY6iMxBWuVI+DxaF3vpaG7X7GhpvyBDedC6clBPw
         AxY3tLUpMOJLrya+t3CW3BnWb+OTFHuItBmWBOnNER8Trsn0ednmN2Bvuu+3jJSSUhlQ
         2KAIaldNpXQ3iGxt3QxLCExUwR/slCPnslZNjXk/v27CrgcaRQJr5X3CvYxERlRIT8LF
         qN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=5OS7MeeQZkVjDOMphKCQJrQLOTO9o+8UDZ4EUYnvOds=;
        b=r1w5bejLosp1e4ZsX7r0T8Zko2D6Xincjs1gFbC1Sb6gm/VnYKpMSsHqipZHQgBhqj
         i5TxMQFlf7+3xHSqJUylDNJ7qTlFM2nNRWbqiSEDmaBkfjvR5ui5F/6Cvu5tfR2AOHWU
         GKTQaYvJFBEcnc3eWJCPNr/jOqerxq4xlS1fU7nTjpPHOGfK+4lJ1+w+/wBgZ5KKqZC2
         ASFm1BxhB5RdH8N0YoGBoMFpzmOdyz62lgd5jjsBXWcDTfzCdm+NBL4ysFV11/nGgm3P
         gfCqKtWErzZj4RhgJcAdBFTYaLmXJYzFawTzcSld7GIKRzB2KS4mZW4osQL6E8xb2k30
         ncnQ==
X-Gm-Message-State: APjAAAUSEMDXdcFImZAR0HhbMaM1Z2jgiQv8rcc7u0qwjcEK9M4hc72p
        5/3diB069mzmmbvtCVKqxv+phh853w==
X-Google-Smtp-Source: APXvYqx/cNkdwyZirz00IGu2ZgmtakS46fNpTZOT32zHCJpwPLUg87c4TuhXkaDGUy3yld7NLDF76nc2cw==
X-Received: by 2002:ac8:27a6:: with SMTP id w35mr27473970qtw.157.1553637951208;
 Tue, 26 Mar 2019 15:05:51 -0700 (PDT)
Date:   Tue, 26 Mar 2019 23:03:48 +0100
Message-Id: <20190326220348.61172-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH] floppy: fix usercopy direction
From:   Jann Horn <jannh@google.com>
To:     Jiri Kosina <jikos@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        jannh@google.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As sparse points out, these two copy_from_user() should actually be
copy_to_user().

Fixes: 229b53c9bf4e ("take floppy compat ioctls to sodding floppy.c")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
compile-tested only

 drivers/block/floppy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 95f608d1a098..8c641245ff12 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3749,7 +3749,7 @@ static int compat_getdrvprm(int drive,
 	v.native_format = UDP->native_format;
 	mutex_unlock(&floppy_mutex);
 
-	if (copy_from_user(arg, &v, sizeof(struct compat_floppy_drive_params)))
+	if (copy_to_user(arg, &v, sizeof(struct compat_floppy_drive_params)))
 		return -EFAULT;
 	return 0;
 }
@@ -3785,7 +3785,7 @@ static int compat_getdrvstat(int drive, bool poll,
 	v.bufblocks = UDRS->bufblocks;
 	mutex_unlock(&floppy_mutex);
 
-	if (copy_from_user(arg, &v, sizeof(struct compat_floppy_drive_struct)))
+	if (copy_to_user(arg, &v, sizeof(struct compat_floppy_drive_struct)))
 		return -EFAULT;
 	return 0;
 Eintr:
-- 
2.21.0.392.gf8f6787159e-goog

