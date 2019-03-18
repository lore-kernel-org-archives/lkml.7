Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81713C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 07:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 574D320857
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 07:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfCRH3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 03:29:52 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:50525 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfCRH3w (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Mon, 18 Mar 2019 03:29:52 -0400
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Mon, 18 Mar 2019 08:29:51 +0100
Received: from d104.suse.de (nwb-a10-snat.microfocus.com [10.120.13.201])
        by emea4-mta.ukb.novell.com with ESMTP (NOT encrypted); Mon, 18 Mar 2019 07:29:44 +0000
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, anshuman.khandual@arm.com,
        william.kucharski@oracle.com, hughd@google.com, jack@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2] mm: Fix __dump_page when mapping->host is not set
Date:   Mon, 18 Mar 2019 08:29:31 +0100
Message-Id: <20190318072931.29094-1-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Swap mapping->host is NULL, so let us protect __dump_page() for such cases.

Fixes: 1c6fb1d89e73c ("mm: print more information about mapping in __dump_page")
Signed-off-by: Oscar Salvador <osalvador@suse.de>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/debug.c b/mm/debug.c
index c0b31b6c3877..7759f12a8fbb 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -79,7 +79,7 @@ void __dump_page(struct page *page, const char *reason)
 		pr_warn("ksm ");
 	else if (mapping) {
 		pr_warn("%ps ", mapping->a_ops);
-		if (mapping->host->i_dentry.first) {
+		if (mapping->host && mapping->host->i_dentry.first) {
 			struct dentry *dentry;
 			dentry = container_of(mapping->host->i_dentry.first, struct dentry, d_u.d_alias);
 			pr_warn("name:\"%pd\" ", dentry);
-- 
2.13.7

