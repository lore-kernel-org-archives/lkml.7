Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5DEC5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 14:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 695652089F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 14:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568211217;
	bh=q4Y7ST0eO607+g6D3aQth/Q9xrqwcsEEj2BO2x3fO1o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=a7cRLU7BawaRzaT5hMqXEB7byaLQK2UaPlLa1IoJe9cqV51l1g4WzGhFMJsqVjcUb
	 YXh3fpHNJatL5F4WwRbokTuynQkXlEZclpLyULWIFOTZEi7JAdcKzWgSFO5o0vYCd/
	 J9QYOBUASRC/oyedQIbeNPNd6nqvF2/JOB0PtKmo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbfIKONg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 10:13:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:52920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbfIKONg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 10:13:36 -0400
Received: from X1 (110.8.30.213.rev.vodafone.pt [213.30.8.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E09E120863;
        Wed, 11 Sep 2019 14:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568211215;
        bh=q4Y7ST0eO607+g6D3aQth/Q9xrqwcsEEj2BO2x3fO1o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SzjNBnUdKKtkJJFXvj8EgFhIuIo+x5nsHdoFPTeBunWHAFnn33rDFDfZa1ZCsgwVc
         VR+SWEBn5qcANGb827BXDvKsaC1mn6fPaAxkc8i7HgT+pevwoU8tfNEbEiooo12dYR
         KyS32lBQGy/SXcZwJmFG9lywOs+WxyJFq/65dM+E=
Date:   Wed, 11 Sep 2019 07:13:31 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: avoid slub allocation while holding list_lock
Message-Id: <20190911071331.770ecddff6a085330bf2b5f2@linux-foundation.org>
In-Reply-To: <20190909061016.173927-1-yuzhao@google.com>
References: <20190909061016.173927-1-yuzhao@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  9 Sep 2019 00:10:16 -0600 Yu Zhao <yuzhao@google.com> wrote:

> If we are already under list_lock, don't call kmalloc(). Otherwise we
> will run into deadlock because kmalloc() also tries to grab the same
> lock.
> 
> Instead, allocate pages directly. Given currently page->objects has
> 15 bits, we only need 1 page. We may waste some memory but we only do
> so when slub debug is on.
> 
>   WARNING: possible recursive locking detected
>   --------------------------------------------
>   mount-encrypted/4921 is trying to acquire lock:
>   (&(&n->list_lock)->rlock){-.-.}, at: ___slab_alloc+0x104/0x437
> 
>   but task is already holding lock:
>   (&(&n->list_lock)->rlock){-.-.}, at: __kmem_cache_shutdown+0x81/0x3cb
> 
>   other info that might help us debug this:
>    Possible unsafe locking scenario:
> 
>          CPU0
>          ----
>     lock(&(&n->list_lock)->rlock);
>     lock(&(&n->list_lock)->rlock);
> 
>    *** DEADLOCK ***
> 

It would be better if a silly low-level debug function like this
weren't to try to allocate memory at all.  Did you consider simply
using a statically allocated buffer?

{
	static char buffer[something large enough];
	static spinlock_t lock_to_protect_it;


Alternatively, do we need to call get_map() at all in there?  We could
simply open-code the get_map() functionality inside
list_slab_objects().  It would be slower, but printk is already slow. 
Potentially extremely slow.
