Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00CAC3A59E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 00:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E67A20828
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 00:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730032AbfIEAwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 20:52:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:48654 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727156AbfIEAwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 20:52:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DA5E8B03D;
        Thu,  5 Sep 2019 00:52:46 +0000 (UTC)
Date:   Wed, 4 Sep 2019 17:52:34 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Michel Lespinasse <walken@google.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 1/3] x86,mm/pat: Use generic interval trees
Message-ID: <20190905005234.vse4pm4mw7bogcbp@linux-r8p5>
References: <20190813224620.31005-1-dave@stgolabs.net>
 <20190813224620.31005-2-dave@stgolabs.net>
 <20190821215707.GA99147@google.com>
 <20190822044936.qusm5zgjdf6n5fds@linux-r8p5>
 <20190822181701.zhfdkjbwjh56i3ax@linux-r8p5>
 <CANN689E+xsZWOKFBuv1pkpXO-i4i=Yhg3ebnD++ujz7yfDqwuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CANN689E+xsZWOKFBuv1pkpXO-i4i=Yhg3ebnD++ujz7yfDqwuQ@mail.gmail.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Aug 2019, Michel Lespinasse wrote:

>I think vma_interval_tree is a bit of a mixed bag, but mostly leans
>towards using half closed intervals.
>
>Right now vma_last_pgoff() has to do -1 because of the interval tree
>using closed intervals. Similarly, rmap_walk_file(), which I consider
>to be the main user of the vma_interval_tree, also has to do -1 when
>computing pgoff_end because of the interval tree closed intervals. So,
>I think overall vma_interval_tree would also more naturally use
>half-open intervals.
>
>But, that's not a 100% thing for vma_interval_tree, as it also has
>uses that do stabbing queries (in arch specific code, in hugetlb
>cases, and in dax code).

Ok, so for that I've added the following helper which will make the
conversion a bit more straightforward:

#define vma_interval_tree_foreach_stab(vma, root, start)
       vma_interval_tree_foreach(vma, root, start, start)

I think this also makes sense as it documents the nature of the lookup.

