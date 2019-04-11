Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9921C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93DB8217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vhtQbjHs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfDKQDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 12:03:10 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41360 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfDKQDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 12:03:09 -0400
Received: by mail-pf1-f196.google.com with SMTP id 188so3660501pfd.8;
        Thu, 11 Apr 2019 09:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BJ/Gso+Q5jwEnsmntUi9c86L5hWSyu9b3Jfn28t72Xs=;
        b=vhtQbjHsSppuSn6epjOSTTL7SqBFdZVyDZDNtjMLqdadlfv3k+bCLjBenmDuJ+zqxv
         8IJxIvItboeTV1Pj51XiM0m9wZ0wXAPu69oFJBGK9sEzLpCbzFsXtft56YKLvdakAC4E
         l7RGnaifccta4xuG3tgMElEKZwElP5atgJrUpBh3arn9Fb2N80t2PB5U6J2FEfPx7vLm
         PHuxgR9wZJFZplndPukdoSkiHduTOefiisfrz1JX7l+38zHNvVhWqlEi2uDysHN+omYB
         uTxcQOvl0MvK2wFDEAo+4agNrRll9sfOpvVYgs2Ys13FlSVi+p7F36A0kJF11ygtFEes
         0Tjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=BJ/Gso+Q5jwEnsmntUi9c86L5hWSyu9b3Jfn28t72Xs=;
        b=tcb1SUPO8JDh3K8ZZYu3/fzfmvNl8KE1DzASo+Vz7aDqu4IOgyM3GN+6Cv8VooFDJt
         MzgD/1AEDEQqN2A9M2p+QWWg75LTjPjYqlh6cuhjGmPE0skDIqz6rpCLkMcTINMjAyRF
         U0dpSdKm/mUZU6xoMIZ7ontlUldKqqp/erQc2BiDJ9pzc7KAOoj2ppwWuk90GEKVIzEm
         o9YO1RJy/7moZ4t3ujujqsAZ+OZWcd+xrrX/TvkPEj2f/GLl0zLbbQGD0uCmEs8FelWh
         tic26uuqk/NEDUEoD0t+rxNRu/CiXwyyWJX2udn5w5OkOEYku1wgjzjoBCpfpXy3vJDf
         SXEQ==
X-Gm-Message-State: APjAAAVHHw1YEtPcvIBR6r2PkpYhor9s8ybkbkZnAwzrQoWKKUEoDIhD
        dc83f36cpDKwSEXxL82tHKU=
X-Google-Smtp-Source: APXvYqzR6a83qe5wTXmnS4wTTXw1ufEJk9WOtap/xkl6UbkIAn5SNKRVTlLq6rX4SuXwKTUZkv1NIQ==
X-Received: by 2002:a62:aa01:: with SMTP id e1mr50743993pff.43.1554998588967;
        Thu, 11 Apr 2019 09:03:08 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y19sm53922019pfn.164.2019.04.11.09.03.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 09:03:07 -0700 (PDT)
Date:   Thu, 11 Apr 2019 09:03:05 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Vladimir Zapolskiy <vz@mleia.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: pnx4008: readout watchddog state
Message-ID: <20190411160305.GA27530@roeck-us.net>
References: <20190411153646.32228-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411153646.32228-1-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On Thu, Apr 11, 2019 at 05:36:46PM +0200, Alexandre Belloni wrote:
> Readout the enabled state so it is possible to get the pre-userspace
> handler working. Also, avoid disabling the watchdog when nowayout is set to
> ensure the watchdog continues working and triggers if there is an issue
> later in the boot or if userspace fails to start.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/watchdog/pnx4008_wdt.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
> index 8e261799c84e..9e3714e3814c 100644
> --- a/drivers/watchdog/pnx4008_wdt.c
> +++ b/drivers/watchdog/pnx4008_wdt.c
> @@ -209,7 +209,11 @@ static int pnx4008_wdt_probe(struct platform_device *pdev)
>  	watchdog_set_nowayout(&pnx4008_wdd, nowayout);
>  	watchdog_set_restart_priority(&pnx4008_wdd, 128);
>  
> -	pnx4008_wdt_stop(&pnx4008_wdd);	/* disable for now */
> +	if (readl(WDTIM_CTRL(wdt_base)) & COUNT_ENAB)
> +		set_bit(WDOG_HW_RUNNING, &pnx4008_wdd.status);
> +
> +	if (!nowayout)
> +		pnx4008_wdt_stop(&pnx4008_wdd);	/* disable for now */

I don't see the point of stopping the watchdog here, even though that is the
old behavior. If it is possible to detect that the watchdog is running, we
can let the core handle pings until the watchdog device is opened. The code
above does that, but only if nowayout is set. That seems inconsistent and
unnecessary. Is there a downside to doing that unconditionally ?

Nitpick: s/watchddog/watchdog/ in subject line.

Thanks,
Guenter

>  
>  	ret = watchdog_register_device(&pnx4008_wdd);
>  	if (ret < 0) {
> -- 
> 2.20.1
> 
