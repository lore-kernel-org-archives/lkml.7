Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E8CC76190
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0298A218D4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563887537;
	bh=ZO1wGUmWSLKPo9gdfNOhIY94diLFMvhRrwi5O5KH5Dg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=gf90XjTGTZRT/a9XvqvdPJLv8cSRu0WhsFJMfVpxbbbiibKughimv51/agFSquNKF
	 dEvSF23Bhr1Xykl7SMw9QQFUzyRZyZcx6Mcy77BqRxHgkuzwznzN8BjjanjpmAvht+
	 EUMPMV338+4818oj0WIOH+Rzff9XtJNmVOUleXBU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389916AbfGWNMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 09:12:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728323AbfGWNMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 09:12:15 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE4EF21734;
        Tue, 23 Jul 2019 13:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563887534;
        bh=ZO1wGUmWSLKPo9gdfNOhIY94diLFMvhRrwi5O5KH5Dg=;
        h=From:To:Cc:Subject:Date:From;
        b=THmUzDONEyO1NATBaw9+6OuqUfeHe4ipWbIjPLQ/NzvjO64hlY6DK00Xr6DbflX6/
         eHD8o9DGxDG+tvbB3DbKvPaYfgNXokZExapLeFB4tkEYOMhESeYkqjI4FrdIWuKFlk
         zZ2HUxyee8m9rj9ugWJbnV5Hxpfrdt9Qq08x0uwQ=
From:   Jeff Layton <jlayton@kernel.org>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, lhenriques@suse.com, cmaiolino@redhat.com
Subject: [PATCH] mm: check for sleepable context in kvfree
Date:   Tue, 23 Jul 2019 09:12:12 -0400
Message-Id: <20190723131212.445-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A lot of callers of kvfree only go down the vfree path under very rare
circumstances, and so may never end up hitting the might_sleep_if in it.
Ensure that when kvfree is called, that it is operating in a context
where it is allowed to sleep.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Luis Henriques <lhenriques@suse.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 mm/util.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/util.c b/mm/util.c
index e6351a80f248..81ec2a003c86 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -482,6 +482,8 @@ EXPORT_SYMBOL(kvmalloc_node);
  */
 void kvfree(const void *addr)
 {
+	might_sleep_if(!in_interrupt());
+
 	if (is_vmalloc_addr(addr))
 		vfree(addr);
 	else
-- 
2.21.0

