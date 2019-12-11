Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA99C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 22:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A2062077B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 22:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n+ZARFho"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfLKWeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 17:34:20 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:34793 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbfLKWeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 17:34:18 -0500
Received: by mail-pg1-f202.google.com with SMTP id w9so216840pgl.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 14:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Y4D8Hun8+9595czEIJNfVkixcPf77pk7+sm5yWYYjUs=;
        b=n+ZARFhoQ535NVrmfuKF3VOqS3CmGIVwrx2YK5WGONPsCwrpvZvYyUBOEtyiUCUf+/
         evgXKfKCFC9ASzvVosbQsj7YxUNFTPmi8wUCPVSg5KKzTpHrzrP1uwuY7LRgidQjaH8P
         zyzqgrdoRb2Or9OsULXEoxDi+S1q7wMK3Ziq7FaXRKz+QO++L/esS8tjw5rXOdSPziYD
         JDP9Zro5FpDgUmIOzFP3/0CLof7xYVdgdtMqlAPZkGP5kylIAvSNZTbSTcPZy9tbftMh
         sznLRvoLy93yFEU4Bc1EwMMSFRM6k2FdSwtDhBC3VdMuGVAZhR7av8aK2gRETta8HQM+
         kBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Y4D8Hun8+9595czEIJNfVkixcPf77pk7+sm5yWYYjUs=;
        b=ZyvXPK+wVZ9yuG8kPcanrRRWKQLiz+PLCyy94bRz43+fpYPEi8v6SEw5/XxGOsGWdk
         Jm1iQC2iY/9YMjodDugv0Lllqkdolnu03WKcU4ePu4lzvwDbPBrePTe2B3ictJJRUyAe
         hpsXhz8aeqFEPaxTPZkSzPFk/uViuxUvIq+FmBvFHqfxWkJR2r6hokuk4HlPnswPZdsF
         NWszx6BqAKb3tTibKP0+SIZ6Xg39LooFNyxcMzQZWi6AWuaFrwDQ994aMM2FgZ06aWkR
         KhSjh7pQ6UlopCdXLjEbpYPoD4WU6hZWi6/sJcrqiCrZcREQAmNUJFNAPg/WiFM0A2iu
         FhhQ==
X-Gm-Message-State: APjAAAWklZb/Xr0IRY6fEG4o4a7clmmqU4y0WhpmaCAY49Rggf5WmjhG
        qaQnFJwQt+39W00BfPaKNxlBBsz9zCpU
X-Google-Smtp-Source: APXvYqyMADUFX33kcrWgeSMruNfr+ZYze4AbBp4I1mb+NFqGvYXoor3MzneVVSy2hvhsSXVBvc+zbvQLfN9d
X-Received: by 2002:a63:31d0:: with SMTP id x199mr6974188pgx.286.1576103657067;
 Wed, 11 Dec 2019 14:34:17 -0800 (PST)
Date:   Wed, 11 Dec 2019 14:33:34 -0800
In-Reply-To: <20191211223344.165549-1-brianvv@google.com>
Message-Id: <20191211223344.165549-2-brianvv@google.com>
Mime-Version: 1.0
References: <20191211223344.165549-1-brianvv@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v3 bpf-next 01/11] bpf: add bpf_map_{value_size,update_value,map_copy_value}
 functions
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Brian Vazquez <brianvv@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Yonghong Song <yhs@fb.com>, Stanislav Fomichev <sdf@google.com>,
        Petar Penkov <ppenkov@google.com>,
        Willem de Bruijn <willemb@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit moves reusable code from map_lookup_elem and map_update_elem
to avoid code duplication in kernel/bpf/syscall.c.

