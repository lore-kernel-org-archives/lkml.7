Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B681C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C2821900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q3xRy5rK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbfCVQD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:03:56 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35959 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbfCVQDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 12:03:55 -0400
Received: by mail-ed1-f68.google.com with SMTP id e4so2124016edi.3;
        Fri, 22 Mar 2019 09:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZJ9sneURuV6T0DHPRC59M7V8Mss5XFXvnxqpj6sa1h0=;
        b=q3xRy5rK/zVrg0j1x9HjHL1AHfDy8Zff6SPtUgxvNefQlM9fPhudIGNzFWAYRom4b4
         9nst5DFZ4z86Dm4uuhkUKI6TOBcejUWnrlNZjmNXh6GA1960d1UKaWbSfo3/ZlyIuOuJ
         SGcb8eanqQToAaHDZeLy1/OA2txAQI3f9KdHvr+sQwR8lZJBLV8G8hAbva54mFsIV8o+
         f++iULx6dTnPMnYie0WkrSXu6T4lJStz40Gj0uiv1oJQ676/gHRuFKHJXTp90nbOu4/Q
         GPCIS+nHDyz6neoVl/ekEgqhat+bhg205p3lCTZrvxb3jyW2ExHvO+rKMhEBk+OPeHle
         9T5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZJ9sneURuV6T0DHPRC59M7V8Mss5XFXvnxqpj6sa1h0=;
        b=RVp6fswCy/Ik+1D7dCWmkEmOnhwzOF5T4iVmG0S0UToUBHEcNg2VOUJIMb/swLHY8J
         pd9P27E4yOgPHVT1gxcPu2cxK8azffCRb9CKv8//isxsgbMgz4O4eDGa5zK1x8g8aWer
         Ufj310vG8Q6E3RYtcSjR/Q/VRf1mwpWSRxLxi4ql0EVnsxauThoEsJHMhyUWLLHxuN3O
         EkUuadYb1tMWZnmaod5CbFEVRg0YHm7GLQn5NqDbzJLAvv7oWq6qrBYcrSsPT1VN9BX2
         0yef+bj0tWmuMMxL4wNMWZDBTePVhdYyJsYJAmnxgrWNrEwVPQdt+n4mh/Zxib3qB/Ts
         yIgw==
X-Gm-Message-State: APjAAAXD3Qag0r1JLeL5UB4ensf4LD2rd0pJ5axbGu1ZRUprIlOFC7u7
        GLHJJ1SkgfdUHJuB46SfdUs=
X-Google-Smtp-Source: APXvYqyxYcVnFe8TUt3TAeaT3pdOuznpKnf488aIA2MMuIWlOOJJjgXFzEP/og2H6U0A7ZvqPciFbw==
X-Received: by 2002:a50:90ee:: with SMTP id d43mr7197684eda.220.1553270633342;
        Fri, 22 Mar 2019 09:03:53 -0700 (PDT)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id r27sm2673641eda.0.2019.03.22.09.03.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 22 Mar 2019 09:03:52 -0700 (PDT)
Date:   Fri, 22 Mar 2019 09:03:50 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Coly Li <colyli@suse.de>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        Shenghui Wang <shhuiw@foxmail.com>,
        Hannes Reinecke <hare@suse.com>, linux-bcache@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bcache: avoid clang -Wunintialized warning
Message-ID: <20190322160350.GE21978@archlinux-ryzen>
References: <20190322143507.1256436-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322143507.1256436-1-arnd@arndb.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 03:35:00PM +0100, Arnd Bergmann wrote:
> clang has identified a code path in which it thinks a
> variable may be unused:
> 
> drivers/md/bcache/alloc.c:333:4: error: variable 'bucket' is used uninitialized whenever 'if' condition is false
>       [-Werror,-Wsometimes-uninitialized]
>                         fifo_pop(&ca->free_inc, bucket);
>                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/md/bcache/util.h:219:27: note: expanded from macro 'fifo_pop'
>  #define fifo_pop(fifo, i)       fifo_pop_front(fifo, (i))
>                                 ^~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/md/bcache/util.h:189:6: note: expanded from macro 'fifo_pop_front'
>         if (_r) {                                                       \
>             ^~
> drivers/md/bcache/alloc.c:343:46: note: uninitialized use occurs here
>                         allocator_wait(ca, bch_allocator_push(ca, bucket));
>                                                                   ^~~~~~
> drivers/md/bcache/alloc.c:287:7: note: expanded from macro 'allocator_wait'
>                 if (cond)                                               \
>                     ^~~~
> drivers/md/bcache/alloc.c:333:4: note: remove the 'if' if its condition is always true
>                         fifo_pop(&ca->free_inc, bucket);
>                         ^
> drivers/md/bcache/util.h:219:27: note: expanded from macro 'fifo_pop'
>  #define fifo_pop(fifo, i)       fifo_pop_front(fifo, (i))
>                                 ^
> drivers/md/bcache/util.h:189:2: note: expanded from macro 'fifo_pop_front'
>         if (_r) {                                                       \
>         ^
> drivers/md/bcache/alloc.c:331:15: note: initialize the variable 'bucket' to silence this warning
>                         long bucket;
>                                    ^
> 
> This cannot happen in practice because we only enter the loop
> if there is at least one element in the list.
> 
> Slightly rearranging the code makes this clearer to both the
> reader and the compiler, which avoids the warning.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Yes, I like this much better than my patch, thanks!

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  drivers/md/bcache/alloc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/md/bcache/alloc.c b/drivers/md/bcache/alloc.c
> index 5002838ea476..f8986effcb50 100644
> --- a/drivers/md/bcache/alloc.c
> +++ b/drivers/md/bcache/alloc.c
> @@ -327,10 +327,11 @@ static int bch_allocator_thread(void *arg)
>  		 * possibly issue discards to them, then we add the bucket to
>  		 * the free list:
>  		 */
> -		while (!fifo_empty(&ca->free_inc)) {
> +		while (1) {
>  			long bucket;
>  
> -			fifo_pop(&ca->free_inc, bucket);
> +			if (!fifo_pop(&ca->free_inc, bucket))
> +				break;
>  
>  			if (ca->discard) {
>  				mutex_unlock(&ca->set->bucket_lock);
> -- 
> 2.20.0
> 
