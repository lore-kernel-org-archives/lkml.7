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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156F8CA9EC2
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D717621783
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pit86DQr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390713AbfJ1PTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 11:19:55 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45661 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730149AbfJ1PTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 11:19:55 -0400
Received: by mail-pl1-f196.google.com with SMTP id y24so5711223plr.12;
        Mon, 28 Oct 2019 08:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Y5HapZnby+jyqPlPKCmmD1uZdwYPEqf/I0zhoDbSqdE=;
        b=pit86DQrHLHcPW+IaWOpF5Q1YGkUJQQofm3PHHK+/6cozH3AGBQ9dBZg75b60WxPQV
         AEcZ95OpnuuwG09kNyzgVsDppHsDIpGsBg3yCHeGQ7nnToDdma6IMRv7fOPpCC26qOFz
         DGgbbD/83h/RndSa/xKKwKyQ2OVNQsKOeW+GIOL4YF7mrH1R0xYL+WUJhnwZhnlON0YY
         a9yyjvAyQW4nuWxB9cGW4keFDDfRMd+LlboAhXNTUiOs+94CTCT/I4imahM2xOl38o4b
         q/vmhor4lfPdU4ImyUf7Od58aQHgII5AKZyIP6FTisKY//sURPzLIqkVTpQHg/ivgUaU
         R0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Y5HapZnby+jyqPlPKCmmD1uZdwYPEqf/I0zhoDbSqdE=;
        b=JEE1Vaf9jNBNWvOuVTKIhOUZ0gpmIe2c8b/dk1MfFN0jislc87Sf4JDmouXpi8Vw/p
         Jo7vJvWvmxuodXpxIjPFaKTN6EZOClR1ywkGnZxwpYHrK2KTTVTbCrTEPXQmPSNnmJRG
         Za8iqlpkyPqMRu91CiZHRYLAG86sLa3lAIr4Xe03dYrQNL3dTL8nWJEeZYYQS03LRG2z
         Rl5WKoP5DgozgGx0TBF6fCAWdp1Bhd1dBKHMV4EzVaoZqv8uVSU8/kSLeO9p/QsNQrTv
         7lKTyVPK7y5XCGxrsEWGnv45UGjssVe2lR9xdDqNDt9fX8MCzAmAU1KMnUnNcaak/nhO
         Dmqw==
X-Gm-Message-State: APjAAAUPxo7F3QHh6ZRxSgOA3CSVxIZiAZFAgMF7nqHGyQIn0pxf3wZT
        S5rveogxxA3E89PxDULfCW5gvk7L
X-Google-Smtp-Source: APXvYqz/qPZxoEoqjtjh3D3T3Ocbjc4GSVeld18Am5kZixE3i0NSPmDnUsQxPpaVV0J2yI+G/w5PbQ==
X-Received: by 2002:a17:902:b116:: with SMTP id q22mr19353634plr.201.1572275992639;
        Mon, 28 Oct 2019 08:19:52 -0700 (PDT)
Received: from madhuparna-HP-Notebook.nitk.ac.in ([2402:3a80:51e:687:393e:2dcf:24de:b4fb])
        by smtp.gmail.com with ESMTPSA id v3sm2786467pfn.171.2019.10.28.08.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 08:19:52 -0700 (PDT)
From:   madhuparnabhowmik04@gmail.com
To:     paulmck@kernel.org, joel@joelfernandes.org, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        Madhuparna Bhowmik <madhuparnbhowmik04@gmail.com>
Subject: [PATCH 2/2] Documentation: RCU: Converted arrayRCU.txt to arrayRCU.rst.
Date:   Mon, 28 Oct 2019 20:49:36 +0530
Message-Id: <20191028151936.27016-1-madhuparnabhowmik04@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>

This patch converts arrayRCU from txt to rst format.
arrayRCU.rst is also added in the index.rst file.

