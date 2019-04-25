Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01ACBC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 782CD20685
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pj90B39I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbfDYSI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:08:58 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41421 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729242AbfDYSI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:08:58 -0400
Received: by mail-ed1-f66.google.com with SMTP id m4so687120edd.8;
        Thu, 25 Apr 2019 11:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LcuPp4VUMGvYfJkfS+lOt3bGBCBLd3jhg06YeoQI2NA=;
        b=Pj90B39IUsQmToWi+41j2bmcG1nscOWV8JIvTnofJCKc4gfraf2kfkzFt1SmLDRva8
         wEEv4+CUxoUTruREkBE93zm8h0xa8nqsUXS1NbFzEvy3tC1Xv42WG00uhhBJgF81Cz5o
         /Tm78yZJyV2ggXlXnw74K0f0CiPnu+KEVqBEr1fmHk1at6We5bU4RQ9aJDKCxIuylIdX
         VRXfWnlP931VuXJSluPcBkU0q33JltvgKwElnuxwofyE+Waezd4g+O3XgrJ0T96UhwPP
         WHLaFK6Dycu7KVmSwfmS5jS59U7q1n68koEBnBCOGpURp/O+4otlToHvD8uHhMKlbteL
         mA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LcuPp4VUMGvYfJkfS+lOt3bGBCBLd3jhg06YeoQI2NA=;
        b=kwj30yXhgG+Zeim7nCKGUHOVfCHDiTUHHsurt70Tx3LzoM/k+ukRyXUKuVcepYZ1LB
         v0BB2oIThJEeT/0484QtuVMnJ/2+m1ZTfJW34wUGJwOcu8QDfXOHXuswuiABqbkwXISe
         NL48HN/rxzvowqZ0pggAB79o3XSgbhNYMtwO2BxQQyE5mZmEHb/DXGB23gY3RdPXAVgc
         zgJ1gw2yZVnaPPgch7ZBbDjZtdjKV8A53nwXmYHUhi7t5E5BRG3gIzXeLJek97PpUfTP
         1RfZAOBP93eOdfuCjsKi1MzK79yJ2SHfCOqKeK2eA7v17glWQCamJtmYboOINXiI+nue
         9eJA==
X-Gm-Message-State: APjAAAWUIPIKyl2yJRhKHCyq/4MpqXHlhhQaRKTRcT6Ky6fKjxdEi1vq
        bBoknbwD+nbn++lcxSDky1Q=
X-Google-Smtp-Source: APXvYqwMSwLG4/WQc5qq/qJyDyiTxG9/gf0x3H/9KV9WcKpGeO6mmoMxQZvi5lZI6IX7q7WpFmZN1Q==
X-Received: by 2002:a17:906:1f12:: with SMTP id w18mr1951824ejj.95.1556215736138;
        Thu, 25 Apr 2019 11:08:56 -0700 (PDT)
Received: from archlinux-i9 ([2a01:4f9:2b:2b84::2])
        by smtp.gmail.com with ESMTPSA id ka15sm2910408ejb.11.2019.04.25.11.08.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Apr 2019 11:08:55 -0700 (PDT)
Date:   Thu, 25 Apr 2019 11:08:53 -0700
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
Message-ID: <20190425180853.GA4507@archlinux-i9>
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

Hi all,

Could someone please review/pick this up? This is one of two remaining
-Wsometimes-uninitialized warnings among arm, arm64, and x86_64
all{yes,mod}config and I'd like to get it turned on as soon as possible
to catch more bugs.

Thanks,
Nathan
