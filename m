Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175AFC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EACA8206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="bVfgVT+9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfDYONx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 10:13:53 -0400
Received: from smtp89.iad3b.emailsrvr.com ([146.20.161.89]:44808 "EHLO
        smtp89.iad3b.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726120AbfDYONx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 10:13:53 -0400
Received: from smtp12.relay.iad3b.emailsrvr.com (localhost [127.0.0.1])
        by smtp12.relay.iad3b.emailsrvr.com (SMTP Server) with ESMTP id C1161C0174;
        Thu, 25 Apr 2019 10:13:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1556201631;
        bh=ZTDJFDMurbCxWd1zNz+FBNlikriqJ0a3UjAP/wPvR0g=;
        h=Subject:To:From:Date:From;
        b=bVfgVT+9y0FnsEUTZxEzhXHPuCaVyTQId6KBhMs1lvXffrUl9r9vVYahO6Xh/S4fR
         9jlTj4OYQMRqBbPZQiNidD4yhdvxxlTneLs8q4ZNy/2BHkq7nzcKLecljbRC14LKgi
         jpEZSUsnoSIw/cq2j9NLk75rWQ2p3iJJ0iVC3/u0=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp12.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id AFE1AC01FB;
        Thu, 25 Apr 2019 10:13:50 -0400 (EDT)
X-Sender-Id: abbotti@mev.co.uk
Received: from [10.0.0.62] (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Thu, 25 Apr 2019 10:13:51 -0400
Subject: Re: [PATCH] dma-mapping: remove an unnecessary NULL check
To:     Christoph Hellwig <hch@lst.de>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org,
        "kernel-janitors@vger.kernel.org H Hartley Sweeten" 
        <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20190424142437.GA29490@mwanda> <20190424142743.GC20974@lst.de>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <3142dc82-1d4c-5f01-678e-628038d86bd6@mev.co.uk>
Date:   Thu, 25 Apr 2019 15:13:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424142743.GC20974@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/2019 15:27, Christoph Hellwig wrote:
> On Wed, Apr 24, 2019 at 05:24:37PM +0300, Dan Carpenter wrote:
>> We already dereferenced "dev" when we called get_dma_ops() so this NULL
>> check is too late.  We're not supposed to pass NULL "dev" pointers to
>> dma_alloc_attrs().
> 
> Thanks, applied to the dma-mapping for-next tree.
> 
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>> ---
>> There are still at least two drivers which do pass a NULL unfortunately.
>>
>> drivers/staging/comedi/drivers/comedi_isadma.c:195 comedi_isadma_alloc() error: NULL dereference inside function 'dma_alloc_coherent()'
>> drivers/staging/comedi/drivers/comedi_isadma.c:227 comedi_isadma_free() error: NULL dereference inside function 'dma_free_coherent()'
> 
> This is staging code.  Per official decree from Linus we can just
> ignore it, and I tend to do so to keep my sanity.

So for comedi_isadma, we can just replace the NULL with a pointer to a 
static dummy device with a 24-bit coherent mask?

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
