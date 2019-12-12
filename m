Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB433C2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 19:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF72E21556
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 19:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDCckX+5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730556AbfLLTKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 14:10:07 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:41385 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730346AbfLLTKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 14:10:06 -0500
Received: by mail-pj1-f68.google.com with SMTP id ca19so1449012pjb.8;
        Thu, 12 Dec 2019 11:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/CFTvsuLouSL+b+ykFmdN8fLszmQshAka4tYRtpWxCg=;
        b=DDCckX+53jRup7lxzh/bxqu4w8WMEM7JfkNDE8ddbtmubhsPo4HzghREbieunEzc4N
         /QIPAlyEXZJpzbxaTi/10nLMDa2VjWS3gJv37yKhE9LNJVNy2mVKqq/QAOaZqPnDnqUI
         JGiiJtS9CXi/rZk6LP7urXNmhEgcbd9d9neOsGM0759DtGXJxFhvRqYZW0WivJwpCv/K
         Q2eqUU2ulZ32zGaWZ0ojcvhTNMi2R8RD0zyGSumPB/oCZbcQInbGOvCBYz5DNbmVfl3t
         YZFHzsIy/mTl3a9enQkCC7bg68f7N4oj8pajqNH3ytaqLgRJbHxLhxIg1QOQl2HpmsZu
         4OeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/CFTvsuLouSL+b+ykFmdN8fLszmQshAka4tYRtpWxCg=;
        b=EAyPXDVCZyv3FvYov9MZAsQFrjmpEXucat0VTr/Ev6md8bgMBn9GQsNa6SWBf2GF6q
         16xm5Ndr+dSCLFaBsDDmrE1ztOwHvzs3vzDM2qqL2SFhZX3t6r1ruKwjdZJGg96jyg/n
         qPQYDLc46ojaweapIKTIWTcPr8v06R0WwX0iZQvJYZR1MwBPcyzVuSR1rfX6JZHRb0k1
         dZzidoXBAlMPiwbli80jTrfN6tWFWdWRZIwlq7ZMLOBMiOfXmDXQIj/pknrRRs1mUTuf
         jpR9dlYqkkkgT32gJ/fxhZM8FDMr9lywBswt1r/10CdBKbS/5K/TdmlYhKGlP7UfnfSD
         czIw==
X-Gm-Message-State: APjAAAUKmNw7OY+OO6SmtJLnBCZq5fGry8YptZkVNti5jOquP6MWwyHF
        WDwO0kYaQ3H85AHjdfO1zhw=
X-Google-Smtp-Source: APXvYqy80cGHOGC3vXShKkDjiLlNoD3iNKSNfr0cJkwWPHaK/hzVp8CcTB//JpDWpvEmMRR4xvjaSA==
X-Received: by 2002:a17:902:7287:: with SMTP id d7mr11152811pll.17.1576177805515;
        Thu, 12 Dec 2019 11:10:05 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id v29sm7466413pgl.88.2019.12.12.11.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 11:10:04 -0800 (PST)
Date:   Thu, 12 Dec 2019 11:10:02 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        x86 <x86@kernel.org>
Subject: Re: [PATCH v1] clk: Convert managed get functions to devm_add_action
 API
Message-ID: <20191212191002.GA101194@dtor-ws>
References: <20191128185630.GK82109@yoga>
 <20191202014237.GR248138@dtor-ws>
 <f177ef95-ef7e-cab0-1322-6de28f18ecdb@free.fr>
 <c0ccca86-b7b1-b587-60c1-4794376fa789@arm.com>
 <ba630966-5479-c831-d0e2-bc2eb12bc317@free.fr>
 <20191211222829.GV50317@dtor-ws>
 <70528f77-ca10-01cd-153b-23486ce87d45@free.fr>
 <cf5b3dee-061e-a476-7219-aa08c2977488@arm.com>
 <6a647c20-c2fa-f14c-256d-6516d0ad03b0@free.fr>
 <6ce49a67-8065-277b-5f80-ed47011e50d6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ce49a67-8065-277b-5f80-ed47011e50d6@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 06:15:16PM +0000, Robin Murphy wrote:
> On 12/12/2019 4:59 pm, Marc Gonzalez wrote:
> > On 12/12/2019 15:47, Robin Murphy wrote:
> > 
> > > On 12/12/2019 1:53 pm, Marc Gonzalez wrote:
> > > 
> > > > On 11/12/2019 23:28, Dmitry Torokhov wrote:
> > > > 
> > > > > On Wed, Dec 11, 2019 at 05:17:28PM +0100, Marc Gonzalez wrote:
> > > > > 
> > > > > > What is the rationale for the devm_add_action API?
> > > > > 
> > > > > For one-off and maybe complex unwind actions in drivers that wish to use
> > > > > devm API (as mixing devm and manual release is verboten). Also is often
> > > > > used when some core subsystem does not provide enough devm APIs.
> > > > 
> > > > Thanks for the insight, Dmitry. Thanks to Robin too.
> > > > 
> > > > This is what I understand so far:
> > > > 
> > > > devm_add_action() is nice because it hides/factorizes the complexity
> > > > of the devres API, but it incurs a small storage overhead of one
> > > > pointer per call, which makes it unfit for frequently used actions,
> > > > such as clk_get.
> > > > 
> > > > Is that correct?
> > > > 
> > > > My question is: why not design the API without the small overhead?
> > > 
> > > Probably because on most architectures, ARCH_KMALLOC_MINALIGN is at
> > > least as big as two pointers anyway, so this "overhead" should mostly be
> > > free in practice. Plus the devres API is almost entirely about being
> > > able to write simple robust code, rather than absolute efficiency - I
> > > mean, struct devres itself is already 5 pointers large at the absolute
> > > minimum ;)
> > 
> > (3 pointers: 1 list_head + 1 function pointer)
> 
> Ah yes, I failed to mentally preprocess the debug config :)
> 
> > I'm confused. The first patch was criticized for potentially adding
> > an extra pointer for every devm_clk_get (e.g. 800 bytes on a 64-bit
> > platform with 100 clocks).
> 
> I'm not sure it was a criticism so much as an observation of an aspect that
> deserved consideration (certainly it was on my part, and I read Dmitry's "It
> might still, ..." as implying the same). I'd say by this point it has been
> thoroughly considered, and personally I'm now happy with the conclusion that
> the kind of embedded platforms that will have many dozens of clocks are also
> the kind that will tend to have enough padding to make it moot, and thus the
> code simplification probably is worthwhile overall.

I wonder if we could actually avoid allocating the data with
ARCH_KMALLOC_MINALIGN in all the cases. It is definitely needed for the
devm_k*alloc() group of functions as they are direct replacement for
k*alloc() APIs that give users aligned memory, but for other data
structures (clocks, regulators, etc, etc) it is not required.

Thanks.

-- 
Dmitry
