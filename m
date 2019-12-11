Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AA5C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F036208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576077057;
	bh=9zpLNPI5XZRFD6601chy04kpn9vCfjMzRQc3/zkWmVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xfj6RFZDg4Mm9oZfXzyhjDNu9s0qJzgAjizN6Mai0xxcWIYxHvA1cET/tKRTmX9mk
	 ixjIwaUdE/3Xh3t85iYr1fgyDPs37mk1zKnMPyvpXzA4TNctiTvY8ATi2/fmzN0l3z
	 vYXtxHMyT9t0cV647TNU3EnNRYmYFq+40KD2Stic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730845AbfLKPK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:10:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:59316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730835AbfLKPKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:10:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 784FC24658;
        Wed, 11 Dec 2019 15:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077053;
        bh=9zpLNPI5XZRFD6601chy04kpn9vCfjMzRQc3/zkWmVo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UYJap3NmmS7dl2Q61dJO55JioFopkmHkZdns5ILtTXL6qt0Jc8Sw8CHU22Yyu+/XP
         rj0urF6ni8vuYMl2k/xr3vETOn2LUHBuIEgmHnkSZ8tKZeN2QtCK67r79jbdtZ2KST
         hu6pFaLxhZKfBexXUfn7L9rFKvQnDfIpeLOtGCPY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 5.4 92/92] binder: Handle start==NULL in binder_update_page_range()
Date:   Wed, 11 Dec 2019 16:06:23 +0100
Message-Id: <20191211150303.283404907@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150221.977775294@linuxfoundation.org>
References: <20191211150221.977775294@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jann Horn <jannh@google.com>

commit 2a9edd056ed4fbf9d2e797c3fc06335af35bccc4 upstream.

The old loop wouldn't stop when reaching `start` if `start==NULL`, instead
continuing backwards to index -1 and crashing.

Luckily you need to be highly privileged to map things at NULL, so it's not
a big problem.

Fix it by adjusting the loop so that the loop variable is always in bounds.

This patch is deliberately minimal to simplify backporting, but IMO this
function could use a refactor. The jump labels in the second loop body are
horrible (the error gotos should be jumping to free_range instead), and
both loops would look nicer if they just iterated upwards through indices.
And the up_read()+mmput() shouldn't be duplicated like that.

Cc: stable@vger.kernel.org
Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
Signed-off-by: Jann Horn <jannh@google.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Link: https://lore.kernel.org/r/20191018205631.248274-3-jannh@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/android/binder_alloc.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -277,8 +277,7 @@ static int binder_update_page_range(stru
 	return 0;
 
 free_range:
-	for (page_addr = end - PAGE_SIZE; page_addr >= start;
-	     page_addr -= PAGE_SIZE) {
+	for (page_addr = end - PAGE_SIZE; 1; page_addr -= PAGE_SIZE) {
 		bool ret;
 		size_t index;
 
@@ -291,6 +290,8 @@ free_range:
 		WARN_ON(!ret);
 
 		trace_binder_free_lru_end(alloc, index);
+		if (page_addr == start)
+			break;
 		continue;
 
 err_vm_insert_page_failed:
@@ -298,7 +299,8 @@ err_vm_insert_page_failed:
 		page->page_ptr = NULL;
 err_alloc_page_failed:
 err_page_ptr_cleared:
-		;
+		if (page_addr == start)
+			break;
 	}
 err_no_vma:
 	if (mm) {


