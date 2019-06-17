Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DF9C31E5C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 20:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04FDC20861
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 20:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="R2BthEpt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbfFQUYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 16:24:24 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:58319 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfFQUYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 16:24:24 -0400
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Jun 2019 16:24:23 EDT
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id F30383F44D;
        Mon, 17 Jun 2019 22:18:15 +0200 (CEST)
Authentication-Results: ste-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=R2BthEpt;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YXBqzaUs7E13; Mon, 17 Jun 2019 22:18:05 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id CADE9473E5;
        Mon, 17 Jun 2019 22:18:05 +0200 (CEST)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 81A6B3619C2;
        Mon, 17 Jun 2019 22:18:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1560802685; bh=ywu99SLn6S80+sqVBhdQUXNvrrN564QuiBbE0vgNWMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R2BthEptNsl7QdOQcwhzGZ4p1lP93BOuBKQp1M/QAbnB8CfI/0s9/h984W/kJh9tu
         fS30ddBToeUz1YGpL8p7MzfXgoJpFooqIKt9rmTyj3c6XhY/9y/pZWGD6HRnB0YvBy
         5Y8+cTy8W47iqgHKqnO7Lo4ix4SxnCL4RX5NpLM8=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas@shipmail.org>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-graphics-maintainer@vmware.com, pv-drivers@vmware.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 7/9] drm/vmwgfx: Use an RBtree instead of linked list for MOB resources
Date:   Mon, 17 Jun 2019 22:17:54 +0200
Message-Id: <20190617201756.12587-8-thomas@shipmail.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617201756.12587-1-thomas@shipmail.org>
References: <20190617201756.12587-1-thomas@shipmail.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

With emulated coherent memory we need to be able to quickly look up
a resource from the MOB offset. Instead of traversing a linked list with
O(n) worst case, use an RBtree with O(log n) worst case complexity.

Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Deepak Rawat <drawat@vmware.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c       |  5 ++--
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h      | 10 +++----
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c | 33 +++++++++++++++++-------
 3 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
index 90ca866640fe..e8bc7a7ac031 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
@@ -464,6 +464,7 @@ void vmw_bo_bo_free(struct ttm_buffer_object *bo)
 	struct vmw_buffer_object *vmw_bo = vmw_buffer_object(bo);
 
 	WARN_ON(vmw_bo->dirty);
+	WARN_ON(!RB_EMPTY_ROOT(&vmw_bo->res_tree));
 	vmw_bo_unmap(vmw_bo);
 	kfree(vmw_bo);
 }
@@ -480,6 +481,7 @@ static void vmw_user_bo_destroy(struct ttm_buffer_object *bo)
 	struct vmw_buffer_object *vbo = &vmw_user_bo->vbo;
 
 	WARN_ON(vbo->dirty);
+	WARN_ON(!RB_EMPTY_ROOT(&vbo->res_tree));
 	vmw_bo_unmap(vbo);
 	ttm_prime_object_kfree(vmw_user_bo, prime);
 }
