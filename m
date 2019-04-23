Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4C9C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBCD7218D2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbfDWPon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 11:44:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57184 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728233AbfDWPog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 11:44:36 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3837C3B3C0;
        Tue, 23 Apr 2019 15:44:36 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2922E271A0;
        Tue, 23 Apr 2019 15:44:29 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id x3NFiSjO018213;
        Tue, 23 Apr 2019 11:44:28 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id x3NFiSUQ018209;
        Tue, 23 Apr 2019 11:44:28 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 23 Apr 2019 11:44:28 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Huaisheng Ye <yehs2007@zoho.com>
cc:     snitzer@redhat.com, agk@redhat.com, prarit@redhat.com,
        chengnt@lenovo.com, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, Huaisheng Ye <yehs1@lenovo.com>
Subject: Re: [PATCH] dm-writecache: avoid unnecessary lookups in
 writecache_find_entry
In-Reply-To: <20190420162102.6460-1-yehs2007@zoho.com>
Message-ID: <alpine.LRH.2.02.1904231140240.17390@file01.intranet.prod.int.rdu2.redhat.com>
References: <20190420162102.6460-1-yehs2007@zoho.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 23 Apr 2019 15:44:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 21 Apr 2019, Huaisheng Ye wrote:

> From: Huaisheng Ye <yehs1@lenovo.com>
> 
> Only when entry has been found, that would only be necessary to check the
> lowest or highest seq-count.
> 
> Add local variable "found" in writecache_find_entry, if no entry has been
> found, it is meaningless that having a useless rb_prev or rb_next.


Hi

I don't quite see what is this patch trying to fix.
Don't fix something that isn't broken.

Mikulas


> Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
> ---
>  drivers/md/dm-writecache.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
> index ddf1732..047ae09 100644
> --- a/drivers/md/dm-writecache.c
> +++ b/drivers/md/dm-writecache.c
> @@ -537,14 +537,18 @@ static struct wc_entry *writecache_find_entry(struct dm_writecache *wc,
>  {
>  	struct wc_entry *e;
>  	struct rb_node *node = wc->tree.rb_node;
> +	bool found = false;
>  
>  	if (unlikely(!node))
>  		return NULL;
>  
>  	while (1) {
>  		e = container_of(node, struct wc_entry, rb_node);
> -		if (read_original_sector(wc, e) == block)
> +		if (read_original_sector(wc, e) == block) {
> +			found = true;
>  			break;
> +		}
> +
>  		node = (read_original_sector(wc, e) >= block ?
>  			e->rb_node.rb_left : e->rb_node.rb_right);
>  		if (unlikely(!node)) {
> @@ -564,7 +568,8 @@ static struct wc_entry *writecache_find_entry(struct dm_writecache *wc,
>  		}
>  	}
>  
> -	while (1) {
> +	/* only need to check lowest or highest seq-count when entry has been found */
> +	while (found) {
>  		struct wc_entry *e2;
>  		if (flags & WFE_LOWEST_SEQ)
>  			node = rb_prev(&e->rb_node);
> @@ -577,6 +582,9 @@ static struct wc_entry *writecache_find_entry(struct dm_writecache *wc,
>  			return e;
>  		e = e2;
>  	}
> +
> +	/* no entry has been found, return the following entry */
> +	return e;
>  }
>  
>  static void writecache_insert_entry(struct dm_writecache *wc, struct wc_entry *ins)
> -- 
> 1.8.3.1
> 
> 
