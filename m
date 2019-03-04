Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05763C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C88F6208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551687847;
	bh=AxsJp8CtWKHMs+x9bPG0lfxuERczGfpVg7Zd1dzrkAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ysIY0pCmT2hSqn8pdgWbLH+ddHDlIUmNqpc5L58bMc6iwGQBfJXRnLadR8db3Vlcj
	 WVUUGzQDIHD7DzR6lnfv+SPqV+zRyUx8Z+Z+Im99d3PrkeA8xEY7s5ptqOaThB37Gk
	 TVW9ZQZAGo+YroT/oxpYHeuj1ErEjG5lV+ta1PDk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfCDIYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:24:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:41230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbfCDIYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:24:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C0D920863;
        Mon,  4 Mar 2019 08:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551687842;
        bh=AxsJp8CtWKHMs+x9bPG0lfxuERczGfpVg7Zd1dzrkAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w4mHLEzHsrSOoXZnkqNXX5J/hTTVZek1T/1e738i4neg01wTZHASuDm6BigfbFbua
         7m+1TDERBaa88OxA2TFMHDwSWCjRvySn48cacedkphrz6clxqQ/y6n9OGSSs7UOTBP
         J2QX54PvLLcgaUc0wUFPkeFkTf9lsK8Rb1FQLM3g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, stable@kernel.org,
        Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 31/32] mm: enforce min addr even if capable() in expand_downwards()
Date:   Mon,  4 Mar 2019 09:22:19 +0100
Message-Id: <20190304081604.613235914@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081602.307094059@linuxfoundation.org>
References: <20190304081602.307094059@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2345,12 +2345,11 @@ int expand_downwards(struct vm_area_stru
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


