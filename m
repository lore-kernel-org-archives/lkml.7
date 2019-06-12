Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE1BC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A335215EA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="osWFZDHN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbfFLTQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 15:16:14 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35919 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbfFLTQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 15:16:14 -0400
Received: by mail-qt1-f196.google.com with SMTP id p15so367378qtl.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 12:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=VM0X6sjIUXYgIgyRfttiOmJ9MQtVYKp30kcz3vOUcd8=;
        b=osWFZDHNmnVngzJkRWmhdL6JobmUmTjdYAA3S1jiMrMfY3FmdHH38icHv8dXo1Tohc
         mSXiMZChJeDdK+U8DMvHPW5aeQO8oKWBgQInrgerdzBRWqEAdKbBTTpYbG7l/KvSHJQm
         aWb6+MdEAuYAsGuzGQSX/eZavG1WjeWvJr8Covmg+XJdIsjtgkmJNfJPZcj7K1fiaTNg
         3pC2hp1o/HKnHMZLH8R4IVfHCmY0jMRECcspcwRN2a0I/M1hPWCtmiefmN6o+Ddx4Ahd
         i4vFCh3B8XD2dlYfMRgKSTj2DTy01/twYA7iKw3x3bJyhHahvFsSQMdT23cTRKPmirRq
         PJWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VM0X6sjIUXYgIgyRfttiOmJ9MQtVYKp30kcz3vOUcd8=;
        b=jntlQPACYhXDK28UUbOlGvdjK3nQijnl2Bmjt37y8Pp+ou7pxpzmYmhK37yBr9UPzS
         +lT7zAfXIuKPCAtXZazRI1Lp7woBOt2Lrj3upuj3WWtj6r1l3oAaNaymn0cZarTWlcX5
         F2/1JKjTHLEAEUqjOKBpwAvSkh8tJfebDtZmi7dtyPTZ7HKOw1N8SUpqbGwDkk+vu96E
         oL0jHmZeEJTOGigNKu+sMlSIpYAGPXotNOmqXJZ+iGzHax0DdHRRi6pr8yQ4eIx8GMWf
         kgYjvJ/b9ivdBlhhNyi2IHZ8488hY9WNECy7Q26RaaIqA2NI9n/m0C2iw05/Ohu/jYF+
         ML/A==
X-Gm-Message-State: APjAAAWLQBk7EczJ6a3reag5wvNAunmLX9dvWfAoYnV6uaOqz79QuB6M
        YsMVIPm+l7JOeikPW/uSGCEj/Q==
X-Google-Smtp-Source: APXvYqwq5OuLqmcTYHYFkbjfzskyM1J/2vUhrTfX19xKEL2RF3CO3MzulELPQ4bfvgWOTUb6ZbUhpg==
X-Received: by 2002:ac8:c0e:: with SMTP id k14mr29436661qti.72.1560366973092;
        Wed, 12 Jun 2019 12:16:13 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id d25sm209437qko.96.2019.06.12.12.16.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 12:16:12 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     dan.j.williams@intel.com, osalvador@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next] mm/hotplug: skip bad PFNs from pfn_to_online_page()
Date:   Wed, 12 Jun 2019 15:15:52 -0400
Message-Id: <1560366952-10660-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The linux-next commit "mm/sparsemem: Add helpers track active portions
of a section at boot" [1] causes a crash below when the first kmemleak
scan kthread kicks in. This is because kmemleak_scan() calls
pfn_to_online_page(() which calls pfn_valid_within() instead of
pfn_valid() on x86 due to CONFIG_HOLES_IN_ZONE=n.

The commit [1] did add an additional check of pfn_section_valid() in
pfn_valid(), but forgot to add it in the above code path.

page:ffffea0002748000 is uninitialized and poisoned
raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff
raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff
page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
------------[ cut here ]------------
kernel BUG at include/linux/mm.h:1084!
invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN PTI
CPU: 5 PID: 332 Comm: kmemleak Not tainted 5.2.0-rc4-next-20190612+ #6
Hardware name: Lenovo ThinkSystem SR530 -[7X07RCZ000]-/-[7X07RCZ000]-,
BIOS -[TEE113T-1.00]- 07/07/2017
RIP: 0010:kmemleak_scan+0x6df/0xad0
Call Trace:
 kmemleak_scan_thread+0x9f/0xc7
 kthread+0x1d2/0x1f0
 ret_from_fork+0x35/0x4

[1] https://patchwork.kernel.org/patch/10977957/

Signed-off-by: Qian Cai <cai@lca.pw>
---
 include/linux/memory_hotplug.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 0b8a5e5ef2da..f02be86077e3 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -28,6 +28,7 @@
 	unsigned long ___nr = pfn_to_section_nr(___pfn);	   \
 								   \
 	if (___nr < NR_MEM_SECTIONS && online_section_nr(___nr) && \
+	    pfn_section_valid(__nr_to_section(___nr), pfn) &&	   \
 	    pfn_valid_within(___pfn))				   \
 		___page = pfn_to_page(___pfn);			   \
 	___page;						   \
-- 
1.8.3.1

