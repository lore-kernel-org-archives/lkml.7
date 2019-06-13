Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26B2C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B03D2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731941AbfFMQr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:47:27 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36589 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730263AbfFME72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 00:59:28 -0400
Received: by mail-pl1-f195.google.com with SMTP id d21so7568613plr.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 21:59:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h0KDBfDB37l8E729U6HPxYoMiRVAhHq+dt2xwEVXrE0=;
        b=Ni+355mJqMvKQGOnmbJQzu3m4PJ9CA624fAMrccya+HI2DGDihIowjEzYxwzO0MEpA
         dQri3wzNKWyIBjDyj/1XP/c0kqCdrVJl4fl6pwT3e5vhuXGAt3NFqM0DPw0FIYzAuqvw
         NR6Gq8WrBXSIiTvMDZUJPF190uTp4i0s+h+H2vbyXCReT/L6XruAZCET3b4sILbYOyFV
         +hKqHyuQVAh4PWb7KZ1vQgSRAV9VDK0OLzrU+ilUXlkruA9XAFc9kFP3WHCY3SFkmOmp
         W1IjMbCMoNgpRmi5ACr5/okpFhPSxobbUNbM/C84hr6atoxFHCZk6y5/pcpFDgm+P+8Y
         9oMQ==
X-Gm-Message-State: APjAAAUExdahMHQF2CCeBrf8pcPEhlfS62sHbYKKL3gqXbalFMDkWXi2
        YjHNKPkVI4FU4FCahjMZjmLn0m/qEmw=
X-Google-Smtp-Source: APXvYqxCl1a5suJ3MnTqqHdFeNLn+c5SeHAoTPTmnzXIxBvsnXonhgqCq6bEhWAzZzIHrIUoeWF5+w==
X-Received: by 2002:a17:902:2983:: with SMTP id h3mr41707291plb.45.1560401967290;
        Wed, 12 Jun 2019 21:59:27 -0700 (PDT)
Received: from htb-2n-eng-dhcp405.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id o66sm1215327pfb.86.2019.06.12.21.59.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 21:59:26 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Nadav Amit <namit@vmware.com>, Borislav Petkov <bp@suse.de>,
        Toshi Kani <toshi.kani@hpe.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 3/3] resource: Introduce resource cache
Date:   Wed, 12 Jun 2019 21:59:03 -0700
Message-Id: <20190613045903.4922-4-namit@vmware.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613045903.4922-1-namit@vmware.com>
References: <20190613045903.4922-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For efficient search of resources, as needed to determine the memory
type for dax page-faults, introduce a cache of the most recently used
top-level resource. Caching the top-level should be safe as ranges in
that level do not overlap (unlike those of lower levels).

Keep the cache per-cpu to avoid possible contention. Whenever a resource
is added, removed or changed, invalidate all the resources. The
invalidation takes place when the resource_lock is taken for write,
preventing possible races.

This patch provides relatively small performance improvements over the
previous patch (~0.5% on sysbench), but can benefit systems with many
resources.

