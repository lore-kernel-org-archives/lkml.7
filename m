Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1EEC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 17:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77A4E20848
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 17:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbfEQRmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 13:42:04 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:21499 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfEQRmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 13:42:04 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id DCA0D4098D;
        Fri, 17 May 2019 19:42:00 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id w9CjRh6KPBIJ; Fri, 17 May 2019 19:42:00 +0200 (CEST)
Received: from localhost (h-41-252.A163.priv.bahnhof.se [46.59.41.252])
        (Authenticated sender: mb547485)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id E919340974;
        Fri, 17 May 2019 19:41:59 +0200 (CEST)
Date:   Fri, 17 May 2019 19:41:59 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, "hch@lst.de" <hch@lst.de>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "marex@denx.de" <marex@denx.de>,
        "JuergenUrban@gmx.de" <JuergenUrban@gmx.de>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 0/3] prerequisites for device reserved local mem
 rework
Message-ID: <20190517174159.GA32450@sx9>
References: <20190514143807.7745-1-laurentiu.tudor@nxp.com>
 <9d34015d-c219-179b-3141-4b0de3530ac3@arm.com>
 <20190514182931.GA2559@sx9>
 <0e5f3b86-7a80-eec7-691b-34a123194208@nxp.com>
 <20190515162858.GB17162@sx9>
 <ed63c117-610c-ea49-f45e-727be220745f@nxp.com>
 <20190516151548.GB53952@sx9>
 <5fa97254-3038-6fe7-a7e7-a267262049c6@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5fa97254-3038-6fe7-a7e7-a267262049c6@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurentiu,

> > that I tracked down to the calls
> > 
> > 	   hub_port_init
> > 	-> usb_control_msg
> > 	-> usb_internal_control_msg
> > 	-> usb_start_wait_urb
> > 	-> usb_submit_urb
> > 	-> usb_hcd_submit_urb
> > 	-> hcd->driver->urb_enqueue
> > 	-> ohci_urb_enqueue
> > 	-> ed_get
> > 	-> ed_alloc

I found that the generic OHCI driver takes a wrong turn here, in ed_alloc,
and eventually also in td_alloc. Fortunately, your patch can be easily
extended to fix them as well. Please see attached patch below.

With that, the OHCI seems to work as expected with HCD_LOCAL_MEM. :)

Would you like me to submit gen_pool_dma_zalloc as a separate patch?

> That looks indeed worrisome but I'd expect that it's not related to 
> these genalloc changes that I'm working on. I'll try to look into it but 
> as I'm not familiar with the area maybe others will comment.

It seems appropriate to verify that the IRQ will not end up sleeping
somewhere in the pool.

> > Also, DMA_BUFFER_SIZE in ohci-ps2.c is only 256 KiB in total. Is the new
> > pool implementation at least as efficient as the previous one?
> 
> I don't see any obvious reasons for genalloc to be less efficient.

OK, good.

> One thing I noticed between genalloc and the original implementation is 
> that previously the device memory was mapped with memremap() while with 
> genalloc I'm doing a devm_ioremap(). I can't think of a relevant 
> difference except that memremap() maps with WC buth maybe there are 
> other arch specific subtleties. I've attached a new version of the 
> ohci-ps2 patch replacing the devm_ioremap() with devm_memremap() to 
> better match the original implementation. Please test if you find some time.

You're right, it makes no difference.

Fredrik

