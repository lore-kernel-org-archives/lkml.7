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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6872CC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C99D246C3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVfku5Fd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgAFUIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 15:08:39 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35933 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgAFUId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 15:08:33 -0500
Received: by mail-wr1-f68.google.com with SMTP id z3so51189101wru.3;
        Mon, 06 Jan 2020 12:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eWt51KQwIIGexXid/EYUJpEHl4uI8BLmPg/J7TLtAjc=;
        b=DVfku5Fd8cSHoyc2ywYCmHKqT5A3PYvmprt7iIqn/fUWEwMuLlgCIne+ynmw2itUe/
         Ux+pvJhSMBFVDPymuEycZv8ZsQsI9oYsIbE6vVBI2RKUpzWDYwHzHjlScPvWPopsW3+D
         JaEkzObwPsz6yo3THI4t2sr4dGZxvIMgDBYRn+ZOb6FvTHNXvvDzq7K835G4pzTXQqeK
         DifDcgcnKMT5a8+pumAT+xxutkmX9/k4LM0ZWu9p6BJ7ln2CSpEysJBQSIgVe5XHo1+D
         L+jWeMJ7jZQbb783rW4cbEy2hS0e07JJd0hc/CrtigzsHct6FdfxgO9WL+CV1vzSkLHM
         sv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eWt51KQwIIGexXid/EYUJpEHl4uI8BLmPg/J7TLtAjc=;
        b=Rbco+kZx3OJFB3qwse4vMi5XNZuArKz1SFRtHXwRLHntmOeRmvcn4zTd/D37okkTFy
         QN53ShnOJXV2o+AfaHFhTRo9LjjzfzzKIYQ+0fbfSnOnaTj2fxWTQrh4qBIF8qGTvToD
         g/3JR/xoTqLN4sjne7Lcq9fMv+11kv73pgTyawaQpaEAptOLT9G8k8BNGfJPeosLYnRm
         FQuXsk8GlVLEcMTaF/TC/bjKZEt7IzPDD2VXyMkrUwDVrsH5N2oelV8dMY6uRjXapQiW
         2tOkjBLpSm0jzjTpDkv0jP/2KUJzJ4rpe64NmC6mITc+3vwNVFps+ETY56S/fJOVVjmq
         23Jw==
X-Gm-Message-State: APjAAAVqBlEfZyZ7EoWholCqHZk8l9G3B6GpHJ89L3fh+ooyZl+n6BYU
        fIcs25YLZDOM+ZZRV8Q3Cr4=
X-Google-Smtp-Source: APXvYqyIUd1gy7nCgJ2A6QEvB3sGsCR7g89R29pIydrCXhoThnVWvbaTOm2YdHoQpsgsmT//d7MIsw==
X-Received: by 2002:adf:f052:: with SMTP id t18mr102070129wro.192.1578341311244;
        Mon, 06 Jan 2020 12:08:31 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:74f9:b588:decc:794d])
        by smtp.gmail.com with ESMTPSA id t190sm23836982wmt.44.2020.01.06.12.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 12:08:30 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     paulmck@kernel.org
Cc:     corbet@lwn.net, madhuparnabhowmik04@gmail.com, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sjpark@amazon.de>
Subject: [PATCH v3 7/7] rcu: Fix typos in beginning comments
Date:   Mon,  6 Jan 2020 21:08:02 +0100
Message-Id: <20200106200802.26994-8-sj38.park@gmail.com>
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
 kernel/rcu/srcutree.c | 2 +-
 kernel/rcu/tree.c     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 3c4e6441bbf9..0b561480e6c4 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -5,7 +5,7 @@
  * Copyright (C) IBM Corporation, 2006
  * Copyright (C) Fujitsu, 2012
  *
- * Author: Paul McKenney <paulmck@linux.ibm.com>
+ * Authors: Paul McKenney <paulmck@linux.ibm.com>
  *	   Lai Jiangshan <laijs@cn.fujitsu.com>
  *
  * For detailed explanation of Read-Copy Update mechanism see -
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 982c7b48cd9b..8367fc080801 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1,12 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Read-Copy Update mechanism for mutual exclusion
+ * Read-Copy Update mechanism for mutual exclusion (tree-based version)
  *
  * Copyright IBM Corporation, 2008
  *
  * Authors: Dipankar Sarma <dipankar@in.ibm.com>
  *	    Manfred Spraul <manfred@colorfullife.com>
- *	    Paul E. McKenney <paulmck@linux.ibm.com> Hierarchical version
+ *	    Paul E. McKenney <paulmck@linux.ibm.com>
  *
  * Based on the original work by Paul McKenney <paulmck@linux.ibm.com>
  * and inputs from Rusty Russell, Andrea Arcangeli and Andi Kleen.
-- 
2.17.1

