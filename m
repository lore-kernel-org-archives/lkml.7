Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0ABC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2426C20CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576520044;
	bh=xIAUMyEs4IxOo03+cfmn9uPZNxEon7WbX0KauaAyN3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nq1XTZzIGwCif72Hai5wKXFu4fZ+6XwOmq/RSg3xLHjvKr/GPa5kUMAmBvcsy9QMm
	 rlsEKgWWRF+k3gjhmLG8ktN5Uz/tgL8V7VfznXNgf+t0e3L76ah9Cfz+9NOGg6R4W9
	 yc4+tNaOQ3bely57fv9dmN+0Zm0ZpC3Vj0TULqk0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731174AbfLPSOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:14:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:60644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730830AbfLPSNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:13:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53CAC207FF;
        Mon, 16 Dec 2019 18:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576520032;
        bh=xIAUMyEs4IxOo03+cfmn9uPZNxEon7WbX0KauaAyN3Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QyFdjh+ldUz+Q1BjNf5+CMjhhxKrB6+X4Si3iUgplfDCera+5ISqC6UgN99xYkLie
         q55yZpEtqn8bLn0CYO7lDQVgQ6Hwsq18KIh0i4DCJNrmsSAdZ72cihGW9sQCiL/ij2
         WhB2GV5EfpwuU3SkbMrDLnMC1JL5tfjDP3Eb721c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicolas Geoffray <ngeoffray@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Hugh Dickins <hughd@google.com>, Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.3 170/180] mm, memfd: fix COW issue on MAP_PRIVATE and F_SEAL_FUTURE_WRITE mappings
Date:   Mon, 16 Dec 2019 18:50:10 +0100
Message-Id: <20191216174847.528262321@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174806.018988360@linuxfoundation.org>
References: <20191216174806.018988360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Geoffray <ngeoffray@google.com>

commit 05d351102dbe4e103d6bdac18b1122cd3cd04925 upstream.

F_SEAL_FUTURE_WRITE has unexpected behavior when used with MAP_PRIVATE:
A private mapping created after the memfd file that gets sealed with
F_SEAL_FUTURE_WRITE loses the copy-on-write at fork behavior, meaning
children and parent share the same memory, even though the mapping is
private.

The reason for this is due to the code below:

  static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
  {
        struct shmem_inode_info *info = SHMEM_I(file_inode(file));

        if (info->seals & F_SEAL_FUTURE_WRITE) {
                /*
                 * New PROT_WRITE and MAP_SHARED mmaps are not allowed when
                 * "future write" seal active.
                 */
                if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_WRITE))
                        return -EPERM;

                /*
                 * Since the F_SEAL_FUTURE_WRITE seals allow for a MAP_SHARED
                 * read-only mapping, take care to not allow mprotect to revert
                 * protections.
                 */
                vma->vm_flags &= ~(VM_MAYWRITE);
        }
        ...
  }

And for the mm to know if a mapping is copy-on-write:

  static inline bool is_cow_mapping(vm_flags_t flags)
  {
        return (flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
  }

The patch fixes the issue by making the mprotect revert protection
happen only for shared mappings.  For private mappings, using mprotect
will have no effect on the seal behavior.

The F_SEAL_FUTURE_WRITE feature was introduced in v5.1 so v5.3.x stable
kernels would need a backport.

[akpm@linux-foundation.org: reflow comment, per Christoph]
Link: http://lkml.kernel.org/r/20191107195355.80608-1-joel@joelfernandes.org
Fixes: ab3948f58ff84 ("mm/memfd: add an F_SEAL_FUTURE_WRITE seal to memfd")
Signed-off-by: Nicolas Geoffray <ngeoffray@google.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/shmem.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2198,11 +2198,14 @@ static int shmem_mmap(struct file *file,
 			return -EPERM;
 
 		/*
-		 * Since the F_SEAL_FUTURE_WRITE seals allow for a MAP_SHARED
-		 * read-only mapping, take care to not allow mprotect to revert
-		 * protections.
+		 * Since an F_SEAL_FUTURE_WRITE sealed memfd can be mapped as
+		 * MAP_SHARED and read-only, take care to not allow mprotect to
+		 * revert protections on such mappings. Do this only for shared
+		 * mappings. For private mappings, don't need to mask
+		 * VM_MAYWRITE as we still want them to be COW-writable.
 		 */
-		vma->vm_flags &= ~(VM_MAYWRITE);
+		if (vma->vm_flags & VM_SHARED)
+			vma->vm_flags &= ~(VM_MAYWRITE);
 	}
 
 	file_accessed(file);


