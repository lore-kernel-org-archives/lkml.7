Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD575C3A59F
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 03:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 841BF2173B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 03:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zj4wTskw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfHQD64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 23:58:56 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40796 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfHQD64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 23:58:56 -0400
Received: by mail-pl1-f196.google.com with SMTP id a93so3232261pla.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 20:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fpzq1IJyTN3+XLH7OodHaHJGoEjp28ZAcokHx0BKwM8=;
        b=zj4wTskwXi8JTaFitu4xIdG1IKRFka99SesptRKIhfkVA9A3VUY8yxC+C6V5UFh1EJ
         BL3kfdAw/RH+la1vpcg1SJWRfLITpUj5rbuMbZQ3kd7BJLWhTQyLReBp5wg4iiGd8n6F
         /TDmGGNEbLWhCTFPeScJfGvABGU3dWQdhQFqKJ9Xa6JgmG8r3VmspZ3BaH4aHaXWWK/6
         W+6MxtpTUyxRSJsKCGFHH5BIrGPp6Jm2CRy5rZVGQiqxgwJKTuQvJhvzJ8lYYX0MeoXN
         UEndhJEX/f0wLy7ztz4/Y5rk9U2OlywenbKF1/Ag+KfUO/6F3KUcHJM/+TTGTBYMtJrj
         pxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fpzq1IJyTN3+XLH7OodHaHJGoEjp28ZAcokHx0BKwM8=;
        b=RVyF41Qv2iLN6TVvzlXqBVrXgZyGDwIrRuivKyQyJk8tMcZk4qlruDaDsNZldLjux5
         y1ktcQAUH3/ud9JH+sBGDj/+bMdHvL+1u9VOJA639uqdg1lhkotUTG+ig0HdENO/enQk
         sEgqlEyKDO1C06EVsvMuOO6SnkS+DKZdYVO/ULjYLdDTQ6Kc5bqSBS4qQ1MSka4Yj05a
         lvbhyba2LGqUQpFiBMifa8pxqUayw8XthFmvQP1EcAcP8OkRntef0bZwSFr7MHqTkqHf
         QVjVXXhBTukdWpzb5o1sCaD9ZGnZVDi1AbNbTiVkPFspA7lX6fBbbvaWpuUDcCaOQYOM
         gjQA==
X-Gm-Message-State: APjAAAVCQd8GNKAf/cfB21wsaJMBR4ISml0sfqMeq6hBdjaezuIvjoW5
        xysF+PopRGUw4BTTiJ8dzVNf
X-Google-Smtp-Source: APXvYqxdLtY4XshCz+FNTJXBVbPVkfdMbdGtSuK9U+G+VAYToLM0bknoU7ihCSGgVowQBAlCe/CjAA==
X-Received: by 2002:a17:902:7612:: with SMTP id k18mr12190722pll.48.1566014335297;
        Fri, 16 Aug 2019 20:58:55 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:70a:af69:9185:a772:a21d:70ac])
        by smtp.gmail.com with ESMTPSA id u7sm8165596pfm.96.2019.08.16.20.58.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Aug 2019 20:58:54 -0700 (PDT)
Date:   Sat, 17 Aug 2019 09:28:45 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, robh+dt@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        fisher.cheng@bitmain.com, alec.lin@bitmain.com
Subject: Re: [PATCH 1/5] dt-bindings: clock: Add Bitmain BM1880 SoC clock
 controller binding
Message-ID: <20190817035845.GD14652@Mani-XPS-13-9360>
References: <20190705151440.20844-1-manivannan.sadhasivam@linaro.org>
 <20190705151440.20844-2-manivannan.sadhasivam@linaro.org>
 <20190808050128.E3DA52186A@mail.kernel.org>
 <20190817033422.GB14652@Mani-XPS-13-9360>
 <20190817034612.6DA7E21721@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190817034612.6DA7E21721@mail.kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 08:46:11PM -0700, Stephen Boyd wrote:
> Quoting Manivannan Sadhasivam (2019-08-16 20:34:22)
> > On Wed, Aug 07, 2019 at 10:01:28PM -0700, Stephen Boyd wrote:
> > > Quoting Manivannan Sadhasivam (2019-07-05 08:14:36)
> > > > +It is expected that it is defined using standard clock bindings as "osc".
> > > > +
> > > > +Example: 
> > > > +
> > > > +        clk: clock-controller@800 {
> > > > +                compatible = "bitmain,bm1880-clk";
> > > > +                reg = <0xe8 0x0c>,<0x800 0xb0>;
> > > 
> > > It looks weird still. What hardware module is this actually part of?
> > > Some larger power manager block?
> > > 
> > 
> > These are all part of the sysctrl block (clock + pinctrl + reset) and the
> > register domains got split between system and pll.
> > 
> 
> And that can't be one node that probes the clk, pinctrl, and reset
> drivers from C code?

It is not a MFD for sure. It's just grouping of the register domains together.

Thanks,
Mani
> 
