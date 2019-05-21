Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2F4C072B5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 04:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B21C21019
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 04:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbfEUExv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 00:53:51 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:45435 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727882AbfEUExt (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Tue, 21 May 2019 00:53:49 -0400
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Tue, 21 May 2019 06:53:48 +0200
Received: from linux-r8p5.suse.de (nwb-a10-snat.microfocus.com [10.120.13.201])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Tue, 21 May 2019 05:53:19 +0100
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, willy@infradead.org, mhocko@kernel.org,
        mgorman@techsingularity.net, jglisse@redhat.com,
        ldufour@linux.vnet.ibm.com, dave@stgolabs.net,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 11/14] ipc: teach the mm about range locking
Date:   Mon, 20 May 2019 21:52:39 -0700
Message-Id: <20190521045242.24378-12-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190521045242.24378-1-dave@stgolabs.net>
References: <20190521045242.24378-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conversion is straightforward, mmap_sem is used within the
the same function context most of the time. No change in
semantics.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 ipc/shm.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/ipc/shm.c b/ipc/shm.c
index ce1ca9f7c6e9..3666fa71bfc2 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1418,6 +1418,7 @@ COMPAT_SYSCALL_DEFINE3(old_shmctl, int, shmid, int, cmd, void __user *, uptr)
 long do_shmat(int shmid, char __user *shmaddr, int shmflg,
 	      ulong *raddr, unsigned long shmlba)
 {
+	DEFINE_RANGE_LOCK_FULL(mmrange);
 	struct shmid_kernel *shp;
 	unsigned long addr = (unsigned long)shmaddr;
 	unsigned long size;
@@ -1544,7 +1545,7 @@ long do_shmat(int shmid, char __user *shmaddr, int shmflg,
 	if (err)
 		goto out_fput;
 
-	if (down_write_killable(&current->mm->mmap_sem)) {
+	if (mm_write_lock_killable(current->mm, &mmrange)) {
 		err = -EINTR;
 		goto out_fput;
 	}
@@ -1564,7 +1565,7 @@ long do_shmat(int shmid, char __user *shmaddr, int shmflg,
 	if (IS_ERR_VALUE(addr))
 		err = (long)addr;
 invalid:
-	up_write(&current->mm->mmap_sem);
+	mm_write_unlock(current->mm, &mmrange);
 	if (populate)
 		mm_populate(addr, populate);
 
@@ -1625,6 +1626,7 @@ COMPAT_SYSCALL_DEFINE3(shmat, int, shmid, compat_uptr_t, shmaddr, int, shmflg)
  */
 long ksys_shmdt(char __user *shmaddr)
 {
+	DEFINE_RANGE_LOCK_FULL(mmrange);
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	unsigned long addr = (unsigned long)shmaddr;
@@ -1638,7 +1640,7 @@ long ksys_shmdt(char __user *shmaddr)
 	if (addr & ~PAGE_MASK)
 		return retval;
 
-	if (down_write_killable(&mm->mmap_sem))
+	if (mm_write_lock_killable(mm, &mmrange))
 		return -EINTR;
 
 	/*
@@ -1726,7 +1728,7 @@ long ksys_shmdt(char __user *shmaddr)
 
 #endif
 
-	up_write(&mm->mmap_sem);
+	mm_write_unlock(mm, &mmrange);
 	return retval;
 }
 
-- 
2.16.4

