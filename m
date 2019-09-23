Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D626C432C1
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 21:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD5B22053B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 21:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569275998;
	bh=3ZGnG/NqjSbpKKJ/8QEaiSRCEzoKV7Zqa/TMkoaO8n4=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Jsc62/4QPij0L7DgqamO2QDsNVFVQ0Te4Wgxw8tYQRJiD2AyCGapd++roIGnBHm6Y
	 /D+o4lL4QWYlL0wKuyHy3MG7WwSq8ImFN9FGg/tYrsKCy+oYpOZkpqKnVuQTl/6q20
	 mN+gw3ma43oBQDErerKUvwbzrxi68lkLPplu9Vts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391098AbfIWV76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 17:59:58 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46943 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389997AbfIWV75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 17:59:57 -0400
Received: by mail-io1-f65.google.com with SMTP id c6so24176744ioo.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 14:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n7phuFKGA4FlxWZYRGlFKfu1KHwnx61oBgNVW4Uvweo=;
        b=KqMWhiWqmcd1UyoGAQ0d3fPT6fnQuHYCwaqjXNS4q0DIaHqAm8pS+q3sFkYo8cJ759
         b2jpxGqIUI0cGCaYy39i9o41jmXAOdzH53TMp0qa2CNdDX3J3I2BRcHDA5k5aFBLpFem
         ms4Q2AJZgoeGhpk70tS/2n2dmpo0W/ppvU3GI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n7phuFKGA4FlxWZYRGlFKfu1KHwnx61oBgNVW4Uvweo=;
        b=Q/8KT8Pfw8XywxgfVhgYyf/o2BNmFFWTNnU1OftiFeOlaO7qZg6wXT1RnTPvCXtp6z
         0HTomXjFUGAlFJJKUUzXXEpBsMW+vY8rsPBE6lgm0s7f4FPHSRQj53MJ9YBNw9bML0gS
         5PTXYTnxwNhRCV1cindzndjE2fHvIz7bOtN2deWNaOC+FCVTTU1eBXKlgdsvSg2BQCdQ
         vvoJxR4Zqsoj6gW0Lnpc1G9p2zRdvpjMDO1YzJN8L6yrs62cK4/UxzY/qBm24nmcCsM3
         5sIhyXg2uZ5zTknjNzbFK9lUcYEXaJzkBqREoU/OnzuL0HjvFxDXP2Yvnj6JaQEB1f/1
         hvPw==
X-Gm-Message-State: APjAAAV0xocnIj3wUm/icvSh19tJR2L4QxUZO7XAmnvRJsXP0coGwK4o
        nNKy13JsHU8e671c5qa3fmhSeQ==
X-Google-Smtp-Source: APXvYqx6octkk8njUJTDWMtObJZST5Zf6eKG0O/ZVPY4DzMxP393WbttHPpRyIFAWVw7IMmtoHepaQ==
X-Received: by 2002:a02:3e8a:: with SMTP id s132mr2046268jas.66.1569275997087;
        Mon, 23 Sep 2019 14:59:57 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f5sm11560011ioh.87.2019.09.23.14.59.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 14:59:56 -0700 (PDT)
Subject: Re: Fwd: [PATCH] fs: direct-io: Fixed a Documentation build warn
To:     Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "skh >> Shuah Khan" <skhan@linuxfoundation.org>
References: <20190923123701.GA9627@madhuparna-HP-Notebook>
 <CAF65HP3W3OM-Euc28fpZc_EPcG9KzEt8==UOC0fgS8ODoWRXiA@mail.gmail.com>
 <CAF65HP0CViR_Dw=xEhSAY++o=UUxtDAv2ZkAHjVkmOMiNTEeBA@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c811c429-3ad5-8601-318a-850a26a46531@linuxfoundation.org>
Date:   Mon, 23 Sep 2019 15:59:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAF65HP0CViR_Dw=xEhSAY++o=UUxtDAv2ZkAHjVkmOMiNTEeBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/19 3:03 PM, Madhuparna Bhowmik wrote:
> Fixed Excess function parameters warning.
> warning: Excess function parameter 'offset' description in
> 'dio_complete'.
> Removed the description of the local variable offset from the
> description for arguments of a function and added it with the
> declaration of the variable.

Change the commit log to say: Fixes instead of Fixed and Removes
instead of Removed.

Also I think what you mean to say is that the this patch removes
offset which isn't an argument to the function from the function
header. Can you rephrase the commit log.

> 
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com 
> <mailto:madhuparnabhowmik04@gmail.com>>

Why is this a Fwd::

> ---
>   fs/direct-io.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/direct-io.c b/fs/direct-io.c
> index ae196784f487..a9cb770f0bc1 100644
> --- a/fs/direct-io.c
> +++ b/fs/direct-io.c
> @@ -243,7 +243,6 @@ void dio_warn_stale_pagecache(struct file *filp)
> 
>   /**
>    * dio_complete() - called when all DIO BIO I/O has been completed
> - * @offset: the byte offset in the file of the completed operation
>    *
>    * This drops i_dio_count, lets interested parties know that a DIO 
> operation
>    * has completed, and calculates the resulting return code for the 
> operation.
> @@ -255,6 +254,7 @@ void dio_warn_stale_pagecache(struct file *filp)
>    */
>   static ssize_t dio_complete(struct dio *dio, ssize_t ret, unsigned int 
> flags)
>   {
> +       /* offset: the byte offset in the file of the completed operation */
>          loff_t offset = dio->iocb->ki_pos;
>          ssize_t transferred = 0;
>          int err;
> -- 
> 2.17.1
> 
> ᐧ
> ᐧ

thanks,
-- Shuah
