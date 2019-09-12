Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7986C4CEC5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 14:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E90420663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 14:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ncaEmNwJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732681AbfILObH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 10:31:07 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38006 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732566AbfILObH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 10:31:07 -0400
Received: by mail-lf1-f67.google.com with SMTP id c12so19546814lfh.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 07:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GGFnevdB6/W3Bn08vXZUmYabxaeEv2/WytcSluM4/qA=;
        b=ncaEmNwJoGN+h9j/w2zBIKBQZsgZQT2H68ZJRafK8UQg1HqUSTqLYVkpITITzG6hYp
         8kNSTxCfdTHB8SlHaOYh+ZtMRu8pMEDN3T6x22PO3AiC3vRwRw+JrMqlP/Jk74y6t3mX
         ywWS24EkuibJ2tShu+SqULfWeNSIMKPpr5wJREZX7Tc1cL+bYwQCkSoznpU7aTReSWjF
         jyH9hbh2kpExgjM79iT+iG6bEqijxuIXLbmtAyZikQrSeR0MiiA079g1SNBe9hFsvZwK
         C1lQqzudFaoE/DZcKU/0HVRJdxc8hXy5dcBdFy2kIB3D3tvU/DZJjJo/WTKqNQBI+1qo
         0Y+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GGFnevdB6/W3Bn08vXZUmYabxaeEv2/WytcSluM4/qA=;
        b=acM21u1vS5FFEJlCPnVoEKMiikIOIgLt78xgqGRjqc2+glp9LQOBhYKFgy+KccIaqC
         D6ac9cBSpC1O6i38U3pT5ZCAOG2kYdIDAnU17MkDTGi3IbfGT6+lduZC6JEi+5zHbGLp
         I8sVQS4DL11j4cHwhGRHBzrkRQXHVt/Ua3B+xsEqgFuLyykFc0XF5c8+iZg3XEo4YXMq
         bykTVwaFA93By76YplwTvWlHzeL/jxPQQm+AXWgfWE/+j9Lkp1CjbAnrIqOnKS2b5/gB
         T1L7vWfuJrjw6hyqCJ/aBXvi+kxnSlrOaOfZ79+2tt9kV288hnhwXEap1757FE5akdfw
         x2qA==
X-Gm-Message-State: APjAAAWY5PiXh6HF8vchYiYbSXmjpL8xhxedhZtxe8yxo2nnOu2RZMDa
        1DFttNs1/Ye4sncBPjMIkFKGQIGvq8sWxQbo2o0fQg==
X-Google-Smtp-Source: APXvYqxO9Z8c7OrTKavPMGL2/MV6p57Y1bzJgt/HX0TZHAPCfiKQUMd+9yPlAdhhtCF+f1UbeWI7+mA8oZoL7ARgpjY=
X-Received: by 2002:ac2:530e:: with SMTP id c14mr1286884lfh.165.1568298665420;
 Thu, 12 Sep 2019 07:31:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568274587.git.rahul.tanwar@linux.intel.com>
 <CACRpkdb7bPo7oH9w5OhAsOoQXx=MWjJELd5JvBt3R1sPdMjnpw@mail.gmail.com> <20190912135806.GA2680@smile.fi.intel.com>
In-Reply-To: <20190912135806.GA2680@smile.fi.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Sep 2019 15:30:52 +0100
Message-ID: <CACRpkdYcdaoA_D6YyKJuT5bfJ5QE4LWfXF8+R1y01xaWJaJZuQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] pinctrl: Add new pinctrl/GPIO driver
To:     Andriy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        qi-ming.wu@intel.com, yixin.zhu@linux.intel.com,
        cheol.yong.kim@intel.com,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 2:58 PM Andriy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> On Thu, Sep 12, 2019 at 11:11:32AM +0100, Linus Walleij wrote:
> > Hi Rahul,
> >
> > thanks for your patches!
> >
> > On Thu, Sep 12, 2019 at 8:59 AM Rahul Tanwar
> > <rahul.tanwar@linux.intel.com> wrote:
> >
> > > This series is to add pinctrl & GPIO controller driver for a new SoC.
> > > Patch 1 adds pinmux & GPIO controller driver.
> > > Patch 2 adds the dt bindings document & include file.
> > >
> > > Patches are against Linux 5.3-rc5 at below Git tree:
> > > git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
> >
> > OK nice, I think you need to include Mika Westerberg on this review
> > as well, because I think he likes to stay on top of all things intel
> > in pin control. (Also included two other Intel folks in Finland who usually
> > take an interest in these things.)
>
> Linus,
> nevertheless I guess you may give your comments WRT device tree use
> (bindings, helpers, etc) along with some basics, (like devm_*()
> [ab]use I just noticed).

I plan to look at the patches per se but right now I don't have much
time because soon there is merge window and kernel summit,
the patches just need to age a little bit like a good wine ;)

Yours,
Linus Walleij
