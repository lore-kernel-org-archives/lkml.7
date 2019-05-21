Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D160DC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 04:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D72D21743
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 04:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fwSjWzWQ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="sCTvjVqC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfEUEat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 00:30:49 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55368 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfEUEat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 00:30:49 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F271D73D94;
        Tue, 21 May 2019 00:30:43 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=yqe15pYqMrJHBvSX/s3j44LVOkQ=; b=fwSjWz
        WQpmiYrLk36MxEzxqXEQVDiuPhga1SeKlaEhWarV4ZzURcGHL+jnhtgYeNWItTws
        kcna0FFQ3+zW+yWUTsPYW/wm/fYUmIevRhZ/1PSjaFLwZYGTX89VUql3e/i01BIc
        OUPS8+PA+seOPnZjkXzTHs3Cxq6xC5T1sWE6g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E0C5373D93;
        Tue, 21 May 2019 00:30:43 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=Fnj6Iyu+QqlQ5VqudM+YbKXA9WmWzolnl8KrXhNrnoE=; b=sCTvjVqC3q8hzkI6/f3jbuF8DaN3V6uWQ8Vyv1xHFX5bb+IwR6dsSFN6gbDjkF2An4KxEmsMFdLrSPv57xwSaxU5XhAuGXTiLOG+J9yBQtWGYtKwSCmkSHBchzP6CerkBQnepEkIrviivzGsemu8DxOk5QGoIRYy9LfAC92IXgo=
Received: from yoda.home (unknown [70.82.130.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9F45973D92;
        Tue, 21 May 2019 00:30:40 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 18BD02DA01F4;
        Tue, 21 May 2019 00:30:38 -0400 (EDT)
Date:   Tue, 21 May 2019 00:30:38 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Gen Zhang <blackgod016574@gmail.com>
cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vt: Fix a missing-check bug in drivers/tty/vt/vt.c
In-Reply-To: <20190521040019.GD5263@zhanggen-UX430UQ>
Message-ID: <nycvar.YSQ.7.76.1905210022050.1558@knanqh.ubzr>
References: <20190521022940.GA4858@zhanggen-UX430UQ> <nycvar.YSQ.7.76.1905202242410.1558@knanqh.ubzr> <20190521030905.GB5263@zhanggen-UX430UQ> <nycvar.YSQ.7.76.1905202323290.1558@knanqh.ubzr> <20190521040019.GD5263@zhanggen-UX430UQ>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 3086D0A4-7B81-11E9-8580-8D86F504CC47-78420484!pb-smtp21.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2019, Gen Zhang wrote:

> On Mon, May 20, 2019 at 11:26:20PM -0400, Nicolas Pitre wrote:
> > On Tue, 21 May 2019, Gen Zhang wrote:
> > 
> > > On Mon, May 20, 2019 at 10:55:40PM -0400, Nicolas Pitre wrote:
> > > > On Tue, 21 May 2019, Gen Zhang wrote:
> > > > 
> > > > > In function con_init(), the pointer variable vc_cons[currcons].d, vc and
> > > > > vc->vc_screenbuf is allocated a memory space via kzalloc(). And they are
> > > > > used in the following codes.
> > > > > However, when there is a memory allocation error, kzalloc() can fail.
> > > > > Thus null pointer (vc_cons[currcons].d, vc and vc->vc_screenbuf)
> > > > > dereference may happen. And it will cause the kernel to crash. Therefore,
> > > > > we should check return value and handle the error.
> > > > > Further,the loop condition MIN_NR_CONSOLES is defined as 1 in
> > > > > include/uapi/linux/vt.h. So there is no need to unwind the loop.
> > > > 
> > > > But what if someone changes that define? It won't be obvious that some 
> > > > code did rely on it to be defined to 1.
> > > I re-examine the source code. MIN_NR_CONSOLES is only defined once and
> > > no other changes to it.
> > 
> > Yes, that is true today.  But if someone changes that in the future, how 
> > will that person know that you relied on it to be 1 for not needing to 
> > unwind the loop?
> > 
> > 
> > Nicolas
> Hi Nicolas,
> Thanks for your explaination! And I got your point. And is this way 
> proper?

Not quite.

> err_vc_screenbuf:
>         kfree(vc);
> 	for (currcons = 0; currcons < MIN_NR_CONSOLES; currcons++)
> 		vc_cons[currcons].d = NULL;
> 	return -ENOMEM;
> err_vc:
> 	console_unlock();
> 	return -ENOMEM;

Now imagine that MIN_NR_CONSOLES is defined to 10 instead of 1.

What happens with allocated memory if the err_vc condition is met on the 
5th loop?

If err_vc_screenbuf condition is encountered on the 5th loop (curcons = 
4), what is the value of vc_cons[4].d? Isn't it the same as vc that you 
just freed?


Nicolas
