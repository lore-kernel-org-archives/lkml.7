Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51AAC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 12:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B27F1205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 12:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EGLVMC2u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfJOMiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 08:38:20 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:35194 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfJOMiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 08:38:20 -0400
Received: by mail-ua1-f65.google.com with SMTP id n41so1560258uae.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 05:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W5+80JllQIHYBJVJxyld1KsO5osXtXEIMZK7m9b3OxE=;
        b=EGLVMC2uAKsATxkZ7/Rd3icpohfPzU52QMFO+FeHFm8RwSaoC8PnfrGvRnufPHLvBl
         mBg8PS19zpO6b3v1jI1a2953+UBNli6Vv0U5eb93wzfdzglaZEA+9bwiUWFjbROxOPMt
         L+BV+77dabMeg5YIVKpyvWX+8hiW1VSyJa5KP07OgbUF8yuFiGfezvoMSM75dnpbtpSZ
         Dot38wCqpaS+uhE7uuRgkDNBLAZNLcd6lCRIGb8K/L4bDVcJe91vlrnYYOMsyFMPDGE3
         O630z//LEnf6Pcs8z3YT45xE2ccMPGqtVqDvxCtS6oA2c0spDcnuDWizKYm+fvur5wWW
         AU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W5+80JllQIHYBJVJxyld1KsO5osXtXEIMZK7m9b3OxE=;
        b=q+ySa1EopKGxSKehAGydnbfNZmFZwm1trxTTwszeZHjzZA2w+nybusebeNM+p+EAJr
         +mdbOGkWpvqJD+EEvjzTuEiGqwc9Ip3dnx562whSDAGhRcPgT5Zon9QA7xr9Kyfpyn/S
         8ssKppD5U47KcvpupGvsgeueBULxNEbqBTZ909eY3ecKy+cSIzmXjpBABvT6nkU5Cqxk
         g9sWYT30jAt2w/GBw3Zh+oGpRMoHPMcw0z0N8WfCBdeKb36ayedsLUM1BjdBTL2MsjnS
         5cQgeZdhOt7qcIQA0txse34Eb3DSdFK3ayWCk+LpB6ae85amvCKTLEQcgGZNg8K5IWHn
         KUBA==
X-Gm-Message-State: APjAAAXHh/QuNCJZHAKXop87AzP8cZ7bqpkgiSnmxbxq+ka+DICQ93fq
        XOMvxhsKI7HpfKB3vbLbq+3lJ1A57JmobYVeFu2GYw==
X-Google-Smtp-Source: APXvYqwEaaI7MrIcRxJjxz6+ok5wSSBBW/qpYDP66EMmyfv6XXKBrQNlxdE8x1TFkmyt+CAJSD0nkB6XYgtVE3Qgeao=
X-Received: by 2002:ab0:348c:: with SMTP id c12mr18268025uar.100.1571143098752;
 Tue, 15 Oct 2019 05:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190926150406.v1.1.I07a769ad7b00376777c9815fb169322cde7b9171@changeid>
 <20190927044239.589e7c4c@oasis.local.home> <20191001163542.GB87296@google.com>
In-Reply-To: <20191001163542.GB87296@google.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 15 Oct 2019 14:37:42 +0200
Message-ID: <CAPDyKFrYqeoiSG5-KaBDt_G4kPtCxRO7+5fRa-HSWjuPPmAheQ@mail.gmail.com>
Subject: Re: [PATCH v1] PM / Domains: Add tracepoints
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Douglas Anderson <dianders@chromium.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Oct 2019 at 18:35, Matthias Kaehlcke <mka@chromium.org> wrote:
>
> On Fri, Sep 27, 2019 at 04:42:39AM -0400, Steven Rostedt wrote:
> > On Thu, 26 Sep 2019 15:04:38 -0700
> > Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > > Define genpd_power_on/off and genpd_set_performance_state
> > > tracepoints and use them.
> >
> > I agree with Greg about adding a "why" you need this. But, in case
> > there's a good reason to have this, I have comments about the code
> > below.
>
> Thanks Greg and Steven for your comments.
>
> How about this instead:
>
>   Add tracepoints for genpd_power_on, genpd_power_off and
>   genpd_set_performance_state. The tracepoints can help with
>   understanding power domain behavior of a given device, which
>   may be particularly interesting for battery powered devices
>   and suspend/resume.

Apologize for the delay, no excuse!

I don't mind adding trace events, as long as it's for good reasons -
and to me, that seems a bit questionable here.

According to the above, I believe the information you need is already
available via genpd's debugfs interface, no?

[...]

Kind regards
Uffe