Cc: Borislav Petkov <bp@suse.de>
Cc: Toshi Kani <toshi.kani@hpe.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 kernel/resource.c | 51 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 51c3bf6d9b98..ab659d0eb52a 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -53,6 +53,12 @@ struct resource_constraint {
 
 static DEFINE_RWLOCK(resource_lock);
 
+/*
+ * Cache of the top-level resource that was most recently use by
+ * find_next_iomem_res().
+ */
+static DEFINE_PER_CPU(struct resource *, resource_cache);
+
 /*
  * For memory hotplug, there is no way to free resource entries allocated
  * by boot mem after the system is up. So for reusing the resource entry
@@ -262,9 +268,20 @@ static void __release_child_resources(struct resource *r)
 	}
 }
 
+static void invalidate_resource_cache(void)
+{
+	int cpu;
+
+	lockdep_assert_held_exclusive(&resource_lock);
+
+	for_each_possible_cpu(cpu)
+		per_cpu(resource_cache, cpu) = NULL;
+}
+
 void release_child_resources(struct resource *r)
 {
 	write_lock(&resource_lock);
+	invalidate_resource_cache();
 	__release_child_resources(r);
 	write_unlock(&resource_lock);
 }
@@ -281,6 +298,7 @@ struct resource *request_resource_conflict(struct resource *root, struct resourc
 	struct resource *conflict;
 
 	write_lock(&resource_lock);
+	invalidate_resource_cache();
 	conflict = __request_resource(root, new);
 	write_unlock(&resource_lock);
 	return conflict;
@@ -312,6 +330,7 @@ int release_resource(struct resource *old)
 	int retval;
 
 	write_lock(&resource_lock);
+	invalidate_resource_cache();
 	retval = __release_resource(old, true);
 	write_unlock(&resource_lock);
 	return retval;
@@ -343,7 +362,7 @@ static int find_next_iomem_res(resource_size_t start, resource_size_t end,
 			       bool first_lvl, struct resource *res)
 {
 	bool siblings_only = true;
-	struct resource *p;
+	struct resource *p, *res_first_lvl;
 
 	if (!res)
 		return -EINVAL;
@@ -353,7 +372,15 @@ static int find_next_iomem_res(resource_size_t start, resource_size_t end,
 
 	read_lock(&resource_lock);
 
-	for (p = iomem_resource.child; p; p = next_resource(p, siblings_only)) {
+	/*
+	 * If our cached entry preceded or matches the range that we are looking
+	 * for, start with it. Otherwise, start from the beginning.
+	 */
+	p = res_first_lvl = this_cpu_read(resource_cache);
+	if (!p || start < p->start)
+		p = iomem_resource.child;
+
+	for (; p; p = next_resource(p, siblings_only)) {
 		/* If we passed the resource we are looking for, stop */
 		if (p->start > end) {
 			p = NULL;
@@ -364,6 +391,10 @@ static int find_next_iomem_res(resource_size_t start, resource_size_t end,
 		if (p->end < start)
 			continue;
 
+		/* We only cache the first level for correctness */
+		if (p->parent == &iomem_resource)
+			res_first_lvl = p;
+
 		/*
 		 * Now that we found a range that matches what we look for,
 		 * check the flags and the descriptor. If we were not asked to
@@ -386,6 +417,9 @@ static int find_next_iomem_res(resource_size_t start, resource_size_t end,
 		res->end = min(end, p->end);
 		res->flags = p->flags;
 		res->desc = p->desc;
+
+		/* Update the cache */
+		this_cpu_write(resource_cache, res_first_lvl);
 	}
 
 	read_unlock(&resource_lock);
@@ -674,6 +708,7 @@ static int reallocate_resource(struct resource *root, struct resource *old,
 	struct resource *conflict;
 
 	write_lock(&resource_lock);
+	invalidate_resource_cache();
 
 	if ((err = __find_resource(root, old, &new, newsize, constraint)))
 		goto out;
@@ -744,6 +779,7 @@ int allocate_resource(struct resource *root, struct resource *new,
 	}
 
 	write_lock(&resource_lock);
+	invalidate_resource_cache();
 	err = find_resource(root, new, size, &constraint);
 	if (err >= 0 && __request_resource(root, new))
 		err = -EBUSY;
@@ -848,6 +884,7 @@ struct resource *insert_resource_conflict(struct resource *parent, struct resour
 	struct resource *conflict;
 
 	write_lock(&resource_lock);
+	invalidate_resource_cache();
 	conflict = __insert_resource(parent, new);
 	write_unlock(&resource_lock);
 	return conflict;
@@ -886,6 +923,7 @@ void insert_resource_expand_to_fit(struct resource *root, struct resource *new)
 		return;
 
 	write_lock(&resource_lock);
+	invalidate_resource_cache();
 	for (;;) {
 		struct resource *conflict;
 
@@ -926,6 +964,7 @@ int remove_resource(struct resource *old)
 	int retval;
 
 	write_lock(&resource_lock);
+	invalidate_resource_cache();
 	retval = __release_resource(old, false);
 	write_unlock(&resource_lock);
 	return retval;
@@ -985,6 +1024,7 @@ int adjust_resource(struct resource *res, resource_size_t start,
 	int result;
 
 	write_lock(&resource_lock);
+	invalidate_resource_cache();
 	result = __adjust_resource(res, start, size);
 	write_unlock(&resource_lock);
 	return result;
@@ -1059,6 +1099,8 @@ reserve_region_with_split(struct resource *root, resource_size_t start,
 	int abort = 0;
 
 	write_lock(&resource_lock);
+	invalidate_resource_cache();
+
 	if (root->start > start || root->end < end) {
 		pr_err("requested range [0x%llx-0x%llx] not in root %pr\n",
 		       (unsigned long long)start, (unsigned long long)end,
@@ -1135,6 +1177,7 @@ struct resource * __request_region(struct resource *parent,
 	res->end = start + n - 1;
 
 	write_lock(&resource_lock);
+	invalidate_resource_cache();
 
 	for (;;) {
 		struct resource *conflict;
@@ -1168,6 +1211,7 @@ struct resource * __request_region(struct resource *parent,
 			schedule();
 			remove_wait_queue(&muxed_resource_wait, &wait);
 			write_lock(&resource_lock);
+			invalidate_resource_cache();
 			continue;
 		}
 		/* Uhhuh, that didn't work out.. */
@@ -1198,6 +1242,7 @@ void __release_region(struct resource *parent, resource_size_t start,
 	end = start + n - 1;
 
 	write_lock(&resource_lock);
+	invalidate_resource_cache();
 
 	for (;;) {
 		struct resource *res = *p;
@@ -1211,6 +1256,7 @@ void __release_region(struct resource *parent, resource_size_t start,
 			}
 			if (res->start != start || res->end != end)
 				break;
+
 			*p = res->sibling;
 			write_unlock(&resource_lock);
 			if (res->flags & IORESOURCE_MUXED)
@@ -1268,6 +1314,7 @@ int release_mem_region_adjustable(struct resource *parent,
 
 	p = &parent->child;
 	write_lock(&resource_lock);
+	invalidate_resource_cache();
 
 	while ((res = *p)) {
 		if (res->start >= end)
-- 
2.20.1

