Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5386CC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 19:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 291EA207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 19:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOTUID1k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbgAFTTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 14:19:38 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38339 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgAFTTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 14:19:16 -0500
Received: by mail-wm1-f67.google.com with SMTP id u2so16507325wmc.3;
        Mon, 06 Jan 2020 11:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BiVSGDhREaUEf54KgSEKmOQyVoop478wRSm340p5AAw=;
        b=BOTUID1kNmUCME5BD87r2im56ctjTtka/2HhskCJDunHZeZI7kNgTLVEDOQek4wdAd
         e2T7n3J46OI4j8w/D2sHdBVv6H1x+cTpmtItSeMsf54y4qukPrNg+DEk7SI08ts/4lwr
         seAMw9zeK/Z5VedOjOGZl3T43528TObl77mXdbe8+J/QEGzlxQAWui/KAgNYIHWTB1JS
         HWgBWDlTnxlgCY0Qr7YQT1J2AniF3Ilrw0im/pugKz5TQs9XEPztWakx23HOj5g468xu
         3WD84iFYHGmf4y34rhut8F3bfHR/tVsOFg1ocd5qvblzk82iy1zXHloPe1l4t2uNRTsa
         B8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BiVSGDhREaUEf54KgSEKmOQyVoop478wRSm340p5AAw=;
        b=Nw1JbtIVgSEr0mEbforfGPfRXwJuoKjP/0EYqtrIg5wv5NU956zc1q73ODMzjtF/s/
         eoP0uLk/Ja9fpCFzxN0uZRhaFmLdhZ8f2Xc0m+H/jTrMSvizpmmJFtwQKmmPvWO0IKo9
         i10m8rpvc8szpgfO0zFSm/9Bf5J+kKUH+3u1GmSDzxWbMJ4JhNcyjrocLb+s0n5HDA48
         UZdbekE3VyNmCSUUtq9opHX9D0InheJL4qWeTtKXJVsdjJLl5yHubNlYAInXpnF7EhAR
         /3o0Phz+nOszg7iF1LLx21nIxLLkrgrW5n8KlfHynT00ivmsf9stvgNoBudfdiZUUMKv
         z6RQ==
X-Gm-Message-State: APjAAAUGKyGuiOn8I9hzCtJIpHJA2V9QB/Znz9LCvSw/BJG3coQEleZa
        uTpFMkRJYtRqRQhalJzKtLe2L7sv
X-Google-Smtp-Source: APXvYqy1wTq4hJotlXKxiQu+cXtwGmQzU4XCYLcRdisOuXwT4/BrV8lTguH2yCMaqCd9xrSFoWJEFA==
X-Received: by 2002:a1c:7901:: with SMTP id l1mr35233423wme.67.1578338354811;
        Mon, 06 Jan 2020 11:19:14 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:74f9:b588:decc:794d])
        by smtp.gmail.com with ESMTPSA id o4sm72041756wrx.25.2020.01.06.11.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 11:19:14 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     paulmck@kernel.org
Cc:     corbet@lwn.net, rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, madhuparnabhowmik04@gmail.com,
        sj38.park@gmail.com, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH v2 4/7] doc/RCU/rcu: Use ':ref:' for links to other docs
Date:   Mon,  6 Jan 2020 20:18:49 +0100
Message-Id: <20200106191852.22973-5-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106191852.22973-1-sjpark@amazon.de>
References: <20200106191852.22973-1-sjpark@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 Documentation/RCU/rcu.rst | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/RCU/rcu.rst b/Documentation/RCU/rcu.rst
index 8dfb437dacc3..a1dd71d01862 100644
--- a/Documentation/RCU/rcu.rst
+++ b/Documentation/RCU/rcu.rst
@@ -11,8 +11,8 @@ must be long enough that any readers accessing the item being deleted have
 since dropped their references.  For example, an RCU-protected deletion
 from a linked list would first remove the item from the list, wait for
 a grace period to elapse, then free the element.  See the
-Documentation/RCU/listRCU.rst file for more information on using RCU with
-linked lists.
+:ref:`Documentation/RCU/listRCU.rst <list_rcu_doc>` for more information on
+using RCU with linked lists.
 
 Frequently Asked Questions
 --------------------------
@@ -50,7 +50,7 @@ Frequently Asked Questions
 - If I am running on a uniprocessor kernel, which can only do one
   thing at a time, why should I wait for a grace period?
 
-  See the Documentation/RCU/UP.rst file for more information.
+  See :ref:`Documentation/RCU/UP.rst <up_doc>` for more information.
 
 - How can I see where RCU is currently used in the Linux kernel?
 
@@ -68,9 +68,9 @@ Frequently Asked Questions
 
 - Why the name "RCU"?
 
-  "RCU" stands for "read-copy update".  The file Documentation/RCU/listRCU.rst
-  has more information on where this name came from, search for
-  "read-copy update" to find it.
+  "RCU" stands for "read-copy update".
+  :ref:`Documentation/RCU/listRCU.rst <list_rcu_doc>` has more information on where
+  this name came from, search for "read-copy update" to find it.
 
 - I hear that RCU is patented?  What is with that?
 
-- 
2.17.1

