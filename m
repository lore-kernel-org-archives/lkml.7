Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C0BC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B581E20828
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KHMycYhG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbfICOtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 10:49:10 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:33257 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbfICOtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 10:49:09 -0400
Received: by mail-vs1-f65.google.com with SMTP id s18so4422328vsa.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 07:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CQLkGwKQ606SBhDXYVZ/wIEqALYPfmqGkU+b2OoxSog=;
        b=KHMycYhG2Y7WHnw+EuBG4+CdLshJqNlVA/OT7aQHdigAAwCUgOApY5f6VL8hxznVHt
         JWNHYAo+S/rFPORr1CpNVbINUk7JIin6Cs1Eka7rCL2nl1w8qq1M62XggCgUaMnURSGi
         33Oxu+V3NVbtK/KbO0KIxVVKWLIUBG/xGRC3O2XMyB5CHGA2T0QKNWsoBVGadGaRruof
         zbTrQEfkXyKf/QmAgHwUZzOXzdt8Q40N3Kqe+pKJCALXF9OTCRj3gDDfT5/MendnZxVy
         Blc7JYR/GDFBtqv0NhshUYQInCUje++lKyDQQ5ZUTusnBi8U/Wal9R+YCiFUZ8FMUpDz
         3w8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CQLkGwKQ606SBhDXYVZ/wIEqALYPfmqGkU+b2OoxSog=;
        b=fHyy2XmWH84BUcT6jlIPcQiwQDMTqEd9SVeHXrDRfqNUWcSJbTH/VpQrXs0sxxZvAk
         yMEqTZj9anZKOvDMkHS7B9g7gBQ8Nt986bE/bWt5/pIVy3q30tDXPmaxGnya1gIkMuYY
         CndvR5KlOQC+PZ5qf40VRaMUd8z/Ck0e1qo/UB5uSG76JYMDHYxIwKpLrk8OnLZP6ZAi
         oYr2YhBvjBQ/7+Lv+rPobChs3fRw2F6ZRGFYJciFb8BhcB3gmQ17K8Lb0IEbBOawiBPq
         j/P2kZ2At6Oj96gqucOGy/IEEx611Kfx9AEEMd/b3gzLaX2MA+d63SzPHJq+W1cfU2GP
         bdAw==
X-Gm-Message-State: APjAAAVQxVfDx5E4kZJIAddJCiua1lIwCRGQNvN1fMMwwZO56j3CWsTx
        1HpdGeTM0C5TsoJ3LielUqmccfyHzhsyNHq5HHvjKw==
X-Google-Smtp-Source: APXvYqyd0pWvJiNrUztCCQ87hmga1RG1L9BG5LyLAKxB8i0L1jom1pOqkHDVUIvJHWJhzw9BQ4YovByAtRfexvKB21U=
X-Received: by 2002:a67:fe4e:: with SMTP id m14mr19402036vsr.34.1567522148468;
 Tue, 03 Sep 2019 07:49:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190902035842.2747-1-andrew@aj.id.au> <20190902035842.2747-2-andrew@aj.id.au>
 <CACPK8XfYgEUfaK6rtr+FdEq-Vau6d4wE2Rvfp6Q4G2-kjVLT0g@mail.gmail.com> <83570e25-b20a-4a17-85ea-15a9a53289bf@www.fastmail.com>
In-Reply-To: <83570e25-b20a-4a17-85ea-15a9a53289bf@www.fastmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 3 Sep 2019 16:48:32 +0200
Message-ID: <CAPDyKFpWJu3RH4TWoO_wcJq0LDrM_fAUfsCC==e8O_6A8dLhiA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mmc: sdhci-of-aspeed: Fix link failure for SPARC
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     Joel Stanley <joel@jms.id.au>, Arnd Bergmann <arnd@arndb.de>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Sep 2019 at 07:26, Andrew Jeffery <andrew@aj.id.au> wrote:
>
>
>
> On Mon, 2 Sep 2019, at 13:42, Joel Stanley wrote:
> > On Mon, 2 Sep 2019 at 03:58, Andrew Jeffery <andrew@aj.id.au> wrote:
> > >
> > > Resolves the following build error reported by the 0-day bot:
> > >
> > >     ERROR: "of_platform_device_create" [drivers/mmc/host/sdhci-of-aspeed.ko] undefined!
> > >
> > > SPARC does not set CONFIG_OF_ADDRESS so the symbol is missing. Guard the
> > > callsite to maintain build coverage for the rest of the driver.
> > >
> > > Reported-by: kbuild test robot <lkp@intel.com>
> > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > > ---
> > >  drivers/mmc/host/sdhci-of-aspeed.c | 38 ++++++++++++++++++++----------
> > >  1 file changed, 25 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> > > index d5acb5afc50f..96ca494752c5 100644
> > > --- a/drivers/mmc/host/sdhci-of-aspeed.c
> > > +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> > > @@ -224,10 +224,30 @@ static struct platform_driver aspeed_sdhci_driver = {
> > >         .remove         = aspeed_sdhci_remove,
> > >  };
> > >
> > > -static int aspeed_sdc_probe(struct platform_device *pdev)
> > > -
> > > +static int aspeed_sdc_create_sdhcis(struct platform_device *pdev)
> > >  {
> > > +#if defined(CONFIG_OF_ADDRESS)
> >
> > This is going to be untested code forever, as no one will be running
> > on a chip with this hardware present but OF_ADDRESS disabled.
> >
> > How about we make the driver depend on OF_ADDRESS instead?
>
> Testing is split into two pieces here: compile-time and run-time.
> Clearly the run-time behaviour is going to be broken on configurations
> without CONFIG_OF_ADDRESS (SPARC as mentioned), but I don't think
> that means we shouldn't allow it to be compiled in that case
> (e.g. CONFIG_COMPILE_TEST performs a similar role).
>
> With respect to compile-time it's possible to compile either path as
> demonstrated by the build failure report.
>
> Having said that there's no reason we  couldn't do what you suggest,
> just it wasn't the existing solution pattern for the problem (there are
> several other drivers that suffered the same bug that were fixed in the
> style of this patch). Either way works, it's all somewhat academic.
> Your suggestion is more obvious in terms of correctness, but this
> patch is basically just code motion (the only addition is the `#if`/
> `#endif` lines over what was already there if we disregard the
> function declaration/invocation). I'll change it if there are further
> complaints and a reason to do a v3.

I am in favor of Joel's suggestion as I don't really like having
ifdefs bloating around in the driver (unless very good reasons).
Please re-spin a v3.

Another option is to implement stub function and to deal with error
codes, but that sounds more like a long term thingy, if even
applicable here.

Kind regards
Uffe
