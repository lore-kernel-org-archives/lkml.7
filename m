Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6CACA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ACE621852
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393886AbfJRPjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:39:22 -0400
Received: from ms.lwn.net ([45.79.88.28]:36676 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728464AbfJRPjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:39:21 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 35AC9378;
        Fri, 18 Oct 2019 15:39:21 +0000 (UTC)
Date:   Fri, 18 Oct 2019 09:39:20 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] docs: block: Remove blk_init_queue related description
Message-ID: <20191018093920.6fbc8141@lwn.net>
In-Reply-To: <1571061002-25998-1-git-send-email-zhangshaokun@hisilicon.com>
References: <1571061002-25998-1-git-send-email-zhangshaokun@hisilicon.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Oct 2019 21:50:02 +0800
Shaokun Zhang <zhangshaokun@hisilicon.com> wrote:

> blk_init_queue has been removed since commit <a1ce35fa4985>
> ("block: remove dead elevator code"), Let's cleanup the description
> in the biodoc.rst document.
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>

So I applied this, then changed my mind and unapplied it; I think it's the
wrong fix.

>  Documentation/block/biodoc.rst | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/Documentation/block/biodoc.rst b/Documentation/block/biodoc.rst
> index b964796ec9c7..a19081d88349 100644
> --- a/Documentation/block/biodoc.rst
> +++ b/Documentation/block/biodoc.rst
> @@ -1013,11 +1013,6 @@ request_fn execution which it means that lots of older drivers
>  should still be SMP safe. Drivers are free to drop the queue
>  lock themselves, if required. Drivers that explicitly used the
>  io_request_lock for serialization need to be modified accordingly.
> -Usually it's as easy as adding a global lock::
> -
> -	static DEFINE_SPINLOCK(my_driver_lock);
> -
> -and passing the address to that lock to blk_init_queue().

This is a section about coping with the removal of the io_request_lock,
which happened in 2.5, prior to the git era.  I think it is probably safe
to say that there are no relevant drivers that still need to be updated
for this particular change.

>  5.2 64 bit sector numbers (sector_t prepares for 64 bit support)
>  ----------------------------------------------------------------
> @@ -1071,11 +1066,6 @@ right thing to use is bio_endio(bio) instead.
>  If the driver is dropping the io_request_lock from its request_fn strategy,
>  then it just needs to replace that with q->queue_lock instead.
>  
> -As described in Sec 1.1, drivers can set max sector size, max segment size
> -etc per queue now. Drivers that used to define their own merge functions i
> -to handle things like this can now just use the blk_queue_* functions at
> -blk_init_queue time.
> -
>  Drivers no longer have to map a {partition, sector offset} into the
>  correct absolute location anymore, this is done by the block layer, so
>  where a driver received a request ala this before::

Here, too.  We're talking about teaching drivers how to use bios.

My suggested fix is to just remove both sections from the document
entirely; neither is relevant in 2019.

Even better, of course, would be to pass through this document and bring
it up to current practice in general; there is certain to be a lot more in
need of fixing here.

Thanks,

jon
