Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC70AC2D0D3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 18:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DEC220722
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 18:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiiEQlwy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbfL3SqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 13:46:18 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45047 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbfL3SqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 13:46:18 -0500
Received: by mail-pf1-f195.google.com with SMTP id 195so17771439pfw.11;
        Mon, 30 Dec 2019 10:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nBZiNp/5ZDljBNnJwdB8VJM1EgbiFAgEf4nBjxk3pCQ=;
        b=NiiEQlwyaPxeR/HBCUL36jKYZzqdi6gXMafTaB3Y39Vmwke2cpj5Kapy6zbrh9qVdg
         ExnQZ/20EcUibQpnV5EfXvqR8jbodKB3elEE4y7BOzOUsZHj+Jvsy8OYYbzjSsYq2d4e
         vm2L4SyYNmuaL81ZnWM+vRmiu0YAeflfo+waQ+ETVv1zsmA7gnxJJIKUpkdkRf+z5UYt
         ndds0fvHZ4uyw7I9YG+D8JBRrGENVfCCVr84PPWXsvo9vy39UzXfhuqBMomFUMNYH/2S
         rgPR+SMbR7ZTTNq6t587mjwrPNS9m/QxYO35GE1Vn6rkM5MeFmXX/21732GGY/wZZRuG
         oppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=nBZiNp/5ZDljBNnJwdB8VJM1EgbiFAgEf4nBjxk3pCQ=;
        b=jc6LU68qVj8JhxpW+6ZncC7HCO45VjrBx4gLizos2boRbMXAgywLPMku38QUyb79BU
         cunL+EvOzKX3qbEM7Tr7LASlvKEMHWE9gXVWpErD3l+lkFFXxgPrvLzRDUyffIYE+9mR
         wFtAhCOq/Tz/8o5XxkVluuqsG7M532FwYP7JXVqIPjwaSB/oawRYT/LUFDD92Xa+76Ia
         pwd+fcWXaOLYmu3jLcSo/VoIDkZ272twbsmp/yoh3wTSnrl6Y2xJS3m9fvd5+4uzB60K
         DgzNcaUhL5rNgDtNLwh5U3gqprYNOerkv5P9kh4vqlT5IYnF7psuZAdS9otojS6fX90D
         Lgzg==
X-Gm-Message-State: APjAAAVyMK+ntxcR1yA3QUxJ6URFTGo2aeVQCtvc0n0cQjSkk4ZTKQeF
        E2v6fvSxTqKVcuJZbD+JEjxaISOt
X-Google-Smtp-Source: APXvYqxj8DCa4bG6Y2U2srYNmQTFBC2du5c79JALur2/0MlM/fSZPJ66ZjgvqFWpl5gJa+pbzELPgw==
X-Received: by 2002:a63:a357:: with SMTP id v23mr73973634pgn.223.1577731577587;
        Mon, 30 Dec 2019 10:46:17 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i68sm54113232pfe.173.2019.12.30.10.46.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Dec 2019 10:46:16 -0800 (PST)
Date:   Mon, 30 Dec 2019 10:46:15 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH] clk: Warn about critical clks that fail to enable
Message-ID: <20191230184615.GA25973@roeck-us.net>
References: <20191226221354.11957-1-sboyd@kernel.org>
 <20191230175517.D2CC620718@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191230175517.D2CC620718@mail.kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 09:55:17AM -0800, Stephen Boyd wrote:
> Quoting Stephen Boyd (2019-12-26 14:13:54)
> > If we don't warn here users of the CLK_IS_CRITICAL flag may not know
> > that their clk isn't actually enabled because it silently fails to
> > enable. Let's drop a big WARN_ON in that case so developers find these
> > problems faster.
> > 
> > Suggested-by: Jerome Brunet <jbrunet@baylibre.com>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> > ---
> > 
> > I suspect that this may start warning for other users. Let's see
> > and revert in case it doesn't work.
> > 
> >  drivers/clk/clk.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index 772258de2d1f..6a9a66dfdeaa 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -3427,13 +3427,13 @@ static int __clk_core_init(struct clk_core *core)
> >                 unsigned long flags;
> >  
> >                 ret = clk_core_prepare(core);
> > -               if (ret)
> > +               if (WARN_ON(ret))
> 
> We should probably just print the clk name that failed to be critically
> enabled with a pr_warn(). The traceback pointing to this location will
> be really hard to understand otherwise.
> 
Agreed.

Guenter

> >                         goto out;
> >  
> >                 flags = clk_enable_lock();
> >                 ret = clk_core_enable(core);
> >                 clk_enable_unlock(flags);
> > -               if (ret) {
> > +               if (WARN_ON(ret)) {
> >                         clk_core_unprepare(core);
> >                         goto out;
> >                 }
> > 
> > base-commit: 12ead77432f2ce32dea797742316d15c5800cb32
> > -- 
> > Sent by a computer, using git, on the internet
> > 