@@ -515,8 +517,7 @@ int vmw_bo_init(struct vmw_private *dev_priv,
 	memset(vmw_bo, 0, sizeof(*vmw_bo));
 	BUILD_BUG_ON(TTM_MAX_BO_PRIORITY <= 3);
 	vmw_bo->base.priority = 3;
-
-	INIT_LIST_HEAD(&vmw_bo->res_list);
+	vmw_bo->res_tree = RB_ROOT;
 
 	ret = ttm_bo_init(bdev, &vmw_bo->base, size,
 			  ttm_bo_type_device, placement,
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
index 27c259395790..9b347923196f 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
@@ -89,7 +89,7 @@ struct vmw_fpriv {
 /**
  * struct vmw_buffer_object - TTM buffer object with vmwgfx additions
  * @base: The TTM buffer object
- * @res_list: List of resources using this buffer object as a backing MOB
+ * @res_tree: RB tree of resources using this buffer object as a backing MOB
  * @pin_count: pin depth
  * @dx_query_ctx: DX context if this buffer object is used as a DX query MOB
  * @map: Kmap object for semi-persistent mappings
@@ -98,7 +98,7 @@ struct vmw_fpriv {
  */
 struct vmw_buffer_object {
 	struct ttm_buffer_object base;
-	struct list_head res_list;
+	struct rb_root res_tree;
 	s32 pin_count;
 	/* Not ref-counted.  Protected by binding_mutex */
 	struct vmw_resource *dx_query_ctx;
@@ -146,8 +146,8 @@ struct vmw_res_func;
  * pin-count greater than zero. It is not on the resource LRU lists and its
  * backup buffer is pinned. Hence it can't be evicted.
  * @func: Method vtable for this resource. Immutable.
+ * @mob_node; Node for the MOB backup rbtree. Protected by @backup reserved.
  * @lru_head: List head for the LRU list. Protected by @dev_priv::resource_lock.
- * @mob_head: List head for the MOB backup list. Protected by @backup reserved.
  * @binding_head: List head for the context binding list. Protected by
  * the @dev_priv::binding_mutex
  * @res_free: The resource destructor.
@@ -168,8 +168,8 @@ struct vmw_resource {
 	unsigned long backup_offset;
 	unsigned long pin_count;
 	const struct vmw_res_func *func;
+	struct rb_node mob_node;
 	struct list_head lru_head;
-	struct list_head mob_head;
 	struct list_head binding_head;
 	struct vmw_resource_dirty *dirty;
 	void (*res_free) (struct vmw_resource *res);
@@ -742,7 +742,7 @@ void vmw_resource_dirty_update(struct vmw_resource *res, pgoff_t start,
  */
 static inline bool vmw_resource_mob_attached(const struct vmw_resource *res)
 {
-	return !list_empty(&res->mob_head);
+	return !RB_EMPTY_NODE(&res->mob_node);
 }
 
 /**
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
index da9afa83fb4f..b84dd5953886 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
@@ -41,11 +41,24 @@
 void vmw_resource_mob_attach(struct vmw_resource *res)
 {
 	struct vmw_buffer_object *backup = res->backup;
+	struct rb_node **new = &backup->res_tree.rb_node, *parent = NULL;
 
 	lockdep_assert_held(&backup->base.resv->lock.base);
 	res->used_prio = (res->res_dirty) ? res->func->dirty_prio :
 		res->func->prio;
-	list_add_tail(&res->mob_head, &backup->res_list);
+
+	while (*new) {
+		struct vmw_resource *this =
+			container_of(*new, struct vmw_resource, mob_node);
+
+		parent = *new;
+		new = (res->backup_offset < this->backup_offset) ?
+			&((*new)->rb_left) : &((*new)->rb_right);
+	}
+
+	rb_link_node(&res->mob_node, parent, new);
+	rb_insert_color(&res->mob_node, &backup->res_tree);
+
 	vmw_bo_prio_add(backup, res->used_prio);
 }
 
@@ -59,7 +72,8 @@ void vmw_resource_mob_detach(struct vmw_resource *res)
 
 	lockdep_assert_held(&backup->base.resv->lock.base);
 	if (vmw_resource_mob_attached(res)) {
-		list_del_init(&res->mob_head);
+		rb_erase(&res->mob_node, &backup->res_tree);
+		RB_CLEAR_NODE(&res->mob_node);
 		vmw_bo_prio_del(backup, res->used_prio);
 	}
 }
@@ -206,8 +220,8 @@ int vmw_resource_init(struct vmw_private *dev_priv, struct vmw_resource *res,
 	res->res_free = res_free;
 	res->dev_priv = dev_priv;
 	res->func = func;
+	RB_CLEAR_NODE(&res->mob_node);
 	INIT_LIST_HEAD(&res->lru_head);
-	INIT_LIST_HEAD(&res->mob_head);
 	INIT_LIST_HEAD(&res->binding_head);
 	res->id = -1;
 	res->backup = NULL;
@@ -756,19 +770,20 @@ int vmw_resource_validate(struct vmw_resource *res, bool intr)
  */
 void vmw_resource_unbind_list(struct vmw_buffer_object *vbo)
 {
-
-	struct vmw_resource *res, *next;
 	struct ttm_validate_buffer val_buf = {
 		.bo = &vbo->base,
 		.num_shared = 0
 	};
 
 	lockdep_assert_held(&vbo->base.resv->lock.base);
-	list_for_each_entry_safe(res, next, &vbo->res_list, mob_head) {
-		if (!res->func->unbind)
-			continue;
+	while (!RB_EMPTY_ROOT(&vbo->res_tree)) {
+		struct rb_node *node = vbo->res_tree.rb_node;
+		struct vmw_resource *res =
+			container_of(node, struct vmw_resource, mob_node);
+
+		if (!WARN_ON_ONCE(!res->func->unbind))
+			(void) res->func->unbind(res, res->res_dirty, &val_buf);
 
-		(void) res->func->unbind(res, res->res_dirty, &val_buf);
 		res->backup_dirty = true;
 		res->res_dirty = false;
 		vmw_resource_mob_detach(res);
-- 
2.20.1

