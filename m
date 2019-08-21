Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8E0C3A589
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 02:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D6E22D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 02:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfHUC0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 22:26:51 -0400
Received: from smtprelay0117.hostedemail.com ([216.40.44.117]:34080 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726372AbfHUC0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 22:26:51 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id C9874181D33FC;
        Wed, 21 Aug 2019 02:26:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: actor10_3b6f480e7015b
X-Filterd-Recvd-Size: 2398
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Wed, 21 Aug 2019 02:26:48 +0000 (UTC)
Message-ID: <7aaca457a3d3feb951082d0659eec568a908971f.camel@perches.com>
Subject: Re: [PATCH 2/2] staging/erofs: Balanced braces around a few
 conditional statements.
From:   Joe Perches <joe@perches.com>
To:     Caitlyn <caitlynannefinn@gmail.com>,
        Gao Xiang <gaoxiang25@huawei.com>,
        Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Tobin C . Harding" <me@tobin.cc>, linux-erofs@lists.ozlabs.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Tue, 20 Aug 2019 19:26:46 -0700
In-Reply-To: <1566346700-28536-3-git-send-email-caitlynannefinn@gmail.com>
References: <1566346700-28536-1-git-send-email-caitlynannefinn@gmail.com>
         <1566346700-28536-3-git-send-email-caitlynannefinn@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-08-20 at 20:18 -0400, Caitlyn wrote:
> Balanced braces to fix some checkpath warnings in inode.c and
> unzip_vle.c
[]
> diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
[]
> @@ -915,21 +915,21 @@ static int z_erofs_vle_unzip(struct super_block *sb,
>  	mutex_lock(&work->lock);
>  	nr_pages = work->nr_pages;
>  
> -	if (likely(nr_pages <= Z_EROFS_VLE_VMAP_ONSTACK_PAGES))
> +	if (likely(nr_pages <= Z_EROFS_VLE_VMAP_ONSTACK_PAGES)) {
>  		pages = pages_onstack;
> -	else if (nr_pages <= Z_EROFS_VLE_VMAP_GLOBAL_PAGES &&
> -		 mutex_trylock(&z_pagemap_global_lock))
> +	} else if (nr_pages <= Z_EROFS_VLE_VMAP_GLOBAL_PAGES &&
> +		 mutex_trylock(&z_pagemap_global_lock)) {

Extra space after tab

>  		pages = z_pagemap_global;
> -	else {
> +	} else {
>  repeat:
>  		pages = kvmalloc_array(nr_pages, sizeof(struct page *),
>  				       GFP_KERNEL);
>  
>  		/* fallback to global pagemap for the lowmem scenario */
>  		if (unlikely(!pages)) {
> -			if (nr_pages > Z_EROFS_VLE_VMAP_GLOBAL_PAGES)
> +			if (nr_pages > Z_EROFS_VLE_VMAP_GLOBAL_PAGES) {
>  				goto repeat;
> -			else {
> +			} else {

Unnecessary else

>  				mutex_lock(&z_pagemap_global_lock);
>  				pages = z_pagemap_global;
>  			}


