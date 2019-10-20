Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE44BCA9EA0
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 15:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3308218BA
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 15:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l3dIfT35"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfJTP0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 11:26:33 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33255 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbfJTP0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 11:26:33 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so6754623pfl.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 08:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pABsGm/wMCxH90AX9FR3kDnSbIIdKlksDYYOMuJR3UM=;
        b=l3dIfT35FNsyilrzD12H/GM6NaoBomwigaHeRsiefY7c48bn+SzhgXJ5n4pgI/RWkT
         tT5Ilds8pOllSWIKdoeeu5kYTLu4o/0QY9yiHkTFzUJjX2+nazm52I0sdQsh98R8iAzS
         OOCavF36ylhvGeS6IZjADe2a/I4Oz/7lACz8c6fVXR74xrsyg8xnRA5k6gBMbUe0aITb
         vB3c3s+AX/ooT6GucfabbSLgNQBYuxsDGL+jKepLjy2QIPOUdepKXer//f4B4pRfmOXY
         2ChijdYt1sAqksFvBxOIddDJbmUIM4B3UmP+FbXgAKj3Vlqp7jHOSu5T7TwgvJMgqr1R
         oluQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pABsGm/wMCxH90AX9FR3kDnSbIIdKlksDYYOMuJR3UM=;
        b=K6cej8Uu8+lVIPmR/5GMc9MXTMMjKZfzXTtbaxMJQUm/SulEkN8G1wGUWXrXZbFvSD
         9nOD1GBZPd0ylHenEN7rEqvdll/X1dlxhPYCoW6mDcRLDQ0CIeXm0mTwY5BKeZlylS7j
         tCi4zM+Ex9nuYGHZFeT/GgvK+SbBtdinf9fLunsnWX7kUO2sY3xkJs+si3LII+BI5Ysw
         C53338SLvE+Y0pl+aGQFuNASPzqEk5lCUaG723of2grN5d86nyb7nbSnkP3y4vGwsYSE
         R+FYpYkheMlICFWRpRpBNoBSZ9mrti/EoOoOhrKWrwYBT2DiCBKFXS1YbWi6VQ+KvzQy
         LPkg==
X-Gm-Message-State: APjAAAW/gcXGRrY0/+rAotGtkyu82DsK7bydfnvXJH0KtD5rLpxav7VS
        Onb0+iALR2MQJRwsC5kdODhX
X-Google-Smtp-Source: APXvYqz6lFf/t+2dK+E0DYAikE4NDPP1GnLHT18bKNaEQd3kNtSuINwDMT4/RL71Kq2y2oRCKOXGLw==
X-Received: by 2002:aa7:9467:: with SMTP id t7mr18002654pfq.172.1571585192102;
        Sun, 20 Oct 2019 08:26:32 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:619e:9471:81c6:faf1:b3a2:6750])
        by smtp.gmail.com with ESMTPSA id a8sm12107920pff.5.2019.10.20.08.26.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 Oct 2019 08:26:31 -0700 (PDT)
Date:   Sun, 20 Oct 2019 20:56:24 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, robh+dt@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        fisher.cheng@bitmain.com, alec.lin@bitmain.com
Subject: Re: [PATCH v5 1/8] clk: Zero init clk_init_data in helpers
Message-ID: <20191020152624.GB12864@Mani-XPS-13-9360>
References: <20190916161447.32715-1-manivannan.sadhasivam@linaro.org>
 <20190916161447.32715-2-manivannan.sadhasivam@linaro.org>
 <20190917203957.9F75C2054F@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917203957.9F75C2054F@mail.kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 01:39:56PM -0700, Stephen Boyd wrote:
> Quoting Manivannan Sadhasivam (2019-09-16 09:14:40)
> > The clk_init_data struct needs to be initialized to zero for the new
> > parent_map implementation to work correctly. Otherwise, the member which
> > is available first will get processed.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/clk/clk-composite.c  | 2 +-
> >  drivers/clk/clk-divider.c    | 2 +-
> >  drivers/clk/clk-fixed-rate.c | 2 +-
> >  drivers/clk/clk-gate.c       | 2 +-
> >  drivers/clk/clk-mux.c        | 2 +-
> >  5 files changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
> > index b06038b8f658..4d579f9d20f6 100644
> > --- a/drivers/clk/clk-composite.c
> > +++ b/drivers/clk/clk-composite.c
> > @@ -208,7 +208,7 @@ struct clk_hw *clk_hw_register_composite(struct device *dev, const char *name,
> >                         unsigned long flags)
> >  {
> >         struct clk_hw *hw;
> > -       struct clk_init_data init;
> > +       struct clk_init_data init = { NULL };
> 
> I'd prefer { } because then we don't have to worry about ordering the
> struct to have a pointer vs. something else first.
>

okay. I thought having NULL would look more explicit!

Thanks,
Mani
 
> >         struct clk_composite *composite;
> >         struct clk_ops *clk_composite_ops;
> >         int ret;
