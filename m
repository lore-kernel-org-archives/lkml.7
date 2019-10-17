Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3994FA372B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 01:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8061C2082C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 01:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="EK4oU0BZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406842AbfJQBZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 21:25:35 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34847 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406083AbfJQBZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 21:25:33 -0400
Received: by mail-pg1-f196.google.com with SMTP id p30so313095pgl.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 18:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=isMm51VtK/oRU6lGsD9w6jqnjg5iuBGo4uf1ljxv9U4=;
        b=EK4oU0BZG1V6UaQsnBNZnjXP8g8KxL/hhWkVyT8+14E8rqLSg3p2oglexNRbLfDRyD
         uEfvJrRT1xB9OLiujVi/H6ZYlpgtsIXX7v5bz1AeiKn7Cf5lHwzOGKals+WHChh0ctti
         rZVxpfdH6wI8CAMhz4odtR5tkZaQNKlfoegVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=isMm51VtK/oRU6lGsD9w6jqnjg5iuBGo4uf1ljxv9U4=;
        b=dcPgd4JpXxuH9VBVHyXEV6ijSqaFw5YrYgToUmCRAZgmNlJCP7ifH/568beuImRYMH
         LJ+NqVSyXgJrM5iS48D4N/qODZftA/lt/PxFWo0Ma7xvl964NfHV8pujzTzzy7LdzuUO
         UVSDa/E9sLqv+Nm5xTW52YB89O2ws3bTMXSdrD1uZM92EcrO0i2wkWCycshS26Rb1a6+
         WG+zvfb6+gDMNoN8KQX/BxuRiGPBghQ9XASOz5bb+4XgIOZqI1P7tWJZCqj2c7Ngz0ct
         smNb3wnX29x818q+vs81aSqF+S3UzuN4M/xOaX1JXfYEZsNP5QO0xB0nXAbagvVvPjOD
         FnFw==
X-Gm-Message-State: APjAAAXF8anJFcORKLnGM8mcJlape7O5r00y7IWuq95foJKnkZI1Z+0R
        d7/DmS/wjV3eH5pR6jP2I8z8fg==
X-Google-Smtp-Source: APXvYqz8KIe0XQW6K5vnFa8nQQJeKdiESpPZJX7VNQmEzPXTQBBRxJ6FkEGke8hAC3oYssSRd5RjMQ==
X-Received: by 2002:a63:d916:: with SMTP id r22mr1243029pgg.46.1571275532214;
        Wed, 16 Oct 2019 18:25:32 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net. [59.167.251.205])
        by smtp.gmail.com with ESMTPSA id f89sm391422pje.20.2019.10.16.18.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 18:25:31 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     kasan-dev@googlegroups.com, linux-mm@kvack.org, x86@kernel.org,
        aryabinin@virtuozzo.com, glider@google.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, christophe.leroy@c-s.fr
Cc:     linuxppc-dev@lists.ozlabs.org, gor@linux.ibm.com,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH v9 4/5] x86/kasan: support KASAN_VMALLOC
Date:   Thu, 17 Oct 2019 12:25:05 +1100
Message-Id: <20191017012506.28503-5-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017012506.28503-1-dja@axtens.net>
References: <20191017012506.28503-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the case where KASAN directly allocates memory to back vmalloc
space, don't map the early shadow page over it.

We prepopulate pgds/p4ds for the range that would otherwise be empty.
This is required to get it synced to hardware on boot, allowing the
lower levels of the page tables to be filled dynamically.

Acked-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Daniel Axtens <dja@axtens.net>

---
v5: fix some checkpatch CHECK warnings. There are some that remain
    around lines ending with '(': I have not changed these because
    it's consistent with the rest of the file and it's not easy to
    see how to fix it without creating an overlong line or lots of
    temporary variables.

v2: move from faulting in shadow pgds to prepopulating
---
 arch/x86/Kconfig            |  1 +
 arch/x86/mm/kasan_init_64.c | 60 +++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git arch/x86/Kconfig arch/x86/Kconfig
index abe822d52167..92f5d5d5c78a 100644
--- arch/x86/Kconfig
+++ arch/x86/Kconfig
@@ -135,6 +135,7 @@ config X86
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN			if X86_64
+	select HAVE_ARCH_KASAN_VMALLOC		if X86_64
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS		if MMU
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if MMU && COMPAT
diff --git arch/x86/mm/kasan_init_64.c arch/x86/mm/kasan_init_64.c
index 296da58f3013..8f00f462709e 100644
--- arch/x86/mm/kasan_init_64.c
+++ arch/x86/mm/kasan_init_64.c
@@ -245,6 +245,51 @@ static void __init kasan_map_early_shadow(pgd_t *pgd)
 	} while (pgd++, addr = next, addr != end);
 }
 
+static void __init kasan_shallow_populate_p4ds(pgd_t *pgd,
+					       unsigned long addr,
+					       unsigned long end,
+					       int nid)
+{
+	p4d_t *p4d;
+	unsigned long next;
+	void *p;
+
+	p4d = p4d_offset(pgd, addr);
+	do {
+		next = p4d_addr_end(addr, end);
+
+		if (p4d_none(*p4d)) {
+			p = early_alloc(PAGE_SIZE, nid, true);
+			p4d_populate(&init_mm, p4d, p);
+		}
+	} while (p4d++, addr = next, addr != end);
+}
+
+static void __init kasan_shallow_populate_pgds(void *start, void *end)
+{
+	unsigned long addr, next;
+	pgd_t *pgd;
+	void *p;
+	int nid = early_pfn_to_nid((unsigned long)start);
+
+	addr = (unsigned long)start;
+	pgd = pgd_offset_k(addr);
+	do {
+		next = pgd_addr_end(addr, (unsigned long)end);
+
+		if (pgd_none(*pgd)) {
+			p = early_alloc(PAGE_SIZE, nid, true);
+			pgd_populate(&init_mm, pgd, p);
+		}
+
+		/*
+		 * we need to populate p4ds to be synced when running in
+		 * four level mode - see sync_global_pgds_l4()
+		 */
+		kasan_shallow_populate_p4ds(pgd, addr, next, nid);
+	} while (pgd++, addr = next, addr != (unsigned long)end);
+}
+
 #ifdef CONFIG_KASAN_INLINE
 static int kasan_die_handler(struct notifier_block *self,
 			     unsigned long val,
@@ -352,9 +397,24 @@ void __init kasan_init(void)
 	shadow_cpu_entry_end = (void *)round_up(
 			(unsigned long)shadow_cpu_entry_end, PAGE_SIZE);
 
+	/*
+	 * If we're in full vmalloc mode, don't back vmalloc space with early
+	 * shadow pages. Instead, prepopulate pgds/p4ds so they are synced to
+	 * the global table and we can populate the lower levels on demand.
+	 */
+#ifdef CONFIG_KASAN_VMALLOC
+	kasan_shallow_populate_pgds(
+		kasan_mem_to_shadow((void *)PAGE_OFFSET + MAXMEM),
+		kasan_mem_to_shadow((void *)VMALLOC_END));
+
+	kasan_populate_early_shadow(
+		kasan_mem_to_shadow((void *)VMALLOC_END + 1),
+		shadow_cpu_entry_begin);
+#else
 	kasan_populate_early_shadow(
 		kasan_mem_to_shadow((void *)PAGE_OFFSET + MAXMEM),
 		shadow_cpu_entry_begin);
+#endif
 
 	kasan_populate_shadow((unsigned long)shadow_cpu_entry_begin,
 			      (unsigned long)shadow_cpu_entry_end, 0);
-- 
2.20.1

