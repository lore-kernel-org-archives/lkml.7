Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC92C3A5AA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2906322DBF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567621037;
	bh=EXJFMCe0j7c1JE5xw+Ox8ar2HYLuO+hkBy9PQix63Jw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HU2hkHq5t9iuUS/uWdrp8ktNX7qOkOTAnB1Naa8uBPRUuvomMKrBCUcIsAgSt2gHA
	 F2IeRgph5+/OqsIWpyHys1T5o/5UbFj0KAJkF7L1YosY3EJqYWTnFG55aJcSHIBR4S
	 yfaV/xAYxIqaS/i1F3yCcAF7Somyp9g+sqNQCSBw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390040AbfIDSNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:13:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:57836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389432AbfIDSNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:13:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF979206BA;
        Wed,  4 Sep 2019 18:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620790;
        bh=EXJFMCe0j7c1JE5xw+Ox8ar2HYLuO+hkBy9PQix63Jw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=weZzINd3KkCzHMRoR8spRBfrdGbtwL5GGFd3WPXTTu7n16ZxFK3tuUjvpJCWpxhnw
         Yfm+r9xGIOrLaWDxTHgs0DIzUgC5OB84blk832cgZPjtxnBv5b6m1nypx3CULh0FRw
         kKrWc2oKiy1e6ddnIvPzY6CEpLpsdvZ+oujHIAOg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Henry Burns <henrywolfeburns@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Jonathan Adams <jwadams@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.2 059/143] mm/zsmalloc.c: fix build when CONFIG_COMPACTION=n
Date:   Wed,  4 Sep 2019 19:53:22 +0200
Message-Id: <20190904175316.381917669@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175314.206239922@linuxfoundation.org>
References: <20190904175314.206239922@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@linux-foundation.org>

commit 441e254cd40dc03beec3c650ce6ce6074bc6517f upstream.

Fixes: 701d678599d0c1 ("mm/zsmalloc.c: fix race condition in zs_destroy_pool")
Link: http://lkml.kernel.org/r/201908251039.5oSbEEUT%25lkp@intel.com
Reported-by: kbuild test robot <lkp@intel.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Henry Burns <henrywolfeburns@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Jonathan Adams <jwadams@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/zsmalloc.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -2432,7 +2432,9 @@ struct zs_pool *zs_create_pool(const cha
 	if (!pool->name)
 		goto err;
 
+#ifdef CONFIG_COMPACTION
 	init_waitqueue_head(&pool->migration_wait);
+#endif
 
 	if (create_cache(pool))
 		goto err;


