Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C286C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 04:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD290216F4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 04:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbfHTEob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 00:44:31 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:42485 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfHTEob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 00:44:31 -0400
Received: by mail-yw1-f65.google.com with SMTP id z63so1888561ywz.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 21:44:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=r71QpmjjYMneD14So1/FrWnFg6w/jYQUum7iTbCpFnc=;
        b=pmbBIdgBvXJh/LzamzcRicVnUnb/80ciU8vkeg542Gd6MgsONkNBv0zXMB/j89sW9K
         sgahVACGovfX+nOfyFtnZTJ7Yyb7e6RyJSB4STbtBLu1gLjksiipxCa+k3vsO9DWC5Ft
         Dt920FKfYUK7nkXWiPHFEqclXCEM79tlGRLf0+RzPjeTnoR73ctG+RfX6FJzIl2Fia5c
         W/7uQjZE6YsqL5d023Fy/jLZczbsn0GZIC2pNI9Ha8E4TKNLf2H6ZR75pytwKCzXwFEA
         9ZuM8cl+JzA/+wg02OhQeQzyylrAeQbn6rCECchlTCi5CyEtnfLYR/0inizThIMJ82R3
         oe6A==
X-Gm-Message-State: APjAAAXnQZIQtvPPujHhBxyCX9/LzWVb09gub677kOuiou1C1mdyPjVk
        xy84IAaNpnEd/BM7tfoLFvU=
X-Google-Smtp-Source: APXvYqwVS1H+5xxxJ90R2buxUAwKN9DaBncdTrg8AcfL+d8c4s6q0FgRlA9whCBe0putdAnNreqcWQ==
X-Received: by 2002:a0d:d557:: with SMTP id x84mr17497695ywd.455.1566276270669;
        Mon, 19 Aug 2019 21:44:30 -0700 (PDT)
Received: from localhost.localdomain (24-158-240-219.dhcp.smyr.ga.charter.com. [24.158.240.219])
        by smtp.gmail.com with ESMTPSA id z9sm3501119ywj.84.2019.08.19.21.44.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Aug 2019 21:44:29 -0700 (PDT)
From:   Wenwen Wang <wenwen@cs.uga.edu>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mtd@lists.infradead.org (open list:UBI FILE SYSTEM (UBIFS)),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ubifs: fix a memory leak bug
Date:   Mon, 19 Aug 2019 23:44:24 -0500
Message-Id: <1566276264-8942-1-git-send-email-wenwen@cs.uga.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ubifs_mount(), 'c' is allocated through kzalloc() in alloc_ubifs_info().
However, it is not deallocated in the following execution if
ubifs_fill_super() fails, leading to a memory leak bug. To fix this issue,
free 'c' before going to the 'out_deact' label.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 fs/ubifs/super.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 2c0803b..46e30e2 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -2252,8 +2252,10 @@ static struct dentry *ubifs_mount(struct file_system_type *fs_type, int flags,
 		}
 	} else {
 		err = ubifs_fill_super(sb, data, flags & SB_SILENT ? 1 : 0);
-		if (err)
+		if (err) {
+			kfree(c);
 			goto out_deact;
+		}
 		/* We do not support atime */
 		sb->s_flags |= SB_ACTIVE;
 		if (IS_ENABLED(CONFIG_UBIFS_ATIME_SUPPORT))
-- 
2.7.4

