Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDB6C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 18:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6676D227C1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 18:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SOC6zwd2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391497AbfGWS3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 14:29:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39192 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731080AbfGWS3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 14:29:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RRFyJIRsQXw1HyelIZmuqPSkCJ5sVdaDgZrRUn5Qers=; b=SOC6zwd238eNTxVRmBmENC25T
        /PVrrzGC1396Nuj63jug527eA2ETr6mAg0Xp2s0ddwAJF51nkVQRSzAsJVTOAZoDHZ2l0RM+7v66X
        RXHQx7bHdhWuTecaixTQgbz0sOBCNLoo/NGIrpMV95TuvI/syZVReZxgGVIIPdlsK4yH5h/OzA2qE
        o3NyJdQQrNdy9wOQ0R74G5rhpUmp4qQuZEctFcAE0hHguOpLvSW2cjdBB3iEgP4MKRlgy6BfJESYJ
        Ea0kiWLIA9YGXO6MvpnDOki6GHjs6fK2kjPsP/V3yxCwcYnw21aip0VGDtoBQTKtHirZaMZvfdpJ1
        hzEmbcm1Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hpzXk-0006kT-Kc; Tue, 23 Jul 2019 18:29:44 +0000
Date:   Tue, 23 Jul 2019 11:29:44 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        lhenriques@suse.com, cmaiolino@redhat.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] mm: check for sleepable context in kvfree
Message-ID: <20190723182944.GO363@bombadil.infradead.org>
References: <20190723131212.445-1-jlayton@kernel.org>
 <3622a5fe9f13ddfd15b262dbeda700a26c395c2a.camel@kernel.org>
 <20190723175543.GL363@bombadil.infradead.org>
 <f43c131d9b635994aafed15cb72308b32d2eef67.camel@kernel.org>
 <20190723181124.GM363@bombadil.infradead.org>
 <d7cd46333eb1a29fb7e0e078dc4fef7646fe2a8c.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7cd46333eb1a29fb7e0e078dc4fef7646fe2a8c.camel@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 02:19:03PM -0400, Jeff Layton wrote:
> On Tue, 2019-07-23 at 11:11 -0700, Matthew Wilcox wrote:
> > On Tue, Jul 23, 2019 at 02:05:11PM -0400, Jeff Layton wrote:
> > > On Tue, 2019-07-23 at 10:55 -0700, Matthew Wilcox wrote:
> > > > I think it's a bit of a landmine, to be honest.  How about we have kvfree()
> > > > call vfree_atomic() instead?
> > > 
> > > Not a bad idea, though it means more overhead for the vfree case.
> > > 
> > > Since we're spitballing here...could we have kvfree figure out whether
> > > it's running in a context where it would need to queue it instead and
> > > only do it in that case?
> > > 
> > > We currently have to figure that out for the might_sleep_if anyway. We
> > > could just have it DTRT instead of printk'ing and dumping the stack in
> > > that case.
> > 
> > I don't think we have a generic way to determine if we're currently
> > holding a spinlock.  ie this can fail:
> > 
> > spin_lock(&my_lock);
> > kvfree(p);
> > spin_unlock(&my_lock);
> > 
> > If we're preemptible, we can check the preempt count, but !CONFIG_PREEMPT
> > doesn't record the number of spinlocks currently taken.
> 
> Ahh right...that makes sense.
> 
> Al also suggested on IRC that we could add a kvfree_atomic if that were
> useful. That might be good for new callers, but we'd probably need a
> patch like this one to suss out which of the existing kvfree callers
> would need to switch to using it.
> 
> I think you're quite right that this is a landmine. That said, this
> seems like something we ought to try to clean up.

I'd rather add a kvfree_fast().  So something like this:

diff --git a/mm/util.c b/mm/util.c
index bab284d69c8c..992f0332dced 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -470,6 +470,28 @@ void *kvmalloc_node(size_t size, gfp_t flags, int node)
 }
 EXPORT_SYMBOL(kvmalloc_node);
 
+/**
+ * kvfree_fast() - Free memory.
+ * @addr: Pointer to allocated memory.
+ *
+ * kvfree_fast frees memory allocated by any of vmalloc(), kmalloc() or
+ * kvmalloc().  It is slightly more efficient to use kfree() or vfree() if
+ * you are certain that you know which one to use.
+ *
+ * Context: Either preemptible task context or not-NMI interrupt.  Must not
+ * hold a spinlock as it can sleep.
+ */
+void kvfree_fast(const void *addr)
+{
+	might_sleep();
+
+	if (is_vmalloc_addr(addr))
+		vfree(addr);
+	else
+		kfree(addr);
+}
+EXPORT_SYMBOL(kvfree_fast);
+
 /**
  * kvfree() - Free memory.
  * @addr: Pointer to allocated memory.
@@ -478,12 +500,12 @@ EXPORT_SYMBOL(kvmalloc_node);
  * It is slightly more efficient to use kfree() or vfree() if you are certain
  * that you know which one to use.
  *
- * Context: Either preemptible task context or not-NMI interrupt.
+ * Context: Any context except NMI.
  */
 void kvfree(const void *addr)
 {
 	if (is_vmalloc_addr(addr))
-		vfree(addr);
+		vfree_atomic(addr);
 	else
 		kfree(addr);
 }
