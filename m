Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9814FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684DB21019
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688064;
	bh=X91o3poVfr08GbmmqVW1AyliYlUZ9sIHp2Jmp6PbG+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XiRGAffb/I8FspO3aGtMxjrSwKmAhfTszcurP5OVqIRsVehAfRekb20X1N6EGPSaE
	 8v77xV0B29LUwxdis7djI6qL0h3tq16BGdgDylkXh1xrxqdJ+utwrOVoNkTlZJGNfl
	 79nVHZ1GtCuytPfKBUV7Z77NtXC9zIkZr+TDXNA8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfCDI1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:27:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:51628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726808AbfCDI1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:27:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E43A4208E4;
        Mon,  4 Mar 2019 08:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688057;
        bh=X91o3poVfr08GbmmqVW1AyliYlUZ9sIHp2Jmp6PbG+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yxm6NhKGMK+4t4OnnJP+13VUW4rUkw/IREnpz3CfydeAk+Us0iGhDf9/KPm6O6xnm
         TetKRvVdLnVPLYosDYVwaGs56vLxOPuZOFUoz7IgUgconaj+KaaS+AvIpV+un/m16x
         SmEu/wRk4K33dDbdPhL+3CctxVyKfEhSFdMw7q9Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, stable@kernel.org,
        Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 49/52] mm: enforce min addr even if capable() in expand_downwards()
Date:   Mon,  4 Mar 2019 09:22:47 +0100
Message-Id: <20190304081619.911595342@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081617.159014799@linuxfoundation.org>
References: <20190304081617.159014799@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2348,12 +2348,11 @@ int expand_downwards(struct vm_area_stru
 {
 	struct mm_struct *mm = vma->vm_mm;
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


