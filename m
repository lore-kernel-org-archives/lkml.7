Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B6DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE972171F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LeGz+7v4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbfCKS2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:28:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44592 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfCKS2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:28:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zql7ZPptly1iIxZew0nuirsgoVetFeGAsmzuBdx4ALU=; b=LeGz+7v4sytMAPhaqO4O+s2eiR
        J4A65GkGNwlB6A71S5xyBKnlTlzoExbDsihBzxk39z1OGyh7z8W5BDTxzK4NbQTXYhfZM2RssWdlk
        h90MpXhyDG4SG56kHctd6QNwTO+Rd1IpF1AF7CAkPAjVjC81jlvuf4rOoruls4hPLkXySccLECKsF
        JaVtVqWq7ZkH7DeHD64DLoS4CG4k3F57iBvLiTNwQ1vYT0M00JnmXD8vDTHo/W9neBBiaZFlS+/Ts
        KLC4oBlY03f55e0Ig/FOMmIDAkMdLfj2xevxct3c/rq1wi9N6pvoqtEn2RFW6Z6dEVWmN6jJwGq/L
        m9GADYfQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h3Pf3-0000QH-Kf; Mon, 11 Mar 2019 18:28:29 +0000
Date:   Mon, 11 Mar 2019 11:28:29 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] XArray updates for 5.1-rc1
Message-ID: <20190311182829.GE19508@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

This pull request changes the xa_alloc() API.  I'm only aware of one
subsystem that has started trying to use it, and we agree on the following
fixup patch to be applied as part of the merge [1].

The xa_insert() error code also changed to match xa_alloc() (EEXIST to
EBUSY), and I added xa_alloc_cyclic().  Beyond that, the usual bugfixes,
optimisations and tweaking.

I now have a git tree with all users of the radix tree and IDR converted
over to the XArray that I'll be feeding to maintainers over the next
few weeks.

The following changes since commit 8834f5600cf3c8db365e18a3d5cac2c2780c81e5:

  Linux 5.0-rc5 (2019-02-03 13:48:04 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/willy/linux-dax.git xarray

for you to fetch changes up to 4a5c8d898948d1ac876522cdd62f07a78104bfe9:

  XArray: Fix xa_reserve for 2-byte aligned entries (2019-02-21 17:54:44 -0500)

----------------------------------------------------------------
Matthew Wilcox (11):
      XArray tests: RCU lock prohibits GFP_KERNEL
      XArray: Update xa_erase family descriptions
      XArray: Change xa_insert to return -EBUSY
      XArray: Add support for 1s-based allocation
      XArray: Redesign xa_alloc API
      XArray: Add cyclic allocation
      XArray: Mark xa_insert and xa_reserve as must_check
      XArray: Fix xa_release in allocating arrays
      XArray: Use xa_cmpxchg to implement xa_reserve
      XArray: Fix xa_erase of 2-byte aligned entries
      XArray: Fix xa_reserve for 2-byte aligned entries

 Documentation/core-api/xarray.rst |  15 +-
 fs/nilfs2/btnode.c                |   2 +-
 include/linux/xarray.h            | 296 +++++++++++++++++++++++++++-----------
 lib/test_xarray.c                 | 288 +++++++++++++++++++++++++++++--------
 lib/xarray.c                      | 163 ++++++++++++---------
 5 files changed, 547 insertions(+), 217 deletions(-)

[1]

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index a9f29156e486..7421ec4883fb 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -668,19 +668,10 @@ static int assign_name(struct ib_device *device, const char *name)
 	}
 	strlcpy(device->name, dev_name(&device->dev), IB_DEVICE_NAME_MAX);
 
-	/* Cyclically allocate a user visible ID for the device */
-	device->index = last_id;
-	ret = xa_alloc(&devices, &device->index, INT_MAX, device, GFP_KERNEL);
-	if (ret == -ENOSPC) {
-		device->index = 0;
-		ret = xa_alloc(&devices, &device->index, INT_MAX, device,
-			       GFP_KERNEL);
-	}
-	if (ret)
-		goto out;
-	last_id = device->index + 1;
-
-	ret = 0;
+	ret = xa_alloc_cyclic(&devices, &device->index, device, xa_limit_31b,
+			&last_id, GFP_KERNEL);
+	if (ret > 0)
+		ret = 0;
 
 out:
 	up_write(&devices_rwsem);
@@ -1059,14 +1050,15 @@ static int assign_client_id(struct ib_client *client)
 	 * to get the LIFO order. The extra linked list can go away if xarray
 	 * learns to reverse iterate.
 	 */
-	if (list_empty(&client_list))
+	if (list_empty(&client_list)) {
 		client->client_id = 0;
-	else
-		client->client_id =
-			list_last_entry(&client_list, struct ib_client, list)
-				->client_id;
-	ret = xa_alloc(&clients, &client->client_id, INT_MAX, client,
-		       GFP_KERNEL);
+	} else {
+		struct ib_client *last;
+
+		last = list_last_entry(&client_list, struct ib_client, list);
+		client->client_id = last->client_id + 1;
+	}
+	ret = xa_insert(&clients, client->client_id, client, GFP_KERNEL);
 	if (ret)
 		goto out;
 
diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
index fa804093fafb..3b5ff2f7b5f8 100644
--- a/drivers/infiniband/core/restrack.c
+++ b/drivers/infiniband/core/restrack.c
@@ -13,28 +13,6 @@
 #include "cma_priv.h"
 #include "restrack.h"
 
-static int rt_xa_alloc_cyclic(struct xarray *xa, u32 *id, void *entry,
-			      u32 *next)
-{
-	int err;
-
-	*id = *next;
-	if (*next == U32_MAX)
-		*id = 0;
-
-	xa_lock(xa);
-	err = __xa_alloc(xa, id, U32_MAX, entry, GFP_KERNEL);
-	if (err && *next != U32_MAX) {
-		*id = 0;
-		err = __xa_alloc(xa, id, *next, entry, GFP_KERNEL);
-	}
-
-	if (!err)
-		*next = *id + 1;
-	xa_unlock(xa);
-	return err;
-}
-
 /**
  * rdma_restrack_init() - initialize and allocate resource tracking
  * @dev:  IB device
@@ -226,7 +204,8 @@ static void rdma_restrack_add(struct rdma_restrack_entry *res)
 	kref_init(&res->kref);
 	init_completion(&res->comp);
 	if (res->type != RDMA_RESTRACK_QP)
-		ret = rt_xa_alloc_cyclic(&rt->xa, &res->id, res, &rt->next_id);
+		ret = xa_alloc_cyclic(&rt->xa, &res->id, res, xa_limit_32b,
+				&rt->next_id, GFP_KERNEL);
 	else {
 		/* Special case to ensure that LQPN points to right QP */
 		struct ib_qp *qp = container_of(res, struct ib_qp, res);
