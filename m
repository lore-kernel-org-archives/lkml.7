Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D889C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 16:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9FD82168B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 16:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBRfGNO1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbfEQQS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 12:18:58 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41328 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728551AbfEQQS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 12:18:58 -0400
Received: by mail-ot1-f67.google.com with SMTP id g8so7235217otl.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 09:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v7etLOWnFTx/oiSRltkdwyhks2nBY8EVfFvp1BaIFSc=;
        b=cBRfGNO1xsmb6HXBeAtKjg8UBW4INvCL3j2xsudUChEy7CTOmVeoXzBoS5N9YzzXcM
         3RUVmdrXWlNShR91Y0GJWPCkuwH4h7I7Pj8m75akCIDbVOxrlenC+swmGHQHtHDKgSS8
         1lvcWIP7/k9f+PEVJpYjBDOmG09CQsMqm+wlBJSRulGWO5POZ2jXuOz1YN5RdG4XI3UK
         gDRcSAppDmfIdp9exinvhjajqYaze2Ddx+s9dzuRMYC2d/VAD6t5SPVpYBiCmjBQl40b
         0AilXMIzRis7wbmnGeXJwKH4fIOAnJ7wXyN5oW9USlTsy7xFAA/g1XUOFrMQ7s7nW6uZ
         imYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=v7etLOWnFTx/oiSRltkdwyhks2nBY8EVfFvp1BaIFSc=;
        b=OBzxFs5wbrNmBroF2cRUlCKpdpJbmbdT7J4HvadIKAWrPkkrNhg1T5fDtHzip05YTr
         IWVZJg7HhRnocgs2rIKGsrUiqFsiokiuHlS89hfDa4Yyy6uH9UebpA8qv23Gn77RXT/B
         2JSdo5C4CzIWphSne8JJ90jrom0cCeSTpo7x35oM3FYUUVVU2NYonknEFfwDH+bs6EqF
         iEqfvg2tgHzYZqv2gyTlvHJ5X4fu3qY5tTp0oDv4jFX9fveV/xzY4xp0+MVRpoDyLv41
         tqgL0pc22nUJx7jnnrBHWdvBlQYSiPTyz/iQoBty4hSJ5OhrzaBjj2wOxu3zcrRA4y9y
         YwNw==
X-Gm-Message-State: APjAAAWaA45eosz28w9VDf032WzUIueWsS7u+0/JbbuKa9UBtJsfSC+L
        VDt92ONVEmwVOIWVDcm7gQ==
X-Google-Smtp-Source: APXvYqw1TYL5oNitOoOEo4Qgqwf6IKqqAmJBrMZ29Ig20w7fENOergT1ZuJIGeiPhVoopSSIQIdL5Q==
X-Received: by 2002:a05:6830:200d:: with SMTP id e13mr461147otp.304.1558109937331;
        Fri, 17 May 2019 09:18:57 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id 80sm3643875otj.2.2019.05.17.09.18.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 May 2019 09:18:56 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:d5e:aa5a:44d8:6907])
        by serve.minyard.net (Postfix) with ESMTPSA id 37259182A49;
        Fri, 17 May 2019 16:18:56 +0000 (UTC)
Date:   Fri, 17 May 2019 11:18:55 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmi_si: use bool type for initialized variable
Message-ID: <20190517161855.GC11017@minyard.net>
Reply-To: minyard@acm.org
References: <20190517101245.4341-1-wangkefeng.wang@huawei.com>
 <20190517101245.4341-2-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517101245.4341-2-wangkefeng.wang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 06:12:45PM +0800, Kefeng Wang wrote:
> Cover 'int' to 'bool' type for initialized variable.

A reasonable cleanup, queued for 5.3.

-corey

> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/char/ipmi/ipmi_si_intf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
> index f124a2d2bb9f..da5b6723329a 100644
> --- a/drivers/char/ipmi/ipmi_si_intf.c
> +++ b/drivers/char/ipmi/ipmi_si_intf.c
> @@ -71,7 +71,7 @@ enum si_intf_state {
>  
>  static const char * const si_to_str[] = { "invalid", "kcs", "smic", "bt" };
>  
> -static int initialized;
> +static bool initialized;
>  
>  /*
>   * Indexes into stats[] in smi_info below.
> @@ -2124,7 +2124,7 @@ static int __init init_ipmi_si(void)
>  	}
>  
>  skip_fallback_noirq:
> -	initialized = 1;
> +	initialized = true;
>  	mutex_unlock(&smi_infos_lock);
>  
>  	if (type)
> -- 
> 2.20.1
> 
