Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315C9C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 18:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0876920B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 18:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="lMwqpl2J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfJJSdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 14:33:16 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38501 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfJJSdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 14:33:16 -0400
Received: by mail-qk1-f194.google.com with SMTP id x4so2598901qkx.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 11:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=UMGkm8vlJcXfwuaXc8Eh6q4HwPOEO5uzQitJ0iRzkKw=;
        b=lMwqpl2JmzHxPY0WofpK4cnZygbmHL2Gsrbxjc36tMEiL3FohF2kw1FhNWQvWMmXQ3
         qL3Mn+m8kMaVaG6HK6WOnvab/PZI5LLW+JsNt8JfNZKmXsz5ej3SdHjlJmSQyQOVHIOZ
         WbieWlTTkQ7urEeXPi+5vNrN/ZFqrXYb4TuldKVahk7gJbf8/0lvln7fqtIUw9JRQfNt
         lfnx+OYCO8YpuENipcpybxFshBYK0tb77U3psNShAmJABds2GoCH/JvtGcs/TbypX4Hx
         DiJNYLldutuIgbd1LUyGuN9b9+FEM/qKjeH+TzawX97ttl1Knffq2Tu/G/8Jsv/xUvGT
         xYXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UMGkm8vlJcXfwuaXc8Eh6q4HwPOEO5uzQitJ0iRzkKw=;
        b=T0GKG8ti0OJzTiXB2zumQa5bChkkUJArICVOKY4iOXevRy4b/tPzegGm6WB8+LZN3J
         oU04ty7DYzGFqpLNQa5rdQ78NVkjER6bqQIeZUZuSFYCsEGGvm3gyt1jaDPCjC/KhcHV
         V7ZTzzbvpilTAqxP9ptDjl9lBXDUQbaY/Te09Wk/cd5wYbrzVNNgYGjLZ7XvN8ob6aab
         PLpX1RanE1TxjtiwN3MuvxZgSnPGVYFLMaogpuhxsCSvqlSPksncsLHYJQKSlIvcJ8lx
         Pn6PuSYrcIjJiZzKR3beWUEFUuiTbDBG18ZlA8P3fJqw6R84vvqqgkXMlL3mhVobYgG7
         8q2g==
X-Gm-Message-State: APjAAAWqSv3Ib/caB9wtZVMROV9+n0FasOjX8itQyWbsYf/s81jZ++/S
        d16cL2H9jUqHcOV5O+cpSMmJ29aEPqA=
X-Google-Smtp-Source: APXvYqwIWhuCMnICE+C+HhJYXq5I4Gxdbiuzk0ivNFDBihrMDXlBtCSp8FMErPRENKQ9nkpGhZI8bw==
X-Received: by 2002:a05:620a:12c7:: with SMTP id e7mr11189984qkl.162.1570732395555;
        Thu, 10 Oct 2019 11:33:15 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id u123sm2746990qkh.120.2019.10.10.11.33.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 11:33:14 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] mm/page_owner: fix a crash after memory offline
Date:   Thu, 10 Oct 2019 14:32:46 -0400
Message-Id: <1570732366-16426-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The linux-next series "mm/memory_hotplug: Shrink zones before removing
memory" [1] seems make a crash easier to reproduce while reading
/proc/pagetypeinfo after offlining a memory section. Fix it by using
pfn_to_online_page() in the PFN walker.

[1] https://lore.kernel.org/linux-mm/20191006085646.5768-1-david@redhat.com/

page:ffffea0021200000 is uninitialized and poisoned
raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff
raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff
page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
There is not page extension available.
------------[ cut here ]------------
kernel BUG at include/linux/mm.h:1107!
RIP: 0010:pagetypeinfo_showmixedcount_print+0x4fb/0x680
Call Trace:
 walk_zones_in_node+0x3a/0xc0
 pagetypeinfo_show+0x260/0x2c0
 seq_read+0x27e/0x710
 proc_reg_read+0x12e/0x190
 __vfs_read+0x50/0xa0
 vfs_read+0xcb/0x1e0
 ksys_read+0xc6/0x160
 __x64_sys_read+0x43/0x50
 do_syscall_64+0xcc/0xaec
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/page_owner.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index dee931184788..03a6b19b3cdd 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -296,11 +296,10 @@ void pagetypeinfo_showmixedcount_print(struct seq_file *m,
 		pageblock_mt = get_pageblock_migratetype(page);
 
 		for (; pfn < block_end_pfn; pfn++) {
-			if (!pfn_valid_within(pfn))
+			page = pfn_to_online_page(pfn);
+			if (!page)
 				continue;
 
-			page = pfn_to_page(pfn);
-
 			if (page_zone(page) != zone)
 				continue;
 
-- 
1.8.3.1

