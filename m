Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAACBC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 02:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C70B02084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 02:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731628AbfFTCZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 22:25:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36322 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbfFTCZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 22:25:10 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C7B6F22386D;
        Thu, 20 Jun 2019 02:25:09 +0000 (UTC)
Received: from xz-x1.redhat.com (ovpn-12-78.pek2.redhat.com [10.72.12.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0F7811001E69;
        Thu, 20 Jun 2019 02:24:59 +0000 (UTC)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>, peterx@redhat.com,
        Martin Cracauer <cracauer@cons.org>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Shaohua Li <shli@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v5 23/25] userfaultfd: wp: declare _UFFDIO_WRITEPROTECT conditionally
Date:   Thu, 20 Jun 2019 10:20:06 +0800
Message-Id: <20190620022008.19172-24-peterx@redhat.com>
In-Reply-To: <20190620022008.19172-1-peterx@redhat.com>
References: <20190620022008.19172-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 20 Jun 2019 02:25:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only declare _UFFDIO_WRITEPROTECT if the user specified
UFFDIO_REGISTER_MODE_WP and if all the checks passed.  Then when the
user registers regions with shmem/hugetlbfs we won't expose the new
ioctl to them.  Even with complete anonymous memory range, we'll only
expose the new WP ioctl bit if the register mode has MODE_WP.

Reviewed-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/userfaultfd.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 498971fa9163..4e1d7748224a 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1465,14 +1465,24 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 	up_write(&mm->mmap_sem);
 	mmput(mm);
 	if (!ret) {
+		__u64 ioctls_out;
+
+		ioctls_out = basic_ioctls ? UFFD_API_RANGE_IOCTLS_BASIC :
+		    UFFD_API_RANGE_IOCTLS;
+
+		/*
+		 * Declare the WP ioctl only if the WP mode is
+		 * specified and all checks passed with the range
+		 */
+		if (!(uffdio_register.mode & UFFDIO_REGISTER_MODE_WP))
+			ioctls_out &= ~((__u64)1 << _UFFDIO_WRITEPROTECT);
+
 		/*
 		 * Now that we scanned all vmas we can already tell
 		 * userland which ioctls methods are guaranteed to
 		 * succeed on this range.
 		 */
-		if (put_user(basic_ioctls ? UFFD_API_RANGE_IOCTLS_BASIC :
-			     UFFD_API_RANGE_IOCTLS,
-			     &user_uffdio_register->ioctls))
+		if (put_user(ioctls_out, &user_uffdio_register->ioctls))
 			ret = -EFAULT;
 	}
 out:
-- 
2.21.0

