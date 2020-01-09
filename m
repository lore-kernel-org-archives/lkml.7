Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8723DC33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 00:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ED38206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 00:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j3Da9P8d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbgAIAcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 19:32:41 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45779 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbgAIAcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 19:32:41 -0500
Received: by mail-ot1-f68.google.com with SMTP id 59so5455525otp.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 16:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JR/KjA7bK/5h1lh8mNM1kPx+FAOViYqnY1kccdyZdpw=;
        b=j3Da9P8d6imGyd0RYW8XhpvMCLsnXjixXfOCLE3kkbxwt1ezf4AwTmT7cEHJyR3X76
         WaENdtnmoyTLZkc9+2qBd/HwZksA2/TAv4sm0QDsCkDDKJfC5dRhEU7dSE65q/6UEJrQ
         fTc5jJhrsn68YZmWE6QCc8hPsC49BA/vfvgwscRgULKmYnNp7Ku8jYVMZpZuQhojobWe
         7VEhv5inC6tLvFVwc5hXLh/Ml4bMs4pxNIRenfeWVj/gWRSr1Uz3pZbw9qp8TWL/vAK/
         OQYD+roonfdZoU4Yrnq6Lj02lb/0P9RzkTndH5AzDkPJWe6Q0xo9qBlQeikjmB5BfA1P
         Sj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JR/KjA7bK/5h1lh8mNM1kPx+FAOViYqnY1kccdyZdpw=;
        b=X8WAyb6iicobhiw+waTv31h1IWxOeKaMew6F9feOtBfrAvSlrUV9XagvhX/j0BuB5Y
         MLaSmlhXXeySbr/rquQQ9LAc2tGgUX12FoD6Zwhg8x1b+6y8f3q0+WBSWNNWjBwVBOKL
         sIn36mLHaGTRVYe3odF2AMaSnX6CKvF9eZFG5C4UwzJgcGSUbHxDRf1Z1+LOfVeZCpHB
         KCazfWXeZjeuld4wvxuQmR+z4MuzjEehdW5BNk6n5hdFqH+uAjyFaP2Uyj0whj9zTumO
         pfvlFktKdaGAkM51qugiuDvA9qeVyGYNLEBNryMut6ME959oDLWkp9x6uQwhFp70iAN2
         TfIQ==
X-Gm-Message-State: APjAAAWl4APUE4JaLGAdWDyw5qP4xk+pIzyrZJichg0j2zoAAQpuUwTA
        81u9sQsXbKdT6YiVhryC2G3/vqZDJ71WHhKr/Mb3+Q==
X-Google-Smtp-Source: APXvYqwCihk5u4K5/SRutO9DNp8bfrDx57oO32s94aeDDqmeM0UX5oFd6QJyaXZ8ATE8dF9bYKlJVbqXEUPF7PCj5Xg=
X-Received: by 2002:a05:6830:1e09:: with SMTP id s9mr6498126otr.139.1578529959892;
 Wed, 08 Jan 2020 16:32:39 -0800 (PST)
MIME-Version: 1.0
References: <20191207002424.201796-1-saravanak@google.com> <20191207002424.201796-2-saravanak@google.com>
 <20200108103210.oyrqxlybrdbelkne@vireshk-i7>
In-Reply-To: <20200108103210.oyrqxlybrdbelkne@vireshk-i7>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 8 Jan 2020 16:32:03 -0800
Message-ID: <CAGETcx-fcKmMj4YF7U+zqr47zhAVoSTG_2R-1szik6nVqLykhg@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] dt-bindings: opp: Introduce opp-peak-kBps and
 opp-avg-kBps bindings
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Sweeney, Sean" <seansw@qti.qualcomm.com>,
        David Dai <daidavid1@codeaurora.org>, adharmap@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 8, 2020 at 2:32 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 06-12-19, 16:24, Saravana Kannan wrote:
> > Interconnects often quantify their performance points in terms of
> > bandwidth. So, add opp-peak-kBps (required) and opp-avg-kBps (optional) to
> > allow specifying Bandwidth OPP tables in DT.
> >
> > opp-peak-kBps is a required property that replaces opp-hz for Bandwidth OPP
> > tables.
> >
> > opp-avg-kBps is an optional property that can be used in Bandwidth OPP
> > tables.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/opp/opp.txt     | 15 ++++++++++++---
> >  .../devicetree/bindings/property-units.txt        |  4 ++++
> >  2 files changed, 16 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> > index 68592271461f..dbad8eb6c746 100644
> > --- a/Documentation/devicetree/bindings/opp/opp.txt
> > +++ b/Documentation/devicetree/bindings/opp/opp.txt
> > @@ -83,9 +83,14 @@ properties.
> >
> >  Required properties:
> >  - opp-hz: Frequency in Hz, expressed as a 64-bit big-endian integer. This is a
> > -  required property for all device nodes but devices like power domains. The
> > -  power domain nodes must have another (implementation dependent) property which
> > -  uniquely identifies the OPP nodes.
> > +  required property for all device nodes except for devices like power domains
> > +  or bandwidth opp tables.
>
> Fine until here.
>
> > The power domain nodes must have another
> > +  (implementation dependent) property which uniquely identifies the OPP nodes.
> > +  The interconnect opps are required to have the opp-peak-kBps property.
>
> Maybe rewrite it as:
>
> The devices which don't have this property must have another
> (implementation dependent) property which uniquely identifies the OPP
> nodes.
>
> So we won't be required to update this again for another property.
>
> > +
> > +- opp-peak-kBps: Peak bandwidth in kilobytes per second, expressed as a 32-bit
> > +  big-endian integer.
>
> > This is a required property for all devices that don't
> > +  have opp-hz.
>
> This statement is surely incorrect, isn't it ? What about power-domain
> tables ?
>
> Suggest rewriting it as:
>
> This is a required property for bandwidth OPP tables.
>

Agree with all the suggestions. Will fix in the next version.

-Saravana
