Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE42C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C5520652
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="X8JPWrXu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388894AbfDRNip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 09:38:45 -0400
Received: from a9-46.smtp-out.amazonses.com ([54.240.9.46]:50444 "EHLO
        a9-46.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733205AbfDRNip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 09:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1555594724;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=Mn2jJaVyXnfxUugHqDabQsqBL//yamSkxsI3eXyDlrA=;
        b=X8JPWrXuwI/DmpMMQRAri2xJUwQ0i7jWaes61IDWWWuJLbXYDrbCni8Zo0sXjXuW
        yuEhkjEnFwk2btLft+ero1yzF/zwR+mKYyrtIAMwHcfTE867Fpu+T5ENro+L+x0VPM8
        HiGNCzzwCW0kHJo5F8RXhjgVSKoGCFVBJ3UtdK4A=
Date:   Thu, 18 Apr 2019 13:38:44 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Roman Gushchin <guroan@gmail.com>
cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>, david@fromorbit.com,
        Pekka Enberg <penberg@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH 4/5] mm: rework non-root kmem_cache lifecycle
 management
In-Reply-To: <20190417215434.25897-5-guro@fb.com>
Message-ID: <0100016a30abc330-011d895a-b4af-40a9-8937-990297ed4ffd-000000@email.amazonses.com>
References: <20190417215434.25897-1-guro@fb.com> <20190417215434.25897-5-guro@fb.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.04.18-54.240.9.46
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2019, Roman Gushchin wrote:

>  static __always_inline int memcg_charge_slab(struct page *page,
>  					     gfp_t gfp, int order,
>  					     struct kmem_cache *s)
>  {
> -	if (is_root_cache(s))
> +	int idx = (s->flags & SLAB_RECLAIM_ACCOUNT) ?
> +		NR_SLAB_RECLAIMABLE : NR_SLAB_UNRECLAIMABLE;
> +	struct mem_cgroup *memcg;
> +	struct lruvec *lruvec;
> +	int ret;
> +
> +	if (is_root_cache(s)) {
> +		mod_node_page_state(page_pgdat(page), idx, 1 << order);

Hmmm... This is functionality that is not memcg specific being moved into
a memcg function??? Maybe rename the function to indicate that it is not
memcg specific and add the proper #ifdefs?

>  static __always_inline void memcg_uncharge_slab(struct page *page, int order,
>  						struct kmem_cache *s)
>  {
> -	memcg_kmem_uncharge(page, order);
> +	int idx = (s->flags & SLAB_RECLAIM_ACCOUNT) ?
> +		NR_SLAB_RECLAIMABLE : NR_SLAB_UNRECLAIMABLE;
> +	struct mem_cgroup *memcg;
> +	struct lruvec *lruvec;
> +
> +	if (is_root_cache(s)) {
> +		mod_node_page_state(page_pgdat(page), idx, -(1 << order));
> +		return;
> +	}

And again.

