Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3515C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9EE221773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTA8NQVT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfDXN1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:27:25 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41266 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfDXN1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 09:27:24 -0400
Received: by mail-oi1-f196.google.com with SMTP id v7so14246447oie.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 06:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TiDnhjK/VArowtwPe5AuaHtBqWO5JLqyyuR7HAzGWwI=;
        b=RTA8NQVTixY3QcCRnFGfQn1eAmUTWMLgy8dlgw0bI/pnDYuTT5Lcj2hqodcJfwy0Xi
         sh3Ni+db7tJlS8eVdMge409nfSVso4fUqrxRLLJRCvT1LrbfBi/IS2Kcs55xpW4/WZkA
         5TYuLQIe4fM9TCVIjm3Ie4xXIsc2dE624H54gmR/qoOlXY3Y0xK8mYZnwUMfmd5tecrC
         bx7aZ+mfAdqgQnYOqb3carGuky9Lw0+JUPlvTvNJbH6nvOLIHHe0spNMAJHY/vYb4B0B
         Vlz89AT0tWTIw2hAuJlzysIy7xslZLswAyA0DX6R/7j9mbMgGvovud3AZQWUd70xKd6u
         mdgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=TiDnhjK/VArowtwPe5AuaHtBqWO5JLqyyuR7HAzGWwI=;
        b=bPrSpV41MeWL3kDvo5MNkZ+3wcEfm0VtD0zMtmv6LrbdTUSrGwQfwTz9cHmjjzcne2
         j2npV15vKOqGkHvvebADzS6PVz3mx6R6oXaRmsAyS4vtkufO3+JOLmwkAslkiu7bvt5J
         3og3Is8KAeuLbaPG6Lzra8VlvhFuWQhrTxDnUhBBPMIfA+Wk5ZD4BQYh2QIPyQgltoL0
         rdAdKsblyqSSk9OxT37nA5GWcEZGFqjwRPbDRoitxIJtZ/sNXAtkqKrScdBG8Vqn6IPT
         ZMNmwZ3DbtRT1eVGwDWb1mi8Of8yn5BsuHnciTItzRtYzTrYdg3iuqjvpR8Tmnfatww3
         RZiw==
X-Gm-Message-State: APjAAAUqUX+j4Ibpzo3XC72tuGrdksEyDp0SozgeePsdjuPVmhSHS8H4
        CcwcSVqlBuW0eNFkSW0f/MX07zY=
X-Google-Smtp-Source: APXvYqx1XWm4e1gtQ3pKYSOpp4KEPDQwOCjj3AVd35ACt2b/qGthQUd2uGZCVzainHtaY5AJu4QPGg==
X-Received: by 2002:aca:abce:: with SMTP id u197mr5254580oie.151.1556112443479;
        Wed, 24 Apr 2019 06:27:23 -0700 (PDT)
Received: from serve.minyard.net ([47.184.134.43])
        by smtp.gmail.com with ESMTPSA id e133sm8291629oif.44.2019.04.24.06.27.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 06:27:22 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:d5e:aa5a:44d8:6907])
        by serve.minyard.net (Postfix) with ESMTPSA id 041AA1800CF;
        Wed, 24 Apr 2019 13:27:22 +0000 (UTC)
Date:   Wed, 24 Apr 2019 08:27:20 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Kamlakant Patel <kamlakantp@marvell.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "openipmi-developer@lists.sourceforge.net" 
        <openipmi-developer@lists.sourceforge.net>
Subject: Re: [PATCH] ipmi: fix slave-addr property add to ipmi platform device
Message-ID: <20190424132720.GC6623@minyard.net>
Reply-To: minyard@acm.org
References: <1556102007-14083-1-git-send-email-kamlakantp@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556102007-14083-1-git-send-email-kamlakantp@marvell.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 10:34:14AM +0000, Kamlakant Patel wrote:
> Remove check for p->slave_addr while adding 'slave-addr' property entry
> since it can be 0.
> Currently, it throws following error:
> "ipmi_ssif dmi-ipmi-ssif.0: ipmi_ssif: device has no slave-addr
> property"
> 
> This patch fixes the issue.

This would cause things that don't supply slave addresses to get
the wrong address, they will get 0x00 instead of 0x20, like they
should.

The right thing is to remote the warning, I guess.

-corey

> 
> Signed-off-by: Kamlakant Patel <kamlakantp@marvell.com>
> ---
>  drivers/char/ipmi/ipmi_plat_data.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_plat_data.c b/drivers/char/ipmi/ipmi_plat_data.c
> index 8f0ca2a..2b62104 100644
> --- a/drivers/char/ipmi/ipmi_plat_data.c
> +++ b/drivers/char/ipmi/ipmi_plat_data.c
> @@ -34,8 +34,7 @@ struct platform_device *ipmi_platform_add(const char *name, unsigned int inst,
>  		p->regspacing = p->regsize;
>  
>  	pr[pidx++] = PROPERTY_ENTRY_U8("ipmi-type", p->type);
> -	if (p->slave_addr)
> -		pr[pidx++] = PROPERTY_ENTRY_U8("slave-addr", p->slave_addr);
> +	pr[pidx++] = PROPERTY_ENTRY_U8("slave-addr", p->slave_addr);
>  	pr[pidx++] = PROPERTY_ENTRY_U8("addr-source", p->addr_source);
>  	if (p->regshift)
>  		pr[pidx++] = PROPERTY_ENTRY_U8("reg-shift", p->regshift);
> -- 
> 1.8.3.1
> 
