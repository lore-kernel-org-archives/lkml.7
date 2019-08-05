Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F102FC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C55A22067D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565010638;
	bh=xnjTLQj/KZjHELxGR6ezwzVsHjQKUD9v24S4/Ae5VUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tPHKAARE9sphgQCRdTThSVxC8ly70hdlaeim+sIt301HewEXYPTItF+wdhW/c4ENx
	 sQJdyTpQwHqasxNBzP6wkpqbacBuPduuMLmspVH2+0TTsH9fXFIhjfHtqf+x+nswTG
	 8W8QLwdQDTPHkGckmJo5yNqzdKMBJq9roBu3NsaE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730359AbfHENKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:10:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:49568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730347AbfHENKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:10:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B95FC2067D;
        Mon,  5 Aug 2019 13:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565010634;
        bh=xnjTLQj/KZjHELxGR6ezwzVsHjQKUD9v24S4/Ae5VUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xP2XvJlbfoBTmZc+w/4BZZUPRCVRNYCgXsmm/EFbWqB5TqLllTaAwqjcQThj5LqZs
         42DRHdMN90j7Hv5JypCz+z41YDn9kX+n7+kmYIMu5WWAbXDJyETekPwum4wL/lpizs
         oPgzA6aWbCrxoxrP4zsboWHDt16H3Y8kMxnj430g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        "Yan, Zheng" <zyan@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 18/74] ceph: fix improper use of smp_mb__before_atomic()
Date:   Mon,  5 Aug 2019 15:02:31 +0200
Message-Id: <20190805124937.270523477@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190805124935.819068648@linuxfoundation.org>
References: <20190805124935.819068648@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 582e28fd1b7bf..d8579a56e5dc2 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -526,7 +526,12 @@ static inline void __ceph_dir_set_complete(struct ceph_inode_info *ci,
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



