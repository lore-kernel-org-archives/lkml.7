Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE24C5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 23:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB4721721
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 23:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562023934;
	bh=dBXpbIE1R4CzpTJv8obwrKm6+ibARscFWpAQm9lSQZA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=MTB3K5emsn6l6XjTfy77SIAiiUqoKMmcrgcumvbubny8oB/hrurpj6/vEc5aDx+y9
	 nOz5/SfW+K7N2XONHd51RgrP0OIpSyEGIydNZKoSnVds5fbrksf8Lyd0REYL/UTICl
	 soqjbteEJbtOQtkUrvPX1aoEV3O3dqm5kl9+Dfcw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfGAXcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 19:32:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:55252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbfGAXcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 19:32:13 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E146821479;
        Mon,  1 Jul 2019 23:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562023932;
        bh=dBXpbIE1R4CzpTJv8obwrKm6+ibARscFWpAQm9lSQZA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yulAQMWrcw1P+CopEJYaogBfFneJfl2za6FZd5pFA6D5io9m+xQnEm+yQaDWjdT/Y
         9DFHXlk5mdBoyq4T6dTSKA58o6T74Hd/T8dTqYp/w0HOnpZqf6i5nqYGJuQ9bA1XgI
         Mo0ZF2H9lZFRsD+XZV8fRh2gemTtyGNq9stOi+ew=
Date:   Mon, 1 Jul 2019 16:32:11 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Henry Burns <henryburns@google.com>
Cc:     Vitaly Wool <vitalywool@gmail.com>,
        Vitaly Vul <vitaly.vul@sony.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Xidong Wang <wangxidong_97@163.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jonathan Adams <jwadams@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/z3fold.c: Lock z3fold page before 
 __SetPageMovable()
Message-Id: <20190701163211.e9e0f2cf5332c06640e3019d@linux-foundation.org>
In-Reply-To: <20190701212303.168581-1-henryburns@google.com>
References: <20190701212303.168581-1-henryburns@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  1 Jul 2019 14:23:03 -0700 Henry Burns <henryburns@google.com> wrote:

> __SetPageMovable() expects it's page to be locked, but z3fold.c doesn't
> lock the page.

So this triggers the VM_BUG_ON_PAGE(!PageLocked(page), page) in
__SetPageMovable(), yes?

> Following zsmalloc.c's example we call trylock_page() and
> unlock_page(). Also makes z3fold_page_migrate() assert that newpage is
> passed in locked, as documentation.
> 
> ...
>
> --- a/mm/z3fold.c
> +++ b/mm/z3fold.c
> @@ -918,7 +918,9 @@ static int z3fold_alloc(struct z3fold_pool *pool, size_t size, gfp_t gfp,
>  		set_bit(PAGE_HEADLESS, &page->private);
>  		goto headless;
>  	}
> +	WARN_ON(!trylock_page(page));

If this warn triggers then someone else has locked the page.

>	__SetPageMovable(page, pool->inode->i_mapping);
> + 	unlock_page(page);

and we proceed to undo their lock.  So that other code path will then
perform an unlock of an unlocked page.  Etcetera.

It would be much much better to do a plain old lock_page() here.  If
that results in a deadlock then let's find out why and fix it without
trylock hacks.


