Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641C6C76191
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BBBB218B8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qWMt+4nu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388452AbfGZTJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 15:09:19 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44278 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387570AbfGZTJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 15:09:19 -0400
Received: by mail-oi1-f196.google.com with SMTP id e189so40883189oib.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 12:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uMjbCjRJe2QgOB++4gB2dFB5TOTHSYGv6ueksF05DF0=;
        b=qWMt+4nuD+G9wfkiBLqhatMdGiIGjryWvl4VemHGe+lra/XPFxrFP5BtycXgdkp8ln
         F4I0fhvcwv14Fr6GtboQALGSmOYnTFO+mIqfR0J8CTVrRip2x4MhWOBIR/1pmRacGii1
         MQ6Cvcu5EpljkPhvpcXz64TQVz9utpvHamAaPCqZTR/p5e5yQgWzA99hH5p9nQYRphdd
         bqWc9lBJlNTjfydL2L1WyLx0O2ma8c9Rkyi8FsG3avLsayUt+RkZQta5K8mbjvt+AqBa
         3MMh4G3EPbZtldkEXTOLj+5W1q0AhnZ+/shafrDXI1id10d9gHDUvWoknJ1/JLSytEQh
         nCUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uMjbCjRJe2QgOB++4gB2dFB5TOTHSYGv6ueksF05DF0=;
        b=Njk6zPatZpLh8WvOEIiYOk5DVy9ZN2e65mYswQUdIGXkN3ncQMoeA9b5KcAx1GpP7L
         gDUQyrnpGVNl4yVdc2I5xHRDBUjKDJS1UJsDHEer74hlxH0ax4zfQVeB9sTQynZ3ByDh
         aCkbRd6bsdDbxB/z79HJLqegkalH0r5xhxyFSFZ6JATqD+7OOw7BXGsqGPgCvS4h6VY2
         p/BHmWxWVaM0B0Zg62HmNpKkpRv+y2vD3o7qJjXZmi57Kto2oCPRzyNeTzz91ll51Stw
         eY0wHA4sE1Xprc3YBFGp0zEZWyfLckZwWmGOj/QIQFBgEkIqyWC6okO8eEu9hBYNHbjz
         akLw==
X-Gm-Message-State: APjAAAVQLiObu3hYAQfhQoQH8ezwntiphue2wf0TJyqw4pdptmz15X09
        TfNceKRH1kA1b5XIy0qNUafdv5Le+e9cZUWQ61ATAg==
X-Google-Smtp-Source: APXvYqzMJYSItiK2iXqdRerPLeNrhU2MqqSk/R0D+pqt82QICG41qW0Z72u3gFc+QshDm3bifpp8U2mEOYts446GMB8=
X-Received: by 2002:aca:d8c2:: with SMTP id p185mr49094053oig.30.1564168157686;
 Fri, 26 Jul 2019 12:09:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190703011020.151615-1-saravanak@google.com> <20190703011020.151615-2-saravanak@google.com>
 <2befbd75-e0f4-dbcc-e9b1-9a9f99c084d3@linaro.org>
In-Reply-To: <2befbd75-e0f4-dbcc-e9b1-9a9f99c084d3@linaro.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 26 Jul 2019 12:08:41 -0700
Message-ID: <CAGETcx8X2XuC5E2pxRU_7fTXYYJ+8hD-_TRvUPh5sE+oGPWgfA@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: opp: Introduce opp-peak-KBps and
 opp-avg-KBps bindings
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Sweeney, Sean" <seansw@qti.qualcomm.com>,
        David Dai <daidavid1@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
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

On Fri, Jul 26, 2019 at 9:24 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Hi Saravana,
>
> On 7/3/19 04:10, Saravana Kannan wrote:
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
> >  Documentation/devicetree/bindings/opp/opp.txt | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> > index 76b6c79604a5..c869e87caa2a 100644
> > --- a/Documentation/devicetree/bindings/opp/opp.txt
> > +++ b/Documentation/devicetree/bindings/opp/opp.txt
> > @@ -83,9 +83,14 @@ properties.
> >
> >  Required properties:
> >  - opp-hz: Frequency in Hz, expressed as a 64-bit big-endian integer. This is a
> > -  required property for all device nodes but devices like power domains. The
> > -  power domain nodes must have another (implementation dependent) property which
> > -  uniquely identifies the OPP nodes.
> > +  required property for all device nodes but for devices like power domains or
> > +  bandwidth opp tables. The power domain nodes must have another (implementation
> > +  dependent) property which uniquely identifies the OPP nodes. The interconnect
> > +  opps are required to have the opp-peak-bw property.
> > +
> > +- opp-peak-KBps: Peak bandwidth in kilobytes per second, expressed as a 32-bit
>
> As Rob already mentioned, KBps should be documented. See [1].
>

Will do. Thanks for the pointer.

-Saravana
