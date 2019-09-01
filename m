Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37987C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 07:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0654D23429
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 07:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567322280;
	bh=csVVin+Olpb/qDxAyD+cBrDfz5AYW4dnPEW/8nHkCXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fV/W2QTbHqBoqJR2ypvzgOmZwv9cHzGoMYbwWboDm0or6mzxmA1yI6Wyxcxb5vH0X
	 FyPfAbL2GKsbRnb/XYUpZbpm5uZN2FhumKAtnRHXb7rZIHMrDTPYoxYjOw44UBVQUJ
	 yui8lZqzJThkrL4MR/uubRdgWgVJMkHEK03nARKw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbfIAHR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 03:17:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:37448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbfIAHR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 03:17:58 -0400
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE4CE22CF7;
        Sun,  1 Sep 2019 07:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567322278;
        bh=csVVin+Olpb/qDxAyD+cBrDfz5AYW4dnPEW/8nHkCXU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T27OuVHr9dwrxAnstXVsyaik9OZpoR4Vpdc8V26AcSOcVEDLxYXSQRUKEPVF9Efr7
         2gsuumL5aEwqeupMejKbNDz7AEBBhcj2ObGMBGxIkvfPKa0jNR6MkcyhZhW89QLl2E
         pIw0wT+ll3v0yX3/Ff2kspPG431Kosc9m6EveRKY=
Date:   Sun, 1 Sep 2019 00:17:57 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH v4] f2fs: add bio cache for IPU
Message-ID: <20190901071757.GA49907@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190219081529.5106-1-yuchao0@huawei.com>
 <d2b3c101-0399-4e85-5765-7b6504aaca74@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2b3c101-0399-4e85-5765-7b6504aaca74@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/31, Chao Yu wrote:
> On 2019/2/19 16:15, Chao Yu wrote:
> > @@ -1976,10 +2035,13 @@ static int __write_data_page(struct page *page, bool *submitted,
> >  	}
> >  
> >  	unlock_page(page);
> > -	if (!S_ISDIR(inode->i_mode) && !IS_NOQUOTA(inode))
> > +	if (!S_ISDIR(inode->i_mode) && !IS_NOQUOTA(inode)) {
> > +		f2fs_submit_ipu_bio(sbi, bio, page);
> >  		f2fs_balance_fs(sbi, need_balance_fs);
> > +	}
> 
> Above bio submission was added to avoid below deadlock:
> 
> - __write_data_page
>  - f2fs_do_write_data_page
>   - set_page_writeback        ---- set writeback flag
>   - f2fs_inplace_write_data
>  - f2fs_balance_fs
>   - f2fs_gc
>    - do_garbage_collect
>     - gc_data_segment
>      - move_data_page
>       - f2fs_wait_on_page_writeback
>        - wait_on_page_writeback  --- wait writeback
> 
> However, it breaks the merge of IPU IOs, to solve this issue, it looks we need
> to add global bio cache for such IPU merge case, then later
> f2fs_wait_on_page_writeback can check whether writebacked page is cached or not,
> and do the submission if necessary.
> 
> Jaegeuk, any thoughts?

How about calling f2fs_submit_ipu_bio() when we need to do GC in the same
context?

> 
> Thanks,
