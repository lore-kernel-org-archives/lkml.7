Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7865C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 19:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB41222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 19:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ieu5+M+A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbfIZTpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 15:45:08 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33732 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbfIZTpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 15:45:08 -0400
Received: by mail-io1-f65.google.com with SMTP id z19so9824473ior.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 12:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EwN6HUAXw1lkc+wDBGR97AJtjcSWR0LM+4YKhabgOzg=;
        b=Ieu5+M+AXUxsKK2faofNRw7KtrK9oTeCkIx0W+4oBVRAtqNin4Y/C4iPwDXgZB/ZLS
         ltXcTuZhMFfoIJm0TVG+l/csAEpus4Y4Xm8Tn1NNvWxZnLUFimdXU7DEK+dvy+XRwTyg
         TupBpx7HHp6APHUl+Lapfxsog+WA7KZ8UJsAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EwN6HUAXw1lkc+wDBGR97AJtjcSWR0LM+4YKhabgOzg=;
        b=hVphecBTZT4Fg4izg72IPTBrQziPHqxtv0yM8iVs4Hnot8PsIIkf5206b4kFj+S+A2
         KE8sK/wNQQxRYiuTrz0Dcvd7X6bA8G4VibVDpF+wwigzPTtoIV28KkXtdkKiEIRYW3H5
         v5KfFgfMhfoeQPJINuhDKs3lBLF+t4Mbr1oXlANqNSXA1FD43aoh2wfLZTl5nR9iFNec
         /FrvWg2kxgBm4MMd0yOfD5CIE99lHZ7H5PVFe/rz0JP6CFG2ONhixBLhvR4f93PpbPRU
         KfJscNwOzFPN/Q4Bo9SiqqrJxyDNpu7jTEcS3/Pn28HbQsyKPsVBKxeVIYTVaW5mPHys
         D11g==
X-Gm-Message-State: APjAAAWFXEYlqofHrltnzK6bK4GH4L7XRXgRyBdjZhExBzAtgxK5XBbW
        rq+JTzi8nbxW1zJFqgykAmdBQJ8/bYA=
X-Google-Smtp-Source: APXvYqz+1RwpT+8p6FpIkSAMwjUBcAlDBTNl8/9uD9R/4fE1+aqpmUu4RbVu5xpsNJkjXCG6Nh+BpQ==
X-Received: by 2002:a6b:5006:: with SMTP id e6mr4891668iob.275.1569527107543;
        Thu, 26 Sep 2019 12:45:07 -0700 (PDT)
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com. [209.85.166.52])
        by smtp.gmail.com with ESMTPSA id y23sm1362193iob.28.2019.09.26.12.45.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2019 12:45:06 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id q10so9798003iop.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 12:45:05 -0700 (PDT)
X-Received: by 2002:a92:865d:: with SMTP id g90mr394857ild.168.1569527105596;
 Thu, 26 Sep 2019 12:45:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190917154021.14693-1-m.felsch@pengutronix.de>
 <20190917154021.14693-2-m.felsch@pengutronix.de> <CAD=FV=W7M8mwQqnPyU9vsK5VAdqqJdQdyxcoe9FRRGTY8zjnFw@mail.gmail.com>
 <20190923181431.GU2036@sirena.org.uk> <CAD=FV=WVGj8xzKFFxsjpeuqtVzSvv22cHmWBRJtTbH00eC=E9w@mail.gmail.com>
 <20190923184907.GY2036@sirena.org.uk> <CAD=FV=VkaXDn034EFnJWYvWwyLgvq7ajfgMRm9mbhQeRKmPDRQ@mail.gmail.com>
 <20190924182758.GC2036@sirena.org.uk>
In-Reply-To: <20190924182758.GC2036@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 26 Sep 2019 12:44:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WZSy6nHjsY2pvjcoR4iy64b35OPGEb3EPSSc5vpeTTuA@mail.gmail.com>
Message-ID: <CAD=FV=WZSy6nHjsY2pvjcoR4iy64b35OPGEb3EPSSc5vpeTTuA@mail.gmail.com>
Subject: Re: [PATCH 1/3] regulator: core: fix boot-on regulators use_count usage
To:     Mark Brown <broonie@kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>
Cc:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        ckeepax@opensource.cirrus.com, LKML <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 24, 2019 at 11:28 AM Mark Brown <broonie@kernel.org> wrote:
> On Mon, Sep 23, 2019 at 03:40:09PM -0700, Doug Anderson wrote:
> > On Mon, Sep 23, 2019 at 11:49 AM Mark Brown <broonie@kernel.org> wrote:
> > > On Mon, Sep 23, 2019 at 11:36:11AM -0700, Doug Anderson wrote:
>
> > > > 1. Would it be valid to say that it's always incorrect to set this
> > > > property if there is a way to read the status back from the regulator?
>
> > > As originally intended, yes.  I'm now not 100% sure that it won't
> > > break any existing systems though :/
>
> > Should I change the bindings doc to say that?
>
> Sure.

Sent ("regulator: Document "regulator-boot-on" binding more thoroughly").

https://lore.kernel.org/r/20190926124115.1.Ice34ad5970a375c3c03cb15c3859b3ee501561bf@changeid


> > > It should be possible to do a regulator_disable() though I'm not
> > > sure anyone actually uses that.  The pattern for a regular
> > > consumer should be the normal enable/disable pair to handle
> > > shared usage, only an exclusive consumer should be able to use
> > > just a straight disable.
>
> > Ah, I see, I wasn't aware of the "exclusive" special case!  Marco: is
> > this working for you?  I wonder if we need to match
> > "regulator->enable_count" to "rdev->use_count" at the end of
> > _regulator_get() in the exclusive case...
>
> Yes, I think that case has been missed when adding the enable
> counts - I've never actually had a system myself that made any
> use of this stuff.  It probably needs an audit of the users to
> make sure nobody's relying on the current behaviour though I
> can't think how they would.

Marco: I'm going to assume you'll tackle this since I don't actually
have any use cases that need this.

-Doug
