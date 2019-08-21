Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B55C3A589
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 02:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C92CB22DD6
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 02:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfHUCcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 22:32:08 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3098 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726512AbfHUCcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 22:32:08 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id AAA6243E135E022D3262;
        Wed, 21 Aug 2019 10:32:03 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 21 Aug 2019 10:32:03 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 21 Aug 2019 10:32:02 +0800
Date:   Wed, 21 Aug 2019 10:31:22 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Joe Perches <joe@perches.com>
CC:     Caitlyn <caitlynannefinn@gmail.com>, Chao Yu <yuchao0@huawei.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Tobin C . Harding" <me@tobin.cc>, <linux-erofs@lists.ozlabs.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] staging/erofs: Balanced braces around a few
 conditional statements.
Message-ID: <20190821023122.GA159802@architecture4>
References: <1566346700-28536-1-git-send-email-caitlynannefinn@gmail.com>
 <1566346700-28536-3-git-send-email-caitlynannefinn@gmail.com>
 <7aaca457a3d3feb951082d0659eec568a908971f.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7aaca457a3d3feb951082d0659eec568a908971f.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme713-chm.china.huawei.com (10.1.199.109) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 07:26:46PM -0700, Joe Perches wrote:
> On Tue, 2019-08-20 at 20:18 -0400, Caitlyn wrote:
> > Balanced braces to fix some checkpath warnings in inode.c and
> > unzip_vle.c
> []
> > diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
> []
> > @@ -915,21 +915,21 @@ static int z_erofs_vle_unzip(struct super_block *sb,
> >  	mutex_lock(&work->lock);
> >  	nr_pages = work->nr_pages;
> >  
> > -	if (likely(nr_pages <= Z_EROFS_VLE_VMAP_ONSTACK_PAGES))
> > +	if (likely(nr_pages <= Z_EROFS_VLE_VMAP_ONSTACK_PAGES)) {
> >  		pages = pages_onstack;
> > -	else if (nr_pages <= Z_EROFS_VLE_VMAP_GLOBAL_PAGES &&
> > -		 mutex_trylock(&z_pagemap_global_lock))
> > +	} else if (nr_pages <= Z_EROFS_VLE_VMAP_GLOBAL_PAGES &&
> > +		 mutex_trylock(&z_pagemap_global_lock)) {
> 
> Extra space after tab

There is actually balanced braces in linux-next.
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/staging/erofs/zdata.c#n762

> 
> >  		pages = z_pagemap_global;
> > -	else {
> > +	} else {
> >  repeat:
> >  		pages = kvmalloc_array(nr_pages, sizeof(struct page *),
> >  				       GFP_KERNEL);
> >  
> >  		/* fallback to global pagemap for the lowmem scenario */
> >  		if (unlikely(!pages)) {
> > -			if (nr_pages > Z_EROFS_VLE_VMAP_GLOBAL_PAGES)
> > +			if (nr_pages > Z_EROFS_VLE_VMAP_GLOBAL_PAGES) {
> >  				goto repeat;
> > -			else {
> > +			} else {
> 
> Unnecessary else

There is not the "goto repeat" in linux-next anymore.
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/staging/erofs/zdata.c#n765

Thanks,
Gao Xiang

> 
> >  				mutex_lock(&z_pagemap_global_lock);
> >  				pages = z_pagemap_global;
> >  			}
> 
> 
