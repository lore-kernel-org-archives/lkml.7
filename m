Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443C4C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1817D2084C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfLNlMat"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbfDHSHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 14:07:54 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43903 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfDHSHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 14:07:54 -0400
Received: by mail-pf1-f195.google.com with SMTP id c8so8072198pfd.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 11:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4Vw+jqU8/Q/NfNhkCQ7NB5tYS522weWWpd/A6CbS8wQ=;
        b=JfLNlMat8BGG2rMe452PjOLTYHDr5xES8aYwHpc8Iux6s0tt/WELkxHZHMhgP+k6w1
         UE9wQf5RgYwHEpxfi6p0Z72JDkuiLdOGyCXF1fabGwQIxFv6ODmplaA2ne5grFVdFcMx
         qHfK0fkd/MbsWb8HVEF4bUKMImEkvBo3TEGw9TTu9JGQpxX8JqDODi4UHGYY6q/pORwW
         I3hm1ROfRJE4AqGTRPnVeJ1PDsesE9f4Zq7OoMhvCjrrgs3a8t55DmkZ4RcgjxY8TYu8
         gotkUDtTfMb5JCJJddTVf5/RzB+aTnTIb0egl9bLlcnOGeiwfsg3g8e6cC3Y/+H9Vwr8
         UVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4Vw+jqU8/Q/NfNhkCQ7NB5tYS522weWWpd/A6CbS8wQ=;
        b=I98lXeHUsrNcJx/Gl5Yy/WbQhw8isfiub1GBwl71+v5fnN5KDQdYJ43X07eVKcMLPe
         zk++tv734Kr6Ten1VVyNSDolT+bm87iqXP3rqx0kQCR5c1Jw1dSP4AFkKONzbC5ebWpH
         aobdcUsQhOrV63Lfiwi1jmh2E/0e+QXGkzCisa0iIvjYdTq/QR3ey+gL7rMPIkky8aR8
         fXNsH/ynsNH625HhH98OJNbjtdoMNNXynrWF5uNEWqwzQ+gprKNmSXMczGkkxjCn6Cq6
         ZB7Fy/dGOt10i9AasBaYXcLnjX3dgLwdg4EYmFJgjH+waXCSQxm1+81Rxrg2Y0z6nMmG
         wOhA==
X-Gm-Message-State: APjAAAWtkO2dlNQyTkzCLKiLXdea2qfvrOCO9Y9moNXlNrkI4yAejVFx
        JEbrdbV610rE7Hu2vgOym9A=
X-Google-Smtp-Source: APXvYqwq6TQ6numuLHobw3qOIegvKbJeqsj73KvkJNUsvDwBiOaRe7HuUfPXSD7/mcCwGYnvCwJerg==
X-Received: by 2002:a62:292:: with SMTP id 140mr31695541pfc.206.1554746873883;
        Mon, 08 Apr 2019 11:07:53 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h187sm53917141pfc.52.2019.04.08.11.07.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 11:07:53 -0700 (PDT)
Date:   Mon, 8 Apr 2019 11:07:51 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Russell King <linux@arm.linux.org.uk>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH 2/7] watchdog/sbsa: Use arch_timer_read_counter instead
 of arch_counter_get_cntvct
Message-ID: <20190408180751.GA28778@roeck-us.net>
References: <20190408154907.223536-1-marc.zyngier@arm.com>
 <20190408154907.223536-3-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408154907.223536-3-marc.zyngier@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 04:49:02PM +0100, Marc Zyngier wrote:
> Only arch_timer_read_counter will guarantee that workarounds are
> applied. So let's use this one instead of arch_counter_get_cntvct.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

... assuming/hoping that those counters are actually the same.

Guenter

> ---
>  drivers/watchdog/sbsa_gwdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
> index e8bd9887c566..e221e47396ab 100644
> --- a/drivers/watchdog/sbsa_gwdt.c
> +++ b/drivers/watchdog/sbsa_gwdt.c
> @@ -161,7 +161,7 @@ static unsigned int sbsa_gwdt_get_timeleft(struct watchdog_device *wdd)
>  		timeleft += readl(gwdt->control_base + SBSA_GWDT_WOR);
>  
>  	timeleft += lo_hi_readq(gwdt->control_base + SBSA_GWDT_WCV) -
> -		    arch_counter_get_cntvct();
> +		    arch_timer_read_counter();
>  
>  	do_div(timeleft, gwdt->clk);
>  
> -- 
> 2.20.1
> 
