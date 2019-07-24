Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41E9C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C65AF204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="aJRIeg6p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389369AbfGXU2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:28:54 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39738 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389016AbfGXTeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:34:00 -0400
Received: by mail-pg1-f193.google.com with SMTP id u17so21711040pgi.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 12:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c620Z7QmNN4xuzBoT0I523KlXKmQArPqXiiSBk5DJAo=;
        b=aJRIeg6pq323ryehRW15NWh/H46jxm2+UlXPt/GAp+gGlXsdiD5tuwNAzwSOlQjvte
         kAf7yvLfhsa31LbfvzoQxal4db/+ND5t3sCE3KQ0cK1D2FNrEMSsUF10lD+va5+XCjZF
         82tS1vs8G8RyiJ9FtkZUoim+/k0zp6iCqhTGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c620Z7QmNN4xuzBoT0I523KlXKmQArPqXiiSBk5DJAo=;
        b=LwzvdKSrby8qXkw3PUl+x6XM5Q8ntgV2cCrKfF5tthGPGWUMXmw8H/Te25ClHM4QXy
         VYW544QOWtXPFAHNztntqEEuqkwdlJwGsyKQizWLTjy6zfbLEN94vjo0z6M9pOA6pnPg
         Y8/WkgFKpritEhAfyid9E3SMxWBPBd5gJ3yGeUH54cuxH1MeI4ZFHNPkQgkM8sqKeunh
         /8DCgT/cl4NbMkalPRiYaxSn0af3sLCFpssx7G8u8NzuIxtn/3fzh/J2G0PmkJjkLml8
         NjumosUpJxxxc6fp8LdapxN+lkey8XYmXfMXgYD+BjdSN9r8wG2KljjVQfMjZ2AsVKTY
         T3Sg==
X-Gm-Message-State: APjAAAWWSXvVnEDekCtxzXwhhacOBOtSfn3D0HVUxhTSuKIkxqZzcaix
        4Vlu7HoOIBAa6qP6o2vvmhc=
X-Google-Smtp-Source: APXvYqxRZo6EdKy/Ij4HPNmhe7JYCvmAq8gwdkPC9eWWevt48AruaweG4iMi6+eWocFY2nBwaDK8/g==
X-Received: by 2002:a17:90a:2190:: with SMTP id q16mr86312060pjc.23.1563996839453;
        Wed, 24 Jul 2019 12:33:59 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id i124sm87050514pfe.61.2019.07.24.12.33.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 12:33:58 -0700 (PDT)
Date:   Wed, 24 Jul 2019 15:33:57 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, vdavydov.dev@gmail.com,
        Brendan Gregg <bgregg@netflix.com>, kernel-team@android.com,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>, carmenjackson@google.com,
        Christian Hansen <chansen3@cisco.com>,
        Colin Ian King <colin.king@canonical.com>, dancol@google.com,
        David Howells <dhowells@redhat.com>, fmayer@google.com,
        joaodias@google.com, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>, minchan@google.com,
        minchan@kernel.org, namhyung@google.com, sspatil@google.com,
        surenb@google.com, Thomas Gleixner <tglx@linutronix.de>,
        timmurray@google.com, tkjos@google.com,
        Vlastimil Babka <vbabka@suse.cz>, wvw@google.com
Subject: Re: [PATCH v1 1/2] mm/page_idle: Add support for per-pid page_idle
 using virtual indexing
Message-ID: <20190724193357.GB21829@google.com>
References: <20190722213205.140845-1-joel@joelfernandes.org>
 <20190722150639.27641c63b003dd04e187fd96@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722150639.27641c63b003dd04e187fd96@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 03:06:39PM -0700, Andrew Morton wrote:
[snip] 
> > +	*end = *start + count * BITS_PER_BYTE;
> > +	if (*end > max_frame)
> > +		*end = max_frame;
> > +	return 0;
> > +}
> > +
> >
> > ...
> >
> > +static void add_page_idle_list(struct page *page,
> > +			       unsigned long addr, struct mm_walk *walk)
> > +{
> > +	struct page *page_get;
> > +	struct page_node *pn;
> > +	int bit;
> > +	unsigned long frames;
> > +	struct page_idle_proc_priv *priv = walk->private;
> > +	u64 *chunk = (u64 *)priv->buffer;
> > +
> > +	if (priv->write) {
> > +		/* Find whether this page was asked to be marked */
> > +		frames = (addr - priv->start_addr) >> PAGE_SHIFT;
> > +		bit = frames % BITMAP_CHUNK_BITS;
> > +		chunk = &chunk[frames / BITMAP_CHUNK_BITS];
> > +		if (((*chunk >> bit) & 1) == 0)
> > +			return;
> > +	}
> > +
> > +	page_get = page_idle_get_page(page);
> > +	if (!page_get)
> > +		return;
> > +
> > +	pn = kmalloc(sizeof(*pn), GFP_ATOMIC);
> 
> I'm not liking this GFP_ATOMIC.  If I'm reading the code correctly,
> userspace can ask for an arbitrarily large number of GFP_ATOMIC
> allocations by doing a large read.  This can potentially exhaust page
> reserves which things like networking Rx interrupts need and can make
> this whole feature less reliable.

For the revision, I will pre-allocate the page nodes in advance so it does
not need to do this. Diff on top of this patch is below. Let me know any
comments, thanks.

Btw, I also dropped the idle_page_list_lock by putting the idle_page_list
list_head on the stack instead of heap.
---8<-----------------------

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH] mm/page_idle: Avoid need for GFP_ATOMIC

GFP_ATOMIC can harm allocations does by other allocations that are in
need of reserves and the like. Pre-allocate the nodes list so that
spinlocked region can just use it.

Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 mm/page_idle.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/mm/page_idle.c b/mm/page_idle.c
index 874a60c41fef..b9c790721f16 100644
--- a/mm/page_idle.c
+++ b/mm/page_idle.c
@@ -266,6 +266,10 @@ struct page_idle_proc_priv {
 	unsigned long start_addr;
 	char *buffer;
 	int write;
+
+	/* Pre-allocate and provide nodes to add_page_idle_list() */
+	struct page_node *page_nodes;
+	int cur_page_node;
 };
 
 static void add_page_idle_list(struct page *page,
@@ -291,10 +295,7 @@ static void add_page_idle_list(struct page *page,
 	if (!page_get)
 		return;
 
-	pn = kmalloc(sizeof(*pn), GFP_ATOMIC);
-	if (!pn)
-		return;
-
+	pn = &(priv->page_nodes[priv->cur_page_node++]);
 	pn->page = page_get;
 	pn->addr = addr;
 	list_add(&pn->list, &idle_page_list);
@@ -379,6 +380,15 @@ ssize_t page_idle_proc_generic(struct file *file, char __user *ubuff,
 	priv.buffer = buffer;
 	priv.start_addr = start_addr;
 	priv.write = write;
+
+	priv.cur_page_node = 0;
+	priv.page_nodes = kzalloc(sizeof(struct page_node) * (end_frame - start_frame),
+				  GFP_KERNEL);
+	if (!priv.page_nodes) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
 	walk.private = &priv;
 	walk.mm = mm;
 
@@ -425,6 +435,7 @@ ssize_t page_idle_proc_generic(struct file *file, char __user *ubuff,
 		ret = copy_to_user(ubuff, buffer, count);
 
 	up_read(&mm->mmap_sem);
+	kfree(priv.page_nodes);
 out:
 	kfree(buffer);
 out_mmput:
-- 
2.22.0.657.g960e92d24f-goog

