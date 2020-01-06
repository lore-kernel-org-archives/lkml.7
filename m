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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D069BC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 19:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A529C207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 19:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeOWgz29"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbgAFTTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 14:19:33 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39147 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgAFTTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 14:19:20 -0500
Received: by mail-wr1-f66.google.com with SMTP id y11so50971484wrt.6;
        Mon, 06 Jan 2020 11:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vGg3ZTA0AdAyTlCUXvBOcxXYMS9l69TXZtzSDH3ov8s=;
        b=XeOWgz299BHP2DP1j1E1lK2HGTUOUZ94xHwxWj1f8/4DEmDtRvuHel4fljRhCdDwjO
         MV4Qf39yQ1Ku791UG4WyFHN9TN0IMVlDWvVGozIFe8SL0QGEffsK5iKWP1qDuWkF5v0q
         SJlED1oWHLiNmpYP8DWJ7+52XW3RA5nAMKBRAvGdRAnjELMXA2olTrMgscE2zAI4mk+G
         +aZfXlvS8tiJEiIjs4v/OWS66OjG8KHXovBajwf7xUyKsmmOzu2VWOCP8XwTOIaPU0UI
         I1/0IS6lLBeHrKnHnNWDLj5FIqvfarAmHbYSoYOkJXicNvfYBH+AryuPMatDlAGWFReX
         7nRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vGg3ZTA0AdAyTlCUXvBOcxXYMS9l69TXZtzSDH3ov8s=;
        b=tGaHm+C+hLSXQXDVJisk8DEdXNuPmUlggyp6mmGjzl42VArG3K81SZMMhWUdE5WHFN
         qAWITCX0bcgP9V1ydIohaH2lyLTd/PhPakzHBaHKlgY2hnE/Pm0IB07NM0K8SreSQFWo
         k3j28/INTx9KGkIvSplaS3NmxLBU0xVZvtzarhaXYmnp/SK+OIO/r1AdEntc/Qt5jL51
         +iRXC+JXcsbt6YtkyMqHAr5FnT4VWLhGzMi8jOk2eSuC0RIAVn3kyjCOYwi0b9HWfyla
         /u3zgg0QJyCo1vHM305cZ8Y2dbrSRSKi4oNtU4JlMM4yoeqLgU4tRrXhEY+O0fdR2xOj
         xtEQ==
X-Gm-Message-State: APjAAAWGg1tJH8z0IciBu9zGPdttmwhSpG18KOoOGOxc1isRvpGGpOU/
        TWjhOWYHWFYFO1u5YzUHTdk=
X-Google-Smtp-Source: APXvYqxMwRG0fTMpNevLwHNROx4q6sdNJBT+nqdNCYxHybddDiXql6Di+T/nCRGJUlV/Ltj8IM99jw==
X-Received: by 2002:adf:f288:: with SMTP id k8mr110922459wro.301.1578338358105;
        Mon, 06 Jan 2020 11:19:18 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:74f9:b588:decc:794d])
        by smtp.gmail.com with ESMTPSA id o4sm72041756wrx.25.2020.01.06.11.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 11:19:17 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     paulmck@kernel.org
Cc:     corbet@lwn.net, rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, madhuparnabhowmik04@gmail.com,
        sj38.park@gmail.com, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH v2 7/7] rcu: Fix typos in beginning comments
Date:   Mon,  6 Jan 2020 20:18:52 +0100
Message-Id: <20200106191852.22973-8-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106191852.22973-1-sjpark@amazon.de>
References: <20200106191852.22973-1-sjpark@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

