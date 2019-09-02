Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0541C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 11:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D21C21882
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 11:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="gDXdH1Vz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731522AbfIBLWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 07:22:04 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43004 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730207AbfIBLWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 07:22:04 -0400
Received: by mail-pl1-f194.google.com with SMTP id y1so6476417plp.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 04:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Pi33Ab5H1THuUOlmFKCqF9xJSMT6s+LImLmp8toPnA=;
        b=gDXdH1Vzt9MxAmqX7AuRJKG5lhNoxBKVnKniwrJl5XzSGvzlnrJnb+p31PYrO9K9gG
         6oKXzhCh06wj46HhNFqV2lhipcEhwXhF2tZ88V/ROZ9ZIxL6YbGKCrH1NnlcBZTiBpbZ
         GPFRkVKygJf7mZNWWmmm8N1pkU1UFrSxNc9LQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Pi33Ab5H1THuUOlmFKCqF9xJSMT6s+LImLmp8toPnA=;
        b=hms9WJJAjqLuis8nidVO6GvZ34dATsS31DXAh35rXW1t2ockL8RfwaZ1qQ4AWN+PhT
         g/NiHsg8bwu5dL/2OrRsVue40mWs/x2GNe96SVNE7mJkMLlv61/RgtSqvLIu/k5cNmW6
         Gq+Xd3oAx5MniRVASZNxI1Ebgg3KQAmv4ky3YoRdz0Yo1JKW/stDUKrQO6gxeWBbz+ne
         RGa6Utv9+H0mamgu8OeljmdApNxWHfJmEy+ukWLf62qjd0kWipj/HzYgKVWfRDHSdtnC
         UPNUMkUupFB+gprKeogL6m/sNC7YETj9VBaCo3qqdRJV4k8W2VBFrnL75grnQYSNf4ij
         eNrw==
X-Gm-Message-State: APjAAAV+k6iCS9rExfM/1QCoDCzROyWJ7J1d/MVv4CnwsW66UUA67hWP
        8g1VA3RDl35Y2pYhyf39Xk1fdw==
X-Google-Smtp-Source: APXvYqwOuMIC7qhrbPrEee+w2Q+KHHV7BK3R6x7r58fT6LOhqr2EZe5BvG/TJ1wJkhZZ3klGYrUUDQ==
X-Received: by 2002:a17:902:b08f:: with SMTP id p15mr5676763plr.49.1567423323788;
        Mon, 02 Sep 2019 04:22:03 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net. [59.167.251.205])
        by smtp.gmail.com with ESMTPSA id i6sm9452487pfq.20.2019.09.02.04.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 04:22:03 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     kasan-dev@googlegroups.com, linux-mm@kvack.org, x86@kernel.org,
        aryabinin@virtuozzo.com, glider@google.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, christophe.leroy@c-s.fr
Cc:     linuxppc-dev@lists.ozlabs.org, gor@linux.ibm.com,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH v6 4/5] x86/kasan: support KASAN_VMALLOC
Date:   Mon,  2 Sep 2019 21:20:27 +1000
Message-Id: <20190902112028.23773-5-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190902112028.23773-1-dja@axtens.net>
References: <20190902112028.23773-1-dja@axtens.net>
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

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2502f7f60c9c..300b4766ccfa 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -134,6 +134,7 @@ config X86
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN			if X86_64
+	select HAVE_ARCH_KASAN_VMALLOC		if X86_64
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS		if MMU
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if MMU && COMPAT
diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index 296da58f3013..8f00f462709e 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
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

