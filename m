Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63755C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 279012175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553120194;
	bh=/KXinx4yh7ZqVYs57TWXRP9i6yk4EcRk8/BYfC8kIvs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=gces81KvxZ8HB/RzlkVJoZnHmUjq1OKFJbcwNUqvdTLS5ezttgZbIbzL7l2tiAjeZ
	 8EsFQNkGX5Y2SKUhrEMw6sDafPKFRB7J2sg9Oq9P779RnNWA0KKwWR1FZdjgiXqOtN
	 9ZHlrF0HpVxkD2KGV7X5vukYp/d52AgdCMY3HEA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfCTWQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 18:16:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40196 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbfCTWQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 18:16:32 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 90ADA7056;
        Wed, 20 Mar 2019 22:16:31 +0000 (UTC)
Date:   Wed, 20 Mar 2019 15:16:30 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>, chrubis@suse.cz,
        Vlastimil Babka <vbabka@suse.cz>, kirill@shutemov.name,
        osalvador@suse.de, stable@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: mempolicy: make mbind() return -EIO when
 MPOL_MF_STRICT is specified
Message-Id: <20190320151630.9c7c604a96f0a892c29befdc@linux-foundation.org>
In-Reply-To: <CAFqt6zbqYyzVB3HbYXv19jo8=3hGC=XZAkwvE8PCVdLOKTeG1g@mail.gmail.com>
References: <1553020556-38583-1-git-send-email-yang.shi@linux.alibaba.com>
        <CAFqt6zbqYyzVB3HbYXv19jo8=3hGC=XZAkwvE8PCVdLOKTeG1g@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2019 11:23:03 +0530 Souptick Joarder <jrdr.linux@gmail.com> wrote:

> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -447,6 +447,13 @@ static inline bool queue_pages_required(struct page *page,
> >         return node_isset(nid, *qp->nmask) == !(flags & MPOL_MF_INVERT);
> >  }
> >
> > +/*
> > + * The queue_pages_pmd() may have three kind of return value.
> > + * 1 - pages are placed on he right node or queued successfully.
> 
> Minor typo -> s/he/the ?

Yes, that comment needs some help.  This?

--- a/mm/mempolicy.c~mm-mempolicy-make-mbind-return-eio-when-mpol_mf_strict-is-specified-fix
+++ a/mm/mempolicy.c
@@ -429,9 +429,9 @@ static inline bool queue_pages_required(
 }
 
 /*
- * The queue_pages_pmd() may have three kind of return value.
- * 1 - pages are placed on he right node or queued successfully.
- * 0 - THP get split.
+ * queue_pages_pmd() has three possible return values:
+ * 1 - pages are placed on the right node or queued successfully.
+ * 0 - THP was split.
  * -EIO - is migration entry or MPOL_MF_STRICT was specified and an existing
  *        page was already on a node that does not follow the policy.
  */
_

