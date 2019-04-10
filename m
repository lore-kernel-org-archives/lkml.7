Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA77C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D4B20820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b="O/25pqCH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfDJWlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 18:41:01 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38073 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfDJWlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 18:41:01 -0400
Received: by mail-wr1-f66.google.com with SMTP id k11so4782409wro.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 15:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kragniz.eu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lQG5/tXvzBGNkqHlPz5Vc7T5e7qLQSkm2WFhbrJXDCI=;
        b=O/25pqCHwPsg/f9zqw8+8GM20BHclNVRLLBLQEe8BW1acj4vLf7CmBpSa4yUCM+8pz
         HzpcpBsScr6AVPZ9ZTYnWiRfMGe7fr78SQ+VLMRE2QOaAqzzs+b0eujLiDs1CEf8iRwz
         QeHkn16TGWjzbdiWErPEKVpCsljYgNuVtNZ2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lQG5/tXvzBGNkqHlPz5Vc7T5e7qLQSkm2WFhbrJXDCI=;
        b=r/XeAhZLo2ARkeiuePNbXb6BVZRs5j8OldzeEXSSVxOITZsPMRjWl832zfWliDGyrf
         aV35P67LbN3BqUWAOU4N49mu1QDZ0H2wOIEKAZtmsY31KQZnc3Iic0rL9H7KIt1AVx7w
         YKkCy9s6tSc2dhnWv8JmSvm4SoFgfAk6NI9+lwGlRpwoeOYJyH3Nsmu37e135Q0OCn/H
         gP6J3t4/z9tHSoALsqv6eGoXtqy99EdBNi5jM3olwsYwnPdNlaYJGgkAUWsn/WD2C8VW
         UElVJt3fYZKbGm+cJ6bFh2CNoQ/7IJDo4pu7bUbEGKeGHQ7bC3wqd9qPjrxWo0x2FMBr
         p21g==
X-Gm-Message-State: APjAAAWqh55VjmrLEPL7HWuaCHVGsuNLBAJ9zQ91REiVAN7JuJhu60Gb
        EJwShy8N9SmdXpinKqPnaj3xag==
X-Google-Smtp-Source: APXvYqzLwP7/K5coJ6txOBpJdXM5FVmtt3dLGWiYv8z18yhwwOqSQUdFCea3MpkBfEqvF0oVcOtlKA==
X-Received: by 2002:adf:f78c:: with SMTP id q12mr7659921wrp.172.1554936059680;
        Wed, 10 Apr 2019 15:40:59 -0700 (PDT)
Received: from localhost.localdomain ([95.149.160.82])
        by smtp.gmail.com with ESMTPSA id v16sm67989286wro.48.2019.04.10.15.40.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 15:40:58 -0700 (PDT)
From:   Louis Taylor <louis@kragniz.eu>
To:     dhowells@redhat.com
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, Louis Taylor <louis@kragniz.eu>
Subject: [PATCH v2] afs: use correct format characters
Date:   Wed, 10 Apr 2019 23:41:24 +0100
Message-Id: <20190410224124.6901-1-louis@kragniz.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190410220301.2332-1-louis@kragniz.eu>
References: <20190410220301.2332-1-louis@kragniz.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling with -Wformat, clang warns:

fs/afs/flock.c:632:29: warning: format specifies type 'short' but the argument has type
      'unsigned char' [-Wformat]
        _leave(" = %d [%hd]", ret, fl->fl_type);
                       ~~~         ^~~~~~~~~~~

fs/afs/dir.c:138:11: warning: format specifies type 'unsigned short' but
the argument has type 'int' [-Wformat]
       ntohs(dbuf->blocks[tmp].hdr.magic));
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

fl_type is declared as an unsigned char unconditionally in
include/linux/fs.h, so use the correct format characters.

Link: https://github.com/ClangBuiltLinux/linux/issues/378
Signed-off-by: Louis Taylor <louis@kragniz.eu>
---
 fs/afs/dir.c   | 2 +-
 fs/afs/flock.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 8a2562e3a316..4ceaec94e9c5 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -133,7 +133,7 @@ static bool afs_dir_check_page(struct afs_vnode *dvnode, struct page *page,
 	dbuf = kmap(page);
 	for (tmp = 0; tmp < qty; tmp++) {
 		if (dbuf->blocks[tmp].hdr.magic != AFS_DIR_MAGIC) {
-			printk("kAFS: %s(%lx): bad magic %d/%d is %04hx\n",
+			printk("kAFS: %s(%lx): bad magic %d/%d is %04x\n",
 			       __func__, dvnode->vfs_inode.i_ino, tmp, qty,
 			       ntohs(dbuf->blocks[tmp].hdr.magic));
 			trace_afs_dir_check_failed(dvnode, off, i_size);
diff --git a/fs/afs/flock.c b/fs/afs/flock.c
index 6a0174258382..be4c3f6a3178 100644
--- a/fs/afs/flock.c
+++ b/fs/afs/flock.c
@@ -629,7 +629,7 @@ static int afs_do_getlk(struct file *file, struct file_lock *fl)
 
 	ret = 0;
 error:
-	_leave(" = %d [%hd]", ret, fl->fl_type);
+	_leave(" = %d [%hhu]", ret, fl->fl_type);
 	return ret;
 }
 
-- 
2.21.0

