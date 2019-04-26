Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F22FC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 05:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1915206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 05:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcV64xdz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbfDZFou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 01:44:50 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:41379 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbfDZFou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 01:44:50 -0400
Received: by mail-pf1-f170.google.com with SMTP id 188so1110352pfd.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 22:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bavQMhVqKoMG87B0v2gGFRoGBu6uL+gG5W6fIIpCA6g=;
        b=EcV64xdzxIHul2upDA4CTC7mFLTsrEh6t3QQjplDaM/gNLbSHtXcr9gzOz69WOuQj3
         nEkfcmQbscP2TlRD47lOQO2rPr+41Qhv5CbTAUeTKCHSUcMYF2zVCtnvWiumFARtUEu3
         sUa4jL+oKMQHjhUMYM6TuLmO6+590pHuIKQYp8bw/bfKXLletJEsbPc9WuWBIVgb8ZyE
         hCOZ/dsCy5cLxVeKA21PoNxgzj5s3A+Ucc7KR70ToVBm2xKbut2Tpg5jCmszuj5f50Mx
         K0Y6zyHKjBxPrVogNP6dl7d7WN1LSmaQfMp2eXZjxz5EZG6wPev7cL658I1CmTaDWs+X
         IzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bavQMhVqKoMG87B0v2gGFRoGBu6uL+gG5W6fIIpCA6g=;
        b=V6S+05nwPQFi0spRgBDfkGWjrrcwlaY6Ch/x0SUu/3oiu48rYeEmm3OZIi7FmizCQ2
         5BL0wDkZL31ST62CAc2A9TwzFdk6e2FPmjqkYjqacr98034mpudFt1OOAdxJfyTRdJqi
         KKpG6kxFY+ZhcdK9lohV6tvybLS6S9oC3dyoudd0er1HTieEcpQXEXl0nErH0LM09KTs
         tv1ZzOfHQ38wSl3t0E8xfzaSdpf6Zg0SfAMr2jh9H0dfSBiLGdm+5QcF7ORKRGUkkon1
         4EZ/JbF0q4u5q9eog3LhKHWSdd7/mdGRtOTzJx2bRJogIddodXgEd0IcHdkJ5t9Fo+HY
         d7Bg==
X-Gm-Message-State: APjAAAUAxURqVjmUrgwY0nK2KDDpVTeAcyyhFOfHFhCRPk814Xm2EmJy
        ovzIIZajFzpOxo753+ezaak=
X-Google-Smtp-Source: APXvYqwBszMQNjPPA81J9ugnqQ2M7lrw78H8i4b3vdceqhX4JtRQpSPeV3rQHzy0Ikj/kXfO4uFPTw==
X-Received: by 2002:a65:6284:: with SMTP id f4mr18195720pgv.11.1556257489348;
        Thu, 25 Apr 2019 22:44:49 -0700 (PDT)
Received: from localhost ([110.70.55.171])
        by smtp.gmail.com with ESMTPSA id j19sm36001312pfr.155.2019.04.25.22.44.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 22:44:48 -0700 (PDT)
Date:   Fri, 26 Apr 2019 14:44:45 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCHv2 4/4] printk: make sure we always print console disabled
 message
Message-ID: <20190426054445.GA564@jagdpanzerIV>
References: <20190426053302.4332-1-sergey.senozhatsky@gmail.com>
 <20190426053302.4332-5-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426053302.4332-5-sergey.senozhatsky@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Forgot to mention that the series is still in RFC phase.


On (04/26/19 14:33), Sergey Senozhatsky wrote:
[..]
> +++ b/kernel/printk/printk.c
> @@ -2613,6 +2613,12 @@ static int __unregister_console(struct console *console)
>  	pr_info("%sconsole [%s%d] disabled\n",
>  		(console->flags & CON_BOOT) ? "boot" : "",
>  		console->name, console->index);
> +	/*
> +	 * Print 'console disabled' on all the consoles, including the
> +	 * one we are about to unregister.
> +	 */
> +	console_unlock();
> +	console_lock();
>  
>  	res = _braille_unregister_console(console);
>  	if (res)

Need to think more if this is race free...

	-ss
