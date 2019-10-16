Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F11FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 18:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BD8621D7A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 18:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Up4tCXps"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389716AbfJPSNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 14:13:22 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34131 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfJPSNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 14:13:21 -0400
Received: by mail-pg1-f194.google.com with SMTP id k20so7405953pgi.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 11:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2Wk3hvOL8LxJ403Uu8ih4ctFo+HR4RFi1ji6yQZRZrc=;
        b=Up4tCXps8fEJXhg3ptr4mnd5E+6YUCp8JTpF1K3zztrikjaOVy65TuMzCHSBHNV6mo
         UIK6sLQSzZV9hyc9gSWkrYcOAr+yNtSi9CQKQRfk2YASsSivWkYBrjBWH7FT+KqGvxdz
         0yuoSEoOVx15VDosuM8chSZZ+GBqrCjGp1b5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2Wk3hvOL8LxJ403Uu8ih4ctFo+HR4RFi1ji6yQZRZrc=;
        b=A4dzioPayQnx8Os0OTkeZMRzjUh68aQnKaAOrK0rO7BcZqdTsErGjGgVzId6fbA69J
         RLB8u8m7QwolfH+xhBLxoSn+0LVyFOCZ2X5083mA/CM9EBRxHf0KipjoTgeiPk7RR4OU
         rK4f2GVLIxDGEmadFQyjJrLP4UhvlQ8FjQMP4+z2YAEgUDXxpNNazZr/zTFVKNFj6bQR
         GrTKt/T2oIn0NLDT3Af3agls6Lt17AjJKM/jSaAe6aWvCqokGI6VqSiAL1we22n2jRBn
         eRcaVLZhzIMiBiY3XcjqXdmK0Ue34r4WUmxCpJD5cuhq24hp5diFzdMNzQe12mP59muN
         I0CA==
X-Gm-Message-State: APjAAAWyEFAkZO35Nzf+qjR3omFul++FQoTdBzUv+PaEOKTc0SK7VS59
        WYEAZPgkc/9dKTe359tJttIRAM6asjE=
X-Google-Smtp-Source: APXvYqx7apK+WUTs5X4UNquaQO/4GTaUMXKIUkyWCbK/F6iBsGmHob40rFdKOAjYyLlaCE+33joEUw==
X-Received: by 2002:aa7:86cb:: with SMTP id h11mr47417728pfo.59.1571249601340;
        Wed, 16 Oct 2019 11:13:21 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id x10sm9929361pgl.53.2019.10.16.11.13.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2019 11:13:19 -0700 (PDT)
Date:   Wed, 16 Oct 2019 11:13:17 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
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
Subject: Re: [PATCH v1] PM / Domains: Add tracepoints
Message-ID: <20191016181317.GP87296@google.com>
References: <20190926150406.v1.1.I07a769ad7b00376777c9815fb169322cde7b9171@changeid>
 <20190927044239.589e7c4c@oasis.local.home>
 <20191001163542.GB87296@google.com>
 <CAPDyKFrYqeoiSG5-KaBDt_G4kPtCxRO7+5fRa-HSWjuPPmAheQ@mail.gmail.com>
 <20191015171937.GO87296@google.com>
 <CAPDyKFpE0LoxXAR=2JvPi8pvb-6_q4rgs-A4D6OU7XuP1XEtbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPDyKFpE0LoxXAR=2JvPi8pvb-6_q4rgs-A4D6OU7XuP1XEtbg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 03:47:44PM +0200, Ulf Hansson wrote:
> On Tue, 15 Oct 2019 at 19:19, Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > Hi Ulf,
> >
> > On Tue, Oct 15, 2019 at 02:37:42PM +0200, Ulf Hansson wrote:
> > > On Tue, 1 Oct 2019 at 18:35, Matthias Kaehlcke <mka@chromium.org> wrote:
> > > >
> > > > On Fri, Sep 27, 2019 at 04:42:39AM -0400, Steven Rostedt wrote:
> > > > > On Thu, 26 Sep 2019 15:04:38 -0700
> > > > > Matthias Kaehlcke <mka@chromium.org> wrote:
> > > > >
> > > > > > Define genpd_power_on/off and genpd_set_performance_state
> > > > > > tracepoints and use them.
> > > > >
> > > > > I agree with Greg about adding a "why" you need this. But, in case
> > > > > there's a good reason to have this, I have comments about the code
> > > > > below.
> > > >
> > > > Thanks Greg and Steven for your comments.
> > > >
> > > > How about this instead:
> > > >
> > > >   Add tracepoints for genpd_power_on, genpd_power_off and
> > > >   genpd_set_performance_state. The tracepoints can help with
> > > >   understanding power domain behavior of a given device, which
> > > >   may be particularly interesting for battery powered devices
> > > >   and suspend/resume.
> > >
> > > Apologize for the delay, no excuse!
> > >
> > > I don't mind adding trace events, as long as it's for good reasons -
> > > and to me, that seems a bit questionable here.
> > >
> > > According to the above, I believe the information you need is already
> > > available via genpd's debugfs interface, no?
> >
> > Not in all cases, e.g. you can't peek at sysfs while the device is
> > suspended.
> 
> Not sure I get this right. If a device that is attached to a genpd
> that is runtime suspended, for sure you can have a look at the genpd
> debugfs to see its current status.

Sorry, I used an ambiguous terminology by talking about 'the device',
I was referring to system suspend.

> > Also sysfs doesn't help much with seeing that a PD is
> > toggling between on an off for some (possibly legitimate) reason.
> 
> Well, you could look at the "active_time" and the "total_idle_time"
> nodes for the genpd in question. Those should change accordingly.

Ok, thanks for the pointer!
