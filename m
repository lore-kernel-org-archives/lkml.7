Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24CCC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 708C120637
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574418928;
	bh=wdelKJofsea4ejOrCFnoP4sWAiQO/Sw8Fby/doyW6Sk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uI3rzg1sOIL00ChCvjAEN0QLmLlXZtV++BeNt+O+Fy1y6gUqp6kHaSuJBVMSak4/6
	 B79X6itGQ9FJSZVoGrRMkRDyTCCQRrbDNjsafzhhmSO7OAkMvX4Jm2l+jkXKtrdIHq
	 GO+cQNVl2d2+MN9mFfHj+lWfGs2Z6QJYGbWMkqS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbfKVKf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:35:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:33536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727388AbfKVKfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:35:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A59BE20637;
        Fri, 22 Nov 2019 10:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574418924;
        bh=wdelKJofsea4ejOrCFnoP4sWAiQO/Sw8Fby/doyW6Sk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e8Vh8VI3vuniwKnWScme6N14cHl7nTdBJOMgR7wRbFrJExkCk6K90tI1e5dNp+pbl
         /6HAj5051tMP0eA+/mPPX9RSo7V9MdfsDiww2SWu7IvqYyJyoamoQXntJzPFTvU8zh
         XWi9oaDwD6/9aEXvta2urjHNX/v61ZP0fE7AX/c8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, zhong jiang <zhongjiang@huawei.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 4.4 098/159] memfd: Use radix_tree_deref_slot_protected to avoid the warning.
Date:   Fri, 22 Nov 2019 11:28:09 +0100
Message-Id: <20191122100818.517338061@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100704.194776704@linuxfoundation.org>
References: <20191122100704.194776704@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhong jiang <zhongjiang@huawei.com>

The commit eb4058d8daf8 ("memfd: Fix locking when tagging pins")
introduces the following warning messages.

*WARNING: suspicious RCU usage in memfd_wait_for_pins*

It is because we still use radix_tree_deref_slot without read_rcu_lock.
We should use radix_tree_deref_slot_protected instead in the case.

Cc: stable@vger.kernel.org
Fixes: eb4058d8daf8 ("memfd: Fix locking when tagging pins")
Signed-off-by: zhong jiang <zhongjiang@huawei.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/shmem.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1862,7 +1862,7 @@ static void shmem_tag_pins(struct addres
 	spin_lock_irq(&mapping->tree_lock);
 restart:
 	radix_tree_for_each_slot(slot, &mapping->page_tree, &iter, start) {
-		page = radix_tree_deref_slot(slot);
+		page = radix_tree_deref_slot_protected(slot, &mapping->tree_lock);
 		if (!page || radix_tree_exception(page)) {
 			if (radix_tree_deref_retry(page))
 				goto restart;


