Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5C7C2D0C8
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 20:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0EC207E0
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 20:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfL1UUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 15:20:54 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35430 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfL1UUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 15:20:53 -0500
Received: by mail-wr1-f66.google.com with SMTP id g17so29287228wro.2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Dec 2019 12:20:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=eiYG0r3RnO+3gfVHtiFP6m7HzMly6ykc/O5rOPhcF+w=;
        b=doQwve1Y0EPhHiG6LgZ7Rj6Y8Gj1s6igV/YBf0J6qI4vF5ZNQL6PEEOVxDCsq5UzeP
         XLJYTIh/LRyU2srmDVNvYrRO6EdjFYlBA4wKTTgCAKHjZAsxzTCw3WRxcVcTpJ8ceQ8q
         n30G5ZE+SiM7qrRpTyAKuxThzoeAr5cCuHmWczeN068i/4fbWl4GxGJM8Js7azOZ+gDq
         Kt2EDUtHfWwrOjg5LCpGfgyOBlJOZLlJa68BheK6YvlixUebv0nYPBbJfKo/xM6HjkzS
         9nNekr0zVZXzA4MqAGxkrrUMVbwj4zHdQgb+1wbKFLB+D5M71UMdhECYMuWfLShE9ZWN
         XGiw==
X-Gm-Message-State: APjAAAXph/n+2pSTA0mBAqfPQKHzSN+P6SUC5nQJxnaY5CQGkkYUoClC
        TpZox/5jeSDNhlDuNAs4qZg=
X-Google-Smtp-Source: APXvYqz/4lSqiik1cM7GuG64NNvJouY4086r1cuactSesE6bsvkT+sqlilsDMS0yjSe6cUtTq2NFmQ==
X-Received: by 2002:a5d:530d:: with SMTP id e13mr57112564wrv.125.1577564451100;
        Sat, 28 Dec 2019 12:20:51 -0800 (PST)
Received: from [10.9.0.26] ([46.166.128.205])
        by smtp.gmail.com with ESMTPSA id k13sm38903934wrx.59.2019.12.28.12.20.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Dec 2019 12:20:50 -0800 (PST)
Subject: Re: [PATCH v1 1/1] lkdtm/stackleak: Make the stack erasing test more
 verbose
From:   Alexander Popov <alex.popov@linux.com>
To:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     notify@kernel.org
References: <20191219145416.435508-1-alex.popov@linux.com>
Autocrypt: addr=alex.popov@linux.com; prefer-encrypt=mutual; keydata=
 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
 j3lCqPk=
Message-ID: <7d692333-7ff8-0c3f-8e36-dd2cc0ff3163@linux.com>
Date:   Sat, 28 Dec 2019 23:20:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191219145416.435508-1-alex.popov@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Just a friendly ping.
Could I have the feedback for this patch?

Best regards,
Alexander


On 19.12.2019 17:54, Alexander Popov wrote:
> Make the stack erasing test more verbose about the errors that it
> can detect. BUG() in case of test failure is useful when the test
> is running in a loop.
> 
> Signed-off-by: Alexander Popov <alex.popov@linux.com>
> ---
>  drivers/misc/lkdtm/stackleak.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/misc/lkdtm/stackleak.c b/drivers/misc/lkdtm/stackleak.c
> index d5a084475abc..d198de4d4c7e 100644
> --- a/drivers/misc/lkdtm/stackleak.c
> +++ b/drivers/misc/lkdtm/stackleak.c
> @@ -16,6 +16,7 @@ void lkdtm_STACKLEAK_ERASING(void)
>  	unsigned long *sp, left, found, i;
>  	const unsigned long check_depth =
>  			STACKLEAK_SEARCH_DEPTH / sizeof(unsigned long);
> +	bool test_failed = false;
>  
>  	/*
>  	 * For the details about the alignment of the poison values, see
> @@ -34,7 +35,8 @@ void lkdtm_STACKLEAK_ERASING(void)
>  		left--;
>  	} else {
>  		pr_err("FAIL: not enough stack space for the test\n");
> -		return;
> +		test_failed = true;
> +		goto end;
>  	}
>  
>  	pr_info("checking unused part of the thread stack (%lu bytes)...\n",
> @@ -52,22 +54,29 @@ void lkdtm_STACKLEAK_ERASING(void)
>  	}
>  
>  	if (found <= check_depth) {
> -		pr_err("FAIL: thread stack is not erased (checked %lu bytes)\n",
> +		pr_err("FAIL: the erased part is not found (checked %lu bytes)\n",
>  						i * sizeof(unsigned long));
> -		return;
> +		test_failed = true;
> +		goto end;
>  	}
>  
> -	pr_info("first %lu bytes are unpoisoned\n",
> +	pr_info("the erased part begins after %lu not poisoned bytes\n",
>  				(i - found) * sizeof(unsigned long));
>  
>  	/* The rest of thread stack should be erased */
>  	for (; i < left; i++) {
>  		if (*(sp - i) != STACKLEAK_POISON) {
> -			pr_err("FAIL: thread stack is NOT properly erased\n");
> -			return;
> +			pr_err("FAIL: bad value number %lu in the erased part: 0x%lx\n",
> +								i, *(sp - i));
> +			test_failed = true;
>  		}
>  	}
>  
> -	pr_info("OK: the rest of the thread stack is properly erased\n");
> -	return;
> +end:
> +	if (test_failed) {
> +		pr_err("FAIL: the thread stack is NOT properly erased\n");
> +		BUG();
> +	} else {
> +		pr_info("OK: the rest of the thread stack is properly erased\n");
> +	}
>  }
> 

