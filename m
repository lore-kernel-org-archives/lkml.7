Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813D0C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 00:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 513F420828
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 00:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KyTmnzEV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfGXATI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 20:19:08 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40165 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbfGXATI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 20:19:08 -0400
Received: by mail-ot1-f67.google.com with SMTP id 60so6445727otr.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 17:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HEWjLSp+3ZYUNuS4KEhJxXUV1NrMjDNJTyQjAT98l0c=;
        b=KyTmnzEVvpYk+8Vlka2lOIuadkdcTW/Tz8dySg662PkCDcfqcEtDIWJHSQjNaXMk0C
         haii7dxiHOazpNAsR3Z5uOs1P7uV2Vqw/MLZ02bTVjbLF8knC5hZGHCDpTU4NMPLpWuL
         Xhx3HY2Hw65F9lEzCn6KA48uIWF57MLOLQvoohWT9KUUMS/pA7OUMytCzoKMUioppvFj
         vWSTNw9ple229Kqqzr/vF/e++yp0Xaojca4wB+WeVU9cDFpKWtVztOMrEWXFACXsEgpL
         FOKqSw6cChnRDA39sXL1mdr0XGu4PW1KThKsddz652YlAEIG+ce02Vei72xDob9tgh9J
         HffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HEWjLSp+3ZYUNuS4KEhJxXUV1NrMjDNJTyQjAT98l0c=;
        b=ea2NUmhyc+NZwOZNgS/1vOiwyR3Is18bmnJ0TL5rUAPKPObzU2+H9LpUrg0FjExAfm
         XwyMCaej5uNkS5YAEPZzUM+T6M5CzAM8DpF7/gz14erfiPkAbvaFCNdMvDc2O6/+uZWW
         LKeO8IeG5ZRc828rrNLntTYKIVLsKqdT3OuW+C4FG0P1Ie4qOKsLn0VvzMm97XN2ZA96
         BLCGwX8RmLKfzw1naaEOC8dxP/0hl6bkKTPwtYXXcAZcHzOlUwx3MGZebVjf52y8a7Af
         DKo5OGFxSs68IRVpBUlvKptaa8zXGIsQ3ROY8JHqOCfXsz+VsJUD9uKtpgryr+PXX0TN
         jW3Q==
X-Gm-Message-State: APjAAAVEorL8W6HhcqhWX00kgwvSK1aEMYEWz/qvGNHqclOwt/fMZiMU
        zFlozDn1xXocfsqGxJn7DBAxyiA0D5C0Elepn4tMow==
X-Google-Smtp-Source: APXvYqzquNMPlzmL6KiNv9dmgPAQ6VX+Yc1CbsySXKc3HGl9ASNz/27eBQrBEGbA7tg6Cvx7smNnbzqfSRN1LoHdaAs=
X-Received: by 2002:a05:6830:160c:: with SMTP id g12mr2293485otr.231.1563927547521;
 Tue, 23 Jul 2019 17:19:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190703011020.151615-1-saravanak@google.com> <20190703011020.151615-2-saravanak@google.com>
 <98b2e315-e8da-80ad-1ef8-e6b222c1c6fe@codeaurora.org> <CAGETcx9KSqvyzbM-S8LvBObkNBt38K683Ljm8nNQuhxk7MuvAg@mail.gmail.com>
 <20190722233501.GA19594@bogus> <CAGETcx9GzQj0ZHNF+uR2cGHUkQ5sOPYEwyXKK1dJ2sJbHVSVyw@mail.gmail.com>
 <CAL_JsqJeGK2m6hVEqvFxW6dEhi22LXaRKgb5JmnJfmCp+J6XuA@mail.gmail.com>
In-Reply-To: <CAL_JsqJeGK2m6hVEqvFxW6dEhi22LXaRKgb5JmnJfmCp+J6XuA@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 23 Jul 2019 17:18:31 -0700
Message-ID: <CAGETcx9GkwDJHBuFBRheMqR80=JWnXa4xtPqQ+2xHcfvSd55+A@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: opp: Introduce opp-peak-KBps and
 opp-avg-KBps bindings
To:     Rob Herring <robh@kernel.org>
Cc:     Sibi Sankar <sibis@codeaurora.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Sweeney, Sean" <seansw@qti.qualcomm.com>,
        daidavid1@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 7:27 AM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Jul 22, 2019 at 5:41 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Mon, Jul 22, 2019 at 4:35 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Tue, Jul 16, 2019 at 11:58:08AM -0700, Saravana Kannan wrote:
> > > > On Tue, Jul 16, 2019 at 10:25 AM Sibi Sankar <sibis@codeaurora.org> wrote:
> > > > >
> > > > > Hey Saravana,
> > > > >
> > > > > https://patchwork.kernel.org/patch/10850815/
> > > > > There was already a discussion ^^ on how bandwidth bindings were to be
> > > > > named.
> > > >
> > > > Yes, I'm aware of that series. That series is trying to define a BW
> > > > mapping for an existing frequency OPP table. This patch is NOT about
> > > > adding a mapping to an existing table. This patch is about adding the
> > > > notion of BW OPP tables where BW is the "key" instead of "frequency".
> > > >
> > > > So let's not mixed up these two series.
> > >
> > > Maybe different reasons, but in the end we'd end up with 2 bandwidth
> > > properties. We need to sort out how they'd overlap/coexist.
> >
> > Oh, I totally agree! My point is that the other mapping isn't the
> > right approach because it doesn't handle a whole swath of use cases.
> > The one I'm proposing can act as a super set of the other (as in, can
> > handle that use case too).
> >
> > > The same comment in that series about defining a standard unit suffix
> > > also applies to this one.
> >
> > I thought I read that whole series and I don't remember reading about
> > the unit suffix. But I'll take a closer look. I've chosen to keep the
> > DT units at least as "high of a resolution" as what the APIs accept
> > today. The APIs take KB/s. So I make sure DT can capture KB/s
> > differences. If we all agree that KB/s is "too accurate" then I think
> > we should change everything to MB/s.
>
> Either one is fine with me, but trying to align to what the OS picked
> doesn't work. What does BSD use for example? More important is
> aligning across DT properties so we don't have folks picking whatever
> random unit they like. We generally try to go with the smallest units
> that will have enough (32-bit) range for everyone, so that's probably
> KB/s here.

Yeah, that makes sense.

-Saravana
