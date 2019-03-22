Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280BCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E911F21916
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254174;
	bh=4FkdIpUmP/3J/uRjOjWPsqa+g1PtbAG7Quj1utkhs64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=shKjN9Oocc/yG/H8tPbTxv+fH2r3XN+9EzewP5iVpCwHzLQ6PDvwqosOTZswAVL4d
	 ReSmRtNzVU4/h1zfkLzSodJVaGUfWVHPX627fem6xG+D8HTcs6hTnXL97OL5XJcwA9
	 OxHrL0wbdRimeGrFo+A25WoJpN6p/Y2hMUL5vpWk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbfCVL3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:29:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:57346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729806AbfCVL32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:29:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6345620449;
        Fri, 22 Mar 2019 11:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254167;
        bh=4FkdIpUmP/3J/uRjOjWPsqa+g1PtbAG7Quj1utkhs64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a8IF0n/ZLbiq8HHMw5FL5MKTzUFLx5EoJFAOSU4qXXjV3w7/fzY+ijvsm65sFFdS9
         c8zHeiRn0m5eEvDl/V/IlR3YEiwL4ixL/ZUWNDeiYUar5pXiWY1JrhIRQPSnTKIsRN
         nJT5lthdSkVBj2oyErTUHwlL/ZEsM8NTzH9Px0Uk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, stable@kernel.org,
        Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.4 053/230] mm: enforce min addr even if capable() in expand_downwards()
Date:   Fri, 22 Mar 2019 12:13:11 +0100
Message-Id: <20190322111240.413735370@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jann Horn <jannh@google.com>

commit 0a1d52994d440e21def1c2174932410b4f2a98a1 upstream.

security_mmap_addr() does a capability check with current_cred(), but
we can reach this code from contexts like a VFS write handler where
current_cred() must not be used.

This can be abused on systems without SMAP to make NULL pointer
dereferences exploitable again.

Fixes: 8869477a49c3 ("security: protect from stack expansion into low vm addresses")
Cc: stable@kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/mmap.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2294,12 +2294,11 @@ int expand_downwards(struct vm_area_stru
 	struct mm_struct *mm = vma->vm_mm;
 	struct vm_area_struct *prev;
 	unsigned long gap_addr;
-	int error;
+	int error = 0;
 
 	address &= PAGE_MASK;
-	error = security_mmap_addr(address);
-	if (error)
-		return error;
+	if (address < mmap_min_addr)
+		return -EPERM;
 
 	/* Enforce stack_guard_gap */
 	gap_addr = address - stack_guard_gap;


