Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43190C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 16:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 178362133D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 16:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kY+E5Qiu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390768AbfEXQPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 12:15:46 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44490 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389588AbfEXQPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 12:15:45 -0400
Received: by mail-ed1-f68.google.com with SMTP id b8so15081100edm.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 09:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xiom/qbhc8hzsnkXpNYZUpJBz12Ihudb7omPLvvxhj8=;
        b=kY+E5QiuzaCj1lGRZrWvzWlIc8/dOw5vf72u3ftpBv18Imso/xFk6x0/AyJdz0DyTA
         AWPbrxLmcaWnMK4Jzd0D4eI9reaHq7Y3lIptb3kt/PPctGb9lAR5khYhRboR9IoFz48b
         +FSeY0oBxlWeZryLjXQHxFgG2pMzS3v4439x/ADxoOTnZcgQ5W0spbP3oZUYPxWSWeI/
         lRX6t9zHJGZo1+l05wPc3hQm4T1Qs8O5jj9p4YAliOFsTFRIL7bwCK1myIoxAsMBZ0M9
         HIm/MSiTktQRB/aXE3J79srWkSOjrAlgK++yvYbAY8w2brUrvku3c7JKpd0ZGMAVgK4M
         9tcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xiom/qbhc8hzsnkXpNYZUpJBz12Ihudb7omPLvvxhj8=;
        b=pSO/72EIOQ5YNBV2KDmMshrjZWj2AkTNlmPXyPVt+oedao7PjW5uUFZ5gb43EB6MuL
         Vh9kBoIIiavXxngCuBhyjljc2Iqx/4yO8tJroysEKcZw23W6Z71tjHtsywxWFlNhF5vn
         PhjBYpse2NxpqC8Fsfs6wOBSy8wASarkbt+AK8vmW2qnkzztO96yE8typLyliChAfuRq
         xmQfQ75rf1DGx6uWY02MW/xZKtekAh9lIOFAVQ6HO+MbfiacVLP0gncRc2fYAXFQ9Utz
         YgIpEE5t9vstJz7tqARJTKUCPp4ooTiOWgxHimSi3leAO9RtaOjHjodivOFgaXPX8eGv
         Qa/A==
X-Gm-Message-State: APjAAAXhpWXF39gtLtK+jQfmmne86b5GVNFlAi2walL6st++vbNzKX2B
        lyl+R4LwfD6j85uZhhIUsJI=
X-Google-Smtp-Source: APXvYqwPMvsrTK7DMaHJWzPyB8e3YbMWUoWhnCCT9QLPYu2yG4stqlm1HrSUqH6pfYaXbPKCrw5iJw==
X-Received: by 2002:a17:906:cd08:: with SMTP id oz8mr37589909ejb.67.1558714543948;
        Fri, 24 May 2019 09:15:43 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id u5sm428197ejm.85.2019.05.24.09.15.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 09:15:42 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Cliff Whickman <cpw@sgi.com>, Robin Holt <robinmholt@gmail.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Stephen Hines <srhines@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH] misc: sgi-xp: Properly initialize buf in xpc_get_rsvd_page_pa
Date:   Fri, 24 May 2019 09:15:17 -0700
Message-Id: <20190524161517.125941-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.22.0.rc1
In-Reply-To: <20190524160015.GA7590@kroah.com>
References: <20190524160015.GA7590@kroah.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/misc/sgi-xp/xpc_partition.c:73:14: warning: variable 'buf' is
uninitialized when used within its own initialization [-Wuninitialized]
        void *buf = buf;
              ~~~   ^~~
1 warning generated.

Arnd's explanation during review:

  /*
   * Returns the physical address of the partition's reserved page through
   * an iterative number of calls.
   *
   * On first call, 'cookie' and 'len' should be set to 0, and 'addr'
   * set to the nasid of the partition whose reserved page's address is
   * being sought.
   * On subsequent calls, pass the values, that were passed back on the
   * previous call.
   *
   * While the return status equals SALRET_MORE_PASSES, keep calling
   * this function after first copying 'len' bytes starting at 'addr'
   * into 'buf'. Once the return status equals SALRET_OK, 'addr' will
   * be the physical address of the partition's reserved page. If the
   * return status equals neither of these, an error as occurred.
   */
  static inline s64
  sn_partition_reserved_page_pa(u64 buf, u64 *cookie, u64 *addr, u64 *len)

  so *len is set to zero on the first call and tells the bios how many
  bytes are accessible at 'buf', and it does get updated by the BIOS to
  tell us how many bytes it needs, and then we allocate that and try again.

Fixes: 279290294662 ("[IA64-SGI] cleanup the way XPC locates the reserved page")
Link: https://github.com/ClangBuiltLinux/linux/issues/466
Suggested-by: Stephen Hines <srhines@google.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/misc/sgi-xp/xpc_partition.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/sgi-xp/xpc_partition.c b/drivers/misc/sgi-xp/xpc_partition.c
index 3eba1c420cc0..782ce95d3f17 100644
--- a/drivers/misc/sgi-xp/xpc_partition.c
+++ b/drivers/misc/sgi-xp/xpc_partition.c
@@ -70,7 +70,7 @@ xpc_get_rsvd_page_pa(int nasid)
 	unsigned long rp_pa = nasid;	/* seed with nasid */
 	size_t len = 0;
 	size_t buf_len = 0;
-	void *buf = buf;
+	void *buf = NULL;
 	void *buf_base = NULL;
 	enum xp_retval (*get_partition_rsvd_page_pa)
 		(void *, u64 *, unsigned long *, size_t *) =
-- 
2.22.0.rc1

