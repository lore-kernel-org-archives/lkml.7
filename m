Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB11C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 05:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E49CA20726
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 05:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576473184;
	bh=u30hsvfmxLLRZKaKVXVEyyCEtFrlbAUIga1Wrb+EjNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MOCTX/Va86IVrw4Rok8CpVN9BDNM7xEOWIKdWMyhcrOIbgk5QlCxUhUpbPnbpYLso
	 EcKCUZNj/KVWVhdOwnnCTp3MO7rzIlMuCayXt+PjOEcTms2IQICNlcVbU/yrFIMAAX
	 xevbP2aS0vKIX9l1Wi0ANXdNl0ln504hhYHpqsoc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfLPFND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 00:13:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:52562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbfLPFNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 00:13:02 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C59FF20717;
        Mon, 16 Dec 2019 05:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576473182;
        bh=u30hsvfmxLLRZKaKVXVEyyCEtFrlbAUIga1Wrb+EjNk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NgvgAuBH81IrY45jaSX7FK7WFtbFgk5w3B05coowZlvCvLn76QsPAa0voTiDqSy1b
         F79OMWGXiq4z0kdOLrSy507lFA50pi6vEVG1WlM0Opk9jQudIerDpvgN4nQY7CKvX5
         db/ioZDMHhJk7etTUA4w2XKuXQ+RZDKvNbHgvrsE=
Date:   Sun, 15 Dec 2019 21:13:00 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] init: use do_mount() instead of ksys_mount()
Message-ID: <20191216051300.GB908@sol.localdomain>
References: <20191212135724.331342-1-linux@dominikbrodowski.net>
 <20191212135724.331342-4-linux@dominikbrodowski.net>
 <20191216013536.5wyvq4vjv5efd35n@core.my.home>
 <CAHk-=wh8VLe3AEKhz=1bzSO=1fv4EM71EhufxuC=Gp=+bLhXoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wh8VLe3AEKhz=1bzSO=1fv4EM71EhufxuC=Gp=+bLhXoA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 15, 2019 at 07:50:23PM -0800, Linus Torvalds wrote:
> On Sun, Dec 15, 2019 at 5:35 PM Ondřej Jirman <megi@xff.cz> wrote:
> >
> > Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> 
> Duh. So much for the trivial obvious conversion.
> 
> It didn't take "data might be NULL" into account.
> 
> A patch like this, perhaps? Untested..
> 
>                Linus

>  init/do_mounts.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/init/do_mounts.c b/init/do_mounts.c
> index f55cbd9cb818..d204f605dbce 100644
> --- a/init/do_mounts.c
> +++ b/init/do_mounts.c
> @@ -391,17 +391,19 @@ static int __init do_mount_root(const char *name, const char *fs,
>  				 const int flags, const void *data)
>  {
>  	struct super_block *s;
> -	char *data_page;
> -	struct page *p;
> +	struct page *p = NULL;
> +	char *data_page = NULL;
>  	int ret;
>  
> -	/* do_mount() requires a full page as fifth argument */
> -	p = alloc_page(GFP_KERNEL);
> -	if (!p)
> -		return -ENOMEM;
> -
> -	data_page = page_address(p);
> -	strncpy(data_page, data, PAGE_SIZE - 1);
> +	if (data) {
> +		/* do_mount() requires a full page as fifth argument */
> +		p = alloc_page(GFP_KERNEL);
> +		if (!p)
> +			return -ENOMEM;
> +		data_page = page_address(p);
> +		strncpy(data_page, data, PAGE_SIZE - 1);
> +		data_page[PAGE_SIZE - 1] = '\0';
> +	}
>  
>  	ret = do_mount(name, "/root", fs, flags, data_page);
>  	if (ret)
> @@ -417,7 +419,8 @@ static int __init do_mount_root(const char *name, const char *fs,
>  	       MAJOR(ROOT_DEV), MINOR(ROOT_DEV));
>  
>  out:
> -	put_page(p);
> +	if (p)
> +		put_page(p);
>  	return ret;

I'm seeing the boot crash too, and Linus' patch fixes it.

Note that adding the line

		data_page[PAGE_SIZE - 1] = '\0';

is not necessary since do_mount() already does it.

- Eric
