Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28F0C4CECE
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 00:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3D2E222BD
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 00:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wP3VRc4S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbfJMAax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 20:30:53 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:52731 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729003AbfJMAav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 20:30:51 -0400
Received: by mail-pg1-f201.google.com with SMTP id e15so9878491pgh.19
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 17:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=P7abJRI85r+K/TRDAITrJhvU4blOks6xxJvHrDmdwNo=;
        b=wP3VRc4Sjd0MfiWZ3l2O6xPOLegcNe5EG1wD6mk6jKeio7RlfzqcFgBJyTj8r2Qle2
         kuGJwA3jttSxlj7OKvvEPJdc3CKObPaqCoIxgSi2+gefihDO33R6kqlmnHH76TwNxMpG
         SLcYgJmC6zeZuTvcfSwzUAMb4vKCHShqf89n0eGQQIbfvZ280blHsZSwNsjdxgaXhUpQ
         ljle8dNBA64Hmq3eBKl6ld5wmof4nc8QdiozpMkmy+vjIrXPnnPjAImDGAKwjPoIZHw5
         Ffr+GO/dLvKz03UQ1axTfrFlysqXhmwBXxxDdUJDi9DbQUmX73pfEtBtHLS0/xbo2JCd
         qzHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=P7abJRI85r+K/TRDAITrJhvU4blOks6xxJvHrDmdwNo=;
        b=IZjQe1F8svOqh/3T5LUQHFn/5gduwv9lL6RFY2weYaiIDk5ZEpLYsYAy2AvLR3P2fk
         f0QXHSDjzPbYclA9UyNgjfNCJriI6B/78mG+xbM4opZE+lr+BATpuULBGAu4Ox2IE+R9
         RYhvMcm/E0NhIWW3RbXNv4i/ZTZfYnGfR/YtJLcJmqkKLtzaOsp8xIwJplqj1O8Zc+2s
         83K2m+s1iPU2r8qA33e/cCvJjnmJvdo5jZTUZtMVpvTWTt2Z00UJozfyMS7dQW0iw7Bs
         7y8AWNje0WJairddyWzz3chqjMZKCMJ4tIKIztqdnGDUkrgJxdt21gCudK2InWjpdN06
         A06w==
X-Gm-Message-State: APjAAAVWWMjPFgfEaH/7kMaTVjEVw8b0q1/jM/6PKPGXfwbK9swy5V9l
        pvtKwUjasiLACWR8C3btjDlB69NB/ZzBI0twKw==
X-Google-Smtp-Source: APXvYqxXEc4NA7oKRRTcl220Dm4FauosfZDC5X4WT0geKI4r44dqc3LfO67JzAjlCIBC80vIy5yux4EZzO32zBDpPA==
X-Received: by 2002:a63:cf4a:: with SMTP id b10mr23871724pgj.86.1570926649195;
 Sat, 12 Oct 2019 17:30:49 -0700 (PDT)
Date:   Sat, 12 Oct 2019 17:30:24 -0700
In-Reply-To: <20191013003024.215429-1-almasrymina@google.com>
Message-Id: <20191013003024.215429-9-almasrymina@google.com>
Mime-Version: 1.0
References: <20191013003024.215429-1-almasrymina@google.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH v6 9/9] hugetlb_cgroup: Add hugetlb_cgroup reservation docs
From:   Mina Almasry <almasrymina@google.com>
To:     mike.kravetz@oracle.com
Cc:     shuah@kernel.org, almasrymina@google.com, rientjes@google.com,
        shakeelb@google.com, gthelen@google.com, akpm@linux-foundation.org,
        khalid.aziz@oracle.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org, aneesh.kumar@linux.vnet.ibm.com,
        mkoutny@suse.com, Hillf Danton <hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add docs for how to use hugetlb_cgroup reservations, and their behavior.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Acked-by: Hillf Danton <hdanton@sina.com>

---

Changes in v6:
- Updated docs to reflect the new design based on a new counter that
tracks both reservations and faults.

---
 .../admin-guide/cgroup-v1/hugetlb.rst         | 64 +++++++++++++++----
 1 file changed, 53 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/hugetlb.rst b/Documentation/admin-guide/cgroup-v1/hugetlb.rst
index a3902aa253a96..efb94e4db9d5a 100644
--- a/Documentation/admin-guide/cgroup-v1/hugetlb.rst
+++ b/Documentation/admin-guide/cgroup-v1/hugetlb.rst
@@ -2,13 +2,6 @@
 HugeTLB Controller
 ==================

-The HugeTLB controller allows to limit the HugeTLB usage per control group and
-enforces the controller limit during page fault. Since HugeTLB doesn't
-support page reclaim, enforcing the limit at page fault time implies that,
-the application will get SIGBUS signal if it tries to access HugeTLB pages
-beyond its limit. This requires the application to know beforehand how much
-HugeTLB pages it would require for its use.
-
 HugeTLB controller can be created by first mounting the cgroup filesystem.

 # mount -t cgroup -o hugetlb none /sys/fs/cgroup
