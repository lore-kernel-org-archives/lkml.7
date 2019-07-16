Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5CCC76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 18:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E84EF20665
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 18:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N48FQRXz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388481AbfGPS6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 14:58:45 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34280 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728672AbfGPS6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 14:58:45 -0400
Received: by mail-oi1-f194.google.com with SMTP id l12so16464336oil.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 11:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bKqvJ4KVvMjZevsjiH9ZbBIG3O/bWHc4fStP7VeXPqo=;
        b=N48FQRXzdJ0h2mmJ3Zu+1ca6vXioLCPWbJNDsqs2sjjBeE0x70GmtJG0N3iiBUAxaw
         YDYmjybPLcsokdIDwwCx+rSIvAPeEIMkomRZbABlmW7+EEWMppv1Vh/BMwICt+r96JmV
         3Yi8yhGJK0xq3FnjXl5FIyMXtUlV+XCXarAbDCe1DBsSuHzr4STvdk1cpPVAr+TU2FeN
         vxR7KOxDGizVbKa+nY57AR1SvEJVYKZlxFRs8SPX+oxxY98PdcaoMsjbkaSSLMc1oGzT
         GkFuX/d7KXofUK630+e/vQ0OBjdCBs7xhGG+ss1ZJVlkJip5rnLoUr8izDC8SacIWn2l
         mgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bKqvJ4KVvMjZevsjiH9ZbBIG3O/bWHc4fStP7VeXPqo=;
        b=C8UAiR6TEC/oCOn/tLp6YwfD4lDjvK5+p7MyL6nXvAw/AzoSqsxKwSPQVo0OWIEGSL
         vYI7lIGOPM7D1CTJyA304aooYTLH4AHOuc9E0JGS6UcuiU+8QEa+N3shtxr1tT8I/b9v
         kidklA13a8jKk59P7KHs2cRnH+4tNoc9hbAHO+uEh+RH9m6pexqBRXzv+34Om87TJ+xL
         twmxWfOf9ifmYhbGAxquUAnoSVRU1SLz4OVoseTHizXJdgBqY/lQbquGww2v+EzgJdR7
         vlt4UW9YXZcCEy1AxWSdD8KWshzNIK6qh5Aasgg8YcptKGUEJVUSVf3IrXL8hdvAr5J8
         FQQQ==
X-Gm-Message-State: APjAAAW4PriPlJycnX/mcNd9wCEhbjh7nW6Sk36XMeHZw9Iv0FpQ7P4k
        AJiYAQt2o3PUxleqHnGvngzEu5/lQWRdxdCtjB5UTg==
X-Google-Smtp-Source: APXvYqxMQR/81HXmnAExIUv5kJyXmc10HoZQ6gjI2/nHBupxL139pCza9qYN/IuwOoitZ2NX9Ti/aFO2OkrTJ7DlOzc=
X-Received: by 2002:aca:5106:: with SMTP id f6mr18154752oib.69.1563303523968;
 Tue, 16 Jul 2019 11:58:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190703011020.151615-1-saravanak@google.com> <20190703011020.151615-2-saravanak@google.com>
 <98b2e315-e8da-80ad-1ef8-e6b222c1c6fe@codeaurora.org>
In-Reply-To: <98b2e315-e8da-80ad-1ef8-e6b222c1c6fe@codeaurora.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 16 Jul 2019 11:58:08 -0700
Message-ID: <CAGETcx9KSqvyzbM-S8LvBObkNBt38K683Ljm8nNQuhxk7MuvAg@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: opp: Introduce opp-peak-KBps and
 opp-avg-KBps bindings
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
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

On Tue, Jul 16, 2019 at 10:25 AM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> Hey Saravana,
>
> https://patchwork.kernel.org/patch/10850815/
> There was already a discussion ^^ on how bandwidth bindings were to be
> named.

Yes, I'm aware of that series. That series is trying to define a BW
mapping for an existing frequency OPP table. This patch is NOT about
adding a mapping to an existing table. This patch is about adding the
notion of BW OPP tables where BW is the "key" instead of "frequency".

So let's not mixed up these two series.

-Saravana

> On 7/3/19 6:40 AM, Saravana Kannan wrote:
> > Interconnects often quantify their performance points in terms of
> > bandwidth. So, add opp-peak-KBps (required) and opp-avg-KBps (optional) to
> > allow specifying Bandwidth OPP tables in DT.
> >
> > opp-peak-KBps is a required property that replace opp-hz for Bandwidth OPP
> > tables.
> >
> > opp-avg-KBps is an optional property that can be used in Bandwidth OPP
> > tables.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >   Documentation/devicetree/bindings/opp/opp.txt | 15 ++++++++++++---
> >   1 file changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> > index 76b6c79604a5..c869e87caa2a 100644
> > --- a/Documentation/devicetree/bindings/opp/opp.txt
> > +++ b/Documentation/devicetree/bindings/opp/opp.txt
> > @@ -83,9 +83,14 @@ properties.
> >
> >   Required properties:
> >   - opp-hz: Frequency in Hz, expressed as a 64-bit big-endian integer. This is a
> > -  required property for all device nodes but devices like power domains. The
> > -  power domain nodes must have another (implementation dependent) property which
> > -  uniquely identifies the OPP nodes.
> > +  required property for all device nodes but for devices like power domains or
> > +  bandwidth opp tables. The power domain nodes must have another (implementation
> > +  dependent) property which uniquely identifies the OPP nodes. The interconnect
> > +  opps are required to have the opp-peak-bw property.
> > +
> > +- opp-peak-KBps: Peak bandwidth in kilobytes per second, expressed as a 32-bit
> > +  big-endian integer. This is a required property for all devices that don't
> > +  have opp-hz. For example, bandwidth OPP tables for interconnect paths.
> >
> >   Optional properties:
> >   - opp-microvolt: voltage in micro Volts.
> > @@ -132,6 +137,10 @@ Optional properties:
> >   - opp-level: A value representing the performance level of the device,
> >     expressed as a 32-bit integer.
> >
> > +- opp-avg-KBps: Average bandwidth in kilobytes per second, expressed as a
> > +  32-bit big-endian integer. This property is only meaningful in OPP tables
> > +  where opp-peak-KBps is present.
> > +
> >   - clock-latency-ns: Specifies the maximum possible transition latency (in
> >     nanoseconds) for switching to this OPP from any other OPP.
> >
> >
>
> --
> Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc, is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
