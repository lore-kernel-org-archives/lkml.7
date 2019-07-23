Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E57CC76194
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 17:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02596227B7
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 17:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563904361;
	bh=nmc8uaRDy6gzgZmALXLogPzoQsDDnnuylDBBg1jtn1c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=yaBHlpZkiKqzcukkwEl7rlZfnb+v6NWHx9eXvjUeaobvc3/J4lcakWzglRQm++Ike
	 PC0Tkr35P5LA+wa9wCr52qLEpaaWm8Gi/+Q1daZMWJowYLihK0504cwD4Cuvqkyx6c
	 EzXKlMK8I+N0is2ESW1M3aoaO0Sj2hX0F/Gd1oLk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391216AbfGWRwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 13:52:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:35368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391206AbfGWRwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 13:52:39 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74E752229A;
        Tue, 23 Jul 2019 17:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563904358;
        bh=nmc8uaRDy6gzgZmALXLogPzoQsDDnnuylDBBg1jtn1c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=rduY142VQa1IsnoNlMdQo6TGmPN6qSG3GZUkSwSTd6A59arYA0evBnpSt3fmDAemz
         CkugF3lhK7nLyByuBN8u6yAmLgwlLNa501KqRSNFgeI5W55M+Tw7sOQqUQ4mptCv23
         hbqbBoA5xQYu9iVktqkbMIy0z5Q0SabAWFEhYJvw=
Message-ID: <3622a5fe9f13ddfd15b262dbeda700a26c395c2a.camel@kernel.org>
Subject: Re: [PATCH] mm: check for sleepable context in kvfree
From:   Jeff Layton <jlayton@kernel.org>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, lhenriques@suse.com, cmaiolino@redhat.com,
        Christoph Hellwig <hch@lst.de>
Date:   Tue, 23 Jul 2019 13:52:36 -0400
In-Reply-To: <20190723131212.445-1-jlayton@kernel.org>
References: <20190723131212.445-1-jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-23 at 09:12 -0400, Jeff Layton wrote:
> A lot of callers of kvfree only go down the vfree path under very rare
> circumstances, and so may never end up hitting the might_sleep_if in it.
> Ensure that when kvfree is called, that it is operating in a context
> where it is allowed to sleep.
> 
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Luis Henriques <lhenriques@suse.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  mm/util.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

FWIW, I started looking at this after Luis sent me some ceph patches
that fixed a few of these problems. I have not done extensive testing
with this patch, so maybe consider this an RFC for now.

HCH points out that xfs uses kvfree as a generic "free this no matter
what it is" sort of wrapper and expects the callers to work out whether
they might be freeing a vmalloc'ed address. If that sort of usage turns
out to be prevalent, then we may need another approach to clean this up.

> diff --git a/mm/util.c b/mm/util.c
> index e6351a80f248..81ec2a003c86 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -482,6 +482,8 @@ EXPORT_SYMBOL(kvmalloc_node);
>   */
>  void kvfree(const void *addr)
>  {
> +	might_sleep_if(!in_interrupt());
> +
>  	if (is_vmalloc_addr(addr))
>  		vfree(addr);
>  	else

-- 
Jeff Layton <jlayton@kernel.org>

