Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA69C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F54B22CC2
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564148746;
	bh=oU6y28adueoHuGRD7D1UKKNX7xwgGD2PU8vEm4fV3xs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1tbti73FWptj/2eH/+qDuT23SrBiOuTwKqSEhhdHqWLyKDNcDfd2PdQy31uZv8FfN
	 YVXtpQ2wE3YLUWM9dak3CdcRvNPe0lchmc/LuPreJPYfIgIaRTm0tcn9rjgb7VwZst
	 xDnm3kJCE+E1DpKadfQc3nn+dPJorGm7SUy+DuMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387945AbfGZNpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:45:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:54820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728216AbfGZNpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:45:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F28822CEC;
        Fri, 26 Jul 2019 13:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564148741;
        bh=oU6y28adueoHuGRD7D1UKKNX7xwgGD2PU8vEm4fV3xs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ukJYq1g9akEyWkF/3dXhjmEyppcvDoRMfbGpr+0sHpsJP1XeIzZS8J3k8oc33mo/e
         3nPvVNd+7iqIMsnx1GqXu7XWnI7zJDYsnzHbcPnwE6M2D5g421hbos/wyTv79t4OYH
         R7qPw8ndqIW3nv76d2Zzi+IFK83A+Ve87S65GmI0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Yan, Zheng" <zyan@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, ceph-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 08/23] ceph: fix improper use of smp_mb__before_atomic()
Date:   Fri, 26 Jul 2019 09:45:07 -0400
Message-Id: <20190726134522.13308-8-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726134522.13308-1-sashal@kernel.org>
References: <20190726134522.13308-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Parri <andrea.parri@amarulasolutions.com>

[ Upstream commit 749607731e26dfb2558118038c40e9c0c80d23b5 ]

This barrier only applies to the read-modify-write operations; in
particular, it does not apply to the atomic64_set() primitive.

Replace the barrier with an smp_mb().

Fixes: fdd4e15838e59 ("ceph: rework dcache readdir")
Reported-by: "Paul E. McKenney" <paulmck@linux.ibm.com>
Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Reviewed-by: "Yan, Zheng" <zyan@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/super.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 8c8cb8fe3d32..5d05c77c158d 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -474,7 +474,12 @@ static inline void __ceph_dir_set_complete(struct ceph_inode_info *ci,
 					   long long release_count,
 					   long long ordered_count)
 {
-	smp_mb__before_atomic();
+	/*
+	 * Makes sure operations that setup readdir cache (update page
+	 * cache and i_size) are strongly ordered w.r.t. the following
+	 * atomic64_set() operations.
+	 */
+	smp_mb();
 	atomic64_set(&ci->i_complete_seq[0], release_count);
 	atomic64_set(&ci->i_complete_seq[1], ordered_count);
 }
-- 
2.20.1