Signed-off-by: Brian Vazquez <brianvv@google.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
---
 kernel/bpf/syscall.c | 275 ++++++++++++++++++++++++-------------------
 1 file changed, 151 insertions(+), 124 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 66b90eaf99fe8..2530266fa6477 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -129,6 +129,153 @@ static struct bpf_map *find_and_alloc_map(union bpf_attr *attr)
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
+static void maybe_wait_bpf_programs(struct bpf_map *map)
+{
+	/* Wait for any running BPF programs to complete so that
+	 * userspace, when we return to it, knows that all programs
+	 * that could be running use the new map value.
+	 */
+	if (map->map_type == BPF_MAP_TYPE_HASH_OF_MAPS ||
+	    map->map_type == BPF_MAP_TYPE_ARRAY_OF_MAPS)
+		synchronize_rcu();
+}
+
+static int bpf_map_update_value(struct bpf_map *map, struct fd f, void *key,
+				void *value, __u64 flags)
+{
+	int err;
+	/* Need to create a kthread, thus must support schedule */
+	if (bpf_map_is_dev_bound(map)) {
+		return bpf_map_offload_update_elem(map, key, value, flags);
+	} else if (map->map_type == BPF_MAP_TYPE_CPUMAP ||
+		   map->map_type == BPF_MAP_TYPE_SOCKHASH ||
+		   map->map_type == BPF_MAP_TYPE_SOCKMAP) {
+		return map->ops->map_update_elem(map, key, value, flags);
+	}
+
+	/* must increment bpf_prog_active to avoid kprobe+bpf triggering from
+	 * inside bpf map update or delete otherwise deadlocks are possible
+	 */
+	preempt_disable();
+	__this_cpu_inc(bpf_prog_active);
+	if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
+	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH) {
+		err = bpf_percpu_hash_update(map, key, value, flags);
+	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
+		err = bpf_percpu_array_update(map, key, value, flags);
+	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE) {
+		err = bpf_percpu_cgroup_storage_update(map, key, value,
+						       flags);
+	} else if (IS_FD_ARRAY(map)) {
+		rcu_read_lock();
+		err = bpf_fd_array_map_update_elem(map, f.file, key, value,
+						   flags);
+		rcu_read_unlock();
+	} else if (map->map_type == BPF_MAP_TYPE_HASH_OF_MAPS) {
+		rcu_read_lock();
+		err = bpf_fd_htab_map_update_elem(map, f.file, key, value,
+						  flags);
+		rcu_read_unlock();
+	} else if (map->map_type == BPF_MAP_TYPE_REUSEPORT_SOCKARRAY) {
+		/* rcu_read_lock() is not needed */
+		err = bpf_fd_reuseport_array_update_elem(map, key, value,
+							 flags);
+	} else if (map->map_type == BPF_MAP_TYPE_QUEUE ||
+		   map->map_type == BPF_MAP_TYPE_STACK) {
+		err = map->ops->map_push_elem(map, value, flags);
+	} else {
+		rcu_read_lock();
+		err = map->ops->map_update_elem(map, key, value, flags);
+		rcu_read_unlock();
+	}
+	__this_cpu_dec(bpf_prog_active);
+	preempt_enable();
+	maybe_wait_bpf_programs(map);
+
+	return err;
+}
+
+static int bpf_map_copy_value(struct bpf_map *map, void *key, void *value,
+			      __u64 flags, bool do_delete)
+{
+	void *ptr;
+	int err;
+
+
+	if (bpf_map_is_dev_bound(map)) {
+		err =  bpf_map_offload_lookup_elem(map, key, value);
+
+		if (!err && do_delete)
+			err = bpf_map_offload_delete_elem(map, key);
+
+		return err;
+	}
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
+	if (do_delete)
+		err = err ? err : map->ops->map_delete_elem(map, key);
+
+	this_cpu_dec(bpf_prog_active);
+	preempt_enable();
+	maybe_wait_bpf_programs(map);
+
+	return err;
+}
+
 static void *__bpf_map_area_alloc(u64 size, int numa_node, bool mmapable)
 {
 	/* We really just want to fail instead of triggering OOM killer
@@ -816,7 +963,7 @@ static int map_lookup_elem(union bpf_attr *attr)
 	void __user *uvalue = u64_to_user_ptr(attr->value);
 	int ufd = attr->map_fd;
 	struct bpf_map *map;
-	void *key, *value, *ptr;
+	void *key, *value;
 	u32 value_size;
 	struct fd f;
 	int err;
@@ -848,72 +995,14 @@ static int map_lookup_elem(union bpf_attr *attr)
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
-	} else if (IS_FD_ARRAY(map) || IS_FD_PROG_ARRAY(map)) {
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
+	err = bpf_map_copy_value(map, key, value, attr->flags, false);
 	if (err)
 		goto free_value;
 
@@ -932,16 +1021,6 @@ static int map_lookup_elem(union bpf_attr *attr)
 	return err;
 }
 
-static void maybe_wait_bpf_programs(struct bpf_map *map)
-{
-	/* Wait for any running BPF programs to complete so that
-	 * userspace, when we return to it, knows that all programs
-	 * that could be running use the new map value.
-	 */
-	if (map->map_type == BPF_MAP_TYPE_HASH_OF_MAPS ||
-	    map->map_type == BPF_MAP_TYPE_ARRAY_OF_MAPS)
-		synchronize_rcu();
-}
 
 #define BPF_MAP_UPDATE_ELEM_LAST_FIELD flags
 
