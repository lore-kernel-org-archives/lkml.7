Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCA6C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 03:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F06820851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 03:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZUOyuxg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfCHDKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 22:10:40 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43263 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfCHDKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 22:10:38 -0500
Received: by mail-pg1-f196.google.com with SMTP id l11so12920664pgq.10;
        Thu, 07 Mar 2019 19:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r58CcJqGlkjX5t1gE9hwdGtnjPHn3TSgMqKl38HW6RI=;
        b=fZUOyuxgQiPB/aeLl+LEWYMUFvN05GRR9vzfvwH9V4taDcBhsdAwz+ufziywiyEiWy
         xdG5Awd/8GzmLikLwj7oqmgoo528PMIjXDD2oYw6O1z8NKGso96AJ5KyzjvlBVYgUpft
         eXNbnevVKsk2KMmNMfd9B79Wlsfvvqzi5KJawqTKPq08YHhId2bsUpeIlBVyOzelmVYy
         ScUtp4Sod2MB9+GZmrus746c4/BoPLEjGU5RUDYw8MEtnTBF8TVjvcJUpUETQrwM8D+4
         UtqXyEuKR7s+8Q5vswR+hdZyZHTpF8ten+zKvUYDoDMjH6w3JBgYJ3QFJGBT5jcT16/V
         5FeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r58CcJqGlkjX5t1gE9hwdGtnjPHn3TSgMqKl38HW6RI=;
        b=f1wT05GDd3FiUe2V8Sf+Wjnw4k1z9Ov2eGhqWtKeeAPJgoJ/Qi/p1rHTG/RiasKJH4
         qfb6e+SWp3lTEyjiggDxXwZAc+d4Zbae4JboMBcDLRS9QtgMoTgIO3h4LYRyWYOXONpq
         ykX2Rm0VHfVfh0OTzlDsOmvCfe8/4XtzQRfcqXOWyqX3nsy1y+DHyfBGB2rt6LwNXSAo
         9rBMnqIv8q8PRVTkrIwmne8UAasol1hKymk2HohGgVaf+ZE8KMY4ffs2MmZfrSgNAf7Z
         KQLCqXY24IFgR9cB5z5MJYTrB8p2nEDDnpmvizY0AoRUwkcypidSaITu2GXMmOtibayj
         zL6A==
X-Gm-Message-State: APjAAAX8KzqHbWJdexl5URTyAiaUzJhybIKH3EtcZnHyCjPyUxw4DcHN
        yLUydzQVdN2CVqGonz3PbQM=
X-Google-Smtp-Source: APXvYqyyQY6qMeYxAnYKCOEOhLjGK+i251PSeQZOsBKMTttgIdTTyD3vT7dvl88LUJIb5aZ+9LSdsg==
X-Received: by 2002:a62:449b:: with SMTP id m27mr16395336pfi.79.1552014637227;
        Thu, 07 Mar 2019 19:10:37 -0800 (PST)
Received: from localhost ([175.223.36.163])
        by smtp.gmail.com with ESMTPSA id p5sm8456223pfn.154.2019.03.07.19.10.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 19:10:36 -0800 (PST)
Date:   Fri, 8 Mar 2019 12:10:32 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Calvin Owens <calvinowens@fb.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/4] printk: Introduce per-console loglevel setting
Message-ID: <20190308031032.GA30056@jagdpanzerIV>
References: <cover.1551486732.git.calvinowens@fb.com>
 <06cd267ef5439a9391368423b608959f5f1b1a63.1551486732.git.calvinowens@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06cd267ef5439a9391368423b608959f5f1b1a63.1551486732.git.calvinowens@fb.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/01/19 16:48), Calvin Owens wrote:
[..]
>  		msg = log_from_idx(console_idx);
> -		if (suppress_message_printing(msg->level)) {
> -			/*
> -			 * Skip record we have buffered and already printed
> -			 * directly to the console when we received it, and
> -			 * record that has level above the console loglevel.
> -			 */
> -			console_idx = log_next(console_idx);
> -			console_seq++;
> -			goto skip;
> -		}
>  
>  		/* Output to all consoles once old messages replayed. */
>  		if (unlikely(exclusive_console &&
> @@ -2405,7 +2402,7 @@ void console_unlock(void)
>  		console_lock_spinning_enable();
>  
>  		stop_critical_timings();	/* don't trace print latency */
> -		call_console_drivers(ext_text, ext_len, text, len);
> +		call_console_drivers(ext_text, ext_len, text, len, msg->level);
>  		start_critical_timings();

So it seems that now we always format the text and ext message (if
needed) and only then check if there is at least one console we can
print that message on.

Can we iterate the consoles first and check if msg is worth
the effort (per console suppress_message_printing()) and only
if it is do all the formatting and call console drivers?

	-ss
