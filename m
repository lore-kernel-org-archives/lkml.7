Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CBBFA372B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E4422168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571230231;
	bh=bwSLv67sDBQxQvLavgtbgoTtyP59/2KgU3r9ifTWSTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2cPRSDoR/m6nq5Mh5brPkNnQ6VxC+se7wSL7ZiWWGcI98k+jYAYWeeR+I80b/kIgO
	 cs1c+YdoTL3hSrh73Qm/ihxZnXHpY/3aOJYRIXxP8s6ejrebeHJkq+MKlTxpfcRcsJ
	 uX/mp3pUZbGh+iswR6LRBjpDfQGMEPCBZ7MCba2E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404043AbfJPMua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 08:50:30 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40766 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbfJPMu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 08:50:29 -0400
Received: by mail-pf1-f195.google.com with SMTP id x127so14669629pfb.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 05:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O0eOmFuMJNrbsXIGskEERKbOo8ht6jhTNJgl6S2mbzA=;
        b=J6kv6XJH+NkdDCmTtYpQdHrTMTZRXztqbWT0+av87hWq/nWKID4k4grznPh6T6jj9y
         K43My35lyp9UaL53mzM88GECET01qtIQPPcq/a//A6FGLOwxE9VBlF6znRm1IiuMDocC
         /LrT/QnwkSI/K2X7gytqEdn3xEQ8LaojNiHNfBLwUkY6iGrIGq1xpDNE2mcNgzA5cXHG
         5SDeTAy7BpXOVYgWFMek3dMSovhq1BBCa9/ozQeCoVu4vnZDfMRjZe+hDI3eBa9HhK4l
         hmW6n9KA9fBT6XIceVQYyfzuHWtWqqQOppfb5Dujf9yu5YFtZoA5xaFHgqwkBBY9bkn2
         ELjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=O0eOmFuMJNrbsXIGskEERKbOo8ht6jhTNJgl6S2mbzA=;
        b=QMAxynZ4pa8mJWwVicVBP+PLX01kD2ndU/yfbb/stWKLFRGH9FgJJgX8D5rKWAneVT
         iyHwvd3oo/kfjFwLvpDFiY8t7W1jgcIfi9rR2QhEVJzvp1gSjDXaRXFHUFb/ONbtYhLx
         /FlOGu4KeFbYkN5XKV8vJ/NvC7wovGLG4JxAZ7/wPdpOD83+8cv7/A+XzjIlSfB6u9IR
         xkaYcwopKgoNUV6LojEBjDsWMhyK09cecPt9pqkWeuezfWpExr/QJijLIpUARzA/jLBG
         YLb+i/WZZ31sHF39YiYUB+IY+xHiiVdcnYueQjpcIqzXnBeHHmtpVP2PCrdXoVzOkuBr
         i+MA==
X-Gm-Message-State: APjAAAWftyDXY60UsGD0ISIZJ1/ywyYa0NdItIP3sL5k/JQ1Z2yZ1a1J
        VZGvZZLNvK3RA6hKssfHA7Y=
X-Google-Smtp-Source: APXvYqxJCylZYktGShoNg15EtX37fHUKS1Wtis8xwYNzd9MybBtA0Zt1plmsYmtyGyeB5dux78nDig==
X-Received: by 2002:a17:90a:9f81:: with SMTP id o1mr4937842pjp.60.1571230228192;
        Wed, 16 Oct 2019 05:50:28 -0700 (PDT)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:0:1034:ec6b:8056:9e93])
        by smtp.gmail.com with ESMTPSA id j17sm24010620pfr.70.2019.10.16.05.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 05:50:27 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Song Liu <liu.song.a23@gmail.com>
Subject: [PATCH 1/2] cgroup: Add generation number with cgroup id
Date:   Wed, 16 Oct 2019 21:50:18 +0900
Message-Id: <20191016125019.157144-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
In-Reply-To: <20191016125019.157144-1-namhyung@kernel.org>
References: <20191016125019.157144-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current cgroup id is 32-bit and might be recycled while system is
running.  To support unique id, add generation number (gen) to catch
recycling and make 64 bit number.  This number will be used as kernfs
id and inode number (and file handle).

Also introduced cgroup_idr struct to keep the idr and generation
together.  The related functions are little bit modified as well and I
made some change to cgroup_idr_alloc() to use cyclic allocator.

