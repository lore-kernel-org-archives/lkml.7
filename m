Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC93FC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F84206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574143318;
	bh=nPuahU67wgS5gV79GMvwadFNCPdlDnysN69v1gmDYD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vM5+0UFBw06p7HNAMRCtyqKabjVauR24VlKutZm3L1KTY+R6WMbY2IY+ft/NK7Qz3
	 EJnUPiKrqLih1mBC6GVxxQ58p3jsws3RscZ+y+EgEbVJzSBQSt7bSt0Kcf66UiABII
	 JLz1KkVbVwAcRXCGF/+iLmLvtSWGQ9rkZh6nTcc8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbfKSGB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 01:01:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:38160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730708AbfKSFnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:43:17 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6EF8208C3;
        Tue, 19 Nov 2019 05:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142197;
        bh=nPuahU67wgS5gV79GMvwadFNCPdlDnysN69v1gmDYD8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GuKoHywbfIQtcUZoIhW7mvLG9knhr0tPQkwwDKW7bupuG+2dJQcl6qbc1uDBlTH1H
         JUSdYfxlMt8YuJtrnFjuk9WIRgTBvl4jjDLN52Axs46QS/71Z6++VLxuxiMJuxx2Hp
         GJBum+3TkbfE1puEHzIWm419iHAHjgM/aTXNxlxU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, zhong jiang <zhongjiang@huawei.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 4.19 422/422] memfd: Use radix_tree_deref_slot_protected to avoid the warning.
Date:   Tue, 19 Nov 2019 06:20:19 +0100
Message-Id: <20191119051426.540733163@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhong jiang <zhongjiang@huawei.com>

The commit 99b45e7a1ba1 ("memfd: Fix locking when tagging pins")
introduces the following warning messages.

*WARNING: suspicious RCU usage in memfd_wait_for_pins*

It is because we still use radix_tree_deref_slot without read_rcu_lock.
We should use radix_tree_deref_slot_protected instead in the case.

Cc: stable@vger.kernel.org
Fixes: 99b45e7a1ba1 ("memfd: Fix locking when tagging pins")
Signed-off-by: zhong jiang <zhongjiang@huawei.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/memfd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -41,7 +41,7 @@ static void memfd_tag_pins(struct addres
 
 	xa_lock_irq(&mapping->i_pages);
 	radix_tree_for_each_slot(slot, &mapping->i_pages, &iter, start) {
-		page = radix_tree_deref_slot(slot);
+		page = radix_tree_deref_slot_protected(slot, &mapping->i_pages.xa_lock);
 		if (!page || radix_tree_exception(page)) {
 			if (radix_tree_deref_retry(page)) {
 				slot = radix_tree_iter_retry(&iter);


