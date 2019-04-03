Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFAAC10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 462E6206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6GyP2on"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfDCVsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 17:48:46 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38553 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfDCVsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 17:48:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id j26so135282pgl.5;
        Wed, 03 Apr 2019 14:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mefDxBoY6SHqSsgjKwgG2ujnOfgIpSAFiSRrCr9D8aM=;
        b=e6GyP2onWGtCr20hs+YIzz+Glia9JV0m18J8bd7WPIYAXWqnPggZDg3sAqrDmR7vb8
         fnmKpfCeMjWWc/Gk0M0gFdyKOCuL7Mgyldipr24p7NLmL/HZRoT9fhVEmGkEi5Jyjt7r
         Wc10g8tXIIH9ZipahIHzFPz8AQwYv28YHETv8Zb9T+9PtoBtBvLZo3Cz+9MbirkTPQC7
         9JYUlkJvx9JXrV+7Z6bBQaMpycncJkscY4y19mGHQb0br9DddG0niHhg5CNbUqIAjHqa
         46/LzJBtJlOX25UcFRXyrsLbE68yoPqZPEOE8b6i34YqdmHh6H6WUBNqgS4vHBU+e2vB
         MbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mefDxBoY6SHqSsgjKwgG2ujnOfgIpSAFiSRrCr9D8aM=;
        b=HZ3jRXFDwmv1M2gOaBEOqAM3jh6cuL8PxDQL4Bk4ERAFB2h38n9i4A5mSOYmH6ZXJm
         7IW9VXXcc/TMNe7R230MNZX8QdgprGwgbqSut3LZLz5MzLiP0+gEq+rApi+D/RESuPCM
         hiQZnZ6RJnn3KwZmS5kYwpib/HnsPKxTCK4UyXLMeq8rr1BsrD8ofvHfKAaca+H+MyDH
         R17TkbEh08Rkd5Mgo8tmV4SlGHAFOyg86VFWtsdEloO1ASC5P9DcMozqnNZWTKm0qcBk
         h1jTerW0Hjd5ChnBvkZvEdn2lMywncx8Xpxv+wOpB3lXH63A34XAxY9YioWh//A/UFHN
         gGwQ==
X-Gm-Message-State: APjAAAVdhTz32AzJT/YtEfeQlb/ZiTn8a2qQ7MG3OlXMYKWl3c7uPV/I
        Pi9XJMCuszwHyynj6wo4cn0=
X-Google-Smtp-Source: APXvYqwpa5OZNRVGUquf6ICWNa++Pl3MkX7X4TdX2zBhgAQ65FuO1ULmf7ca9MIwcsy8k3FqZv+/EA==
X-Received: by 2002:a63:5e43:: with SMTP id s64mr1959818pgb.15.1554328124712;
        Wed, 03 Apr 2019 14:48:44 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 20sm23119449pfn.131.2019.04.03.14.48.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 14:48:43 -0700 (PDT)
Date:   Wed, 3 Apr 2019 14:48:42 -0700
From:   "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/2] input: keyboard: imx: no need to control interrupt
 status in event check
Message-ID: <20190403214842.GD53104@dtor-ws>
References: <1553842562-8481-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553842562-8481-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On Fri, Mar 29, 2019 at 07:00:43AM +0000, Anson Huang wrote:
> There is no need to enable release interrupt and disable depress
> interrupt in event check, as a timer is setup for checking these
> events rather than interrupts.

But won't using release interrupt allow signalling key release earlier?

> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/input/keyboard/imx_keypad.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
> index 539cb67..7e32c36 100644
> --- a/drivers/input/keyboard/imx_keypad.c
> +++ b/drivers/input/keyboard/imx_keypad.c
> @@ -276,11 +276,6 @@ static void imx_keypad_check_for_events(struct timer_list *t)
>  		reg_val = readw(keypad->mmio_base + KPSR);
>  		reg_val |= KBD_STAT_KPKR | KBD_STAT_KRSS;
>  		writew(reg_val, keypad->mmio_base + KPSR);
> -
> -		reg_val = readw(keypad->mmio_base + KPSR);
> -		reg_val |= KBD_STAT_KRIE;
> -		reg_val &= ~KBD_STAT_KDIE;
> -		writew(reg_val, keypad->mmio_base + KPSR);
>  	}
>  }
>  
> -- 
> 2.7.4
> 

Thanks.

-- 
Dmitry
