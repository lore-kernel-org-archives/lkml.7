Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0B4C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 222FB206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbfD0PZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:25:34 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33312 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727415AbfD0PPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:24 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2v-000144-St; Sat, 27 Apr 2019 16:15:22 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2n-0004dg-Mi; Sat, 27 Apr 2019 16:15:13 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Oleg Nesterov" <oleg@redhat.com>,
        "Hugh Dickins" <hughd@google.com>,
        "Michal Hocko" <mhocko@suse.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Larry Woodman" <lwoodman@redhat.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.395595783@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 180/202] mm/mmap.c: expand_downwards: don't require
 the gap if !vm_prev
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Oleg Nesterov <oleg@redhat.com>

commit 32e4e6d5cbb0c0e427391635991fe65e17797af8 upstream.

expand_stack(vma) fails if address < stack_guard_gap even if there is no
vma->vm_prev.  I don't think this makes sense, and we didn't do this
before the recent commit 1be7107fbe18 ("mm: larger stack guard gap,
between vmas").

We do not need a gap in this case, any address is fine as long as
security_mmap_addr() doesn't object.

This also simplifies the code, we know that address >= prev->vm_end and
thus underflow is not possible.

Link: http://lkml.kernel.org/r/20170628175258.GA24881@redhat.com
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Larry Woodman <lwoodman@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 mm/mmap.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2244,7 +2244,6 @@ int expand_downwards(struct vm_area_stru
 				   unsigned long address)
 {
 	struct vm_area_struct *prev;
-	unsigned long gap_addr;
 	int error;
 
 	address &= PAGE_MASK;
@@ -2253,15 +2252,12 @@ int expand_downwards(struct vm_area_stru
 		return error;
 
 	/* Enforce stack_guard_gap */
-	gap_addr = address - stack_guard_gap;
-	if (gap_addr > address)
-		return -ENOMEM;
 	prev = vma->vm_prev;
-	if (prev && prev->vm_end > gap_addr &&
+	/* Check that both stack segments have the same anon_vma? */
+	if (prev && !(prev->vm_flags & VM_GROWSDOWN) &&
 			(prev->vm_flags & (VM_WRITE|VM_READ|VM_EXEC))) {
-		if (!(prev->vm_flags & VM_GROWSDOWN))
+		if (address - prev->vm_end < stack_guard_gap)
 			return -ENOMEM;
-		/* Check that both stack segments have the same anon_vma? */
 	}
 
 	/* We must make sure the anon_vma is allocated. */

