Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEAFC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 03:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E67BF22BEB
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 03:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QoVlYWFa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389647AbfGYDHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 23:07:16 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34375 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389632AbfGYDHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 23:07:16 -0400
Received: by mail-pf1-f195.google.com with SMTP id b13so21942721pfo.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 20:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n/mY7p8FgX0kKanouYLWZrHhV2DuR3wDcDqUNd4j1is=;
        b=QoVlYWFaozyLKwWU5HggK0Wsb5zETd9BwqfjXiyHJ7wD+0kSnsripFXn9+voUc/xAP
         qR36PPUNGeKqje5Et1/ByDqWH+c1EyjDKoD4SJpMhGtfi8rXuv2QS53f0kXrZVkHTuDE
         RdufRBxUfGcYyIjBBxCgjc/zYqnbl2ZvZ/gniUAhRRG9jvYZp8rzdEif8I1hV7nYUprY
         Yj7UZxTp3c7IQXXfz2ED6Gl8H7Nt4AsJp9FccYa0itf3AT97nY1CBD2oUcKIV2XrBI1L
         tm4dA+Rwe6yz+PI8bKmSkYnwdewtChl2Qa9ZGj/uLjQXnEOS9FKffVHxPkoPTVdtKaE2
         Krow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n/mY7p8FgX0kKanouYLWZrHhV2DuR3wDcDqUNd4j1is=;
        b=LumqVwi4KW5igyYJHhdHd0Jvl5nsE4XzUI6mXxWvSabNBYnBA2zzykNM73LKBxNbHF
         Mfd7IAvj2mhIoTAsYOb6dFBQcOGjM8JeI4fK/TXFIEnOwNxdRYGmeJdGko2dmPl2M16M
         y64KzUp+57y1HHEr3TU4y1vGTYmraCUZyAQ50Ak6Y+xsOG4209GKsxSzid9eVMrC7p3I
         Yzlw3t3koqxSVCqsSMvPukz1GOgdwmNxwCc6oD5ADh6/yaMyJuuMlJs+Ns1rd7OCnTBR
         ssQYPAd6oy4NEf540AGC2QCOWUzaaemV8eLUmq6/10R7GZ4Imw/SrIlnV8KJQHSEbKz0
         KFkA==
X-Gm-Message-State: APjAAAXKymh42GdyA+hfSfsx/+rImDqmCloCk4G7WKzJrxp1v5pWtwgb
        lnkNCCk5qWgrh04GRfttMz6w3PZUtN8=
X-Google-Smtp-Source: APXvYqxeSWBAIQmtKu3LZAmez/8I0ha6YbZ1bPhln0NTkDdp3FYD3+2+P9KawBwJxG+vAKZtoq566w==
X-Received: by 2002:a63:f807:: with SMTP id n7mr86929749pgh.119.1564024035139;
        Wed, 24 Jul 2019 20:07:15 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id h6sm45272924pfb.20.2019.07.24.20.07.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 20:07:14 -0700 (PDT)
Date:   Thu, 25 Jul 2019 08:37:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>, kernel-team@android.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] OPP: Improve require-opps linking
Message-ID: <20190725030712.lx3cjogo5r7kc262@vireshk-i7>
References: <20190717222340.137578-1-saravanak@google.com>
 <20190717222340.137578-4-saravanak@google.com>
 <20190723102842.t2s45zzylsjuccm4@vireshk-i7>
 <CAGETcx-6M9Ts8tfMf6aA8GjMyzK5sOLr069ZCxTG7RHMFPLzHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx-6M9Ts8tfMf6aA8GjMyzK5sOLr069ZCxTG7RHMFPLzHw@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-07-19, 07:47, Saravana Kannan wrote:
> On Tue, Jul 23, 2019, 3:28 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> 
> > $subject doesn't have correct property name.
> >
> > On 17-07-19, 15:23, Saravana Kannan wrote:
> > > Currently, the linking of required-opps fails silently if the
> > > destination OPP table hasn't been added before the source OPP table is
> > > added. This puts an unnecessary requirement that the destination table
> > > be added before the source table is added.
> > >
> > > In reality, the destination table is needed only when we try to
> > > translate from source OPP to destination OPP. So, instead of
> > > completely failing, retry linking the tables when the translation is
> > > attempted.
> > >
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > ---
> > >  drivers/opp/core.c | 32 +++++++++++-----
> > >  drivers/opp/of.c   | 91 ++++++++++++++++++++++------------------------
> > >  drivers/opp/opp.h  |  5 +++
> > >  3 files changed, 71 insertions(+), 57 deletions(-)
> >
> > Here is the general feedback and requirements I have:
> >
> > - We shouldn't do it from _set_required_opps() but way earlier, it
> >   shouldn't affect the fast path (where we change the frequency).
> >
> 
> I don't think there's any other intermediate OPP call where we can try to
> link the tables. Also if there tables are already fully linked, this is
> just checking for not NULL for a few elements in the array.

We should be doing this whenever a new OPP table is created, and see
if someone else was waiting for this OPP table to come alive. Also we
must make sure that we do this linking only if the new OPP table has
its own required-opps links fixed, otherwise delay further.

> I don't think
> this is really going to allow down the fast path in anyway.

> If you have other ideas, I'm willing to look at it. But as it is right now
> seems the best to me.
> 
Even then I don't want to add these checks to those places. For the
opp-set-rate routine, add another flag to the OPP table which
indicates if we are ready to do dvfs or not and mark it true only
after the required-opps are all set.

-- 
viresh
