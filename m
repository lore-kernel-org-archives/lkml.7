Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241BBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 08:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2D72184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 08:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="kS2EueFz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfCNINQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 04:13:16 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:43910 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfCNINO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 04:13:14 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 1C71571D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 08:13:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6cY6mDvKlPLX for <linux-kernel@vger.kernel.org>;
        Thu, 14 Mar 2019 03:13:13 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id E07936C0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 03:13:12 -0500 (CDT)
Received: by mail-io1-f69.google.com with SMTP id a9so3711183iol.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 01:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SElI6m5e00A1NPP8AKqKf6Qas4qlMROeovLlOxjk3bo=;
        b=kS2EueFzs0+HOgcKzlHjWWi1Pat6HCleHqp6JS6om9IatI15wFbvKv/9Tbh7RFRd5D
         IZSk27mlIf9+t+QI4jHvUpnyfs8zDikj4WRqpOqBhAdUJa6e80JrKeJB5poNFm8cxwQM
         pcKFwkaN/Y7sFD7C2F+XyLa6qC2U35wgrbiFJSHTaJkebRlQO5yOdGsdWq/k+hmtf61E
         ntXZGUmbAKmmUKo1xPJkWGrbuUKwMl7u94ZEklhEwRVUUyv1aBoRVDFj1cKsa877Mj/V
         E4GwaWioVZvRSF7Hy/kUcmi1OMON+8Ymnpfu0H2AJKXBfNmX8mXF5q2c1EZHSccUMIEt
         C8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SElI6m5e00A1NPP8AKqKf6Qas4qlMROeovLlOxjk3bo=;
        b=G+3IEq9do5fSP2k+vfIqOk+MMxsMbzZAhwOpUivm+Xi1Xrt3v9enGM1jH/1445pZtJ
         32nFAQ/8xNBAbkCWoDEpEUeUEIz8fR/uExohazqWUb7kTzR6V1RBjbw62fptE1jz6frS
         Bko5uHFrYZfBOK5EbRihU7RX+f49GaZIHb39AT8jnciYIe87fmzDwerJC2uXosKDz6wG
         28E3WdIGRtSnx8wpdUCnlSYBzjjmYJHggV1K/bVMXNSEr2RrPlHZk50xOa3AAx3aKuaj
         rwqidWfq8r4ahms5BfqMke17eARNRq8vHabY6aF3DiK9geuodo0UCiuzzmCgChzPDbWx
         lu5Q==
X-Gm-Message-State: APjAAAUoJuMzhorR+gtBwGmMJGFZHMywFjaDRNHAups+BCEXA9MJX8eZ
        G40LT9NrORuthfXBLQjK//uNmyGqL+Wm3/wNN3w4e2ASo1TBqZSv+3A22k609H53hrV7oRndgrg
        k94V4JSk33M7F9hx6tURHyg9IXhQb
X-Received: by 2002:a24:2a88:: with SMTP id w130mr1226299itw.95.1552551192049;
        Thu, 14 Mar 2019 01:13:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwL0NZSm/Pb5W3j99/lYGM73qdZBwKCtLfcEIeEGTHRNTDZytsRp5yJQfL21Zo7QkYGkxEWGA==
X-Received: by 2002:a24:2a88:: with SMTP id w130mr1226285itw.95.1552551191811;
        Thu, 14 Mar 2019 01:13:11 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id x25sm6272745ion.78.2019.03.14.01.13.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 01:13:11 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] btrfs: fix a NULL pointer dereference
Date:   Thu, 14 Mar 2019 03:13:04 -0500
Message-Id: <20190314081304.469-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <fcdf722f-d128-03c0-99fb-a220f680193c@suse.com>
References: <fcdf722f-d128-03c0-99fb-a220f680193c@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

btrfs_lookup_block_group may fail and return NULL. The fix uses
assert to ensure cache is not NULL.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>

---
V2: use assert as suggested by Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/extent-tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 994f0cc41799..80d7c272d282 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -7303,6 +7303,7 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 
 		pin = 0;
 		cache = btrfs_lookup_block_group(fs_info, buf->start);
+		ASSERT(cache);
 
 		if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN)) {
 			pin_down_extent(fs_info, cache, buf->start,
-- 
2.17.1

