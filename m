Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E062C2D0C8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 07:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 598F721739
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 07:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576568948;
	bh=sleOrKFR1H69De5Lbkme6pNJjLF6gLGBcGU6ilgUMmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yzhzSkU75gfEuYSXIxIeFhJalBFjdT4jiQYxKfSHLODe8ydqSurYukCLYdMaV6UVe
	 yGjUNTFfarKV8fBX/l4/IdBkdN5XEip2WteSrzuzF4dNXNrCUWRaHJ9PaF1W4R+bQt
	 jTlHDdk3HovNNcNMzHAbBZxXGnVmNjHi13/H9mss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfLQHtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 02:49:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:49726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbfLQHtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 02:49:07 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23439206D3;
        Tue, 17 Dec 2019 07:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576568946;
        bh=sleOrKFR1H69De5Lbkme6pNJjLF6gLGBcGU6ilgUMmE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R31lleWR9r4K/yleGes5xxV5bWkzojpm1Qb3ehHV1lQJGA5t0JPXIhmXBrarIKwmY
         s3fw491fjyQ7qfRALOVFzd5ATWaVdC9CCfOjuITPxWH32/yO2Mn76z1UZxI7PWdEqi
         mzxlgQgRz0ZziUnKjVBoFEsYw6KeXhCtcdSmz9Pc=
Date:   Tue, 17 Dec 2019 08:49:04 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 4.14 204/267] blk-mq: avoid sysfs buffer overflow with
 too many CPU cores
Message-ID: <20191217074904.GA2474507@kroah.com>
References: <20191216174848.701533383@linuxfoundation.org>
 <20191216174913.713799376@linuxfoundation.org>
 <20191217042829.x3n4h4yiuogklmym@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217042829.x3n4h4yiuogklmym@toshiba.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 01:28:29PM +0900, Nobuhiro Iwamatsu wrote:
> On Mon, Dec 16, 2019 at 06:48:50PM +0100, Greg Kroah-Hartman wrote:
> > From: Ming Lei <ming.lei@redhat.com>
> > 
> > commit 8962842ca5abdcf98e22ab3b2b45a103f0408b95 upstream.
> > 
> > It is reported that sysfs buffer overflow can be triggered if the system
> > has too many CPU cores(>841 on 4K PAGE_SIZE) when showing CPUs of
> > hctx via /sys/block/$DEV/mq/$N/cpu_list.
> > 
> > Use snprintf to avoid the potential buffer overflow.
> > 
> > This version doesn't change the attribute format, and simply stops
> > showing CPU numbers if the buffer is going to overflow.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 676141e48af7("blk-mq: don't dump CPU -> hw queue map on driver load")
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > Signed-off-by: Jens Axboe <axboe@kernel.dk>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> 
> This commit also required following commit:
> 
> commit d2c9be89f8ebe7ebcc97676ac40f8dec1cf9b43a
> Author: Ming Lei <ming.lei@redhat.com>
> Date:   Mon Nov 4 16:26:53 2019 +0800
> 
>     blk-mq: make sure that line break can be printed
> 
>     8962842ca5ab ("blk-mq: avoid sysfs buffer overflow with too many CPU cores")
>     avoids sysfs buffer overflow, and reserves one character for line break.
>     However, the last snprintf() doesn't get correct 'size' parameter passed
>     in, so fixed it.
> 
>     Fixes: 8962842ca5ab ("blk-mq: avoid sysfs buffer overflow with too many CPU cores")
>     Signed-off-by: Ming Lei <ming.lei@redhat.com>
>     Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> 
> And this is also required for 4.4, 4.9 and 4.19.
> Please apply.

Thank you for catching this, now queued up.

greg k-h
