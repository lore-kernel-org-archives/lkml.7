Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F327AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 02:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B623620657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 02:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pT0uILkB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfCKCok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 22:44:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49570 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbfCKCok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 22:44:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/dFFqFiVvZ+jMYp5fFQQsVonfVwdzNJx8R7//lKsY7c=; b=pT0uILkBlj109LdICSP+UhnrU
        0w3jathVdK05wCFrghEzTEBt6Do+vy8zN5Eun7tHj6tmVnRLZFZ/QzSXZdZhFBKg2XbfAKrG8G1WG
        fn6QUwST+70dEY7+HMML3wKaZrYurT+DvtnuHT9nRGbvQiQrFMRWDnpaAN6xJEDtMvA+iymacFjQK
        xsn4w3hEZqJh7IiBv7ycsYfiwvumYGVXjwLg975sp4CWrk4/0LJro8MBBWp+oMIP5ANKOwZPFiRkY
        KZif88qN0nSFowc+Ms1JeVm9OWtpURrFmSmfcveVcaYvUTLn/ZS/Ej3O9ONKNOavZw37KBkIotUt5
        nDRyJevtA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h3Ava-0006Cx-DR; Mon, 11 Mar 2019 02:44:34 +0000
Date:   Sun, 10 Mar 2019 19:44:34 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Leon Romanovsky <leonro@mellanox.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the xarray tree
Message-ID: <20190311024434.GA19508@bombadil.infradead.org>
References: <20190221171332.262cf619@canb.auug.org.au>
 <20190221123440.GD17501@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221123440.GD17501@mtr-leonro.mtl.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 12:34:42PM +0000, Leon Romanovsky wrote:
> On Thu, Feb 21, 2019 at 05:13:32PM +1100, Stephen Rothwell wrote:
> > Hi all,
> >
> > After merging the xarray tree, today's linux-next build (powerpc
> > ppc64_defconfig) failed like this:

[API change]

So I ended up being really busy last week and not having time to send
my merge request for XArray yet.  I'm going to send a request this week;
Leon and Jason, how does this merge resolution look?

Compile tested only.

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index a9f29156e486..8a93c0c95953 100644
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
@@ -1059,14 +1050,14 @@ static int assign_client_id(struct ib_client *client)
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
+		struct ib_client *last = list_last_entry(&client_list,
+				struct ib_client, list);
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
