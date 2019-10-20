Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815C1CA9EA0
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 15:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56AEA218BA
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 15:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XZPmteks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfJTPZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 11:25:20 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42272 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfJTPZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 11:25:19 -0400
Received: by mail-pg1-f195.google.com with SMTP id f14so6080931pgi.9
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 08:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NBfjxYubJ59D/157QVxzzDd+Z5iARJKY6CyS8CKa+Lc=;
        b=XZPmteksE3hLU4oNvizyCCh69lNf1Ak9phmFzknbCrO9tGNAVcawtBHCIkBKIPn/8d
         kyV0gxlbA5NI84BffBrpg3TxeyzHwS7ybdU4XjdMOMoMaQvclj9uglkKSv6m4dwbzXo/
         yFnaS70ybYT+ZIrJNrU1KzZN7l0DL6ZGSHWST3Ht7ssFmtL7vnv5lxpdLLjXh90Pvksc
         +k7m/NhIu/ZNg6+oMS6OOUdz9lq1VqKYmZjWbZB0W2USSq6RS3Jbnx0XOky80fv27/CP
         ynHxwqKz5bmeNEKVMwQsuvhuhPvSaXyLsMk88EA5tIZkKGCtsb8GKYvF605ylUlnB+xE
         x+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NBfjxYubJ59D/157QVxzzDd+Z5iARJKY6CyS8CKa+Lc=;
        b=BGltiKu+xeejH0abQmXsnxT74P0+7Umi/cQ+3rMxYYQaO6rKXmp1g5JGnF2mfIGo9q
         g6aXWTX8Y4+iPjqUmNWDGqaTSa/EmOh8YZ/AsmzARGpdAT3JXKniZd4jOdu5xJoWToSJ
         xJRbGTFI7FoBB/pjlQciWWc1wBJWLM0cMfoQNhjDUfRuIPfORnd9u8Khpl3RfgdnJf3D
         Vve26PCuAkdFdioRT9rRQBmwsLfqYIqpLxuFftN8EcrfytOglq1jlB3lxY9kMBuy+rWD
         PyqkQO6I+pont3lL8BKQ6/yviIG3bkAzZOJ99r0Kk1MLf2VkAjOChElN5SMROIClr0Fx
         p/tA==
X-Gm-Message-State: APjAAAX2aDrnjxuvMNkiaalfNHcUZSZcOnwAieikHpePAxqSM3MXZ87f
        +atiYAFlwDC85oCC7P+MoqNW
X-Google-Smtp-Source: APXvYqzn2zHeoS9mfLh+SLsNoxqkvHMBkXDFSX9LUf7w66QcMRwgw+rIC91NXR0dc1Dclgf0dGrAgQ==
X-Received: by 2002:a63:6b06:: with SMTP id g6mr20793670pgc.104.1571585118966;
        Sun, 20 Oct 2019 08:25:18 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:619e:9471:81c6:faf1:b3a2:6750])
        by smtp.gmail.com with ESMTPSA id i10sm11545767pgb.79.2019.10.20.08.25.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 Oct 2019 08:25:17 -0700 (PDT)
Date:   Sun, 20 Oct 2019 20:55:10 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, robh+dt@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        fisher.cheng@bitmain.com, alec.lin@bitmain.com
Subject: Re: [PATCH v5 2/8] clk: Warn if clk_init_data is not zero initialized
Message-ID: <20191020152510.GA12864@Mani-XPS-13-9360>
References: <20190916161447.32715-1-manivannan.sadhasivam@linaro.org>
 <20190916161447.32715-3-manivannan.sadhasivam@linaro.org>
 <20190917203854.8CF702054F@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917203854.8CF702054F@mail.kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Tue, Sep 17, 2019 at 01:38:53PM -0700, Stephen Boyd wrote:
> Quoting Manivannan Sadhasivam (2019-09-16 09:14:41)
> > The new implementation for determining parent map uses multiple ways
> > to pass parent info. The order in which it gets processed depends on
> > the first available member. Hence, it is necessary to zero init the
> > clk_init_data struct so that the expected member gets processed correctly.
> > So, add a warning if multiple clk_init_data members are available during
> > clk registration.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/clk/clk.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index c0990703ce54..7d6d6984c979 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -3497,6 +3497,14 @@ static int clk_core_populate_parent_map(struct clk_core *core)
> >         if (!num_parents)
> >                 return 0;
> >  
> > +       /*
> > +        * Check for non-zero initialized clk_init_data struct. This is
> > +        * required because, we only require one of the (parent_names/
> > +        * parent_data/parent_hws) to be set at a time. Otherwise, the
> > +        * current code would use first available member.
> > +        */
> > +       WARN_ON((parent_names && parent_data) || (parent_names && parent_hws));
> > +
> 
> This will warn for many drivers because they set clk_init_data on the
> stack and assign parent_names but let junk from the stack be assigned to
> parent_data.

Yes, I agree.

> The code uses parent_names first and then looks for
> parent_data or parent_hws because of this fact of life that we've never
> required clk_init_data to be initialized to all zero.
> 

Do you want me to just drop this patch or have any idea to make it better?

Thanks,
Mani

> >         /*
> >          * Avoid unnecessary string look-ups of clk_core's possible parents by
> >          * having a cache of names/clk_hw pointers to clk_core pointers.
