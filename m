Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4C4CA9EC2
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 20:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C711A21835
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 20:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDvDKl0L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733137AbfJ1UYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 16:24:47 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:46853 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbfJ1UYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 16:24:46 -0400
Received: by mail-pl1-f180.google.com with SMTP id q21so6208384plr.13;
        Mon, 28 Oct 2019 13:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=J4RzqsQdEML1cbVHIx8wmTd5XY2mZXDTDOayyDlWSQM=;
        b=GDvDKl0L2190YtllmnUOCffThmSmqPSTRWpGkDL5Cjzq2F6AZ11svWhwrog40YfscZ
         rIEZUCZf/jJiRYI37uGgA1m0GrzSiLNbPU+SYcnU6e5Wu+nUwNEnZiBjEF2fiu4LYgNK
         GcbYoWSZPpD+uQ0i/AVeecTJp+QaHgZ1OJLiVKxbPDoOztZxUoPw5MeY+QpXNF/f4Cr/
         FL/xoJ4926l28/VoziImxbZS12U6/6YnBn2QSjs/yToI9ycMTvC9qdSDiMLkqdydMzre
         OdzdHSSrSbh0CjEqHjpVtKS9A+C5DO4MuFhD9cqcbiqIoTT/W6qWqJ0+/IgxX0idCUTJ
         w87g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=J4RzqsQdEML1cbVHIx8wmTd5XY2mZXDTDOayyDlWSQM=;
        b=YHId6CoREKdQNpJwBEXeBbDacJU71X4fd3VAAdpqiA1mieY+o/eGzGl3gldIn8YhGf
         /ECipvRW08OZ+uIOHrweloPE1mnMVdBvutjjoxxZk0BHKeVKWbEQJJBO83pB1Sj8hQCO
         yDQhd/viFya2CxhPYWkPymgV9zKaIRg7NwbvBLBo8ebfR+VTBpLf+yEJQ+iyEz2DLd93
         lpAWRwXPQ3lrHxryD8oUlUK3Srcth1qzUydEI2pYA3yvXlKylr09ljPV8W9jxKWOBB/7
         b1J0tIxmyStxNONkriW7wB17NUZQSuCHdoumAwvmg493pHLRhUOAgzFdH4dgb9Z+V8TT
         6i5g==
X-Gm-Message-State: APjAAAXxEoIUr1wv7d3ngPawi1lhlBVV9hxgIOYZol6PHGdRlttEZvDR
        +WfSmRpkeUTmDKyutKsdpNw=
X-Google-Smtp-Source: APXvYqzdrjxJ33HXEYoOwo6s2OVkuxmqVwhQXMEn+ZhDxDx5d6FcdvF4Fr/5G+U2zJcrmRk0dOPpOA==
X-Received: by 2002:a17:902:bf0a:: with SMTP id bi10mr21620809plb.56.1572294285327;
        Mon, 28 Oct 2019 13:24:45 -0700 (PDT)
Received: from madhuparna-HP-Notebook.nitk.ac.in ([2402:3a80:539:24ac:e0c0:9d9:7065:4300])
        by smtp.gmail.com with ESMTPSA id x7sm4201760pff.0.2019.10.28.13.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 13:24:44 -0700 (PDT)
From:   madhuparnabhowmik04@gmail.com
To:     paulmck@kernel.org, joel@joelfernandes.org, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Subject: [PATCH] Documentation: RCU: arrayRCU: Converted arrayRCU.txt to arrayRCU.rst
Date:   Tue, 29 Oct 2019 01:54:17 +0530
Message-Id: <20191028202417.13095-1-madhuparnabhowmik04@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>

This patch converts arrayRCU from txt to rst format.
arrayRCU.rst is also added in the index.rst file.

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
---
 .../RCU/{arrayRCU.txt => arrayRCU.rst}         | 18 +++++++++++++-----
 Documentation/RCU/index.rst                    |  1 +
 2 files changed, 14 insertions(+), 5 deletions(-)
 rename Documentation/RCU/{arrayRCU.txt => arrayRCU.rst} (91%)

diff --git a/Documentation/RCU/arrayRCU.txt b/Documentation/RCU/arrayRCU.rst
similarity index 91%
rename from Documentation/RCU/arrayRCU.txt
rename to Documentation/RCU/arrayRCU.rst
index f05a9afb2c39..ed5ae24b196e 100644
--- a/Documentation/RCU/arrayRCU.txt
+++ b/Documentation/RCU/arrayRCU.rst
@@ -1,5 +1,7 @@
-Using RCU to Protect Read-Mostly Arrays
+.. _array_rcu_doc:
 
+Using RCU to Protect Read-Mostly Arrays
+=======================================
 
 Although RCU is more commonly used to protect linked lists, it can
 also be used to protect arrays.  Three situations are as follows:
@@ -26,6 +28,7 @@ described in the following sections.
 
 
 Situation 1: Hash Tables
+------------------------
 
 Hash tables are often implemented as an array, where each array entry
 has a linked-list hash chain.  Each hash chain can be protected by RCU
@@ -34,6 +37,7 @@ to other array-of-list situations, such as radix trees.
 
 
 Situation 2: Static Arrays
+--------------------------
 
 Static arrays, where the data (rather than a pointer to the data) is
 located in each array element, and where the array is never resized,
@@ -41,11 +45,13 @@ have not been used with RCU.  Rik van Riel recommends using seqlock in
 this situation, which would also have minimal read-side overhead as long
 as updates are rare.
 
-Quick Quiz:  Why is it so important that updates be rare when
-	     using seqlock?
+Quick Quiz:  
+		Why is it so important that updates be rare when using seqlock?
 
+:ref:`Answer to Quick Quiz <answer_quick_quiz_seqlock>`
 
 Situation 3: Resizeable Arrays
+------------------------------
 
 Use of RCU for resizeable arrays is demonstrated by the grow_ary()
 function formerly used by the System V IPC code.  The array is used
@@ -60,7 +66,7 @@ the remainder of the new, updates the ids->entries pointer to point to
 the new array, and invokes ipc_rcu_putref() to free up the old array.
 Note that rcu_assign_pointer() is used to update the ids->entries pointer,
 which includes any memory barriers required on whatever architecture
-you are running on.
+you are running on.::
 
 	static int grow_ary(struct ipc_ids* ids, int newsize)
 	{
@@ -112,7 +118,7 @@ a simple check suffices.  The pointer to the structure corresponding
 to the desired IPC object is placed in "out", with NULL indicating
 a non-existent entry.  After acquiring "out->lock", the "out->deleted"
 flag indicates whether the IPC object is in the process of being
-deleted, and, if not, the pointer is returned.
+deleted, and, if not, the pointer is returned.::
 
 	struct kern_ipc_perm* ipc_lock(struct ipc_ids* ids, int id)
 	{
@@ -144,8 +150,10 @@ deleted, and, if not, the pointer is returned.
 		return out;
 	}
 
+.. _answer_quick_quiz_seqlock:
 
 Answer to Quick Quiz:
+	Why is it so important that updates be rare when using seqlock?
 
 	The reason that it is important that updates be rare when
 	using seqlock is that frequent updates can livelock readers.
diff --git a/Documentation/RCU/index.rst b/Documentation/RCU/index.rst
index 5c99185710fa..8d20d44f8fd4 100644
--- a/Documentation/RCU/index.rst
+++ b/Documentation/RCU/index.rst
@@ -7,6 +7,7 @@ RCU concepts
 .. toctree::
    :maxdepth: 3
 
+   arrayRCU
    rcu
    listRCU
    UP
-- 
2.17.1

