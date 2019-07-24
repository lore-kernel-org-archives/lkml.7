Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76116C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4256C21841
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kAKMDoDj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387579AbfGXQ6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 12:58:32 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:35971 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbfGXQ63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 12:58:29 -0400
Received: by mail-qt1-f202.google.com with SMTP id q26so42084784qtr.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 09:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aJbPYrkSLi1J83pO68ABpJTFWg54SVdLxJdC1FsJCN0=;
        b=kAKMDoDjy/GQB+zG684OCW6wlWx3U7guijvEtLmQG1ZO+fg+9B4lwuuHZ1YCxFYbey
         aIILqCEbkhNMH/1BsaX8Cxra7NcE87v+SsbjD5OpcBIbmmWlRz3uXMB8+C45RrrUOw9h
         xvhQNp4wx4gnPQZooqPeuiaeCNaLX3GT0rnAX4NteS3vrzGcdqIfpUxooLnXV3Z9m9HE
         jIjNzyssLbdVIfwJJ/JdhgFI7pcegQgx94lyB5+p3zkgH3rbyskSznAv/K0kwwmiAYgW
         K4/jqLxEv81Y0oEZXKVf8AxZ+dEGvNEjviOpTqygmzBCY5wRY4ccqdr4SUdcY3UI0ork
         IcWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aJbPYrkSLi1J83pO68ABpJTFWg54SVdLxJdC1FsJCN0=;
        b=nKiJovz9UJ+7DAGwK+fig32dw2w/wD45sBwOMEzApEuudk8S01jHCypLs66CDVMk7n
         29NAj7fJZfTjSpIUEQPz/lbDYAaYHort6yPy5SOtrlMq9ecXvQe0TyDqj1rOD1VVOYDs
         93Va8Wn3l8eqrUi3z0qIVXeP1fNKCKet0uge1Q/f2sTysZmZEA0kJnshoVyKOZkMS3fg
         v1uBVd6H+wadagg1At2asV/gyxPPm0AT1a4mMydszsWUyZqcS88edv0kJTiJjC4/fgUD
         lahiPqdlI6U/clg+kDAcIVHg+/A+VEvBE/x+OB+jObgZPI8m+GlZkZaupxJWUkmcyMgn
         Copw==
X-Gm-Message-State: APjAAAXR2969VuMnNjdSH7SQMX23e/p8d3V64KsskVP+ccRcViOhnBI3
        g6za+jeI4akOdoxtbACK9Ikr7dJfrOX3
X-Google-Smtp-Source: APXvYqxgMXcuo8TFQqJKT944SW2wJ4aNvRsr895+1Vy1k+9oaPw7OAsiO1NiJ9psa1RBVkritBGPVRb87m7d
X-Received: by 2002:a0c:afbd:: with SMTP id s58mr60379022qvc.217.1563987508719;
 Wed, 24 Jul 2019 09:58:28 -0700 (PDT)
Date:   Wed, 24 Jul 2019 09:57:58 -0700
In-Reply-To: <20190724165803.87470-1-brianvv@google.com>
Message-Id: <20190724165803.87470-2-brianvv@google.com>
Mime-Version: 1.0
References: <20190724165803.87470-1-brianvv@google.com>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [PATCH bpf-next 1/6] bpf: add bpf_map_value_size and
 bp_map_copy_value helper functions
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Petar Penkov <ppenkov@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Brian Vazquez <brianvv@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move reusable code from map_lookup_elem to helper functions to avoid code
duplication in kernel/bpf/syscall.c

Suggested-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Brian Vazquez <brianvv@google.com>
---
 kernel/bpf/syscall.c | 134 +++++++++++++++++++++++--------------------
 1 file changed, 73 insertions(+), 61 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 5d141f16f6fa9..86cdc2f7bb56e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -126,6 +126,76 @@ static struct bpf_map *find_and_alloc_map(union bpf_attr *attr)
 	return map;
 }
 
