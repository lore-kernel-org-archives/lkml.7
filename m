Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45896C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AECB2467A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOXT3yov"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgAFUIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 15:08:43 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40305 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgAFUIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 15:08:31 -0500
Received: by mail-wm1-f66.google.com with SMTP id t14so16673839wmi.5;
        Mon, 06 Jan 2020 12:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V2G0IIz6PcMHsLxOWfvVq8qGDWQifeiMnhGJx0KlTEE=;
        b=YOXT3yovpoJFTNZsSmaqcYcMr1yKZGJd3CMYIJI9egb7j8h423mZ2aE4iBV9MVGKS7
         jyXeT01EoIiruMT4z5ceC3EtXX0vsZ4DC3NeB2WPqyAIjahdVLRSnJuQVf610J69FN4H
         84JY61Joh+hnocDTj7fOTJOh8YhJ/81FwfhCppgxZTH2t4/SKEZ883P1F8pnNfNL4jAv
         aWVo27y9gqodlnlXD5FomrRoxf1oduSyIMPBSzWbYi16/olWdh5cXjzuN493gCnBmZek
         pR2DTx1gzGZ8k7UAiJR+lt4vXfX24QUGF0AeujwaV8NLah+jw1zNNsxEATq36qJVTRsT
         I+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V2G0IIz6PcMHsLxOWfvVq8qGDWQifeiMnhGJx0KlTEE=;
        b=CWwL4tKWeUWcNK3GNQflMp7gY3vcgd0Pd6Vf1nR8tOjjqzaqdVplT5CGzxRy1LGVru
         UmG8k0peOmxI81N4eelxpXUuZD6sd41Rwhudq8tq0juglT9Oi7bnC8GAXDqzWfa0aW8t
         mevlE1+3t2M/Aqsj7HSmdsoekZnbsQqC4sQzjW+l+9dUtDQ6AoVGt2EbS7ZOWt+DuPis
         CHlmIKfGt1xYV0cwmdDHHEAxfvuYu24DgQXnzHQGlMwRmpYMQ0npnEYf7V2rpBOlcCaw
         ClIqCRAETHgl285yg9O+hFvHUrsBEYvuT1AyzV68gfiEBX6WU84x15zrminwNIUe8Acm
         Y59Q==
X-Gm-Message-State: APjAAAW2DdAPx/mF55UlKTmLHpm/adCZHx4frXXlPEID0n4uAA3v74vl
        UyxRRW8GZiwbZQjosbs5s1M=
X-Google-Smtp-Source: APXvYqwdpG7YGEcjky/WWgXiQqp5C2OTSmCVZ9Sgtgz6vY61i2TrqNa0pCbQV7SibABgyryB126Wyw==
X-Received: by 2002:a7b:cc98:: with SMTP id p24mr34759447wma.139.1578341309009;
        Mon, 06 Jan 2020 12:08:29 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:74f9:b588:decc:794d])
        by smtp.gmail.com with ESMTPSA id t190sm23836982wmt.44.2020.01.06.12.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 12:08:28 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     paulmck@kernel.org
Cc:     corbet@lwn.net, madhuparnabhowmik04@gmail.com, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sjpark@amazon.de>
Subject: [PATCH v3 5/7] doc/RCU/rcu: Use absolute paths for non-rst files
Date:   Mon,  6 Jan 2020 21:08:00 +0100
Message-Id: <20200106200802.26994-6-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106200802.26994-1-sj38.park@gmail.com>
References: <20200106200802.26994-1-sj38.park@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 Documentation/RCU/rcu.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/RCU/rcu.rst b/Documentation/RCU/rcu.rst
index a1dd71d01862..2a830c51477e 100644
--- a/Documentation/RCU/rcu.rst
+++ b/Documentation/RCU/rcu.rst
@@ -75,7 +75,7 @@ Frequently Asked Questions
 - I hear that RCU is patented?  What is with that?
 
   Yes, it is.  There are several known patents related to RCU,
-  search for the string "Patent" in RTFP.txt to find them.
+  search for the string "Patent" in Documentation/RCU/RTFP.txt to find them.
   Of these, one was allowed to lapse by the assignee, and the
   others have been contributed to the Linux kernel under GPL.
   There are now also LGPL implementations of user-level RCU
@@ -88,5 +88,5 @@ Frequently Asked Questions
 
 - Where can I find more information on RCU?
 
-  See the RTFP.txt file in this directory.
+  See the Documentation/RCU/RTFP.txt file.
   Or point your browser at (http://www.rdrop.com/users/paulmck/RCU/).
-- 
2.17.1

