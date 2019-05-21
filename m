Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE581C04AAC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 03:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB2521773
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 03:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BN09u28F";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="e8JKVkqK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfEUDFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 23:05:30 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58692 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbfEUDFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 23:05:30 -0400
X-Greylist: delayed 582 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 May 2019 23:05:27 EDT
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 395A973621;
        Mon, 20 May 2019 22:55:45 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=5IkeaPHh8sPETFmUsbaciy9gu1U=; b=BN09u2
        8FXJ0eYwUSeuRd8WTABQyJAkn6bPn+2kHZ48zhnfwPne5GrP+VEI9CTQIeQYj4a2
        cZzSQwGjCCW4Nw/ufU1zQ3R/yxpJRCvwc4QfK1OIcTdgsTj7gYXb7tveeFVcaysi
        vmxY6v9tFb6G7gEtPVlEj5z81RJNm2V9KSRT0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 31A9A73620;
        Mon, 20 May 2019 22:55:45 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=wjDQmrdsvtMdPiENTi3BGsvVWTilWEcuxFbWktouuw4=; b=e8JKVkqKVSJ86IfuEs+AeAwavRXtDCtN4ud4wr6uVByl6DbLKaILR9M7lskU2A+iDwMylVUp/q+VoOGr1LEA/qMJS2kMV7YL22nk5HcOXA/eA3U7RLA/EoTrOh5T8+QeYRzkviCYXlpMfcbZwISwMMgub4i3H9WdvC2Pw5gWJ0A=
Received: from yoda.home (unknown [70.82.130.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 27FBB7361F;
        Mon, 20 May 2019 22:55:42 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 38EE62DA01F4;
        Mon, 20 May 2019 22:55:40 -0400 (EDT)
Date:   Mon, 20 May 2019 22:55:40 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Gen Zhang <blackgod016574@gmail.com>
cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vt: Fix a missing-check bug in drivers/tty/vt/vt.c
In-Reply-To: <20190521022940.GA4858@zhanggen-UX430UQ>
Message-ID: <nycvar.YSQ.7.76.1905202242410.1558@knanqh.ubzr>
References: <20190521022940.GA4858@zhanggen-UX430UQ>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: EBF69648-7B73-11E9-933C-8D86F504CC47-78420484!pb-smtp21.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2019, Gen Zhang wrote:

> In function con_init(), the pointer variable vc_cons[currcons].d, vc and
> vc->vc_screenbuf is allocated a memory space via kzalloc(). And they are
> used in the following codes.
> However, when there is a memory allocation error, kzalloc() can fail.
> Thus null pointer (vc_cons[currcons].d, vc and vc->vc_screenbuf)
> dereference may happen. And it will cause the kernel to crash. Therefore,
> we should check return value and handle the error.
> Further,the loop condition MIN_NR_CONSOLES is defined as 1 in
> include/uapi/linux/vt.h. So there is no need to unwind the loop.

But what if someone changes that define? It won't be obvious that some 
code did rely on it to be defined to 1.

> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> 
> ---
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index fdd12f8..b756609 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -3350,10 +3350,14 @@ static int __init con_init(void)
>  
>  	for (currcons = 0; currcons < MIN_NR_CONSOLES; currcons++) {
>  		vc_cons[currcons].d = vc = kzalloc(sizeof(struct vc_data), GFP_NOWAIT);
> +		if (!vc_cons[currcons].d || !vc)

Both vc_cons[currcons].d and vc are assigned the same value on the 
previous line. You don't have to test them both.

> +			goto err_vc;
>  		INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
>  		tty_port_init(&vc->port);
>  		visual_init(vc, currcons, 1);
>  		vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_NOWAIT);
> +		if (!vc->vc_screenbuf)
> +			goto err_vc_screenbuf;
>  		vc_init(vc, vc->vc_rows, vc->vc_cols,
>  			currcons || !vc->vc_sw->con_save_screen);
>  	}
> @@ -3375,6 +3379,14 @@ static int __init con_init(void)
>  	register_console(&vt_console_driver);
>  #endif
>  	return 0;
> +err_vc:
> +	console_unlock();
> +	return -ENOMEM;
> +err_vc_screenbuf:
> +	console_unlock();
> +	kfree(vc);
> +	vc_cons[currcons].d = NULL;
> +	return -ENOMEM;

As soon as you release the lock, another thread could come along and 
start using the memory pointed by vc_cons[currcons].d you're about to 
free here. This is unlikely for an initcall, but still.

You should consider this ordering instead:

err_vc_screenbuf:
	kfree(vc);
	vc_cons[currcons].d = NULL;
err_vc:
	console_unlock();
	return -ENOMEM;


>  }
>  console_initcall(con_init);
>  
>  ---
> 