Later 64 bit system can have a simpler implementation with a single 64
bit sequence number and a RB tree.  But it'll need to grab a spinlock
during lookup.  I'm not entirely sure it's ok, so I left it as is.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 include/linux/cgroup-defs.h | 12 ++++++--
 kernel/cgroup/cgroup.c      | 58 +++++++++++++++++++++++++++----------
 2 files changed, 53 insertions(+), 17 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 430e219e3aba..e3f2b47c5c7b 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -364,6 +364,9 @@ struct cgroup {
 	 */
 	int id;
 
+	/* generation number in case of recycled id */
+	int gen;
+
 	/*
 	 * The depth this cgroup is at.  The root is at depth zero and each
 	 * step down the hierarchy increments the level.  This along with
@@ -491,6 +494,11 @@ struct cgroup {
 	int ancestor_ids[];
 };
 
+struct cgroup_idr {
+	struct idr idr;
+	int generation;
+};
+
 /*
  * A cgroup_root represents the root of a cgroup hierarchy, and may be
  * associated with a kernfs_root to form an active hierarchy.  This is
@@ -521,7 +529,7 @@ struct cgroup_root {
 	unsigned int flags;
 
 	/* IDs for cgroups in this hierarchy */
-	struct idr cgroup_idr;
+	struct cgroup_idr cgroup_idr;
 
 	/* The path to use for release notifications. */
 	char release_agent_path[PATH_MAX];
@@ -701,7 +709,7 @@ struct cgroup_subsys {
 	struct cgroup_root *root;
 
 	/* idr for css->id */
-	struct idr css_idr;
+	struct cgroup_idr css_idr;
 
 	/*
 	 * List of cftypes.  Each entry is the first entry of an array
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 8b1c4fd47a7a..44c67d26c1fe 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -300,34 +300,60 @@ bool cgroup_on_dfl(const struct cgroup *cgrp)
 	return cgrp->root == &cgrp_dfl_root;
 }
 
+static void cgroup_idr_init(struct cgroup_idr *cidr)
+{
+	idr_init(&cidr->idr);
+	cidr->generation = 1;  /* for kernfs compatibility */
+}
+
+static void cgroup_idr_destroy(struct cgroup_idr *cidr)
+{
+	idr_destroy(&cidr->idr);
+}
+
+static void *cgroup_idr_find(struct cgroup_idr *cidr, unsigned long id)
+{
+	return idr_find(&cidr->idr, id);
+}
+
 /* IDR wrappers which synchronize using cgroup_idr_lock */
-static int cgroup_idr_alloc(struct idr *idr, void *ptr, int start, int end,
+static int cgroup_idr_alloc(struct cgroup_idr *cidr, void *ptr, bool is_root,
 			    gfp_t gfp_mask)
 {
 	int ret;
+	int cursor;
 
 	idr_preload(gfp_mask);
 	spin_lock_bh(&cgroup_idr_lock);
-	ret = idr_alloc(idr, ptr, start, end, gfp_mask & ~__GFP_DIRECT_RECLAIM);
+	gfp_mask &= ~__GFP_DIRECT_RECLAIM;
+
+	if (is_root) {
+		ret = idr_alloc(&cidr->idr, ptr, 1, 2, gfp_mask);
+	} else {
+		cursor = idr_get_cursor(&cidr->idr);
+		ret = idr_alloc_cyclic(&cidr->idr, ptr, 2, 0, gfp_mask);
+		if (ret > 0 && ret < cursor)
+			cidr->generation++;
+	}
 	spin_unlock_bh(&cgroup_idr_lock);
 	idr_preload_end();
 	return ret;
 }
 
-static void *cgroup_idr_replace(struct idr *idr, void *ptr, int id)
+static void *cgroup_idr_replace(struct cgroup_idr *cidr, void *ptr, int id)
 {
 	void *ret;
 
 	spin_lock_bh(&cgroup_idr_lock);
-	ret = idr_replace(idr, ptr, id);
+	ret = idr_replace(&cidr->idr, ptr, id);
 	spin_unlock_bh(&cgroup_idr_lock);
 	return ret;
 }
 
-static void cgroup_idr_remove(struct idr *idr, int id)
+static void cgroup_idr_remove(struct cgroup_idr *cidr, int id)
 {
 	spin_lock_bh(&cgroup_idr_lock);
-	idr_remove(idr, id);
+	idr_remove(&cidr->idr, id);
 	spin_unlock_bh(&cgroup_idr_lock);
 }
 
@@ -1309,7 +1335,7 @@ static void cgroup_exit_root_id(struct cgroup_root *root)
 void cgroup_free_root(struct cgroup_root *root)
 {
 	if (root) {
-		idr_destroy(&root->cgroup_idr);
+		cgroup_idr_destroy(&root->cgroup_idr);
 		kfree(root);
 	}
 }
@@ -1976,7 +2002,7 @@ void init_cgroup_root(struct cgroup_fs_context *ctx)
 	atomic_set(&root->nr_cgrps, 1);
 	cgrp->root = root;
 	init_cgroup_housekeeping(cgrp);
-	idr_init(&root->cgroup_idr);
+	cgroup_idr_init(&root->cgroup_idr);
 
 	root->flags = ctx->flags;
 	if (ctx->release_agent)
@@ -1997,10 +2023,11 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 
 	lockdep_assert_held(&cgroup_mutex);
 
-	ret = cgroup_idr_alloc(&root->cgroup_idr, root_cgrp, 1, 2, GFP_KERNEL);
+	ret = cgroup_idr_alloc(&root->cgroup_idr, root_cgrp, true, GFP_KERNEL);
 	if (ret < 0)
 		goto out;
 	root_cgrp->id = ret;
+	root_cgrp->gen = root->cgroup_idr.generation;
 	root_cgrp->ancestor_ids[0] = ret;
 
 	ret = percpu_ref_init(&root_cgrp->self.refcnt, css_release,
@@ -5186,7 +5213,7 @@ static struct cgroup_subsys_state *css_create(struct cgroup *cgrp,
 	if (err)
 		goto err_free_css;
 
-	err = cgroup_idr_alloc(&ss->css_idr, NULL, 2, 0, GFP_KERNEL);
+	err = cgroup_idr_alloc(&ss->css_idr, NULL, false, GFP_KERNEL);
 	if (err < 0)
 		goto err_free_css;
 	css->id = err;
@@ -5251,11 +5278,12 @@ static struct cgroup *cgroup_create(struct cgroup *parent)
 	 * Temporarily set the pointer to NULL, so idr_find() won't return
 	 * a half-baked cgroup.
 	 */
-	cgrp->id = cgroup_idr_alloc(&root->cgroup_idr, NULL, 2, 0, GFP_KERNEL);
+	cgrp->id = cgroup_idr_alloc(&root->cgroup_idr, NULL, false, GFP_KERNEL);
 	if (cgrp->id < 0) {
 		ret = -ENOMEM;
 		goto out_stat_exit;
 	}
+	cgrp->gen = root->cgroup_idr.generation;
 
 	init_cgroup_housekeeping(cgrp);
 
@@ -5643,7 +5671,7 @@ static void __init cgroup_init_subsys(struct cgroup_subsys *ss, bool early)
 
 	mutex_lock(&cgroup_mutex);
 
-	idr_init(&ss->css_idr);
+	cgroup_idr_init(&ss->css_idr);
 	INIT_LIST_HEAD(&ss->cfts);
 
 	/* Create the root cgroup state for this subsystem */
@@ -5663,7 +5691,7 @@ static void __init cgroup_init_subsys(struct cgroup_subsys *ss, bool early)
 		/* allocation can't be done safely during early init */
 		css->id = 1;
 	} else {
-		css->id = cgroup_idr_alloc(&ss->css_idr, css, 1, 2, GFP_KERNEL);
+		css->id = cgroup_idr_alloc(&ss->css_idr, css, true, GFP_KERNEL);
 		BUG_ON(css->id < 0);
 	}
 
@@ -5770,7 +5798,7 @@ int __init cgroup_init(void)
 			struct cgroup_subsys_state *css =
 				init_css_set.subsys[ss->id];
 
-			css->id = cgroup_idr_alloc(&ss->css_idr, css, 1, 2,
+			css->id = cgroup_idr_alloc(&ss->css_idr, css, true,
 						   GFP_KERNEL);
 			BUG_ON(css->id < 0);
 		} else {
@@ -6236,7 +6264,7 @@ struct cgroup_subsys_state *css_tryget_online_from_dir(struct dentry *dentry,
 struct cgroup_subsys_state *css_from_id(int id, struct cgroup_subsys *ss)
 {
 	WARN_ON_ONCE(!rcu_read_lock_held());
-	return idr_find(&ss->css_idr, id);
+	return cgroup_idr_find(&ss->css_idr, id);
 }
 
 /**
-- 
2.23.0.700.g56cf767bdb-goog

