Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B87CA9EA9
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 01:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8471C222CD
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 01:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571450340;
	bh=GWYlF/iOYA1FbDRl6AS4IwAeF86kJLhjlrh3zMQI9OA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=1uun9qjihNzw6aoEUrd4MNTVE/p/QjP8W2ocmfbso3dXb6XlCR3D/SDcU+UY51m58
	 aUopnDFpFe13/CGQrYvmzfxpyI0V/63T2u6srTc+Et0mDsiLvoxwDWFix1lleaUVIp
	 RkcyB2s7bgCCZmnOuLHfvLkyzbZ20wSSDm1LzOb8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfJSB67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 21:58:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbfJSB67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 21:58:59 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30A80222C2;
        Sat, 19 Oct 2019 01:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571450337;
        bh=GWYlF/iOYA1FbDRl6AS4IwAeF86kJLhjlrh3zMQI9OA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l56rdP0f9iXMTAUXnT5mvBkd8G9OESNitxSge0+9JSeYosNk39wnMmHTYF48/jsUY
         eF+88V+rmk/e38F9ME1C0VO9uDi5X2FVanpc6NbVRamIE8QqgR2fT2n0H0CmgQBrw9
         QzMaZ0a2d45b0vbZ/bZVX9GRNOBkJ0a2dOXPJ0l8=
Date:   Fri, 18 Oct 2019 18:58:56 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Michal Hocko <mhocko@kernel.org>, Daniel Wagner <dwagner@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hillf Danton <hdanton@sina.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 2/3] mm/vmalloc: respect passed gfp_mask when do
 preloading
Message-Id: <20191018185856.1a77fc3a14a58ec18ca76a59@linux-foundation.org>
In-Reply-To: <20191018094049.GB8744@pc636>
References: <20191016095438.12391-1-urezki@gmail.com>
        <20191016095438.12391-2-urezki@gmail.com>
        <20191016110604.GT317@dhcp22.suse.cz>
        <20191018094049.GB8744@pc636>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2019 11:40:49 +0200 Uladzislau Rezki <urezki@gmail.com> wrote:

> > > alloc_vmap_area() is given a gfp_mask for the page allocator.
> > > Let's respect that mask and consider it even in the case when
> > > doing regular CPU preloading, i.e. where a context can sleep.
> > 
> > This is explaining what but it doesn't say why. I would go with
> > "
> > Allocation functions should comply with the given gfp_mask as much as
> > possible. The preallocation code in alloc_vmap_area doesn't follow that
> > pattern and it is using a hardcoded GFP_KERNEL. Although this doesn't
> > really make much difference because vmalloc is not GFP_NOWAIT compliant
> > in general (e.g. page table allocations are GFP_KERNEL) there is no
> > reason to spread that bad habit and it is good to fix the antipattern.
> > "
> I can go with that, agree. I am not sure if i need to update the patch
> and send v4. Or maybe Andrew can directly update it in his tree.
> 
> Andrew, should i send or can update?

I updated the changelog with Michal's words prior to committing.  You
were cc'ed :)


From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: mm/vmalloc: respect passed gfp_mask when doing preloading

Allocation functions should comply with the given gfp_mask as much as
possible.  The preallocation code in alloc_vmap_area doesn't follow that
pattern and it is using a hardcoded GFP_KERNEL.  Although this doesn't
really make much difference because vmalloc is not GFP_NOWAIT compliant in
general (e.g.  page table allocations are GFP_KERNEL) there is no reason
to spread that bad habit and it is good to fix the antipattern.

[mhocko@suse.com: rewrite changelog]
Link: http://lkml.kernel.org/r/20191016095438.12391-2-urezki@gmail.com
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Daniel Wagner <dwagner@suse.de>
Cc: Hillf Danton <hdanton@sina.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/vmalloc.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/mm/vmalloc.c~mm-vmalloc-respect-passed-gfp_mask-when-do-preloading
+++ a/mm/vmalloc.c
@@ -1063,9 +1063,9 @@ static struct vmap_area *alloc_vmap_area
 		return ERR_PTR(-EBUSY);
 
 	might_sleep();
+	gfp_mask = gfp_mask & GFP_RECLAIM_MASK;
 
-	va = kmem_cache_alloc_node(vmap_area_cachep,
-			gfp_mask & GFP_RECLAIM_MASK, node);
+	va = kmem_cache_alloc_node(vmap_area_cachep, gfp_mask, node);
 	if (unlikely(!va))
 		return ERR_PTR(-ENOMEM);
 
@@ -1073,7 +1073,7 @@ static struct vmap_area *alloc_vmap_area
 	 * Only scan the relevant parts containing pointers to other objects
 	 * to avoid false negatives.
 	 */
-	kmemleak_scan_area(&va->rb_node, SIZE_MAX, gfp_mask & GFP_RECLAIM_MASK);
+	kmemleak_scan_area(&va->rb_node, SIZE_MAX, gfp_mask);
 
 retry:
 	/*
@@ -1099,7 +1099,7 @@ retry:
 		 * Just proceed as it is. If needed "overflow" path
 		 * will refill the cache we allocate from.
 		 */
-		pva = kmem_cache_alloc_node(vmap_area_cachep, GFP_KERNEL, node);
+		pva = kmem_cache_alloc_node(vmap_area_cachep, gfp_mask, node);
 
 	spin_lock(&vmap_area_lock);
 
_

