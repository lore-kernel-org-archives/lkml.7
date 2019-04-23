Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE3DC282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B4F217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kA8UUDwA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbfDWQSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:18:44 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45602 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728618AbfDWQSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:18:42 -0400
Received: by mail-pg1-f195.google.com with SMTP id y3so7838874pgk.12;
        Tue, 23 Apr 2019 09:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=GSv/lNk+cqbIXgSZ96lvblwQ8cpdLHfK+N8P3Q4pHOQ=;
        b=kA8UUDwAkrFY1VmNWIKvOo0XihlU5W9LhPC4hdsnB0kv5YI+W2cwCRR7SdiKpBc0B6
         h3UlUKAKnhgO33C+dC4j6q94CPQ2dqJ/SzYxQlxWj7jW+klThfeXvX3dlM0ZmXDEHeBY
         e1GV4Bisy3AIEWs+PrBhmziN7kYSobkjj0fVLlcOwyE0LITeiiafBbbiRryO6moLzBwQ
         NgnMxDnuU+2CMEOWCRsOoxP8mH/JtO2zSK6LpjVPDkqULZwwixYjw+jHAHRLgoksGoCB
         NjvjHBtw5gPLTJ7n/hQgf0W1mK1RtgnLODEVMWnB4ctyFxeVJB1UsizF0mYFFtnGe0JS
         zybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=GSv/lNk+cqbIXgSZ96lvblwQ8cpdLHfK+N8P3Q4pHOQ=;
        b=mPh0mJogVBGOB99EVPqVfT7pIM+rJG0OruR+1R3Wgwe5XY/GyXPLQofpZiOYHxaewx
         Z4zAIvgzf8fWabN3FbmEw+Z8LGVZTMTIg5Tqvbqkl+pUrhgoEbBBhxcaiIstCjPYz9Tv
         8wCtexlumiJQqJbVmwcUFGR45V8XHNOoQt7EV3uyOSqLyZeUu022wYGr5flDhALIAdHx
         gpmhXBRqB5+epdqFDpYKcHINaHX6Pkpev8mT7AtNsf3GUWDoKzXbVF9Pf09EgXKWrnQl
         48SI8Kdxatztx8THK739kmT125KW9ubKluMiboj351VE10WnUrgPLi/rsZSWXKM7leU2
         y78A==
X-Gm-Message-State: APjAAAWSz6NMD6+UbRd7dhJLVU6CRewXBN9FMUWxG2JhU0fCSy+2zJS7
        pFMTz49fUgKBdocKwmqaIBu6BU8k
X-Google-Smtp-Source: APXvYqwS1b59sQ6vMIoP37NlPnTs0mCmC2KgP8FmHZOjuGZ8TEN3oD/+yhUqBJ4MD9f58x506gH4Sg==
X-Received: by 2002:a63:fc0b:: with SMTP id j11mr25063113pgi.74.1556036321698;
        Tue, 23 Apr 2019 09:18:41 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.32])
        by smtp.gmail.com with ESMTPSA id n26sm29867525pfi.165.2019.04.23.09.18.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 09:18:41 -0700 (PDT)
Date:   Tue, 23 Apr 2019 21:48:31 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
        linux.bhar@gmail.com
Subject: [PATCH] reiserfs: Add comment to explain endianness issue in
 xattr_hash
Message-ID: <20190423161831.GA15387@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

csum_partial() gives different results for little-endian and big-endian
hosts. This causes images created on little-endian hosts and mounted on
big endian hosts to see csum mismatches. This causes an endianness bug.
Sparse gives a warning as csum_partial returns a restricted integer type
__wsum_t and xattr_hash expects __u32. This warning acts as a reminder
for this bug and should not be suppressed.

This comment aims to convey these endianness issues.

Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
---
 fs/reiserfs/xattr.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/reiserfs/xattr.c b/fs/reiserfs/xattr.c
index 32d8986..0ea6654 100644
--- a/fs/reiserfs/xattr.c
+++ b/fs/reiserfs/xattr.c
@@ -450,6 +450,16 @@ static struct page *reiserfs_get_page(struct inode *dir, size_t n)
 
 static inline __u32 xattr_hash(const char *msg, int len)
 {
+	/*
+	 * csum_partial() gives different results for little-endian and
+	 * big endian hosts. Images created on little-endian hosts and
+	 * mounted on big-endian hosts(and vice versa) will see csum mismatches
+	 * when trying to fetch xattrs. Treating the hash as __wsum_t would
+	 * lower the frequency of mismatch. This is an endianness bug in reiserfs.
+	 * The return statement would result in a sparse warning. Do not fix the sparse
+	 * warning so as to not hide the reminder of the bug.
+	 */
+
 	return csum_partial(msg, len, 0);
 }
 
-- 
2.7.4

