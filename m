Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E00C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DDF4206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbfD0PZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:25:35 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33294 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727408AbfD0PPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:24 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2v-00014I-Id; Sat, 27 Apr 2019 16:15:21 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2n-0004dl-OS; Sat, 27 Apr 2019 16:15:13 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Jann Horn" <jannh@google.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.827059567@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 181/202] mm: enforce min addr even if capable() in
 expand_downwards()
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

From: Jann Horn <jannh@google.com>

commit 0a1d52994d440e21def1c2174932410b4f2a98a1 upstream.

security_mmap_addr() does a capability check with current_cred(), but
we can reach this code from contexts like a VFS write handler where
current_cred() must not be used.

This can be abused on systems without SMAP to make NULL pointer
dereferences exploitable again.

Fixes: 8869477a49c3 ("security: protect from stack expansion into low vm addresses")
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 mm/mmap.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2244,12 +2244,11 @@ int expand_downwards(struct vm_area_stru
 				   unsigned long address)
 {
 	struct vm_area_struct *prev;
-	int error;
+	int error = 0;
 
 	address &= PAGE_MASK;
-	error = security_mmap_addr(address);
-	if (error)
-		return error;
+	if (address < mmap_min_addr)
+		return -EPERM;
 
 	/* Enforce stack_guard_gap */
 	prev = vma->vm_prev;