Signed-off-by: Madhuparna Bhowmik <madhuparnbhowmik04@gmail.com>
Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
---
 .../RCU/{arrayRCU.txt => arrayRCU.rst}         | 18 ++++++++++++++----
 Documentation/RCU/index.rst                    |  1 +
 2 files changed, 15 insertions(+), 4 deletions(-)
 rename Documentation/RCU/{arrayRCU.txt => arrayRCU.rst} (91%)

diff --git a/Documentation/RCU/arrayRCU.txt b/Documentation/RCU/arrayRCU.rst
similarity index 91%
rename from Documentation/RCU/arrayRCU.txt
rename to Documentation/RCU/arrayRCU.rst
index f05a9afb2c39..c8a26f7b2577 100644
--- a/Documentation/RCU/arrayRCU.txt
+++ b/Documentation/RCU/arrayRCU.rst
@@ -1,4 +1,7 @@
+.. _array_rcu_doc:
+
 Using RCU to Protect Read-Mostly Arrays
+=======================================
 
 
 Although RCU is more commonly used to protect linked lists, it can
@@ -26,6 +29,7 @@ described in the following sections.
 
 
 Situation 1: Hash Tables
+------------------------
 
 Hash tables are often implemented as an array, where each array entry
 has a linked-list hash chain.  Each hash chain can be protected by RCU
@@ -34,6 +38,7 @@ to other array-of-list situations, such as radix trees.
 
 
 Situation 2: Static Arrays
+--------------------------
 
 Static arrays, where the data (rather than a pointer to the data) is
 located in each array element, and where the array is never resized,
@@ -41,11 +46,14 @@ have not been used with RCU.  Rik van Riel recommends using seqlock in
 this situation, which would also have minimal read-side overhead as long
 as updates are rare.
 
-Quick Quiz:  Why is it so important that updates be rare when
-	     using seqlock?
+Quick Quiz:
+		Why is it so important that updates be rare when using seqlock?
+
+:ref:`Answer to Quick Quiz <answer_quick_quiz_seqlock>`
 
 
 Situation 3: Resizeable Arrays
+------------------------------
 
 Use of RCU for resizeable arrays is demonstrated by the grow_ary()
 function formerly used by the System V IPC code.  The array is used
@@ -60,7 +68,7 @@ the remainder of the new, updates the ids->entries pointer to point to
 the new array, and invokes ipc_rcu_putref() to free up the old array.
 Note that rcu_assign_pointer() is used to update the ids->entries pointer,
 which includes any memory barriers required on whatever architecture
-you are running on.
+you are running on.::
 
 	static int grow_ary(struct ipc_ids* ids, int newsize)
 	{
@@ -112,7 +120,7 @@ a simple check suffices.  The pointer to the structure corresponding
 to the desired IPC object is placed in "out", with NULL indicating
 a non-existent entry.  After acquiring "out->lock", the "out->deleted"
 flag indicates whether the IPC object is in the process of being
-deleted, and, if not, the pointer is returned.
+deleted, and, if not, the pointer is returned.::
 
 	struct kern_ipc_perm* ipc_lock(struct ipc_ids* ids, int id)
 	{
@@ -144,8 +152,10 @@ deleted, and, if not, the pointer is returned.
 		return out;
 	}
 
+.. _answer_quick_quiz_seqlock:
 
 Answer to Quick Quiz:
+	Why is it so important that updates be rare when using seqlock?
 
 	The reason that it is important that updates be rare when
 	using seqlock is that frequent updates can livelock readers.
diff --git a/Documentation/RCU/index.rst b/Documentation/RCU/index.rst
index 340a9725676c..c4586602e7e2 100644
--- a/Documentation/RCU/index.rst
+++ b/Documentation/RCU/index.rst
@@ -7,6 +7,7 @@ RCU concepts
 .. toctree::
    :maxdepth: 1
 
+   arrayRCU
    rcu
    listRCU
    UP
-- 
2.17.1

