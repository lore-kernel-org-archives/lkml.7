Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CAEC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51CAA20880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfDHKO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:14:57 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6708 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725857AbfDHKO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 06:14:56 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 81442EC6E8B648324B64;
        Mon,  8 Apr 2019 18:14:54 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Mon, 8 Apr 2019
 18:14:48 +0800
Date:   Mon, 8 Apr 2019 11:14:39 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>, Greg KH <greg@kroah.com>,
        "Linux Next Mailing List" <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>
Subject: Re: linux-next: manual merge of the staging tree with the
 staging.current tree
Message-ID: <20190408111439.000049bc@huawei.com>
In-Reply-To: <20190408100121.GH9224@smile.fi.intel.com>
References: <20190408130212.0a41f2a8@canb.auug.org.au>
        <20190408091458.00004e48@huawei.com>
        <20190408100121.GH9224@smile.fi.intel.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Apr 2019 13:01:21 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Apr 08, 2019 at 09:14:58AM +0100, Jonathan Cameron wrote:
> > On Mon, 8 Apr 2019 13:02:12 +1000
> > Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >   
> > > Hi all,
> > > 
> > > Today's linux-next merge of the staging tree got a conflict in:
> > > 
> > >   drivers/iio/industrialio-buffer.c
> > > 
> > > between commit:
> > > 
> > >   20ea39ef9f2f ("iio: Fix scan mask selection")
> > > 
> > > from the staging.current tree and commit:
> > > 
> > >   3862828a903d ("iio: buffer: Switch to bitmap_zalloc()")
> > > 
> > > from the staging tree.
> > > 
> > > I fixed it up (I just used the staging tree version) and can carry the
> > > fix as necessary. This is now fixed as far as linux-next is concerned,
> > > but any non trivial conflicts should be mentioned to your upstream
> > > maintainer when your tree is submitted for merging.  You may also want
> > > to consider cooperating with the maintainer of the conflicting tree to
> > > minimise any particularly complex conflicts.
> > >   
> > Thanks Stephen,
> > 
> > That is the correct resolution.  
> 
> I think it still misses the following fix:
> 
Hi Andy,

Is that actually a problem given it's copied over from buffer->scan_mask just after allocation?
The two masks are the same length so I don't think we have a problem with this one.
Am I missing something?

Jonathan


> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 3c7e7380d1c3..9c2d0c97ed24 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -320,7 +320,7 @@ static int iio_scan_mask_set(struct iio_dev *indio_dev,
>  	const unsigned long *mask;
>  	unsigned long *trialmask;
>  
> -	trialmask = bitmap_alloc(indio_dev->masklength, GFP_KERNEL);
> +	trialmask = bitmap_zalloc(indio_dev->masklength, GFP_KERNEL);
>  	if (trialmask == NULL)
>  		return -ENOMEM;
>  	if (!indio_dev->masklength) {
> 
> 