diff --git a/drivers/usb/host/ohci-mem.c b/drivers/usb/host/ohci-mem.c
--- a/drivers/usb/host/ohci-mem.c
+++ b/drivers/usb/host/ohci-mem.c
@@ -82,10 +82,14 @@ dma_to_td (struct ohci_hcd *hc, dma_addr_t td_dma)
 static struct td *
 td_alloc (struct ohci_hcd *hc, gfp_t mem_flags)
 {
+	struct usb_hcd	*hcd = ohci_to_hcd(hc);
 	dma_addr_t	dma;
 	struct td	*td;
 
-	td = dma_pool_zalloc (hc->td_cache, mem_flags, &dma);
+	if (hcd->driver->flags & HCD_LOCAL_MEM)
+		td = gen_pool_dma_zalloc (hcd->localmem_pool, sizeof(*td), &dma);
+	else
+		td = dma_pool_zalloc (hc->td_cache, mem_flags, &dma);
 	if (td) {
 		/* in case hc fetches it, make it look dead */
 		td->hwNextTD = cpu_to_hc32 (hc, dma);
@@ -98,6 +102,7 @@ td_alloc (struct ohci_hcd *hc, gfp_t mem_flags)
 static void
 td_free (struct ohci_hcd *hc, struct td *td)
 {
+	struct usb_hcd	*hcd = ohci_to_hcd(hc);
 	struct td	**prev = &hc->td_hash [TD_HASH_FUNC (td->td_dma)];
 
 	while (*prev && *prev != td)
@@ -106,7 +111,11 @@ td_free (struct ohci_hcd *hc, struct td *td)
 		*prev = td->td_hash;
 	else if ((td->hwINFO & cpu_to_hc32(hc, TD_DONE)) != 0)
 		ohci_dbg (hc, "no hash for td %p\n", td);
-	dma_pool_free (hc->td_cache, td, td->td_dma);
+
+	if (hcd->driver->flags & HCD_LOCAL_MEM)
+		gen_pool_free (hcd->localmem_pool, (unsigned long)td, sizeof(*td));
+	else
+		dma_pool_free (hc->td_cache, td, td->td_dma);
 }
 
 /*-------------------------------------------------------------------------*/
@@ -115,10 +124,14 @@ td_free (struct ohci_hcd *hc, struct td *td)
 static struct ed *
 ed_alloc (struct ohci_hcd *hc, gfp_t mem_flags)
 {
+	struct usb_hcd	*hcd = ohci_to_hcd(hc);
 	dma_addr_t	dma;
 	struct ed	*ed;
 
-	ed = dma_pool_zalloc (hc->ed_cache, mem_flags, &dma);
+	if (hcd->driver->flags & HCD_LOCAL_MEM)
+		ed = gen_pool_dma_zalloc (hcd->localmem_pool, sizeof(*ed), &dma);
+	else
+		ed = dma_pool_zalloc (hc->ed_cache, mem_flags, &dma);
 	if (ed) {
 		INIT_LIST_HEAD (&ed->td_list);
 		ed->dma = dma;
@@ -129,6 +142,11 @@ ed_alloc (struct ohci_hcd *hc, gfp_t mem_flags)
 static void
 ed_free (struct ohci_hcd *hc, struct ed *ed)
 {
-	dma_pool_free (hc->ed_cache, ed, ed->dma);
+	struct usb_hcd	*hcd = ohci_to_hcd(hc);
+
+	if (hcd->driver->flags & HCD_LOCAL_MEM)
+		gen_pool_free (hcd->localmem_pool, (unsigned long)ed, sizeof(*ed));
+	else
+		dma_pool_free (hc->ed_cache, ed, ed->dma);
 }
 
diff --git a/include/linux/genalloc.h b/include/linux/genalloc.h
--- a/include/linux/genalloc.h
+++ b/include/linux/genalloc.h
@@ -121,6 +121,8 @@ extern unsigned long gen_pool_alloc_algo(struct gen_pool *, size_t,
 		genpool_algo_t algo, void *data);
 extern void *gen_pool_dma_alloc(struct gen_pool *pool, size_t size,
 		dma_addr_t *dma);
+extern void *gen_pool_dma_zalloc(struct gen_pool *pool, size_t size,
+		dma_addr_t *dma);
 extern void gen_pool_free(struct gen_pool *, unsigned long, size_t);
 extern void gen_pool_for_each_chunk(struct gen_pool *,
 	void (*)(struct gen_pool *, struct gen_pool_chunk *, void *), void *);
diff --git a/lib/genalloc.c b/lib/genalloc.c
--- a/lib/genalloc.c
+++ b/lib/genalloc.c
@@ -362,6 +362,17 @@ void *gen_pool_dma_alloc(struct gen_pool *pool, size_t size, dma_addr_t *dma)
 }
 EXPORT_SYMBOL(gen_pool_dma_alloc);
 
+void *gen_pool_dma_zalloc(struct gen_pool *pool, size_t size, dma_addr_t *dma)
+{
+	void *vaddr = gen_pool_dma_alloc(pool, size, dma);
+
+	if (vaddr)
+		memset(vaddr, 0, size);
+
+	return vaddr;
+}
+EXPORT_SYMBOL(gen_pool_dma_zalloc);
+
 /**
  * gen_pool_free - free allocated special memory back to the pool
  * @pool: pool to free to
