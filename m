Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B5BC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 22:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4420920675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 22:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aa7OqwoB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfCGWLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 17:11:09 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39571 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfCGWLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 17:11:09 -0500
Received: by mail-ed1-f67.google.com with SMTP id p27so14807028edc.6;
        Thu, 07 Mar 2019 14:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TXb0s9/VA6uDrjEIjqzsVE7IYs9tLVulYfN8P5V0iLI=;
        b=aa7OqwoBj2RHugmTvRqNIv+wYV+9IVcdAEtwY7MLBh7tlDRkHMbDVGFGJIHfLkbu6v
         qptFYqmFtQgZ8Q6QDC59QlZ1a9S/WLHDx6nNWld3dI+gnIhN9rhQT+POlpFY2MDcQYc/
         wMpmo7+ZSdDeEhPdUG/I5BAFnoLxMSIgIR7b/VpTE2NH2s+Z6Ki7KUYdVsf/1MK+MwUU
         gLbJesovR4+RYFdm28MFrAEKLsZdXZUuSY8o9vnCAXCnIEGWROMpzg7Ycggz4bi+xu+m
         vMprnhhjlxRJ2ItgkcBauwpoz9E06nQ+ue8AMkx2oKchI0JPFI8eg0I+GbwCNc+SpB++
         7b3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TXb0s9/VA6uDrjEIjqzsVE7IYs9tLVulYfN8P5V0iLI=;
        b=NFs1+N/L+vJ0i5145B8GdEsIo/e2DZ1R/xaRgTMi09lURDflenvXVBK80nefR9Heb5
         O5E3Bgf8VaK9rrTNn3vY9ex7ODg6SInznvNaMMvenU1kumeG5/EN7m94sqonA6rj6TWw
         sfBbdxMNuzFQZK8EBYJDEt9nJvLoRONXjHMr5dpEprlfFGrSyqZuSyVSynBc0hpVsJT9
         jjKaBT9t/2J3ClDzzUd2dtSMh7QyBiWhvI4ixc3+XFRE515CJkf32avrqB7kogzsg0aE
         FP1/Xe4/MWBMR6GYiRPD06lHD5q9EXNIWsRMVmdGezdcAzJZ6LPO5ohlOz7dmWqQOiC8
         nNaQ==
X-Gm-Message-State: APjAAAU6s4VMLzpm+wGdPg3204qNbKLp+4ByuypglfPMth32N7KtqbUK
        HfJV7fTp2omKwRBTzvZ0zxE=
X-Google-Smtp-Source: APXvYqxOpn0PnfAMILcNUSR3uo3DT56bbTsi/NHLv8lSPsmFWAFn/bIrOgIu5W4I8TjMMrCwN68mTg==
X-Received: by 2002:a50:b3ad:: with SMTP id s42mr30244511edd.142.1551996667286;
        Thu, 07 Mar 2019 14:11:07 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id c50sm1688585edc.81.2019.03.07.14.11.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 14:11:06 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Coly Li <colyli@suse.de>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] bcache: Zero initialize bucket in bch_allocator_thread
Date:   Thu,  7 Mar 2019 15:10:54 -0700
Message-Id: <20190307221054.13126-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with -Wsometimes-uninitialized, Clang warns:

drivers/md/bcache/alloc.c:333:4: warning: variable 'bucket' is used
uninitialized whenever 'if' condition is false
[-Wsometimes-uninitialized]

fifo_pop expands to a conditional depending on '!fifo_empty(...)', which
is the same condition as the while loop. It seems Clang can't piece
together that this condition will never been false as long as we are in
the while loop because they are the same condition. It's easy enough to
silence this warning by just explicitly zero initializing bucket.

Link: https://github.com/ClangBuiltLinux/linux/issues/396
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/md/bcache/alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/bcache/alloc.c b/drivers/md/bcache/alloc.c
index 5002838ea476..c72094901ac6 100644
--- a/drivers/md/bcache/alloc.c
+++ b/drivers/md/bcache/alloc.c
@@ -328,7 +328,7 @@ static int bch_allocator_thread(void *arg)
 		 * the free list:
 		 */
 		while (!fifo_empty(&ca->free_inc)) {
-			long bucket;
+			long bucket = 0;
 
 			fifo_pop(&ca->free_inc, bucket);
 
-- 
2.21.0