@@ -997,60 +1076,8 @@ static int map_update_elem(union bpf_attr *attr)
 	if (copy_from_user(value, uvalue, value_size) != 0)
 		goto free_value;
 
-	/* Need to create a kthread, thus must support schedule */
-	if (bpf_map_is_dev_bound(map)) {
-		err = bpf_map_offload_update_elem(map, key, value, attr->flags);
-		goto out;
-	} else if (map->map_type == BPF_MAP_TYPE_CPUMAP ||
-		   map->map_type == BPF_MAP_TYPE_SOCKHASH ||
-		   map->map_type == BPF_MAP_TYPE_SOCKMAP) {
-		err = map->ops->map_update_elem(map, key, value, attr->flags);
-		goto out;
-	} else if (IS_FD_PROG_ARRAY(map)) {
-		err = bpf_fd_array_map_update_elem(map, f.file, key, value,
-						   attr->flags);
-		goto out;
-	}
+	err = bpf_map_update_value(map, f, key, value, attr->flags);
 
-	/* must increment bpf_prog_active to avoid kprobe+bpf triggering from
-	 * inside bpf map update or delete otherwise deadlocks are possible
-	 */
-	preempt_disable();
-	__this_cpu_inc(bpf_prog_active);
-	if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
-	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH) {
-		err = bpf_percpu_hash_update(map, key, value, attr->flags);
-	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
-		err = bpf_percpu_array_update(map, key, value, attr->flags);
-	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE) {
-		err = bpf_percpu_cgroup_storage_update(map, key, value,
-						       attr->flags);
-	} else if (IS_FD_ARRAY(map)) {
-		rcu_read_lock();
-		err = bpf_fd_array_map_update_elem(map, f.file, key, value,
-						   attr->flags);
-		rcu_read_unlock();
-	} else if (map->map_type == BPF_MAP_TYPE_HASH_OF_MAPS) {
-		rcu_read_lock();
-		err = bpf_fd_htab_map_update_elem(map, f.file, key, value,
-						  attr->flags);
-		rcu_read_unlock();
-	} else if (map->map_type == BPF_MAP_TYPE_REUSEPORT_SOCKARRAY) {
-		/* rcu_read_lock() is not needed */
-		err = bpf_fd_reuseport_array_update_elem(map, key, value,
-							 attr->flags);
-	} else if (map->map_type == BPF_MAP_TYPE_QUEUE ||
-		   map->map_type == BPF_MAP_TYPE_STACK) {
-		err = map->ops->map_push_elem(map, value, attr->flags);
-	} else {
-		rcu_read_lock();
-		err = map->ops->map_update_elem(map, key, value, attr->flags);
-		rcu_read_unlock();
-	}
-	__this_cpu_dec(bpf_prog_active);
-	preempt_enable();
-	maybe_wait_bpf_programs(map);
-out:
 free_value:
 	kfree(value);
 free_key:
-- 
2.24.1.735.g03f4e72817-goog

