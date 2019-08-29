Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387CDC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 21:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07B2F2189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 21:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pensando.io header.i=@pensando.io header.b="SZGvIs6E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbfH2V0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 17:26:40 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33532 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727546AbfH2V0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 17:26:39 -0400
Received: by mail-pg1-f193.google.com with SMTP id n190so2287653pgn.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 14:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=GWW8DLxytIiCzhfA2BJxy+/D87jQXnHMbpMx/kGEXeU=;
        b=SZGvIs6E9TskHAVTLovdtnJ3wivDhHJPTxAcX2m2/O1Wt5ZB7JkMLW3C/v0a5DlJxr
         kjzCc0WgKXUVgNOgxXOQ7+n9XK0EqyIfi5o5jL95OK457mBy/xfRT7k+/qgv7XA0NeDb
         y7kSQTHOux1UP/gcY1ok2//XPPs84aEiEh1sH34eRHiUcUxmdrxWoX9OlPh6xLAqUJ8+
         9EengEykizGIUvi9nrVmOWE0jEoiC7Hb5vnkHtIX4Tc989bmaW53jkxPE7c7C5hSquY/
         8uz2XnV9v7Rv7MZg+uWTtl6GYByJIbw4MFDqFTYOEJK5is/VxOuY3EEc38vbskFjl2I2
         PDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=GWW8DLxytIiCzhfA2BJxy+/D87jQXnHMbpMx/kGEXeU=;
        b=Hc2bUhthBwacvK6aMKvP8iiz3pJFKfIpCSei74WoR8Fl+YDh6eix+uVGUA/95RiViV
         gcuXk+gFn9qOr57MzhaaDJt7Gwv1d2zfjCH7v1JY/24ZVnsLVJpoFym1wBkMDw+3GvRe
         QUH17CmYl9YX973UhG4gFBC3rM+BhthyHbL4N47ypPbAZy7n2I/yhIOtALb7mXmJYO8a
         GCt36cBcpu2xbl9im+FUM5uB5H4TEDvrSIn+Kd69TNeSCoFilKHwP2LM9RyFvVTVbA7B
         KdkaknVXARbsPNKwyOCCJq4ofz7/WBjsrnVX81AfHgQDGhu1Q5paclr7GaIR5/joAbaQ
         evRg==
X-Gm-Message-State: APjAAAUVIOc+ofSS6Ib7+/FlsJ6O3tbs3nGQYc/jxQfzG+dC8ahsSOJI
        BQReu5XBdXcDxyVzmM18PYMRRA==
X-Google-Smtp-Source: APXvYqzgsuapLgy6KYdw7jRoVvKrtPqUVQIKBUbs4nUAFFRMYUPAiPFENsbmkHB/pRiOPNxRcrVZ9Q==
X-Received: by 2002:a63:4a51:: with SMTP id j17mr10144639pgl.284.1567113998895;
        Thu, 29 Aug 2019 14:26:38 -0700 (PDT)
Received: from Shannons-MacBook-Pro.local ([12.1.37.26])
        by smtp.gmail.com with ESMTPSA id v67sm6499918pfb.45.2019.08.29.14.26.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 14:26:38 -0700 (PDT)
Subject: Re: [PATCH v2 net-next 02/15] MIPS: SGI-IP27: restructure ioc3
 register access
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20190829155014.9229-1-tbogendoerfer@suse.de>
 <20190829155014.9229-3-tbogendoerfer@suse.de>
From:   Shannon Nelson <snelson@pensando.io>
Message-ID: <d9192f8c-a8a6-86aa-62eb-91826163bb43@pensando.io>
Date:   Thu, 29 Aug 2019 14:26:35 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190829155014.9229-3-tbogendoerfer@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/19 8:50 AM, Thomas Bogendoerfer wrote:
> Break up the big ioc3 register struct into functional pieces to
> make use in sub-function drivers more straightforward. And while
> doing that get rid of all volatile access by using readX/writeX.
>
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> ---

> diff --git a/arch/mips/sgi-ip27/ip27-console.c b/arch/mips/sgi-ip27/ip27-console.c
> index 6bdb48d41276..5886bee89d06 100644
> --- a/arch/mips/sgi-ip27/ip27-console.c
> +++ b/arch/mips/sgi-ip27/ip27-console.c
> @@ -35,6 +35,7 @@ void prom_putchar(char c)
>   {
>   	struct ioc3_uartregs *uart = console_uart();
>   
> -	while ((uart->iu_lsr & 0x20) == 0);
> -	uart->iu_thr = c;
> +	while ((readb(&uart->iu_lsr) & 0x20) == 0)
> +		;
> +	writeb(c, &uart->iu_thr);
>   }

Is it ever possible to never see your bit get set?
Instead of a tight forever spin, you might add a short delay and a retry 
limit.

I see this in several other times in the following code as well.  It 
might be interesting to see how many times through and perhaps how many 
usecs are normally spent in these loops.

Not a binding request, just a thought...

sln


