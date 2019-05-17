Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901FEC04E87
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 21:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E31216C4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 21:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J6sBCDZE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbfEQVzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 17:55:21 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41841 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729594AbfEQVzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 17:55:21 -0400
Received: by mail-pl1-f196.google.com with SMTP id f12so3922184plt.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 14:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=3cmDmKVrpmOZMNgPRAiH0olqmC9Yh+Gmdf/HadyohC4=;
        b=J6sBCDZEcDFHQljhONfwZsgtsfwSoAQY/BmYrJ9Df8UUnT54h3T2+eZsxV5rHjLhSt
         gsEPT4lke+v+APQlrZCxIn4+A4jvnTSS7HiMae4+5DVhMVIiML1iXWIYyz6mP7E9bSa/
         hJYSNflLuHdJBE65HxtMr6Q6fCKRPt8A47avk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=3cmDmKVrpmOZMNgPRAiH0olqmC9Yh+Gmdf/HadyohC4=;
        b=RA122x/os/10Gjl9tUazeqBUJ6LkT+XwohajxOVIvyzNIPQmPC+1tnvM6096YJYoDX
         xxu8hAo3fWmjtrN79Ohs6agiRP4wHW2E0NDNUWvaKk7t7QyR+cSW3jbTW542bVJBSyME
         PZjSis6bRaKcqIG6Fx2Xo0UWCyIsYsOOJ8K1mmUF+mYNKv/VoA6e6d2AoqITT+ytR4Ma
         KTEBiWdD1ZOP7S11z/2Sd39ct1G9wFUyEzkM41Fu+u2alrOrTQeAhPyLbiOnDXpGQ0jZ
         J9rOIBcFH0DkilwOYOtT7pKB98ifLc1O15X3N92W82vDTmvPbmiuUvt2jO7MIg3DdbIb
         UGpg==
X-Gm-Message-State: APjAAAWpTlgAe+DhuiPfXUdyJlLV7sbRyMqCQZq2GRZgZ9Ij/5vomvD9
        /fT8COwuJcf+BRsjS7Ib1GemAg==
X-Google-Smtp-Source: APXvYqw9MkFyQZykC6TAt/08Rk/EnsGsIC2de8Bs+rNwfZLiGzHmFC8ZPpTfd4rxAE6RGMd2uFlcaw==
X-Received: by 2002:a17:902:868c:: with SMTP id g12mr42106151plo.323.1558130120619;
        Fri, 17 May 2019 14:55:20 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id e73sm9564668pfh.59.2019.05.17.14.55.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 May 2019 14:55:20 -0700 (PDT)
Message-ID: <5cdf2dc8.1c69fb81.521c8.9339@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAHLCerP69Jw27VyO+ek4Fe3-2fDiOejtz6XZPykPSRA2G1831w@mail.gmail.com>
References: <20190114184255.258318-1-mka@chromium.org> <CAHLCerP+F9AP97+qVCMqwu-OMJXRhwZrXd33Wk-vj5eyyw-KyA@mail.gmail.com> <CAHLCerPZ0Y-rkeMa_7BJWtR4g5af2vwfPY9FgOuvpUTJG3rf7g@mail.gmail.com> <155786856719.14659.2902538189660269078@swboyd.mtv.corp.google.com> <CAHLCerP69Jw27VyO+ek4Fe3-2fDiOejtz6XZPykPSRA2G1831w@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: sdm845: Add CPU topology
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>
User-Agent: alot/0.8.1
Date:   Fri, 17 May 2019 14:55:19 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Kucheria (2019-05-16 04:54:45)
> (cc'ing Andy's correct email address)
>=20
> On Wed, May 15, 2019 at 2:46 AM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Amit Kucheria (2019-05-13 04:54:12)
> > > On Mon, May 13, 2019 at 4:31 PM Amit Kucheria <amit.kucheria@linaro.o=
rg> wrote:
> > > >
> > > > On Tue, Jan 15, 2019 at 12:13 AM Matthias Kaehlcke <mka@chromium.or=
g> wrote:
> > > > >
> > > > > The 8 CPU cores of the SDM845 are organized in two clusters of 4 =
big
> > > > > ("gold") and 4 little ("silver") cores. Add a cpu-map node to the=
 DT
> > > > > that describes this topology.
> > > >
> > > > This is partly true. There are two groups of gold and silver cores,
> > > > but AFAICT they are in a single cluster, not two separate ones. SDM=
845
> > > > is one of the early examples of ARM's Dynamiq architecture.
> > > >
> > > > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > >
> > > > I noticed that this patch sneaked through for this merge window but
> > > > perhaps we can whip up a quick fix for -rc2?
> > > >
> > >
> > > And please find attached a patch to fix this up. Andy, since this
> > > hasn't landed yet (can we still squash this into the original patch?),
> > > I couldn't add a Fixes tag.
> > >
> >
> > I had the same concern. Thanks for catching this. I suspect this must
> > cause some problem for IPA given that it can't discern between the big
> > and little "power clusters"?
>=20
> Both EAS and IPA, I believe. It influences the scheduler's view of the
> the topology.

And EAS and IPA are OK with the real topology? I'm just curious if
changing the topology to reflect reality will be a problem for those
two.

