Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A197ECA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 750942089C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKrh8fzj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbfJUNy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:54:59 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50558 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728670AbfJUNy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:54:59 -0400
Received: by mail-wm1-f66.google.com with SMTP id q13so3399047wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 06:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YfrF7IJCoSFUkCGUAvDZfm/QH+GScBQlRpFMLC7/CCw=;
        b=UKrh8fzjyktCEqi/F04owSaxlJ2AZ8i3jwaIV0RIt3p3RVR8RhAiwQVPlgWyNEgWwz
         KN7aJVtURbbQXJ27msli6uh0OETcJ0SUblyrov9WRGsJn1z2aWECGIEA7L3vJ4lKI6Jl
         qhiHya6gh2LYjfoF9IISi7dvI1RZ50/h4yIiybWKXEpqwftMG6PGuPN5+mrUjWavI2Y2
         PNEZyFSr/34Lw7IsLn2N/hN1C+rRNXyuvxHmZM+GLvtkoXEkSugEY80fYkzlVkrWRzxt
         eWPEfzW/V/PqlxCHyWj3fbPcW34bc/4ViqXDqTKEVitpepFxWOVp2++9lhhufkhgfDZI
         oRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YfrF7IJCoSFUkCGUAvDZfm/QH+GScBQlRpFMLC7/CCw=;
        b=rnnsdP8xDN3ea5TTVetIBG4GOi+Mj8vtafTTK8CMb7Z+mWmj7w4gU4fRj0cCjJ5OGJ
         Qt75P/bn0aUZCxwh1m+8xDCuGyZG+hCHYgshUD6FnCTfqelatlF+Wn3Dzj8W+68Wjf+l
         7dGxuii2PC2BbCdxdsOjcYDzsQyM+XnLpR2PuM5xoJzgSXCa7i7LIbLU+whf3MZpmUya
         tYXgjgQ8ydxPFzt556sg45sVOnUDUw0Uo5YFOYZoar0NdJ5tkTlXfjWchhL6vrApe0Ma
         DDGVUvaEFkXKsbGenKvpacGBNhk0/tR3JGm+bV5CApBnf85nAgOmatI4veyVt7iEiA/l
         KLlg==
X-Gm-Message-State: APjAAAVLSiJk0NYaaxvCxZoMad34qAZueqL+XyKWM+BuvhHneaG+W/dI
        ZV6C5M7D4GWoPEHb1j7lgcU=
X-Google-Smtp-Source: APXvYqxp5pgNj/pXVy53CJJH88s1cn3K7BwZ8VWDUkBFog6CuuX4N2M+wKnXg4KLNqU31gBHWuJGyQ==
X-Received: by 2002:a05:600c:2:: with SMTP id g2mr18808922wmc.163.1571666096952;
        Mon, 21 Oct 2019 06:54:56 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id c16sm1359147wrw.32.2019.10.21.06.54.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2019 06:54:56 -0700 (PDT)
Subject: Re: [PATCH -next RESEND] Documentation/admin-guide: fix sysctl Sphinx
 warning
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dmitry Safonov <dima@arista.com>
References: <c5fed83a-d105-4142-8607-4b06ebadf0e8@infradead.org>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <c1442b1f-c90e-0604-bb50-f71a16e8b335@gmail.com>
Date:   Mon, 21 Oct 2019 14:54:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <c5fed83a-d105-4142-8607-4b06ebadf0e8@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On 10/21/19 3:44 AM, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix Sphinx warning when building Documentation:
> 
> Documentation/admin-guide/sysctl/kernel.rst:397: WARNING: Title underline too short.
> 
> hung_task_interval_warnings:
> ===================

Thanks for the patch!

I'm in process of reworking the patch in akpm according to reviews,
I will incorporate your change in next version.

> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Dmitry Safonov <dima@arista.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> ---
>  Documentation/admin-guide/sysctl/kernel.rst |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20191018.orig/Documentation/admin-guide/sysctl/kernel.rst
> +++ linux-next-20191018/Documentation/admin-guide/sysctl/kernel.rst
> @@ -394,7 +394,7 @@ This file shows up if CONFIG_DETECT_HUNG
>  
>  
>  hung_task_interval_warnings:
> -===================
> +============================
>  
>  The same as hung_task_warnings, but set the number of interval
>  warnings to be issued about detected hung tasks during check
> 
> 

Thanks,
          Dmitry
