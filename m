Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C75C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 01:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 742E62171F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 01:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eltNGhHd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730961AbfG3Buw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 21:50:52 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36624 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730918AbfG3Bul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 21:50:41 -0400
Received: by mail-pl1-f193.google.com with SMTP id k8so28231701plt.3;
        Mon, 29 Jul 2019 18:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B53kfNAL5bPehU6SpckbeuA1BwDTxczPn/Y5JPnbD6I=;
        b=eltNGhHdxejXM79qXFqifZMz3c9fD/tHWJqdYrJnjpWpRXTApoIF6g3lgi8ELjYpkm
         WuD26NHfwxy2wLBeTgJHcAw5qX6l1WaxdGOZupq1cjJ6QHBlqGIyuz20MTzaO5M3PTin
         G8jAkZ36iwHdVjHvXowRGWPGjBqjXCALDnj1IDslzPEUwXWSyiLjgFI8xgGOBtglRzBM
         VndPR4HjWJMnQZKKn5dX3CPnddEaxI0TNj8m4dANAY5db6oTtrPvlAAltRadS9wZ7jwN
         kdwxg9HM3PF39JUUhGkmI5Ul8vcYxCfuVZCOXbAJOH4tAVZZArwflc5KsohHLjSuLpVp
         5Crg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B53kfNAL5bPehU6SpckbeuA1BwDTxczPn/Y5JPnbD6I=;
        b=ejau2OOcjCEtEYmnpVsBnndw2KLoeXbQY7GoRV8JX07d7yPdIL9u9RFNlgbIf6m2hJ
         UOz26O3321H24MlJl/N6RLMXhMEUVrzV5Oa+nEQZfDmXZnhk9xQ3tW1RdU37X2LyEQv2
         iaypv32jcsZUyrkY7R04Sq9fVjLCATsKcxYr7mIJE8Bb3fHGBVLibk4ZEppmCIN7Po6U
         QlpT9Iubd0+7+xY7oaR3R0rIC4sbNywgSQSCHdQWaU6SzprjqU7kjy5xtiQkwdeYeGJs
         Css7RHLDPD8NTwldnq1wUUdsAKtR6NpxDDlARX1MDla78fM2z0RuZxsJkVQekvYOrejl
         APfA==
X-Gm-Message-State: APjAAAVgT56f0Ai0PguXo9gmQ1+OjZTVSB8bL95HVsRehFf0SiagkFP9
        j9Q9OUaA9MfrlJyTKMngIDo=
X-Google-Smtp-Source: APXvYqzBrmFYzI1gA3MEAy0sqbGPWC4ZXkGLgmkSkfkzYyNBaIrlOjsnhxJve8s7Brg31n/F6xooVw==
X-Received: by 2002:a17:902:2d01:: with SMTP id o1mr115526266plb.105.1564451440882;
        Mon, 29 Jul 2019 18:50:40 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id r6sm138807156pjb.22.2019.07.29.18.50.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 18:50:40 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, arnd@arndb.de,
        y2038@lists.linaro.org
Subject: [PATCH 20/20] isofs: Initialize filesystem timestamp ranges
Date:   Mon, 29 Jul 2019 18:49:24 -0700
Message-Id: <20190730014924.2193-21-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190730014924.2193-1-deepa.kernel@gmail.com>
References: <20190730014924.2193-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fill in the appropriate limits to avoid inconsistencies
in the vfs cached inode times when timestamps are
outside the permitted range.

Reference: http://www.ecma-international.org/publications/standards/Ecma-119.htm

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 fs/isofs/inode.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 9e30d8703735..62c0462dc89f 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -30,6 +30,9 @@
 #include "isofs.h"
 #include "zisofs.h"
 
+/* max tz offset is 13 hours */
+#define MAX_TZ_OFFSET (52*15*60)
+
 #define BEQUIET
 
 static int isofs_hashi(const struct dentry *parent, struct qstr *qstr);
@@ -801,6 +804,10 @@ static int isofs_fill_super(struct super_block *s, void *data, int silent)
 	 */
 	s->s_maxbytes = 0x80000000000LL;
 
+	/* ECMA-119 timestamp from 1900/1/1 with tz offset */
+	s->s_time_min = mktime64(1900, 1, 1, 0, 0, 0) - MAX_TZ_OFFSET;
+	s->s_time_max = mktime64(U8_MAX+1900, 12, 31, 23, 59, 59) + MAX_TZ_OFFSET;
+
 	/* Set this for reference. Its not currently used except on write
 	   which we don't have .. */
 
-- 
2.17.1

