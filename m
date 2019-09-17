Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050C7C49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 03:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B87B320678
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 03:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="REG49xGh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392051AbfIQDH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 23:07:58 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33306 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbfIQDH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 23:07:58 -0400
Received: by mail-pg1-f193.google.com with SMTP id n190so1194820pgn.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 20:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mC6reeLllG3tF2NGATVusvm3oTh/ZeLAirz0mAmwKGU=;
        b=REG49xGhZhHYiGFM2hICQTZzW4lia4QX30FXYwvGuS401EBzo1mcKjiy2TWor2jIKA
         qptnpbz5TtzQs1mW9OBjbysxGPUsSW/wUhrb+cMjWACtBZIeO+aLtsCDN3i0Q1AlgXh8
         mlMBpSnASWmIP7pVhe2unH9IwaAB02rrhQLlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mC6reeLllG3tF2NGATVusvm3oTh/ZeLAirz0mAmwKGU=;
        b=WwT/5Fcw76+B44w+z4tBWjinQuwVDfre8d2an4Wneg1GRYNUYFpg60GDSsazY4ZEqq
         v155ogk02XiyabefeYUyB3r8E4/w0lQkCdXgg0l6AI5MT49BUTdOKiC8vwbIcgaeSow0
         fY4VTxXSaSN/uLtMpXn6ztNwUfrXbOpU9cYKhZ5tqBQPA5Yn8TygxgiDa/dPrlewK8bK
         JAiqMnzJS45NjyJtoeRxXiDDQ9Ix8HWIVhZPN5uL4Fc4X00LpNq9jgiD+F0Q4xdRy4Tc
         NPhGZeO75i/aIee4jvPTSP+4BI8FeUgCHiDcdHpqAMwNIIKP78ucBVRj+8uJiJUpkqsQ
         C5PQ==
X-Gm-Message-State: APjAAAWhFif5mTb7lnjF5Fw/h/4vjT8tyh/CqxwZJ2wBfo1EKDttfRKq
        ikZTbP7wOUxQcNzFKEqO/Xe7jQ==
X-Google-Smtp-Source: APXvYqwSSU6JluvKcdZk0NzjKCQ0GNYxqiYDtSxDE+xrHz+cECKkm4QKWmRnQHdFbogeGO5EhjkO6Q==
X-Received: by 2002:a62:ed17:: with SMTP id u23mr1771458pfh.147.1568689677775;
        Mon, 16 Sep 2019 20:07:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g5sm558647pfh.133.2019.09.16.20.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 20:07:56 -0700 (PDT)
Date:   Mon, 16 Sep 2019 20:07:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lockdep: Make print_lock() address visible
Message-ID: <201909162006.3138C81AE0@keescook>
References: <20190917013946.9EC51C60479@www.outflux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917013946.9EC51C60479@www.outflux.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 06:39:46PM -0700, keescook@chromium.org wrote:
> commit 519248f36d6f3c80e176f6fa844c10d94f1f5990
> Author: Paul E. McKenney <paulmck@linux.ibm.com>
> Date:   Thu May 30 05:39:25 2019 -0700
> 
>     lockdep: Make print_lock() address visible
>     
>     Security is a wonderful thing, but so is the ability to debug based on
>     lockdep warnings.  This commit therefore makes lockdep lock addresses
>     visible in the clear.
>     
>     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 4861cf8e274b..4aca3f4379d2 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -620,7 +620,7 @@ static void print_lock(struct held_lock *hlock)
>  		return;
>  	}
>  
> -	printk(KERN_CONT "%p", hlock->instance);
> +	printk(KERN_CONT "%px", hlock->instance);
>  	print_lock_name(lock);
>  	printk(KERN_CONT ", at: %pS\n", (void *)hlock->acquire_ip);
>  }

Just to clarify: this is only visible under CONFIG_LOCKDEP, yes? That's
not a state anyone would run a production system under, I'd hope.

-- 
Kees Cook