@@ -28,10 +21,14 @@ process (bash) into it.

 Brief summary of control files::

- hugetlb.<hugepagesize>.limit_in_bytes     # set/show limit of "hugepagesize" hugetlb usage
- hugetlb.<hugepagesize>.max_usage_in_bytes # show max "hugepagesize" hugetlb  usage recorded
- hugetlb.<hugepagesize>.usage_in_bytes     # show current usage for "hugepagesize" hugetlb
- hugetlb.<hugepagesize>.failcnt		   # show the number of allocation failure due to HugeTLB limit
+ hugetlb.<hugepagesize>.reservation_limit_in_bytes     # set/show limit of "hugepagesize" hugetlb reservations
+ hugetlb.<hugepagesize>.reservation_max_usage_in_bytes # show max "hugepagesize" hugetlb reservations and no-reserve faults.
+ hugetlb.<hugepagesize>.reservation_usage_in_bytes     # show current reservations and no-reserve faults for "hugepagesize" hugetlb
+ hugetlb.<hugepagesize>.reservation_failcnt            # show the number of allocation failure due to HugeTLB reservation limit
+ hugetlb.<hugepagesize>.limit_in_bytes                 # set/show limit of "hugepagesize" hugetlb faults
+ hugetlb.<hugepagesize>.max_usage_in_bytes             # show max "hugepagesize" hugetlb  usage recorded
+ hugetlb.<hugepagesize>.usage_in_bytes                 # show current usage for "hugepagesize" hugetlb
+ hugetlb.<hugepagesize>.failcnt                        # show the number of allocation failure due to HugeTLB usage limit

 For a system supporting three hugepage sizes (64k, 32M and 1G), the control
 files include::
@@ -40,11 +37,56 @@ files include::
   hugetlb.1GB.max_usage_in_bytes
   hugetlb.1GB.usage_in_bytes
   hugetlb.1GB.failcnt
+  hugetlb.1GB.reservation_limit_in_bytes
+  hugetlb.1GB.reservation_max_usage_in_bytes
+  hugetlb.1GB.reservation_usage_in_bytes
+  hugetlb.1GB.reservation_failcnt
   hugetlb.64KB.limit_in_bytes
   hugetlb.64KB.max_usage_in_bytes
   hugetlb.64KB.usage_in_bytes
   hugetlb.64KB.failcnt
+  hugetlb.64KB.reservation_limit_in_bytes
+  hugetlb.64KB.reservation_max_usage_in_bytes
+  hugetlb.64KB.reservation_usage_in_bytes
+  hugetlb.64KB.reservation_failcnt
   hugetlb.32MB.limit_in_bytes
   hugetlb.32MB.max_usage_in_bytes
   hugetlb.32MB.usage_in_bytes
   hugetlb.32MB.failcnt
+  hugetlb.32MB.reservation_limit_in_bytes
+  hugetlb.32MB.reservation_max_usage_in_bytes
+  hugetlb.32MB.reservation_usage_in_bytes
+  hugetlb.32MB.reservation_failcnt
+
+
+1. Reservation limits
+
+The HugeTLB controller allows to limit the HugeTLB reservations per control
+group and enforces the controller limit at reservation time and at the fault of
+hugetlb memory for which no reservation exists. Reservation limits
+are superior to Page fault limits (see section 2), since Reservation limits are
+enforced at reservation time (on mmap or shget), and never causes the
+application to get SIGBUS signal if the memory was reserved before hand. For
+MAP_NORESERVE allocations, the reservation limit behaves the same as the fault
+limit, enforcing memory usage at fault time and causing the application to
+receive a SIGBUS if it's crossing its limit.
+
+2. Page fault limits
+
+The HugeTLB controller allows to limit the HugeTLB usage (page fault) per
+control group and enforces the controller limit during page fault. Since HugeTLB
+doesn't support page reclaim, enforcing the limit at page fault time implies
+that, the application will get SIGBUS signal if it tries to access HugeTLB
+pages beyond its limit. This requires the application to know beforehand how
+much HugeTLB pages it would require for its use.
+
+
+3. Caveats with shared memory
+
+For shared hugetlb memory, both hugetlb reservation and page faults are charged
+to the first task that causes the memory to be reserved or faulted, and all
+subsequent uses of this reserved or faulted memory is done without charging.
+
+Shared hugetlb memory is only uncharged when it is unreserved or deallocated.
+This is usually when the hugetlbfs file is deleted, and not when the task that
+caused the reservation or fault has exited.
--
2.23.0.700.g56cf767bdb-goog
