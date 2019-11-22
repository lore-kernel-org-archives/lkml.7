Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D04AC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E623A2070E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574421648;
	bh=1cb9MWqtHS9XKZYwGFko2caVYbppdnjIrOxi/cdSZbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FzKjOr5eYkJmeFK47u1dn2aOpq36Z2BD6uOmB8vM108tIJKNEZvMnGIR0UcsHYyuT
	 4sjFxegfMmAzEhp0kd0OvPrrjjTkDLP9aNvOBRKpVt58dS3moviHDtU5r+MK1zKxYr
	 Wg5avVp3VaxF3rWfT4bPeZ4D7I21JwRA53zAjBwk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbfKVKpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:45:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:52264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729521AbfKVKpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:45:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45D6C20718;
        Fri, 22 Nov 2019 10:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419541;
        bh=1cb9MWqtHS9XKZYwGFko2caVYbppdnjIrOxi/cdSZbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AlT73KSCUU0uQ+DVZKeUGHMHdAL1++rZ17VLt5agtA+RrvkWedBmosFBu/x4n+nK3
         tCAAPpiZX3nm5/erbY7zPUWtDHfeBhj7RjfibUrGS62HuFr98o7C3/arv9teQ2MNtd
         qadOrjxmzkqnF/L6gS0uDwbp/Sa6vKAcfxvqdseo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, zhong jiang <zhongjiang@huawei.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 4.9 146/222] memfd: Use radix_tree_deref_slot_protected to avoid the warning.
Date:   Fri, 22 Nov 2019 11:28:06 +0100
Message-Id: <20191122100913.339562558@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100830.874290814@linuxfoundation.org>
References: <20191122100830.874290814@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhong jiang <zhongjiang@huawei.com>

The commit 3ce6b467b9b2 ("memfd: Fix locking when tagging pins")
introduces the following warning messages.

*WARNING: suspicious RCU usage in memfd_wait_for_pins*

It is because we still use radix_tree_deref_slot without read_rcu_lock.
We should use radix_tree_deref_slot_protected instead in the case.

Cc: stable@vger.kernel.org
Fixes: 3ce6b467b9b2 ("memfd: Fix locking when tagging pins")
Signed-off-by: zhong jiang <zhongjiang@huawei.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/shmem.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2464,7 +2464,7 @@ static void shmem_tag_pins(struct addres
 
 	spin_lock_irq(&mapping->tree_lock);
 	radix_tree_for_each_slot(slot, &mapping->page_tree, &iter, start) {
-		page = radix_tree_deref_slot(slot);
+		page = radix_tree_deref_slot_protected(slot, &mapping->tree_lock);
 		if (!page || radix_tree_exception(page)) {
 			if (radix_tree_deref_retry(page)) {
 				slot = radix_tree_iter_retry(&iter);


