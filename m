Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46EDECE58F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7909E20854
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="awoHS9eV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730919AbfJORTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 13:19:42 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40281 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730700AbfJORTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 13:19:41 -0400
Received: by mail-pf1-f194.google.com with SMTP id x127so12892807pfb.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 10:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TWtOdLU950qO44gtWRI1EevokHAunCwQ1TaUeaOgpXk=;
        b=awoHS9eVotcWQ2gbtqYURIscmftRO0hnxBkikpia+e0TsfNOnDMM3fOzVNuX5Ehopo
         uebssmp/dLs6BBLFKoi04U1jAnQnHV4oiLzvt/DmQZrPeeec1Kw5VWPem+vi+yrWn0ZX
         gXuxpxVFvn1J4rubjdujIthIBrBKUR2U9szVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TWtOdLU950qO44gtWRI1EevokHAunCwQ1TaUeaOgpXk=;
        b=H2UDQI1SdkZL8ZqomrwkKsf0UzrOVM7Vnt45Om5L+U4iIcAG8oPvyPYxvBfi9MbROl
         vMf9nvOLTSTRBY8T8lJC2zF/5tifVw6CpvfilSSVXGi6NzIAbRS7Ogz029oz179cliA2
         n28F7T7VB6G75IUKSOEIxtm8miubQgfircw+cTCBByEv3vY/bp9UYjF59VRZCWjf6u1Y
         4X+2SR6rCmnge3u5hKQK5j4PPlCWUgS+YkSDeB3A4uPDhU/JU9aZytrxNQ5n/VaYkuK9
         6aebDvmqR+AhNf2/ubfNZ5hW5pzvIuOVZqgj9prjmRNbmtq2u84TQvPtD/9b4qH3LL5s
         Go2g==
X-Gm-Message-State: APjAAAWzBawBwAtjTgYt0Le2QVmHPe9uzROfGREqNbQquk6SY6IImr4I
        ANEDm6XEIi28hmO62pYZyL480zRh8lc=
X-Google-Smtp-Source: APXvYqwgk66PcBDs4wpLLZVJPG/VI50z6RsUr748jWOgPSQEjjgVW/mRJuA6zAgAaY2oFXrP0Je05g==
X-Received: by 2002:aa7:924f:: with SMTP id 15mr40455528pfp.194.1571159981109;
        Tue, 15 Oct 2019 10:19:41 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id s36sm22990237pgk.84.2019.10.15.10.19.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2019 10:19:40 -0700 (PDT)
Date:   Tue, 15 Oct 2019 10:19:37 -0700
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
Message-ID: <20191015171937.GO87296@google.com>
References: <20190926150406.v1.1.I07a769ad7b00376777c9815fb169322cde7b9171@changeid>
 <20190927044239.589e7c4c@oasis.local.home>
 <20191001163542.GB87296@google.com>
 <CAPDyKFrYqeoiSG5-KaBDt_G4kPtCxRO7+5fRa-HSWjuPPmAheQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPDyKFrYqeoiSG5-KaBDt_G4kPtCxRO7+5fRa-HSWjuPPmAheQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,

On Tue, Oct 15, 2019 at 02:37:42PM +0200, Ulf Hansson wrote:
> On Tue, 1 Oct 2019 at 18:35, Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > On Fri, Sep 27, 2019 at 04:42:39AM -0400, Steven Rostedt wrote:
> > > On Thu, 26 Sep 2019 15:04:38 -0700
> > > Matthias Kaehlcke <mka@chromium.org> wrote:
> > >
> > > > Define genpd_power_on/off and genpd_set_performance_state
> > > > tracepoints and use them.
> > >
> > > I agree with Greg about adding a "why" you need this. But, in case
> > > there's a good reason to have this, I have comments about the code
> > > below.
> >
> > Thanks Greg and Steven for your comments.
> >
> > How about this instead:
> >
> >   Add tracepoints for genpd_power_on, genpd_power_off and
> >   genpd_set_performance_state. The tracepoints can help with
> >   understanding power domain behavior of a given device, which
> >   may be particularly interesting for battery powered devices
> >   and suspend/resume.
> 
> Apologize for the delay, no excuse!
> 
> I don't mind adding trace events, as long as it's for good reasons -
> and to me, that seems a bit questionable here.
> 
> According to the above, I believe the information you need is already
> available via genpd's debugfs interface, no?

Not in all cases, e.g. you can't peek at sysfs while the device is
suspended. Also sysfs doesn't help much with seeing that a PD is
toggling between on an off for some (possibly legitimate) reason.

At this point I don't need this information badly, just thought it
could be useful. No problem if it is decided to hold back on it for
now.
