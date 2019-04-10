Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7ADC10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 01:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5EB82133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 01:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9ZHe7CK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbfDJB7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 21:59:32 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42081 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfDJB7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 21:59:32 -0400
Received: by mail-pg1-f194.google.com with SMTP id p6so503296pgh.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 18:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qcB6LnB60ML4/2Pcs78woj+0IUIN/pAyB7fDcOrYfGA=;
        b=A9ZHe7CKzJtKlv79Kfsm7xK1dKcurx1dfYwmb+8yvjTtiIJkFhtZTq9rfmakSPb4Jn
         yWeolc2LL9HjoMrweR5OXf8fHzU+gIIEvDB5QYSbiMter++XZQyDkh4jUosvdbAW7LPw
         IVeu6evQMK7xcbLR/ohXU4RqOuADpy0Bqc0Vo8Bthb0xH3mYlg3WKUhQHxnVMkLsg+lj
         0eDmKox5ZORIBMmfXZoDEfxSS6amJMNo8y7tPJGoscL28y3WVwkUsniNhAwSdU/G8FYw
         IkG672dlpo+LuNP8BZRHkwQzgrIz/mp3mhSIDWXzM+Y5Q73n55EIKwskEpoVnRm7Q/LG
         g9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qcB6LnB60ML4/2Pcs78woj+0IUIN/pAyB7fDcOrYfGA=;
        b=dU6OpJcObSRkkZ5Um6zUhS/q0/UTm/8QurUgoX1WyadSCM5DI5GfrN9Psbhufbk6A1
         FoCpItsG+BrHTtMg2JG7NOv2IAgTtWFTDRGZLm1KFMPotIOjE1dLPQYNda49Bz2A2j/K
         t7kJmHXzncet8hLZGHr40t1fXqhbby8TQcN5VhEKoXwlRTJgJflc4CZf/VlTEOWmAeQu
         KYxOy3DslNIq0sz0icXWduTRmVKd9z27MtIxwCv7p16c1KEZRdF3TN+RfNT9dexggTe7
         f8X3phP4gDSvFjW5jHJrvdlvN3Mkwkv6JwPXpSo1/k37bEzA4Jpq0400i+OTDPzu4NX8
         BinQ==
X-Gm-Message-State: APjAAAU7BvNEqIzmiY9DBvZpdbZp3wQrcUVe6tQGela2rerm7t/MuRBe
        yzO3A4SCKhIGP70OwEkRM48=
X-Google-Smtp-Source: APXvYqzYtzYjqOK9gCc809xfmAZ+56mQdZp7WKo01ROc+cwlD+oHgEj2txQ9+gcGsGaebOrzQK5GIQ==
X-Received: by 2002:a62:1a0d:: with SMTP id a13mr41047998pfa.198.1554861571351;
        Tue, 09 Apr 2019 18:59:31 -0700 (PDT)
Received: from localhost ([175.223.11.210])
        by smtp.gmail.com with ESMTPSA id l26sm52114352pfb.20.2019.04.09.18.59.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 18:59:30 -0700 (PDT)
Date:   Wed, 10 Apr 2019 10:59:26 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH 2/2] panic: Enable to print out all printk msg in buffer
Message-ID: <20190410015926.GC26212@jagdpanzerIV>
References: <1554115684-26846-1-git-send-email-feng.tang@intel.com>
 <1554115684-26846-2-git-send-email-feng.tang@intel.com>
 <20190409141430.w2fulp7jnnthojrc@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409141430.w2fulp7jnnthojrc@pathway.suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/09/19 16:14), Petr Mladek wrote:
> We should:
> 
>    + Flush the latest messages before we replay the log.

Do you mean the pending messages? When we replay the log we also should
print "header line" and panic-cpu backtrace. So we will print panic-cpu
oops twice

	// from panic-cpu flush_on_panic
	[header]
	backtrace
	[end of header]

        // from console_replay
	then all logbuf messages
	and then the same header/backtrace one more time

	[header]
	backtrace]
	[end of backtrace]

Is there any particular reason to flush pending messages before
we play the buffer? Replaying the logbuf can take some time, so
my guess would be that you want to print panic-cpu backtrace as
soon as possible. Is there something else?

[..]
> Then I would update cosole_unlock() with something like:
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 02ca827b8fac..14ef4e2431e7 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2386,21 +2386,32 @@ void console_unlock(void)
>  
>  	for (;;) {
>  		struct printk_log *msg;
> +		int reset_idx = 0;
>  		size_t ext_len = 0;
> -		size_t len;
> +		size_t len = 0;
>  
>  		printk_safe_enter_irqsave(flags);
>  		raw_spin_lock(&logbuf_lock);
> +
>  		if (console_seq < log_first_seq) {
>  			len = sprintf(text,
>  				      "** %llu printk messages dropped **\n",
>  				      log_first_seq - console_seq);
>  
>  			/* messages are gone, move to first one */
> +			reset_idx = 1;
> +		}
> +
> +		if (console_replay) {
> +			len += sprintf(text + len,
> +				       "Replaying the entire log:\n");
> +			reset_idx = 1;
> +			console_replay = 0;
> +		}
> +
> +		if (reset_idx) {
>  			console_seq = log_first_seq;
>  			console_idx = log_first_idx;
> -		} else {
> -			len = 0;
>  		}

The printing loop becomes a bit complex with one more state, I should
say; but can do. We handle exclusive consoles there, dropped messages,
panic reset. But I see what you are trying to do.

	-ss
