Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51883C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 22:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1751820651
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 22:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555626275;
	bh=hftJc36X3fIepzS0pe5Bd5zqY9jmYizdCLndpeQqBko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=CdQv1z1kymZLUNOIpKC41AZaeRjxGKGWPkW1/6eiFCvb9F+kie3FjIoHa2+rWxTzW
	 aFtGT0qqLLQNvRXNkvoo58+PsRkwQ/feVQCwI51xoL+6+4s/uQEEVdJOEKLPUlE39Q
	 /Pw48sdjCUN7ofXAK16PejscI4qLdLKe8K8pWkzE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfDRWYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 18:24:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59410 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbfDRWYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 18:24:33 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 584911F5A;
        Thu, 18 Apr 2019 22:24:32 +0000 (UTC)
Date:   Thu, 18 Apr 2019 15:24:31 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Roman Gushchin <guroan@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Joel Fernandes <joelaf@google.com>
Subject: Re: [PATCH v4 1/2] mm: refactor __vunmap() to avoid duplicated call
 to find_vm_area()
Message-Id: <20190418152431.c583ef892a8028c662db3e6a@linux-foundation.org>
In-Reply-To: <20190418111834.GE7751@bombadil.infradead.org>
References: <20190417194002.12369-1-guro@fb.com>
        <20190417194002.12369-2-guro@fb.com>
        <20190417145827.8b1c83bf22de8ba514f157e3@linux-foundation.org>
        <20190418111834.GE7751@bombadil.infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Apr 2019 04:18:34 -0700 Matthew Wilcox <willy@infradead.org> wrote:

> On Wed, Apr 17, 2019 at 02:58:27PM -0700, Andrew Morton wrote:
> > On Wed, 17 Apr 2019 12:40:01 -0700 Roman Gushchin <guroan@gmail.com> wrote:
> > > +static struct vm_struct *__remove_vm_area(struct vmap_area *va)
> > > +{
> > > +	struct vm_struct *vm = va->vm;
> > > +
> > > +	might_sleep();
> > 
> > Where might __remove_vm_area() sleep?
> > 
> > >From a quick scan I'm only seeing vfree(), and that has the
> > might_sleep_if(!in_interrupt()).
> > 
> > So perhaps we can remove this...
> 
> See commit 5803ed292e63 ("mm: mark all calls into the vmalloc subsystem as potentially sleeping")
> 
> It looks like the intent is to unconditionally check might_sleep() at
> the entry points to the vmalloc code, rather than only catch them in
> the occasional place where it happens to go wrong.

afaict, vfree() will only do a mutex_trylock() in
try_purge_vmap_area_lazy().  So does vfree actually sleep in any
situation?  Whether or not local interrupts are enabled?


