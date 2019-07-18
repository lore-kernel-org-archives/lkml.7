Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81403C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 17:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA2F2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 17:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s5g1Dyon"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732305AbfGRR0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 13:26:51 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41171 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbfGRR0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 13:26:50 -0400
Received: by mail-ot1-f66.google.com with SMTP id o101so29884624ota.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 10:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kHot347YLWE5nkm+ELe1ZYMvJsx/cZ07S4YDS0ZiX4U=;
        b=s5g1DyonFBqTLhJwl7Sl2aNMuX3Z9Tb6oahSwY6QyEWQmcNZ2SWhH8/MhiOzWgra4W
         n7tWEqkN7/dEqVLquoLllVRJtb3X27VKoRq7T5bGOrwjBRnia4Gt8kZdFSKfuAZ5n0s/
         5hRS9hcVjmm4FDGkJmXutN9jM+rb/7SxCj8SdLOW2JSn20yN2y4B72kvSn67Y0aISFZO
         K156I4nEPJMmpFMFfyyu6lQbwq5N1FVSFcYd107uvw9huZmEu150LjM3Nuexp41b/NO0
         XVwPCVMQXsRSWoeWr+e2c+KBMJO1tF8M1B/VFMSSw6gQMmhLWEFmXaSpUH9+eta7vS0l
         uuhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kHot347YLWE5nkm+ELe1ZYMvJsx/cZ07S4YDS0ZiX4U=;
        b=O8j1NXrBgIT42BRtl3alpv8bBER80Fbu6zrlRHmovGUmIkEH7Hbk/s9Er53Ttfg9rJ
         LXUFX3Y+sDTXNw1toMYXL/c9TUJJLPI7odWZVz3koc1O5IiaKQ+q938TW3cSxJF+M+AA
         xLAaBDBYweBP+KLA9UOKnzWfh2quJyy6mbx2L/Y5zGSsU0sabfVYHNqZk3vvX/djAg6w
         a/aBIck433h+1I/5dlQGOzKKv1/8jPBpdl/8NxVZvaUR15JCQ38uJhYa95JcvHtP+uO0
         eTsqQx4OSZZOtBlrXZsdN0YAWFGHfgyeEFMWK6WamqtNdO5t/Ms3yo6Qrnl2r0DBHpIE
         WaZQ==
X-Gm-Message-State: APjAAAWxIadiUUSS9kBcETXbD0LaMd1N5Lvk6Gy+iW0AmY+Tbzzg97Cm
        pHfZg+x9z616EXNdbDtps0XHoELRYhymUb4sxvFC0Q==
X-Google-Smtp-Source: APXvYqxx0wUv2PcQOeCnA7yH8Brpx911ipQxgRjsUz11FM8fMvCQ8Z/c5zcaSYTzAc9Lky0K9vcLBi7grFvfvHSwzro=
X-Received: by 2002:a05:6830:12d6:: with SMTP id a22mr7109834otq.236.1563470809129;
 Thu, 18 Jul 2019 10:26:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190703011020.151615-1-saravanak@google.com> <20190703011020.151615-2-saravanak@google.com>
 <20190717075448.xlyg2ddewlci3abg@vireshk-i7> <CAGETcx-kUM7MqNYowwNAL1Q0bnFzxPEO6yMg0YTkk16=OnPdmg@mail.gmail.com>
 <20190718043558.roi4j6jw5n4zkwky@vireshk-i7>
In-Reply-To: <20190718043558.roi4j6jw5n4zkwky@vireshk-i7>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 18 Jul 2019 10:26:13 -0700
Message-ID: <CAGETcx_XtA_-cjU6Ra1Jh4zgWJXBpHY+g_FdWvnFTW84e46D_w@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: opp: Introduce opp-peak-KBps and
 opp-avg-KBps bindings
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Sweeney, Sean" <seansw@qti.qualcomm.com>,
        daidavid1@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>,
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

On Wed, Jul 17, 2019 at 9:36 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 17-07-19, 13:29, Saravana Kannan wrote:
> > On Wed, Jul 17, 2019 at 12:54 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 02-07-19, 18:10, Saravana Kannan wrote:
> > > > Interconnects often quantify their performance points in terms of
> > > > bandwidth. So, add opp-peak-KBps (required) and opp-avg-KBps (optional) to
> > > > allow specifying Bandwidth OPP tables in DT.
> > > >
> > > > opp-peak-KBps is a required property that replace opp-hz for Bandwidth OPP
> > > > tables.
> > > >
> > > > opp-avg-KBps is an optional property that can be used in Bandwidth OPP
> > > > tables.
> > > >
> > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/opp/opp.txt | 15 ++++++++++++---
> > > >  1 file changed, 12 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> > > > index 76b6c79604a5..c869e87caa2a 100644
> > > > --- a/Documentation/devicetree/bindings/opp/opp.txt
> > > > +++ b/Documentation/devicetree/bindings/opp/opp.txt
> > > > @@ -83,9 +83,14 @@ properties.
> > > >
> > > >  Required properties:
> > > >  - opp-hz: Frequency in Hz, expressed as a 64-bit big-endian integer. This is a
> > > > -  required property for all device nodes but devices like power domains. The
> > > > -  power domain nodes must have another (implementation dependent) property which
> > > > -  uniquely identifies the OPP nodes.
> > > > +  required property for all device nodes but for devices like power domains or
> > > > +  bandwidth opp tables. The power domain nodes must have another (implementation
> > > > +  dependent) property which uniquely identifies the OPP nodes. The interconnect
> > > > +  opps are required to have the opp-peak-bw property.
> > >
> > >                                    ??
> >
> > Sorry, what's the question? Was this an accidental email?
>
> Too much smartness is too bad sometimes, sorry about that :)
>
> I placed the ?? right below "opp-peak-bw", there is no property like
> that. You failed to update it :)

Ah, "typo". I'll fix it.

-Saravana
