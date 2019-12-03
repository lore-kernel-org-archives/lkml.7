Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCE1C43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56F2B206EC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1wT1exz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfLCNkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 08:40:32 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:38995 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfLCNkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 08:40:32 -0500
Received: by mail-yb1-f194.google.com with SMTP id o22so968423ybg.6;
        Tue, 03 Dec 2019 05:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PWU/7wWJMqFgQOzJgxgiFIVxjVPFwmXizK0TOekZqDg=;
        b=C1wT1exzI2+JnqAQvtk5yzcIapZj8L6gj8q4NmvEZU6boLKk35ngTnivJE6SSaWttN
         thEPw+fkAmaa6Ye7t/7fSQav4HsPD5z+u1qy01HvbBGa7bc7lyCUNgTm4Xh6D8KK2XbG
         eq8GR+xu6toCsxCSrw9fi02f42jNOlCOdJIUnr3qJ5MQrNmpULkuYoUHL5Hfog4ZA7nq
         DEIH3S3pHNNVfS82/mabk7UDpPbdOIPqA8YkiXlWWA7L6g+mhWT+IFpu856wVa4gPQEu
         rAZ3iSXNY2Sm+PVEAO/drBgBFSK5ubZoyANNhnL+FHbH3v/sn6MTRnKR1KPLy/12jJ12
         g5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=PWU/7wWJMqFgQOzJgxgiFIVxjVPFwmXizK0TOekZqDg=;
        b=QKi+pCQZZSS/fBH606M8K6SfVyvYdoUwZwUp016qvTYPZ5qxzQgw/OEVYOZVhfbrN4
         IJLs7ketHjeSVg0FaGxPCCs742pVVMApHixRQsYm2lK7TzI7yq45pcerm3oiiYWuH/wo
         Nisqg7yeInMl/mPctXsn5CiK0DruVddqFEf6wp8jB/MQJzpF3SQjqKaZf3tqolS9MhRz
         4Y61K3biY+bXBlauQvMjdSz3vqnSmJEo69vjkPJj9+h5DwBVB/I2QhvLZdXNp6Dy7IAk
         s5P/Sl/WMeRgCp55YlEtRoXaAj3UV+2x3aB3FkJ+/eoPEc+Vpa4SGPyRmkfF83154obr
         iIcg==
X-Gm-Message-State: APjAAAXPEuJLW7bY0Lk6pjfPEx1FGXqgzyRJAFEp7PHFe0HR0ljJq8Ow
        b5DN4YiIKJupmQzqe6OY3w==
X-Google-Smtp-Source: APXvYqzlVb+uzUqOoJ7sKz3DGqmH2x4xZFKhoXvP+qn/NpgdBgUv9H8D7Fy3Mg2T7hXTvflhiXmg6A==
X-Received: by 2002:a25:d052:: with SMTP id h79mr4265588ybg.345.1575380429014;
        Tue, 03 Dec 2019 05:40:29 -0800 (PST)
Received: from serve.minyard.net ([47.184.136.59])
        by smtp.gmail.com with ESMTPSA id u2sm1451301ywi.61.2019.12.03.05.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 05:40:28 -0800 (PST)
Received: from minyard.net (unknown [192.168.27.180])
        by serve.minyard.net (Postfix) with ESMTPSA id 95ED9180059;
        Tue,  3 Dec 2019 13:40:27 +0000 (UTC)
Date:   Tue, 3 Dec 2019 07:40:26 -0600
From:   Corey Minyard <minyard@acm.org>
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     openipmi-developer@lists.sourceforge.net, robh+dt@kernel.org,
        mark.rutland@arm.com, joel@jms.id.au, arnd@arndb.de,
        gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Haiyue Wang <haiyue.wang@linux.intel.com>
Subject: Re: [PATCH 2/3] ipmi: kcs: Finish configuring ASPEED KCS device
 before enable
Message-ID: <20191203134026.GI18165@minyard.net>
Reply-To: minyard@acm.org
References: <cover.5630f63168ad5cddf02e9796106f8e086c196907.1575376664.git-series.andrew@aj.id.au>
 <84315a29b453068373c096c03433e3a326731988.1575376664.git-series.andrew@aj.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84315a29b453068373c096c03433e3a326731988.1575376664.git-series.andrew@aj.id.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 11:08:24PM +1030, Andrew Jeffery wrote:
> The currently interrupts are configured after the channel was enabled.

How about:

The interrupts were configured after the channel was enabled, configure
them before so they will work.

-corey

> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> Reviewed-by: Haiyue Wang <haiyue.wang@linux.intel.com>
> ---
>  drivers/char/ipmi/kcs_bmc_aspeed.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c b/drivers/char/ipmi/kcs_bmc_aspeed.c
> index 3c955946e647..e3dd09022589 100644
> --- a/drivers/char/ipmi/kcs_bmc_aspeed.c
> +++ b/drivers/char/ipmi/kcs_bmc_aspeed.c
> @@ -268,13 +268,14 @@ static int aspeed_kcs_probe(struct platform_device *pdev)
>  	kcs_bmc->io_inputb = aspeed_kcs_inb;
>  	kcs_bmc->io_outputb = aspeed_kcs_outb;
>  
> +	rc = aspeed_kcs_config_irq(kcs_bmc, pdev);
> +	if (rc)
> +		return rc;
> +
>  	dev_set_drvdata(dev, kcs_bmc);
>  
>  	aspeed_kcs_set_address(kcs_bmc, addr);
>  	aspeed_kcs_enable_channel(kcs_bmc, true);
> -	rc = aspeed_kcs_config_irq(kcs_bmc, pdev);
> -	if (rc)
> -		return rc;
>  
>  	rc = misc_register(&kcs_bmc->miscdev);
>  	if (rc) {
> -- 
> git-series 0.9.1
