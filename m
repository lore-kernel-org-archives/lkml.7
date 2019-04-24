Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87AAC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 799402077C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1G1BB3C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbfDXN0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:26:03 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37149 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbfDXN0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 09:26:02 -0400
Received: by mail-oi1-f194.google.com with SMTP id k6so518813oic.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 06:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yjt+Dv15SGYi3RbA2PmyDM2Ngtf3sp9YMi++UYop5Ao=;
        b=Y1G1BB3CrE9wUORFDSHSG9uUhkqCD4XoWPs/Tg3Oc1DKPp18oYL3Q9oqA0y5eyCs7x
         Gk9A+wK4nqe7wL6vTQoODOFXLbPvb5NSyHTEoi4j0GtswXa9H454QezNxzR6XVtWl1Hx
         0aF5ERdbJghv/mlsWJWrJiRajWz7X3dU6XMsIijQbtSigI041izNrPR8fdVfwNUhr/Qj
         IdODpR6CZMDILt/ZKrK7ZOz+UFPgZDpf5b4Q9bfU83oqT3w1exT7FCS358zKdZS+tLcE
         xiQ483mI47fnFKYQcTz/y/AANyycq+lAJhTwTZuzXd9+pU9ZuYzS4yUtTvZM6rCD7iFu
         kbag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=Yjt+Dv15SGYi3RbA2PmyDM2Ngtf3sp9YMi++UYop5Ao=;
        b=FZJkKr6C0NdETKWq5kk23f14E38hT1OtCVVMw4wvcu5Nc42Ptu4deAfvtGqPl2QAs7
         N65UQ7a5xrKZXl0yHrVMbzq5k406K3b7qYNffFAKuHHVzAU9T1N74SeyWm8KxwgB4V/g
         0j0jKjTl73Ccabj/DkBbU7NPMgl0NSYmYrUHKgfz/YUhRP5OIwe5QAa9Pz8tgKlS/04j
         gr96KYtQ9DPkp9ynrKn86KgLl51CS49kC8+Kg5tzobb4qFWlRE6kyGio9xj+kN+h6sgR
         HBnFv5oX7AJFcB17jbQGG8n3dmo75mDYsiFOjL52TIxxa8K3o1m+v24/4SLOnFXt1nH1
         4Cnw==
X-Gm-Message-State: APjAAAUzEFHQ+m0MLoYxmHrAFXAY0dKAgGmNZ1HG1N8euQOh5G15xi2D
        RbXyjPhaEFlz9k0ZdXfeqw==
X-Google-Smtp-Source: APXvYqzzq0Xd7crVE2lI3MRxHMh/05pM8/YPWw2sOYCVBDnwill/V7a6ECeZqLrgjCLVxcmYn/epDw==
X-Received: by 2002:a54:4487:: with SMTP id v7mr2013159oiv.66.1556112361284;
        Wed, 24 Apr 2019 06:26:01 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id r133sm8235111oib.21.2019.04.24.06.26.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 06:26:00 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:d5e:aa5a:44d8:6907])
        by serve.minyard.net (Postfix) with ESMTPSA id 958FB1800CF;
        Wed, 24 Apr 2019 13:25:59 +0000 (UTC)
Date:   Wed, 24 Apr 2019 08:25:58 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Kamlakant Patel <kamlakantp@marvell.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "openipmi-developer@lists.sourceforge.net" 
        <openipmi-developer@lists.sourceforge.net>
Subject: Re: [PATCH] ipmi: add i2c-addr property to ipmi platform device
Message-ID: <20190424132558.GB6623@minyard.net>
Reply-To: minyard@acm.org
References: <1556099251-11408-1-git-send-email-kamlakantp@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556099251-11408-1-git-send-email-kamlakantp@marvell.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 09:48:36AM +0000, Kamlakant Patel wrote:
> We need 'i2c-addr' property entry for ssif to work.
> Otherwise, it thorws following error:
> "ipmi_ssif dmi-ipmi-ssif.0: ipmi_ssif: No i2c-addr property"

The patch really isn't right, you only want to add the i2c-addr
property if the interface is SSIF.  But there's no easy way to
tell this in the current code.  I'll work something up.

Also, your mailer has added DOS line endings to all your
patches and I can't apply them cleanly.  If there's any way
you can use git-send for sending patches, that would be ideal.

-corey

> 
> Signed-off-by: Kamlakant Patel <kamlakantp@marvell.com>
> ---
>  drivers/char/ipmi/ipmi_plat_data.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/char/ipmi/ipmi_plat_data.c b/drivers/char/ipmi/ipmi_plat_data.c
> index 8f0ca2a..1075076 100644
> --- a/drivers/char/ipmi/ipmi_plat_data.c
> +++ b/drivers/char/ipmi/ipmi_plat_data.c
> @@ -34,6 +34,8 @@ struct platform_device *ipmi_platform_add(const char *name, unsigned int inst,
>  		p->regspacing = p->regsize;
>  
>  	pr[pidx++] = PROPERTY_ENTRY_U8("ipmi-type", p->type);
> +	if (p->addr)
> +		pr[pidx++] = PROPERTY_ENTRY_U16("i2c-addr", p->addr);
>  	if (p->slave_addr)
>  		pr[pidx++] = PROPERTY_ENTRY_U8("slave-addr", p->slave_addr);
>  	pr[pidx++] = PROPERTY_ENTRY_U8("addr-source", p->addr_source);
> -- 
> 1.8.3.1
> 
