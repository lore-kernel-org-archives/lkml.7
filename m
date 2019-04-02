Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AFDC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA29A2146E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RIAfXofg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730971AbfDBOKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 10:10:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42100 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbfDBOKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 10:10:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yJAk7JBHZRxnc+86KWmwsxNa65Ai6RJsNUROoSDZXM8=; b=RIAfXofgI5AXMkmJK8jl1V8lt
        1XNAJC+z8pYk6lpA22iStJgLlLs4bBogHezEOmO70VSMOS/+G6f3w6Sb58MoJIHScd1yItwYbYhqQ
        /mQuxMdd0L6jfHu4ngsiBSUURN/t3ghJjuukIOuGHNal5AFilhYkyl7N9YAYXecOlP59dCgTOks9D
        Xvrc/IPxnFoqDt1/+HtJd9rdrymV2bM82XZSsBwDhxzxNStLpSraHPKAEj0h8asN4ZBRVaLGySzP6
        0rXi1QKpdtKnuGRsFh50RBIx6d+K3WI6T+l7uc2FoFwAWQ1NB2uhi5bWRvmhg2HLKRcEydUTm/2OE
        JDPPbHB0Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hBK7d-0004gb-Jg; Tue, 02 Apr 2019 14:10:41 +0000
Date:   Tue, 2 Apr 2019 07:10:41 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Qiang Yu <yuq825@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Anholt <eric@anholt.net>
Subject: Re: linux-next: build failure after merge of the drm-misc tree
Message-ID: <20190402141041.GF22763@bombadil.infradead.org>
References: <20190402105006.48f93e53@canb.auug.org.au>
 <CAKGbVbvj9cZnJuey_ra7U+xm-JhoB17bpTgcXKiKaHWbjB9Sxw@mail.gmail.com>
 <20190402112656.GE22763@bombadil.infradead.org>
 <CAKGbVbuY3mKAZ6bA9G87NHq7mdxkw95p7OoO_QyUU_101yQEuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKGbVbuY3mKAZ6bA9G87NHq7mdxkw95p7OoO_QyUU_101yQEuQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 09:56:08PM +0800, Qiang Yu wrote:
> On Tue, Apr 2, 2019 at 7:26 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Tue, Apr 02, 2019 at 01:55:03PM +0800, Qiang Yu wrote:
> > > Thanks, patch is:
> > > Reviewed-by: Qiang Yu <yuq825@gmail.com>
> >
> > This looks like a fairly naive conversion from the old IDR API to the
> > XArray API.  You should be able to remove mgr->lock entirely, relying on
> > the xa_lock for synchronising free and get.
> 
> I'm afraid the a little complex free path may involve some might sleep
> functions so use a mutex lock instead of spinlock.

Ah, good call ...

+       mutex_lock(&mgr->lock);
+       ctx = xa_erase(&mgr->handles, id);
+       if (ctx)
+               kref_put(&ctx->refcnt, lima_ctx_do_release);
+       else
+               ret = -EINVAL;
+       mutex_unlock(&mgr->lock);

+static void lima_ctx_do_release(struct kref *ref)
+{
+       struct lima_ctx *ctx = container_of(ref, struct lima_ctx, refcnt);
+       int i;
+
+       for (i = 0; i < lima_pipe_num; i++)
+               lima_sched_context_fini(ctx->dev->pipe + i, ctx->context + i);
+       kfree(ctx);
+}

+void lima_sched_context_fini(struct lima_sched_pipe *pipe,
+                            struct lima_sched_context *context)
+{
+       drm_sched_entity_fini(&context->base);
+}

and drm_sched_entity_fini() can call kthread_park(), which does sleep.

> > If you think it's worth it,
> > you could even use kfree_rcu() to free the ctx and kref_get_unless_zero()
> > and then your get path would be lock-free.
> 
> I can take a look this way, thanks.

I think that's the only way you can get rid of the mutex, given the
sleeping functions called in the free path.