Now for the interval-tree conversion to [a,b[ , how does the following
look to you? Note that this should be the end result; we can discuss
how to get there later, but I wanna make sure that it was more or less
what you were picturing.

I also converted the pat tree and the cleanups are much nicer now; which
shows in the diffsat:

2 files changed, 38 insertions(+), 123 deletions(-)

I'll send this once the interval tree stuff is sorted out.

Thanks,
Davidlohr

-------8<-------------------------------------------------------------

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
index 31d4deb5d294..f2d98550bdbf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
@@ -205,9 +205,6 @@ amdgpu_mn_sync_pagetables_gfx(struct hmm_mirror *mirror,
 	bool blockable = mmu_notifier_range_blockable(update);
 	struct interval_tree_node *it;
 
-	/* notification is exclusive, but interval is inclusive */
-	end -= 1;
-
 	/* TODO we should be able to split locking for interval tree and
 	 * amdgpu_mn_invalidate_node
 	 */
@@ -254,9 +251,6 @@ amdgpu_mn_sync_pagetables_hsa(struct hmm_mirror *mirror,
 	bool blockable = mmu_notifier_range_blockable(update);
 	struct interval_tree_node *it;
 
-	/* notification is exclusive, but interval is inclusive */
-	end -= 1;
-
 	if (amdgpu_mn_read_lock(amn, blockable))
 		return -EAGAIN;
 
@@ -374,7 +368,7 @@ struct amdgpu_mn *amdgpu_mn_get(struct amdgpu_device *adev,
  */
 int amdgpu_mn_register(struct amdgpu_bo *bo, unsigned long addr)
 {
-	unsigned long end = addr + amdgpu_bo_size(bo) - 1;
+	unsigned long end = addr + amdgpu_bo_size(bo);
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	enum amdgpu_mn_type type =
 		bo->kfd_bo ? AMDGPU_MN_TYPE_HSA : AMDGPU_MN_TYPE_GFX;
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
index 74da35611d7c..36c3c510e01e 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
@@ -99,9 +99,6 @@ userptr_mn_invalidate_range_start(struct mmu_notifier *_mn,
 	if (RB_EMPTY_ROOT(&mn->objects.rb_root))
 		return 0;
 
-	/* interval ranges are inclusive, but invalidate range is exclusive */
-	end = range->end - 1;
-
 	spin_lock(&mn->lock);
 	it = interval_tree_iter_first(&mn->objects, range->start, end);
 	while (it) {
@@ -275,7 +272,7 @@ i915_gem_userptr_init__mmu_notifier(struct drm_i915_gem_object *obj,
 	mo->mn = mn;
 	mo->obj = obj;
 	mo->it.start = obj->userptr.ptr;
-	mo->it.last = obj->userptr.ptr + obj->base.size - 1;
+	mo->it.last = obj->userptr.ptr + obj->base.size;
 	RB_CLEAR_NODE(&mo->it.rb);
 
 	obj->userptr.mmu_object = mo;
diff --git a/drivers/gpu/drm/radeon/radeon_mn.c b/drivers/gpu/drm/radeon/radeon_mn.c
index dbab9a3a969b..2beb22269793 100644
--- a/drivers/gpu/drm/radeon/radeon_mn.c
+++ b/drivers/gpu/drm/radeon/radeon_mn.c
@@ -66,12 +66,8 @@ static int radeon_mn_invalidate_range_start(struct mmu_notifier *mn,
 	struct radeon_mn *rmn = container_of(mn, struct radeon_mn, mn);
 	struct ttm_operation_ctx ctx = { false, false };
 	struct interval_tree_node *it;
-	unsigned long end;
 	int ret = 0;
 
-	/* notification is exclusive, but interval is inclusive */
-	end = range->end - 1;
-
 	/* TODO we should be able to split locking for interval tree and
 	 * the tear down.
 	 */
@@ -80,7 +76,7 @@ static int radeon_mn_invalidate_range_start(struct mmu_notifier *mn,
 	else if (!mutex_trylock(&rmn->lock))
 		return -EAGAIN;
 
-	it = interval_tree_iter_first(&rmn->objects, range->start, end);
+	it = interval_tree_iter_first(&rmn->objects, range->start, range->end);
 	while (it) {
 		struct radeon_mn_node *node;
 		struct radeon_bo *bo;
@@ -92,7 +88,7 @@ static int radeon_mn_invalidate_range_start(struct mmu_notifier *mn,
 		}
 
 		node = container_of(it, struct radeon_mn_node, it);
-		it = interval_tree_iter_next(it, range->start, end);
+		it = interval_tree_iter_next(it, range->start, range->end);
 
 		list_for_each_entry(bo, &node->bos, mn_list) {
 
@@ -174,7 +170,7 @@ static const struct mmu_notifier_ops radeon_mn_ops = {
  */
 int radeon_mn_register(struct radeon_bo *bo, unsigned long addr)
 {
-	unsigned long end = addr + radeon_bo_size(bo) - 1;
+	unsigned long end = addr + radeon_bo_size(bo);
 	struct mmu_notifier *mn;
 	struct radeon_mn *rmn;
 	struct radeon_mn_node *node = NULL;
diff --git a/drivers/gpu/drm/radeon/radeon_vm.c b/drivers/gpu/drm/radeon/radeon_vm.c
index e0ad547786e8..dc9fad8ea84a 100644
--- a/drivers/gpu/drm/radeon/radeon_vm.c
+++ b/drivers/gpu/drm/radeon/radeon_vm.c
@@ -450,13 +450,14 @@ int radeon_vm_bo_set_addr(struct radeon_device *rdev,
 {
 	uint64_t size = radeon_bo_size(bo_va->bo);
 	struct radeon_vm *vm = bo_va->vm;
-	unsigned last_pfn, pt_idx;
+	unsigned pt_idx;
 	uint64_t eoffset;
 	int r;
 
 	if (soffset) {
+		unsigned last_pfn;
 		/* make sure object fit at this offset */
-		eoffset = soffset + size - 1;
+		eoffset = soffset + size;
 		if (soffset >= eoffset) {
 			r = -EINVAL;
 			goto error_unreserve;
@@ -471,7 +472,7 @@ int radeon_vm_bo_set_addr(struct radeon_device *rdev,
 		}
 
 	} else {
-		eoffset = last_pfn = 0;
+		eoffset = 1; /* interval trees are [a,b[ */
 	}
 
 	mutex_lock(&vm->mutex);
diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index 9aebe9ce8b07..58c9269aa072 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -761,9 +761,6 @@ void ib_umem_odp_unmap_dma_pages(struct ib_umem_odp *umem_odp, u64 virt,
 }
 EXPORT_SYMBOL(ib_umem_odp_unmap_dma_pages);
 
-/* @last is not a part of the interval. See comment for function
- * node_last.
- */
 int rbt_ib_umem_for_each_in_range(struct rb_root_cached *root,
 				  u64 start, u64 last,
 				  umem_call_back cb,
@@ -777,12 +774,12 @@ int rbt_ib_umem_for_each_in_range(struct rb_root_cached *root,
 	if (unlikely(start == last))
 		return ret_val;
 
-	for (node = interval_tree_iter_first(root, start, last - 1);
+	for (node = interval_tree_iter_first(root, start, last);
 			node; node = next) {
 		/* TODO move the blockable decision up to the callback */
 		if (!blockable)
 			return -EAGAIN;
-		next = interval_tree_iter_next(node, start, last - 1);
+		next = interval_tree_iter_next(node, start, last);
 		umem = container_of(node, struct ib_umem_odp, interval_tree);
 		ret_val = cb(umem, start, last, cookie) || ret_val;
 	}
diff --git a/drivers/infiniband/hw/hfi1/mmu_rb.c b/drivers/infiniband/hw/hfi1/mmu_rb.c
index 14d2a90964c3..d708c45bfabf 100644
--- a/drivers/infiniband/hw/hfi1/mmu_rb.c
+++ b/drivers/infiniband/hw/hfi1/mmu_rb.c
@@ -89,7 +89,7 @@ static unsigned long mmu_node_start(struct mmu_rb_node *node)
 
 static unsigned long mmu_node_last(struct mmu_rb_node *node)
 {
-	return PAGE_ALIGN(node->addr + node->len) - 1;
+	return PAGE_ALIGN(node->addr + node->len);
 }
 
 int hfi1_mmu_rb_register(void *ops_arg, struct mm_struct *mm,
@@ -195,13 +195,13 @@ static struct mmu_rb_node *__mmu_rb_search(struct mmu_rb_handler *handler,
 	trace_hfi1_mmu_rb_search(addr, len);
 	if (!handler->ops->filter) {
 		node = __mmu_int_rb_iter_first(&handler->root, addr,
-					       (addr + len) - 1);
+					       (addr + len));
 	} else {
 		for (node = __mmu_int_rb_iter_first(&handler->root, addr,
-						    (addr + len) - 1);
+						    (addr + len));
 		     node;
 		     node = __mmu_int_rb_iter_next(node, addr,
-						   (addr + len) - 1)) {
+						   (addr + len))) {
 			if (handler->ops->filter(node, addr, len))
 				return node;
 		}
@@ -293,11 +293,10 @@ static int mmu_notifier_range_start(struct mmu_notifier *mn,
 	bool added = false;
 
 	spin_lock_irqsave(&handler->lock, flags);
-	for (node = __mmu_int_rb_iter_first(root, range->start, range->end-1);
+	for (node = __mmu_int_rb_iter_first(root, range->start, range->end);
 	     node; node = ptr) {
 		/* Guard against node removal. */
-		ptr = __mmu_int_rb_iter_next(node, range->start,
-					     range->end - 1);
+		ptr = __mmu_int_rb_iter_next(node, range->start, range->end);
 		trace_hfi1_mmu_mem_invalidate(node->addr, node->len);
 		if (handler->ops->invalidate(handler->ops_arg, node)) {
 			__mmu_int_rb_remove(node, root);
diff --git a/drivers/infiniband/hw/usnic/usnic_uiom.c b/drivers/infiniband/hw/usnic/usnic_uiom.c
index 62e6ffa9ad78..1d6661b1fe04 100644
--- a/drivers/infiniband/hw/usnic/usnic_uiom.c
+++ b/drivers/infiniband/hw/usnic/usnic_uiom.c
@@ -223,7 +223,7 @@ static void __usnic_uiom_reg_release(struct usnic_uiom_pd *pd,
 
 	npages = PAGE_ALIGN(uiomr->length + uiomr->offset) >> PAGE_SHIFT;
 	vpn_start = (uiomr->va & PAGE_MASK) >> PAGE_SHIFT;
-	vpn_last = vpn_start + npages - 1;
+	vpn_last = vpn_start + npages;
 
 	spin_lock(&pd->lock);
 	usnic_uiom_remove_interval(&pd->root, vpn_start,
@@ -354,7 +354,7 @@ struct usnic_uiom_reg *usnic_uiom_reg_get(struct usnic_uiom_pd *pd,
 	offset = addr & ~PAGE_MASK;
 	npages = PAGE_ALIGN(size + offset) >> PAGE_SHIFT;
 	vpn_start = (addr & PAGE_MASK) >> PAGE_SHIFT;
-	vpn_last = vpn_start + npages - 1;
+	vpn_last = vpn_start + npages;
 
 	uiomr = kmalloc(sizeof(*uiomr), GFP_KERNEL);
 	if (!uiomr)
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 3ea9d7682999..b25709d67d72 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -323,7 +323,7 @@ static int viommu_add_mapping(struct viommu_domain *vdomain, unsigned long iova,
 
 	mapping->paddr		= paddr;
 	mapping->iova.start	= iova;
-	mapping->iova.last	= iova + size - 1;
+	mapping->iova.last	= iova + size;
 	mapping->flags		= flags;
 
 	spin_lock_irqsave(&vdomain->mappings_lock, irqflags);
@@ -348,7 +348,7 @@ static size_t viommu_del_mappings(struct viommu_domain *vdomain,
 {
 	size_t unmapped = 0;
 	unsigned long flags;
-	unsigned long last = iova + size - 1;
+	unsigned long last = iova + size;
 	struct viommu_mapping *mapping = NULL;
 	struct interval_tree_node *node, *next;
 
@@ -367,7 +367,7 @@ static size_t viommu_del_mappings(struct viommu_domain *vdomain,
 		 * Virtio-iommu doesn't allow UNMAP to split a mapping created
 		 * with a single MAP request, so remove the full mapping.
 		 */
-		unmapped += mapping->iova.last - mapping->iova.start + 1;
+		unmapped += mapping->iova.last - mapping->iova.start;
 
 		interval_tree_remove(node, &vdomain->mappings);
 		kfree(mapping);
@@ -787,7 +787,7 @@ static phys_addr_t viommu_iova_to_phys(struct iommu_domain *domain,
 	struct viommu_domain *vdomain = to_viommu_domain(domain);
 
 	spin_lock_irqsave(&vdomain->mappings_lock, flags);
-	node = interval_tree_iter_first(&vdomain->mappings, iova, iova);
+	node = interval_tree_iter_first(&vdomain->mappings, iova, iova + 1);
 	if (node) {
 		mapping = container_of(node, struct viommu_mapping, iova);
 		paddr = mapping->paddr + (iova - mapping->iova.start);
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 5dc174ac8cac..98590a7d900c 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1126,7 +1126,7 @@ static int vhost_process_iotlb_msg(struct vhost_dev *dev,
 		}
 		vhost_vq_meta_reset(dev);
 		vhost_del_umem_range(dev->iotlb, msg->iova,
-				     msg->iova + msg->size - 1);
+				     msg->iova + msg->size);
 		break;
 	default:
 		ret = -EINVAL;
@@ -1320,15 +1320,14 @@ static bool iotlb_access_ok(struct vhost_virtqueue *vq,
 {
 	const struct vhost_umem_node *node;
 	struct vhost_umem *umem = vq->iotlb;
-	u64 s = 0, size, orig_addr = addr, last = addr + len - 1;
+	u64 s = 0, size, orig_addr = addr, last = addr + len;
 
 	if (vhost_vq_meta_fetch(vq, addr, len, type))
 		return true;
 
 	while (len > s) {
 		node = vhost_umem_interval_tree_iter_first(&umem->umem_tree,
-							   addr,
-							   last);
+							   addr, last);
 		if (node == NULL || node->start > addr) {
 			vhost_iotlb_miss(vq, addr, access);
 			return false;
@@ -2055,7 +2054,7 @@ static int translate_desc(struct vhost_virtqueue *vq, u64 addr, u32 len,
 		}
 
 		node = vhost_umem_interval_tree_iter_first(&umem->umem_tree,
-							addr, addr + len - 1);
+							addr, addr + len);
 		if (node == NULL || node->start > addr) {
 			if (umem != dev->iotlb) {
 				ret = -EFAULT;
diff --git a/include/linux/interval_tree_generic.h b/include/linux/interval_tree_generic.h
index aaa8a0767aa3..e714e67ebdb5 100644
--- a/include/linux/interval_tree_generic.h
+++ b/include/linux/interval_tree_generic.h
@@ -69,12 +69,12 @@ ITSTATIC void ITPREFIX ## _remove(ITSTRUCT *node,			      \
 }									      \
 									      \
 /*									      \
- * Iterate over intervals intersecting [start;last]			      \
+ * Iterate over intervals intersecting [start;last[			      \
  *									      \
- * Note that a node's interval intersects [start;last] iff:		      \
- *   Cond1: ITSTART(node) <= last					      \
+ * Note that a node's interval intersects [start;last[ iff:		      \
+ *   Cond1: ITSTART(node) < last					      \
  * and									      \
- *   Cond2: start <= ITLAST(node)					      \
+ *   Cond2: start < ITLAST(node)					      \
  */									      \
 									      \
 static ITSTRUCT *							      \
@@ -88,7 +88,7 @@ ITPREFIX ## _subtree_search(ITSTRUCT *node, ITTYPE start, ITTYPE last)	      \
 		if (node->ITRB.rb_left) {				      \
 			ITSTRUCT *left = rb_entry(node->ITRB.rb_left,	      \
 						  ITSTRUCT, ITRB);	      \
-			if (start <= left->ITSUBTREE) {			      \
+			if (start < left->ITSUBTREE) {			      \
 				/*					      \
 				 * Some nodes in left subtree satisfy Cond2.  \
 				 * Iterate to find the leftmost such node N.  \
@@ -101,8 +101,8 @@ ITPREFIX ## _subtree_search(ITSTRUCT *node, ITTYPE start, ITTYPE last)	      \
 				continue;				      \
 			}						      \
 		}							      \
-		if (ITSTART(node) <= last) {		/* Cond1 */	      \
-			if (start <= ITLAST(node))	/* Cond2 */	      \
+		if (ITSTART(node) < last) {		/* Cond1 */	      \
+			if (start < ITLAST(node))	/* Cond2 */	      \
 				return node;	/* node is leftmost match */  \
 			if (node->ITRB.rb_right) {			      \
 				node = rb_entry(node->ITRB.rb_right,	      \
@@ -125,24 +125,19 @@ ITPREFIX ## _iter_first(struct rb_root_cached *root,			      \
 		return NULL;						      \
 									      \
 	/*								      \
-	 * Fastpath range intersection/overlap between A: [a0, a1] and	      \
-	 * B: [b0, b1] is given by:					      \
-	 *								      \
-	 *         a0 <= b1 && b0 <= a1					      \
-	 *								      \
-	 *  ... where A holds the lock range and B holds the smallest	      \
-	 * 'start' and largest 'last' in the tree. For the later, we	      \
-	 * rely on the root node, which by augmented interval tree	      \
+	 * Fastpath range intersection/overlap where we compare the	      \
+	 * smallest 'start' and largest 'last' in the tree. For the later,    \
+	 * we rely on the root node, which by augmented interval tree	      \
 	 * property, holds the largest value in its last-in-subtree.	      \
 	 * This allows mitigating some of the tree walk overhead for	      \
 	 * for non-intersecting ranges, maintained and consulted in O(1).     \
 	 */								      \
 	node = rb_entry(root->rb_root.rb_node, ITSTRUCT, ITRB);		      \
-	if (node->ITSUBTREE < start)					      \
+	if (node->ITSUBTREE <= start)	/* !Cond2 */			      \
 		return NULL;						      \
 									      \
 	leftmost = rb_entry(root->rb_leftmost, ITSTRUCT, ITRB);		      \
-	if (ITSTART(leftmost) > last)					      \
+	if (ITSTART(leftmost) >= last)	/* !Cond1 */			      \
 		return NULL;						      \
 									      \
 	return ITPREFIX ## _subtree_search(node, start, last);		      \
@@ -156,14 +151,14 @@ ITPREFIX ## _iter_next(ITSTRUCT *node, ITTYPE start, ITTYPE last)	      \
 	while (true) {							      \
 		/*							      \
 		 * Loop invariants:					      \
-		 *   Cond1: ITSTART(node) <= last			      \
+		 *   Cond1: ITSTART(node) < last			      \
 		 *   rb == node->ITRB.rb_right				      \
 		 *							      \
 		 * First, search right subtree if suitable		      \
 		 */							      \
 		if (rb) {						      \
 			ITSTRUCT *right = rb_entry(rb, ITSTRUCT, ITRB);	      \
-			if (start <= right->ITSUBTREE)			      \
+			if (start < right->ITSUBTREE)			      \
 				return ITPREFIX ## _subtree_search(right,     \
 								start, last); \
 		}							      \
@@ -178,10 +173,10 @@ ITPREFIX ## _iter_next(ITSTRUCT *node, ITTYPE start, ITTYPE last)	      \
 			rb = node->ITRB.rb_right;			      \
 		} while (prev == rb);					      \
 									      \
-		/* Check if the node intersects [start;last] */		      \
-		if (last < ITSTART(node))		/* !Cond1 */	      \
+		/* Check if the node intersects [start;last[ */		      \
+		if (last <= ITSTART(node))		/* !Cond1 */	      \
 			return NULL;					      \
-		else if (start <= ITLAST(node))		/* Cond2 */	      \
+		else if (start < ITLAST(node))		/* Cond2 */	      \
 			return node;					      \
 	}								      \
 }
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 14c5eb514bfe..ed5dad316aa1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2245,7 +2245,7 @@ struct vm_area_struct *vma_interval_tree_iter_next(struct vm_area_struct *node,
 	     vma; vma = vma_interval_tree_iter_next(vma, start, last))
 
 #define vma_interval_tree_foreach_stab(vma, root, start)		\
-	vma_interval_tree_foreach(vma, root, start, start)
+	vma_interval_tree_foreach(vma, root, start, start + 1)
 
 void anon_vma_interval_tree_insert(struct anon_vma_chain *node,
 				   struct rb_root_cached *root);
@@ -2265,7 +2265,7 @@ void anon_vma_interval_tree_verify(struct anon_vma_chain *node);
 	     avc; avc = anon_vma_interval_tree_iter_next(avc, start, last))
 
 #define anon_vma_interval_tree_foreach_stab(vma, root, start)		\
-	anon_vma_interval_tree_foreach(vma, root, start, start)
+	anon_vma_interval_tree_foreach(vma, root, start, start + 1)
 
 /* mmap.c */
 extern int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin);
diff --git a/include/rdma/ib_umem_odp.h b/include/rdma/ib_umem_odp.h
index 253df1a1fa54..6ef5d62fc715 100644
--- a/include/rdma/ib_umem_odp.h
+++ b/include/rdma/ib_umem_odp.h
@@ -165,11 +165,10 @@ rbt_ib_umem_lookup(struct rb_root_cached *root, u64 addr, u64 length)
 {
 	struct interval_tree_node *node;
 
-	node = interval_tree_iter_first(root, addr, addr + length - 1);
+	node = interval_tree_iter_first(root, addr, addr + length);
 	if (!node)
 		return NULL;
 	return container_of(node, struct ib_umem_odp, interval_tree);
-
 }
 
 static inline int ib_umem_mmu_notifier_retry(struct ib_umem_odp *umem_odp,
diff --git a/mm/interval_tree.c b/mm/interval_tree.c
index 11c75fb07584..99d1a260043c 100644
--- a/mm/interval_tree.c
+++ b/mm/interval_tree.c
@@ -17,7 +17,7 @@ static inline unsigned long vma_start_pgoff(struct vm_area_struct *v)
 
 static inline unsigned long vma_last_pgoff(struct vm_area_struct *v)
 {
-	return v->vm_pgoff + vma_pages(v) - 1;
+	return v->vm_pgoff + vma_pages(v);
 }
 
 INTERVAL_TREE_DEFINE(struct vm_area_struct, shared.rb,
