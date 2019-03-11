Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2381AC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F012B20850
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfCKJhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:37:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42232 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727323AbfCKJhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 05:37:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A7D2EC002965;
        Mon, 11 Mar 2019 09:37:41 +0000 (UTC)
Received: from xz-x1.nay.redhat.com (dhcp-14-116.nay.redhat.com [10.66.14.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B3B195D705;
        Mon, 11 Mar 2019 09:37:34 +0000 (UTC)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        kvm@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>, peterx@redhat.com,
        Martin Cracauer <cracauer@cons.org>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>, linux-mm@kvack.org,
        Marty McFadden <mcfadden8@llnl.gov>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        linux-fsdevel@vger.kernel.org,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 3/3] userfaultfd: apply unprivileged_userfaultfd check
Date:   Mon, 11 Mar 2019 17:37:01 +0800
Message-Id: <20190311093701.15734-4-peterx@redhat.com>
In-Reply-To: <20190311093701.15734-1-peterx@redhat.com>
References: <20190311093701.15734-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 11 Mar 2019 09:37:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apply the unprivileged_userfaultfd check when doing userfaultfd
syscall.  We didn't check it in other paths of userfaultfd (e.g., the
ioctl() path) because we don't want to drag down the fast path of
userfaultfd, as suggested by Andrea.

Suggested-by: Andrea Arcangeli <aarcange@redhat.com>
Suggested-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/userfaultfd.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index c2188464555a..effdcfc88629 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -951,6 +951,28 @@ void userfaultfd_unmap_complete(struct mm_struct *mm, struct list_head *uf)
 	}
 }
 
+/* Whether current process allows to use userfaultfd syscalls */
+static bool userfaultfd_allowed(void)
+{
+	bool allowed = false;
+
+	switch (unprivileged_userfaultfd) {
+	case UFFD_UNPRIV_ENABLED:
+		allowed = true;
+		break;
+	case UFFD_UNPRIV_KVM:
+		allowed = !!test_bit(MMF_USERFAULTFD_ALLOW,
+				     &current->mm->flags);
+		/* Fall through */
+	case UFFD_UNPRIV_DISABLED:
+		allowed = allowed || ns_capable(current_user_ns(),
+						CAP_SYS_PTRACE);
+		break;
+	}
+
+	return allowed;
+}
+
 static int userfaultfd_release(struct inode *inode, struct file *file)
 {
 	struct userfaultfd_ctx *ctx = file->private_data;
@@ -2018,6 +2040,9 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 	BUILD_BUG_ON(UFFD_CLOEXEC != O_CLOEXEC);
 	BUILD_BUG_ON(UFFD_NONBLOCK != O_NONBLOCK);
 
+	if (!userfaultfd_allowed())
+		return -EPERM;
+
 	if (flags & ~UFFD_SHARED_FCNTL_FLAGS)
 		return -EINVAL;
 
-- 
2.17.1

