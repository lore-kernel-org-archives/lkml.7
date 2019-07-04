Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD5DC0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 05:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8AD0218A4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 05:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562218014;
	bh=I+0cH+uMT7VJ70KPqMIW9T45sVtfmgYmhLBmxgsq+no=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fTU3iNSZlVbGWSobg1EIIbAmf7814KLxI5QEex2Vzs9IbdJTKDvkp0t3ZdQRjeMvG
	 bUjU7Y0nj9apxHa0igcGyKGt+/7Gq17uGSIWtVOHa8WFN50vZwH08G2wqRacVWhq9J
	 oVTX2qxCFMA207cyIibVlXkkn3MJuqmFx8hvFrUk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfGDF0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 01:26:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:39568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfGDF0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 01:26:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7426218A3;
        Thu,  4 Jul 2019 05:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562218012;
        bh=I+0cH+uMT7VJ70KPqMIW9T45sVtfmgYmhLBmxgsq+no=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pLn7CV1p02AUDr60ZlfdxpQ5bkJ8gd6ERqKq4pMX+CjKvnIsgmHtPNGcgQlejITNx
         NYrdzjP+yqOoe/er9SU58/O+EPX1S24y3KThzgRsDyRl3FzS0RfRVPF4fe7AVvg1qd
         vD6iQ1lux/9E6IXGm/cgxz7eruZZHPTmQYa6snQE=
Date:   Thu, 4 Jul 2019 07:26:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     devel@driverdev.osuosl.org, yuchao0@huawei.com,
        linux-kernel@vger.kernel.org, huyue2@yulong.com,
        linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH RESEND v3] staging: erofs: remove unsupported ->datamode
 check in fill_inline_data()
Message-ID: <20190704052649.GA7454@kroah.com>
References: <20190702025601.7976-1-zbestahu@gmail.com>
 <20190703162038.GA31307@kroah.com>
 <20190704095903.0000565e.zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704095903.0000565e.zbestahu@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 09:59:03AM +0800, Yue Hu wrote:
> On Wed, 3 Jul 2019 18:20:38 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Tue, Jul 02, 2019 at 10:56:01AM +0800, Yue Hu wrote:
> > > From: Yue Hu <huyue2@yulong.com>
> > > 
> > > Already check if ->datamode is supported in read_inode(), no need to check
> > > again in the next fill_inline_data() only called by fill_inode().
> > > 
> > > Signed-off-by: Yue Hu <huyue2@yulong.com>
> > > Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>
> > > Reviewed-by: Chao Yu <yuchao0@huawei.com>
> > > ---
> > > no change
> > > 
> > >  drivers/staging/erofs/inode.c | 2 --
> > >  1 file changed, 2 deletions(-)  
> > 
> > This is already in my tree, right?
> 
> Seems not, i have received notes about other 2 patches below mergerd:
> 
> ```note1
> This is a note to let you know that I've just added the patch titled
> 
>     staging: erofs: don't check special inode layout
> 
> to my staging git tree which can be found at
>     git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
> in the staging-next branch.
> ```
> 
> ```note2
> This is a note to let you know that I've just added the patch titled
> 
>     staging: erofs: return the error value if fill_inline_data() fails
> 
> to my staging git tree which can be found at
>     git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
> in the staging-next branch.
> ```
> 
> No this patch in below link checked:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/log/drivers/staging/erofs?h=staging-testing

Then if it is not present, it needs to be rebased as it does not apply.

Please do so and resend it.

thanks,

greg k-h
