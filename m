Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5664CC432C1
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 22:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 292EA20578
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 22:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YlWRPdEz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503446AbfIWWkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 18:40:25 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39545 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503436AbfIWWkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 18:40:24 -0400
Received: by mail-io1-f66.google.com with SMTP id a1so37603374ioc.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 15:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vHYRjKpjUR53YCjkUqHPKrrRzHshQ7D80bU5+29eeEA=;
        b=YlWRPdEz1WQ8va4MecQIlRUa2+z/fx21wRaAPyz0MB8KEVYB6WqTx/Io+xX2GVuTDG
         OHCtxkuKlVPneQ1QqcefA6bd/2euIBQ/R82RPs0fUDh4dInPNkEsSzW/lHkdORsVscGa
         UBITQubA9r6rcWY/UULAhCzE019T7TN9b3xIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vHYRjKpjUR53YCjkUqHPKrrRzHshQ7D80bU5+29eeEA=;
        b=KE506YfU+PS/z2uJWnCkntRQQE84xuGm6oNkLHiCuzPImJNI/FavWtyWeoT6JQr4BZ
         mWKy4lIdZ0fLN586Wp8iW14x9BcpduhEItRTuhPmP8h0OXjPCVCQxBjjo/CD9u0a2+dD
         Da9Poe6mvMJXPg80VVRktVGcxQMsqP3ts627zLuXsJi6QfWNYcXEJOaiH+Vdziz+nu2E
         F55K2TLrzNHVcREZBqaks3Bdg+WvVspcACUByYYTFpErTr+3mZyjV02h5DQ/pXx6wiLM
         1wMIFxZrKj0SL/ONc6pPTUPw+5A0ZQq4NuuGFIETpNtPznQxyQmlMFfsKkT/G9IfDxMW
         Rdlg==
X-Gm-Message-State: APjAAAXRy6bceF4B5yfT7ZmDDZFdm2PPVG8bzTFs3tq8osD5Go2lxWIF
        QucoRA9BTptDkQIp0o4qQlY3xR6E4VU=
X-Google-Smtp-Source: APXvYqwVS+XDBPga/B2NNM0QbOWtmFQIfEvio5sGRM9yYg+qQQOvYzzt6ExADBM53Zg5qa/FMQMJqA==
X-Received: by 2002:a5e:9911:: with SMTP id t17mr9862ioj.283.1569278423571;
        Mon, 23 Sep 2019 15:40:23 -0700 (PDT)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com. [209.85.166.54])
        by smtp.gmail.com with ESMTPSA id i26sm12322176iol.84.2019.09.23.15.40.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 15:40:22 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id z19so15416912ior.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 15:40:22 -0700 (PDT)
X-Received: by 2002:a6b:b704:: with SMTP id h4mr1926798iof.218.1569278422105;
 Mon, 23 Sep 2019 15:40:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190917154021.14693-1-m.felsch@pengutronix.de>
 <20190917154021.14693-2-m.felsch@pengutronix.de> <CAD=FV=W7M8mwQqnPyU9vsK5VAdqqJdQdyxcoe9FRRGTY8zjnFw@mail.gmail.com>
 <20190923181431.GU2036@sirena.org.uk> <CAD=FV=WVGj8xzKFFxsjpeuqtVzSvv22cHmWBRJtTbH00eC=E9w@mail.gmail.com>
 <20190923184907.GY2036@sirena.org.uk>
In-Reply-To: <20190923184907.GY2036@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 23 Sep 2019 15:40:09 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VkaXDn034EFnJWYvWwyLgvq7ajfgMRm9mbhQeRKmPDRQ@mail.gmail.com>
Message-ID: <CAD=FV=VkaXDn034EFnJWYvWwyLgvq7ajfgMRm9mbhQeRKmPDRQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] regulator: core: fix boot-on regulators use_count usage
To:     Mark Brown <broonie@kernel.org>
Cc:     Marco Felsch <m.felsch@pengutronix.de>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        ckeepax@opensource.cirrus.com, LKML <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 23, 2019 at 11:49 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Sep 23, 2019 at 11:36:11AM -0700, Doug Anderson wrote:
> > On Mon, Sep 23, 2019 at 11:14 AM Mark Brown <broonie@kernel.org> wrote:
>
> > > Boot on means that it's powered on when the kernel starts, it's
> > > for regulators that we can't read back the status of.
>
> > 1. Would it be valid to say that it's always incorrect to set this
> > property if there is a way to read the status back from the regulator?
>
> As originally intended, yes.  I'm now not 100% sure that it won't
> break any existing systems though :/

Should I change the bindings doc to say that?


> > 2. Would this be a valid description of how the property is expected to behave
> > a) At early boot this regulator will be turned on if it wasn't already on.
> > b) If no clients are found for this regulator after everything has
> > loaded, this regulator will be automatically disabled.
>
> > If so then I don't _think_ #2b is happening, but I haven't confirmed.
>
> > > boot-on just refers to the status at boot, we can still turn
> > > those regulators off later on if we want to.
>
> > How, exactly?  As of my commit 5451781dadf8 ("regulator: core: Only
> > count load for enabled consumers") if you do:
>
> >   r = regulator_get(...)
> >   regulator_disable(r)
>
> > ...then you'll get "Underflow of regulator enable count".  In other
> > words, if a given regulator client disables more times than it enables
> > then you will get an error.  Since there is no client that did the
> > initial "boot" enable then there's no way to do the disable unless it
> > happens automatically (as per 2b above).
>
> It should be possible to do a regulator_disable() though I'm not
> sure anyone actually uses that.  The pattern for a regular
> consumer should be the normal enable/disable pair to handle
> shared usage, only an exclusive consumer should be able to use
> just a straight disable.

Ah, I see, I wasn't aware of the "exclusive" special case!  Marco: is
this working for you?  I wonder if we need to match
"regulator->enable_count" to "rdev->use_count" at the end of
_regulator_get() in the exclusive case...

-Doug
