Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C586AC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD912230D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142903;
	bh=WbJxy/8DRGlu9013th9fto4GeRgocDeBURwckfTCLQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VCvwoSJMUCcgVJEY+QWYFI0YYG26aOEttSIrAZxSEBF3RN8wyVcXDs8WgNj76eocM
	 GIRrkCEe2f+h/uSpXywktunhRjYRFdDGkk4Kf465YD8DtvaP+Czm7d7Af4sK/QH5ho
	 swpKpG+o8p/4W7TtZRNLlwplAdaacfvgKz/OqeA8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732229AbfKSFzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:55:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:53286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731647AbfKSFzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:55:00 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A97C21850;
        Tue, 19 Nov 2019 05:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142900;
        bh=WbJxy/8DRGlu9013th9fto4GeRgocDeBURwckfTCLQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=17Ntbhv+onuu/DCv8REc/SGGNpMpZKgZbEcLDcYaFziatZyoU852eyjCgSXmsKu1N
         8vVd4lePxJNrHEBnfBaGE00PcYzjoDgDKi3sTwd3VBw0KDXkpKf07l1M/G8aUNYRKw
         I7OODnZBklNtAqrJlRXn7PpTWkWCC9C9DCuAHyqQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, zhong jiang <zhongjiang@huawei.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 4.14 239/239] memfd: Use radix_tree_deref_slot_protected to avoid the warning.
Date:   Tue, 19 Nov 2019 06:20:39 +0100
Message-Id: <20191119051342.809188054@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051255.850204959@linuxfoundation.org>
References: <20191119051255.850204959@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhong jiang <zhongjiang@huawei.com>

The commit 391d4ee568b5 ("memfd: Fix locking when tagging pins")
introduces the following warning messages.

*WARNING: suspicious RCU usage in memfd_wait_for_pins*

It is because we still use radix_tree_deref_slot without read_rcu_lock.
We should use radix_tree_deref_slot_protected instead in the case.

Cc: stable@vger.kernel.org
Fixes: 391d4ee568b5 ("memfd: Fix locking when tagging pins")
Signed-off-by: zhong jiang <zhongjiang@huawei.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/shmem.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2664,7 +2664,7 @@ static void shmem_tag_pins(struct addres
 
 	spin_lock_irq(&mapping->tree_lock);
 	radix_tree_for_each_slot(slot, &mapping->page_tree, &iter, start) {
-		page = radix_tree_deref_slot(slot);
+		page = radix_tree_deref_slot_protected(slot, &mapping->tree_lock);
 		if (!page || radix_tree_exception(page)) {
 			if (radix_tree_deref_retry(page)) {
 				slot = radix_tree_iter_retry(&iter);


