Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37C1C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 05:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9371424682
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 05:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576818619;
	bh=qcdnrjHps8J+NCOxxbTp9n6XGdgvtGVAMWWTJAm9goY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LsYkqsKATRA7NcihfWRO0Kgo8WVj8tIFJLEHplVtym2R2H4JfErQV7Bd1RpT57HPL
	 qUpHKPt6H9QNd6HiVOd5NQmIA8pKU5O8ih+p0qwD/gm0QtyUdgLYEfagdX/+ElCkHN
	 W4bJDwVki/j2HMzwXII8wZezVAMGNP/1N9qz9fwE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfLTFKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 00:10:18 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33611 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfLTFKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 00:10:18 -0500
Received: by mail-lj1-f195.google.com with SMTP id y6so633523lji.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 21:10:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kLySkqD/LApGvm4F01o6HLsM+dST2BfCFVYrBB8urA8=;
        b=MLwERFjk4gzZt9TfWABeft3Vt3MYIsUcCCvX9dCNMPUjjKicLGLOkPK/eRb/YBFMB3
         F3EO0xXzNGPwkxy32wMuZQMtb+0pG857a7lFHfhhEvzHZq7B2EkFYjMqa92nwqTNpgwJ
         +n9GLmdHC9tcDWhO+t18xF4QrNdyOuv2RRvUc1oVBTiIrIaJb8TBOP5Nlh2KY3OebHPW
         DIZ4GjmiG5euYSGTN5ZgQfiYERbPRFja3aCYlkacCMBtjR/hNrYtriVBjf9WLPO0tkC7
         lxnX14/GyNiHQEMKLRSRBvrD7y8rfyZ0vO/8DoBppIBEA5iNw9J6ZbdM4WedeORdHDOk
         flxQ==
X-Gm-Message-State: APjAAAURmqnTq8FrBEgCHZLWsmmPBYZCgctzxgcricmQy/LVRyYpE2zS
        HoRaIuq/FSqEMsX3QEX6NGc=
X-Google-Smtp-Source: APXvYqwT/scfxUoqxxaSzUcn6Q7kYRhDPvctLjzlJ+YEwuVAiS4OIEi2ROw/CrHGZ2kBcaj4C3pJbA==
X-Received: by 2002:a2e:9cd8:: with SMTP id g24mr8328286ljj.243.1576818616049;
        Thu, 19 Dec 2019 21:10:16 -0800 (PST)
Received: from xi.terra (c-14b8e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.184.20])
        by smtp.gmail.com with ESMTPSA id m8sm3408222lfp.4.2019.12.19.21.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 21:10:15 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1iiAYH-0004MT-P2; Fri, 20 Dec 2019 06:10:13 +0100
Date:   Fri, 20 Dec 2019 06:10:13 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        emamd001@umn.edu
Subject: Re: [PATCH] clocksource/drivers: Fix memory leaks in
 ttc_setup_clockevent and ttc_setup_clocksource
Message-ID: <20191220051013.GT22665@localhost>
References: <20191220000923.9924-1-navid.emamdoost@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220000923.9924-1-navid.emamdoost@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 06:09:21PM -0600, Navid Emamdoost wrote:
> In the implementation of ttc_setup_clockevent() and
> ttc_setup_clocksource(), the allocated memory for ttccs is leaked when
> clk_notifier_register() fails. Use goto to direct the execution into error
> handling path.

No, that memory was never leaked since that function did not return on
registration errors before your patch.

> Fixes: 70504f311d4b ("clocksource/drivers/cadence_ttc: Convert init function to return error")

Perhaps you meant to fix the actual leak that was added by this commit
in a different function, ttc_setup_clockevent(), when returning on
notifier-registration errors?

Also should the clock be left enabled on errors?

> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/clocksource/timer-cadence-ttc.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocksource/timer-cadence-ttc.c
> index c6d11a1cb238..46d69982ad33 100644
> --- a/drivers/clocksource/timer-cadence-ttc.c
> +++ b/drivers/clocksource/timer-cadence-ttc.c
> @@ -328,10 +328,8 @@ static int __init ttc_setup_clocksource(struct clk *clk, void __iomem *base,
>  	ttccs->ttc.clk = clk;
>  
>  	err = clk_prepare_enable(ttccs->ttc.clk);
> -	if (err) {
> -		kfree(ttccs);
> -		return err;
> -	}
> +	if (err)
> +		goto release_ttcce;
>  
>  	ttccs->ttc.freq = clk_get_rate(ttccs->ttc.clk);
>  
> @@ -341,8 +339,10 @@ static int __init ttc_setup_clocksource(struct clk *clk, void __iomem *base,
>  
>  	err = clk_notifier_register(ttccs->ttc.clk,
>  				    &ttccs->ttc.clk_rate_change_nb);
> -	if (err)
> +	if (err) {
>  		pr_warn("Unable to register clock notifier.\n");
> +		goto release_ttcce;
> +	}

Johan
