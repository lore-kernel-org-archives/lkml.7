Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD0CC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 14:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB95B2173C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 14:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FjbZggep";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="Xa5m7xy3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbfEVOS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 10:18:58 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63833 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728528AbfEVOS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 10:18:58 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4F31315D3EC;
        Wed, 22 May 2019 10:18:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=4nI4mWcGR82GTPyz6GNRLkoyBvU=; b=FjbZgg
        ep8Ao4H5xCLthcgEtauVqtFwALMSC4K0AmdXLjHqRtSpxcwLIUtkcW3XhnBayKPZ
        ef9zAHzb68yrQKpWuQ/e+wUpsOw2WPp67ezSaDzw1Frfc568VDzHFHuF4wR9j9v5
        ZlNrwxbY/84OPZPlNVpmUwoxedgEFGXW8bvV0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 478BB15D3EB;
        Wed, 22 May 2019 10:18:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=WFrM67U78+f3aOMO3UgklP9/4Y6FDeoJx5G6ciC3808=; b=Xa5m7xy3vopuVhmfMkEU2iICbr7ZTrr2wCKR7pMQfrGme/SH00RNKWP1jYZ7IHcgG47l0gNuDTuOUHV9bOKx8Ym3rw6/6zmTiwl9r4FDvQgiqG8M+5xEis5CGSGsE77RaYNQeN9hJEIqG42mAFitjMQnq5pwoEgC/fj6XD0qE6M=
Received: from yoda.home (unknown [70.82.130.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C674915D3EA;
        Wed, 22 May 2019 10:18:55 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id D96052DA01F4;
        Wed, 22 May 2019 10:18:54 -0400 (EDT)
Date:   Wed, 22 May 2019 10:18:54 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Gen Zhang <blackgod016574@gmail.com>
cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] vt: Fix a missing-check bug in drivers/tty/vt/vt.c
In-Reply-To: <20190522121908.GA6772@zhanggen-UX430UQ>
Message-ID: <nycvar.YSQ.7.76.1905221018170.1558@knanqh.ubzr>
References: <20190521022940.GA4858@zhanggen-UX430UQ> <nycvar.YSQ.7.76.1905202242410.1558@knanqh.ubzr> <20190521030905.GB5263@zhanggen-UX430UQ> <nycvar.YSQ.7.76.1905202323290.1558@knanqh.ubzr> <20190521040019.GD5263@zhanggen-UX430UQ>
 <nycvar.YSQ.7.76.1905210022050.1558@knanqh.ubzr> <20190521073901.GF5263@zhanggen-UX430UQ> <nycvar.YSQ.7.76.1905212218090.1558@knanqh.ubzr> <20190522121908.GA6772@zhanggen-UX430UQ>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 887EC8E0-7C9C-11E9-A701-E828E74BB12D-78420484!pb-smtp2.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 May 2019, Gen Zhang wrote:

> In function con_init(), the pointer variable vc_cons[currcons].d, vc and
> vc->vc_screenbuf is allocated a memory space via kzalloc(). And they are
> used in the following codes.
> However, when there is a memory allocation error, kzalloc() can fail.
> Thus null pointer (vc_cons[currcons].d, vc and vc->vc_screenbuf)
> dereference may happen. And it will cause the kernel to crash. Therefore,
> we should check return value and handle the error.
> Further, since the allcoation is in a loop, we should free all the 
> allocated memory in a loop.
> 
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>

Reviewed-by: Nicolas Pitre <nico@fluxnic.net>


> 
> ---
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index fdd12f8..d50f68f 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -3350,10 +3350,14 @@ static int __init con_init(void)
>  
>  	for (currcons = 0; currcons < MIN_NR_CONSOLES; currcons++) {
>  		vc_cons[currcons].d = vc = kzalloc(sizeof(struct vc_data), GFP_NOWAIT);
> +		if (!vc)
> +			goto fail1;
>  		INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
>  		tty_port_init(&vc->port);
>  		visual_init(vc, currcons, 1);
>  		vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_NOWAIT);
> +		if (!vc->vc_screenbuf)
> +			goto fail2;
>  		vc_init(vc, vc->vc_rows, vc->vc_cols,
>  			currcons || !vc->vc_sw->con_save_screen);
>  	}
> @@ -3375,6 +3379,16 @@ static int __init con_init(void)
>  	register_console(&vt_console_driver);
>  #endif
>  	return 0;
> +fail1:
> +	while (currcons > 0) {
> +		currcons--;
> +		kfree(vc_cons[currcons].d->vc_screenbuf);
> +fail2:
> +		kfree(vc_cons[currcons].d);
> +		vc_cons[currcons].d = NULL;
> +	}
> +	console_unlock();
> +	return -ENOMEM;
>  }
>  console_initcall(con_init);
>  
> ---
> 
