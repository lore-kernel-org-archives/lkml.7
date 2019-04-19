Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257A9C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F01A720693
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbfDSTI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:08:26 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57298 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729530AbfDSTIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:08:24 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hHYrr-00056j-D4; Fri, 19 Apr 2019 19:08:11 +0000
Date:   Fri, 19 Apr 2019 20:08:11 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Roman Gushchin <guroan@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Joel Fernandes <joelaf@google.com>
Subject: Re: [PATCH v4 1/2] mm: refactor __vunmap() to avoid duplicated call
 to find_vm_area()
Message-ID: <20190419190811.GF2217@ZenIV.linux.org.uk>
References: <20190417194002.12369-1-guro@fb.com>
 <20190417194002.12369-2-guro@fb.com>
 <20190417145827.8b1c83bf22de8ba514f157e3@linux-foundation.org>
 <20190418111834.GE7751@bombadil.infradead.org>
 <20190418152431.c583ef892a8028c662db3e6a@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190418152431.c583ef892a8028c662db3e6a@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 03:24:31PM -0700, Andrew Morton wrote:
> On Thu, 18 Apr 2019 04:18:34 -0700 Matthew Wilcox <willy@infradead.org> wrote:
> 
> > On Wed, Apr 17, 2019 at 02:58:27PM -0700, Andrew Morton wrote:
> > > On Wed, 17 Apr 2019 12:40:01 -0700 Roman Gushchin <guroan@gmail.com> wrote:
> > > > +static struct vm_struct *__remove_vm_area(struct vmap_area *va)
> > > > +{
> > > > +	struct vm_struct *vm = va->vm;
> > > > +
> > > > +	might_sleep();
> > > 
> > > Where might __remove_vm_area() sleep?
> > > 
> > > >From a quick scan I'm only seeing vfree(), and that has the
> > > might_sleep_if(!in_interrupt()).
> > > 
> > > So perhaps we can remove this...
> > 
> > See commit 5803ed292e63 ("mm: mark all calls into the vmalloc subsystem as potentially sleeping")
> > 
> > It looks like the intent is to unconditionally check might_sleep() at
> > the entry points to the vmalloc code, rather than only catch them in
> > the occasional place where it happens to go wrong.
> 
> afaict, vfree() will only do a mutex_trylock() in
> try_purge_vmap_area_lazy().  So does vfree actually sleep in any
> situation?  Whether or not local interrupts are enabled?

IIRC, the original problem that used to prohibit vfree() in interrupts
was the use of spinlocks that were used in a lot of places by plain
spin_lock().  I'm not sure it could actually sleep in anything not
too ancient...
