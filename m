Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662E2C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 19:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D24C21783
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 19:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z18GCOhV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfJAThE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 15:37:04 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44315 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfJAThE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 15:37:04 -0400
Received: by mail-pf1-f194.google.com with SMTP id q21so8795802pfn.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 12:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C7sOqQNedkcx0oCS8qMJJDlwDpOYg3wAh4V6d+6Y9us=;
        b=Z18GCOhVkcmnAppiVtHPtC432SZzbQ0CPVKlFMwn4NlnV8o8ElXiCmyMbopSXkwISq
         buEszM7lUB7HW+11kOfbMcZpfHkAf+93d+cY7hOguSnaWBexkIAAyoQtU7V9crqvZO/K
         Js8OCGwxgJ7wYZHApTtbC+H/sCtsZfMViUWUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C7sOqQNedkcx0oCS8qMJJDlwDpOYg3wAh4V6d+6Y9us=;
        b=VXIHbt8y4R3r44I0UUG78fDvEtsxI61iPdcETrW49hCy/RINQ0UR69qN6wTl0FwmLp
         u7MC7NSheuwHNPgPx0rBFMjvJUnrJWC6NPDVHi3MfAmjY5Artbzw/32oSRVFZ/bDSAe1
         8OXIE0K5NJfFgzkoneosWyCpCQu4yN9Y4BV8Fu9y2Gxgl/QpIhIjDthOPO33wcj3OF34
         FkDbQ8pI+B55goy5VEagNuALviwaE/HenQXpfrZWD43fS9tLkRigC98XaBo9aUVYTiWs
         Xf13nu0kYMSL9itZYyTkTuqfuo0aCWu5s/Cp0rdGH40+38kLt8XHALr/w3p6m3Esq6Sm
         /FFQ==
X-Gm-Message-State: APjAAAUijDFQgTwXb7TgHoCft+zPN0jATpLAcTpoI69ON5B2ZLtmSUAq
        zXkdivSwMPqXyBcCC6iw/ylUjg==
X-Google-Smtp-Source: APXvYqzgc+nnPoSiGwwK5dMvZe3vh+x52mbB8Hmzp3uWe6KiEKdzdVkFq5+0RZu54v9/oU/j3jycgg==
X-Received: by 2002:a17:90a:c8a:: with SMTP id v10mr7357813pja.4.1569958623489;
        Tue, 01 Oct 2019 12:37:03 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id w134sm16471589pfd.4.2019.10.01.12.37.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2019 12:37:02 -0700 (PDT)
Date:   Tue, 1 Oct 2019 12:37:01 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-pm@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>
Subject: Re: [PATCH v1] PM / Domains: Add tracepoints
Message-ID: <20191001193701.GD87296@google.com>
References: <20190926150406.v1.1.I07a769ad7b00376777c9815fb169322cde7b9171@changeid>
 <20190927044239.589e7c4c@oasis.local.home>
 <20191001163542.GB87296@google.com>
 <20191001130343.4480afe3@gandalf.local.home>
 <20191001174235.GC87296@google.com>
 <20191001140846.65d7866c@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191001140846.65d7866c@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 02:08:46PM -0400, Steven Rostedt wrote:
> On Tue, 1 Oct 2019 10:42:35 -0700
> Matthias Kaehlcke <mka@chromium.org> wrote:
> 
> > On Tue, Oct 01, 2019 at 01:03:43PM -0400, Steven Rostedt wrote:
> > > On Tue, 1 Oct 2019 09:35:42 -0700
> > > Matthias Kaehlcke <mka@chromium.org> wrote:
> > >   
> > > > How about this instead:
> > > > 
> > > >   Add tracepoints for genpd_power_on, genpd_power_off and
> > > >   genpd_set_performance_state. The tracepoints can help with
> > > >   understanding power domain behavior of a given device, which
> > > >   may be particularly interesting for battery powered devices
> > > >   and suspend/resume.  
> > > 
> > > Do you have a use case example to present?  
> > 
> > TBH I'm not looking into a specific use case right now. While
> > peeking around in /sys/kernel/debug/tracing/events to learn more
> > about existing tracepoints that might be relevant for my work
> > I noticed the absence of genpd ones and it seemed a good idea to
> > add them preemptively. Conceptually they seem similar to the
> > existing regulator_enable/disable and cpu_idle tracepoints.
> > 
> > As an abstract use case I could see power analysis on battery
> > powered devices during suspend. genpd_power_on/off allow to see
> > which power domains remain on during suspend, and might give
> > insights for possible power saving options. Examples could be that
> > a power domain stays unexpectedly on due to a misconfiguration, or
> > two power domains remain on when it could be only one if you just
> > moved that one pin/port over to the other domain in the next
> > hardware revision.
> 
> If the power management maintainers have no issues with adding these,
> then neither do I ;-)  It would be them who would pull them in anyway.

Ok, I'll send a new version with the changes you suggested and some more
info in the commit message, unless PM maintainers raise concerns before
that.
