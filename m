Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80384C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 09:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B6B20693
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 09:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564392513;
	bh=0HkGfziootZ3E2g6wpYbJOlicYBovIjn7G5ofoXR/a4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LtnVl1gusQ79J7NdPsoA9R2+bdZfxHce1OULbOQPATrtVuyKh8FpBBlFfF32YvUQU
	 YjYEKF7BcYLnqZvCOnGwVBW+twnJ/4/QUSHlbIlbnqiviznuh6BxYIAJyvigpZfy7g
	 cYPSFcbQvYfFxb2S7Pa94Sg/1Nf/+bDjwKZTeKVY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbfG2J2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 05:28:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:37594 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726496AbfG2J2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 05:28:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A3037AF21;
        Mon, 29 Jul 2019 09:28:30 +0000 (UTC)
Date:   Mon, 29 Jul 2019 11:28:30 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Henriques <lhenriques@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: [PATCH] mm: Make kvfree safe to call
Message-ID: <20190729092830.GB10926@dhcp22.suse.cz>
References: <20190726210137.23395-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726210137.23395-1-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 26-07-19 14:01:37, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Since vfree() can sleep, calling kvfree() from contexts where sleeping
> is not permitted (eg holding a spinlock) is a bit of a lottery whether
> it'll work.  Introduce kvfree_safe() for situations where we know we can
> sleep, but make kvfree() safe by default.

So now you have converted all kvfree callers to an atomic version. Is
that really desirable? Aren't we adding way too much work to be done in
a deferred context? If not then why a regular vfree cannot do this
already and then we do not need vfree_atomic and kvfree_safe.

In other words, why do we want to complicate the API further?

> Reported-by: Jeff Layton <jlayton@kernel.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Luis Henriques <lhenriques@suse.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Carlos Maiolino <cmaiolino@redhat.com>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/util.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/util.c b/mm/util.c
> index bab284d69c8c..992f0332dced 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -470,6 +470,28 @@ void *kvmalloc_node(size_t size, gfp_t flags, int node)
>  }
>  EXPORT_SYMBOL(kvmalloc_node);
>  
> +/**
> + * kvfree_fast() - Free memory.
> + * @addr: Pointer to allocated memory.
> + *
> + * kvfree_fast frees memory allocated by any of vmalloc(), kmalloc() or
> + * kvmalloc().  It is slightly more efficient to use kfree() or vfree() if
> + * you are certain that you know which one to use.
> + *
> + * Context: Either preemptible task context or not-NMI interrupt.  Must not
> + * hold a spinlock as it can sleep.
> + */
> +void kvfree_fast(const void *addr)
> +{
> +	might_sleep();
> +
> +	if (is_vmalloc_addr(addr))
> +		vfree(addr);
> +	else
> +		kfree(addr);
> +}
> +EXPORT_SYMBOL(kvfree_fast);
> +
>  /**
>   * kvfree() - Free memory.
>   * @addr: Pointer to allocated memory.
> @@ -478,12 +500,12 @@ EXPORT_SYMBOL(kvmalloc_node);
>   * It is slightly more efficient to use kfree() or vfree() if you are certain
>   * that you know which one to use.
>   *
> - * Context: Either preemptible task context or not-NMI interrupt.
> + * Context: Any context except NMI.
>   */
>  void kvfree(const void *addr)
>  {
>  	if (is_vmalloc_addr(addr))
> -		vfree(addr);
> +		vfree_atomic(addr);
>  	else
>  		kfree(addr);
>  }
> -- 
> 2.20.1

-- 
Michal Hocko
SUSE Labs
