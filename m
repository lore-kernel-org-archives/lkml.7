Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7873C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 02:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F7921655
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 02:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nkub5Vvu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729902AbfD3CKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 22:10:21 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38503 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbfD3CKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 22:10:21 -0400
Received: by mail-ed1-f67.google.com with SMTP id w11so4147627edl.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 19:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o3WWnlW4MRHlRUIjLliUfdlV+X8N+PBcU00t4S/qq+k=;
        b=Nkub5VvunDX3oygwdkrT0Num7DhRohElM9ScJixU6FRsrOiNzKltAmIL8/5TKDrjwA
         JetuTPszU8XpZUIvFldDh103U8wFt3LjL/NhIAJxmyhIbM+Wmx98NbHap/nncpVBzZtR
         gZZVH1ZTnT4M6RYJh/tFqti+PDTCezfyalPWUqJcdxAr/Zt7sOUbOxkbVh185N65EhFQ
         lkk1F6L9gv+Nfq+fTAipSd5+feVhnz03yRgdHHJpmQIzD6gYn5wwIp4acxVU4wmVZMKW
         hOzl6jPC6gcxMjMauxmdePvw0FRxsjOW/ZpXICMrQWqVicDWjv47WL1TbornkTWA3s7N
         jMvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o3WWnlW4MRHlRUIjLliUfdlV+X8N+PBcU00t4S/qq+k=;
        b=dr9feW7ezG9PG++fM4OjCFtWjTxL62v+WkpPYq8ZBkKRG8kEkluJZ+8uZ8Brw6yhMB
         y6loVmsa+ieBlgHl9F9RjJLmSfG+1ON+ZDTcNekmfL3iTZb83ppiRqwCB5HUfXcZYofX
         YbsDRqRZeH+s/sE17ScQgZzySevMLjLsgFOQcD1kZs7RshrOOaFFW5+tz9Xux95meQSN
         X7mUfSRWRQg4UbTOJXaPfUkwEjJ/ySxkdLtz1kYMqC0nX3JITHAy7fhXPx9fZPFtKfuq
         +2zl6kREzui739HJYA4nfZr7A/n4NYc8fFGWuvEgtO5fqfzRHqy6EdeOZM7YDGYQypIH
         p9hg==
X-Gm-Message-State: APjAAAWHotw/wQFQO4Xm3oWhbvYqmt4+ZJ7S6XC5Tt15qIbZw7uUpjDP
        a0YiXhEW4rxHj0FvvD/B6lo=
X-Google-Smtp-Source: APXvYqwsnp+fG3RX1ErO00dwIoXW2/fQzV+CNFMXWPamoghLI6TjxloobzSzWt4cItU1LlZYbyw1iQ==
X-Received: by 2002:a50:90db:: with SMTP id d27mr2493360eda.50.1556590219009;
        Mon, 29 Apr 2019 19:10:19 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2b:2b84::2])
        by smtp.gmail.com with ESMTPSA id w40sm6062863edb.50.2019.04.29.19.10.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 19:10:18 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] dm dust: Convert an 'else if' into an 'else' in dust_map
Date:   Mon, 29 Apr 2019 19:10:10 -0700
Message-Id: <20190430021010.25151-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with -Wsometimes-uninitialized, Clang warns:

drivers/md/dm-dust.c:216:11: warning: variable 'ret' is used
uninitialized whenever 'if' condition is false
[-Wsometimes-uninitialized]
        else if (bio_data_dir(bio) == WRITE)
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/bio.h:69:2: note: expanded from macro 'bio_data_dir'
        (op_is_write(bio_op(bio)) ? WRITE : READ)
        ^
drivers/md/dm-dust.c:219:9: note: uninitialized use occurs here
        return ret;
               ^~~
drivers/md/dm-dust.c:216:7: note: remove the 'if' if its condition is
always true
        else if (bio_data_dir(bio) == WRITE)
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/md/dm-dust.c:209:9: note: initialize the variable 'ret' to
silence this warning
        int ret;
               ^
                = 0
1 warning generated.

It isn't wrong; however, bio_data_dir will only ever return READ and
WRITE so the second 'else if' can really become an 'else' to silence
this warning and not change the final meaning of the code.

Link: https://github.com/ClangBuiltLinux/linux/issues/462
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/md/dm-dust.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-dust.c b/drivers/md/dm-dust.c
index 997830984893..5baeb56679ed 100644
--- a/drivers/md/dm-dust.c
+++ b/drivers/md/dm-dust.c
@@ -213,7 +213,7 @@ static int dust_map(struct dm_target *ti, struct bio *bio)
 
 	if (bio_data_dir(bio) == READ)
 		ret = dust_map_read(dd, bio->bi_iter.bi_sector, dd->fail_read_on_bb);
-	else if (bio_data_dir(bio) == WRITE)
+	else
 		ret = dust_map_write(dd, bio->bi_iter.bi_sector, dd->fail_read_on_bb);
 
 	return ret;
-- 
2.21.0