+static u32 bpf_map_value_size(struct bpf_map *map)
+{
+	if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
+	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
+	    map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY ||
+	    map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE)
+		return round_up(map->value_size, 8) * num_possible_cpus();
+	else if (IS_FD_MAP(map))
+		return sizeof(u32);
+	else
+		return  map->value_size;
+}
+
+static int bpf_map_copy_value(struct bpf_map *map, void *key, void *value,
+			      __u64 flags)
+{
+	void *ptr;
+	int err;
+
+	if (bpf_map_is_dev_bound(map))
+		return  bpf_map_offload_lookup_elem(map, key, value);
+
+	preempt_disable();
+	this_cpu_inc(bpf_prog_active);
+	if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
+	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH) {
+		err = bpf_percpu_hash_copy(map, key, value);
+	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
+		err = bpf_percpu_array_copy(map, key, value);
+	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE) {
+		err = bpf_percpu_cgroup_storage_copy(map, key, value);
+	} else if (map->map_type == BPF_MAP_TYPE_STACK_TRACE) {
+		err = bpf_stackmap_copy(map, key, value);
+	} else if (IS_FD_ARRAY(map)) {
+		err = bpf_fd_array_map_lookup_elem(map, key, value);
+	} else if (IS_FD_HASH(map)) {
+		err = bpf_fd_htab_map_lookup_elem(map, key, value);
+	} else if (map->map_type == BPF_MAP_TYPE_REUSEPORT_SOCKARRAY) {
+		err = bpf_fd_reuseport_array_lookup_elem(map, key, value);
+	} else if (map->map_type == BPF_MAP_TYPE_QUEUE ||
+		   map->map_type == BPF_MAP_TYPE_STACK) {
+		err = map->ops->map_peek_elem(map, value);
+	} else {
+		rcu_read_lock();
+		if (map->ops->map_lookup_elem_sys_only)
+			ptr = map->ops->map_lookup_elem_sys_only(map, key);
+		else
+			ptr = map->ops->map_lookup_elem(map, key);
+		if (IS_ERR(ptr)) {
+			err = PTR_ERR(ptr);
+		} else if (!ptr) {
+			err = -ENOENT;
+		} else {
+			err = 0;
+			if (flags & BPF_F_LOCK)
+				/* lock 'ptr' and copy everything but lock */
+				copy_map_value_locked(map, value, ptr, true);
+			else
+				copy_map_value(map, value, ptr);
+			/* mask lock, since value wasn't zero inited */
+			check_and_init_map_lock(map, value);
+		}
+		rcu_read_unlock();
+	}
+	this_cpu_dec(bpf_prog_active);
+	preempt_enable();
+
+	return err;
+}
+
 void *bpf_map_area_alloc(size_t size, int numa_node)
 {
 	/* We really just want to fail instead of triggering OOM killer
@@ -729,7 +799,7 @@ static int map_lookup_elem(union bpf_attr *attr)
 	void __user *uvalue = u64_to_user_ptr(attr->value);
 	int ufd = attr->map_fd;
 	struct bpf_map *map;
-	void *key, *value, *ptr;
+	void *key, *value;
 	u32 value_size;
 	struct fd f;
 	int err;
@@ -761,72 +831,14 @@ static int map_lookup_elem(union bpf_attr *attr)
 		goto err_put;
 	}
 
-	if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
-	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
-	    map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY ||
-	    map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE)
-		value_size = round_up(map->value_size, 8) * num_possible_cpus();
-	else if (IS_FD_MAP(map))
-		value_size = sizeof(u32);
-	else
-		value_size = map->value_size;
+	value_size = bpf_map_value_size(map);
 
 	err = -ENOMEM;
 	value = kmalloc(value_size, GFP_USER | __GFP_NOWARN);
 	if (!value)
 		goto free_key;
 
-	if (bpf_map_is_dev_bound(map)) {
-		err = bpf_map_offload_lookup_elem(map, key, value);
-		goto done;
-	}
-
-	preempt_disable();
-	this_cpu_inc(bpf_prog_active);
-	if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
-	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH) {
-		err = bpf_percpu_hash_copy(map, key, value);
-	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
-		err = bpf_percpu_array_copy(map, key, value);
-	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE) {
-		err = bpf_percpu_cgroup_storage_copy(map, key, value);
-	} else if (map->map_type == BPF_MAP_TYPE_STACK_TRACE) {
-		err = bpf_stackmap_copy(map, key, value);
-	} else if (IS_FD_ARRAY(map)) {
-		err = bpf_fd_array_map_lookup_elem(map, key, value);
-	} else if (IS_FD_HASH(map)) {
-		err = bpf_fd_htab_map_lookup_elem(map, key, value);
-	} else if (map->map_type == BPF_MAP_TYPE_REUSEPORT_SOCKARRAY) {
-		err = bpf_fd_reuseport_array_lookup_elem(map, key, value);
-	} else if (map->map_type == BPF_MAP_TYPE_QUEUE ||
-		   map->map_type == BPF_MAP_TYPE_STACK) {
-		err = map->ops->map_peek_elem(map, value);
-	} else {
-		rcu_read_lock();
-		if (map->ops->map_lookup_elem_sys_only)
-			ptr = map->ops->map_lookup_elem_sys_only(map, key);
-		else
-			ptr = map->ops->map_lookup_elem(map, key);
-		if (IS_ERR(ptr)) {
-			err = PTR_ERR(ptr);
-		} else if (!ptr) {
-			err = -ENOENT;
-		} else {
-			err = 0;
-			if (attr->flags & BPF_F_LOCK)
-				/* lock 'ptr' and copy everything but lock */
-				copy_map_value_locked(map, value, ptr, true);
-			else
-				copy_map_value(map, value, ptr);
-			/* mask lock, since value wasn't zero inited */
-			check_and_init_map_lock(map, value);
-		}
-		rcu_read_unlock();
-	}
-	this_cpu_dec(bpf_prog_active);
-	preempt_enable();
-
-done:
+	err = bpf_map_copy_value(map, key, value, attr->flags);
 	if (err)
 		goto free_value;
 
-- 
2.22.0.657.g960e92d24f-goog

