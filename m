Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25964C10F13
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 00:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4EA92176F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 00:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fOEziz36"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730838AbfDQAKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 20:10:07 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34128 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728809AbfDQAKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 20:10:07 -0400
Received: by mail-oi1-f196.google.com with SMTP id v10so18588178oib.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 17:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tG11UApdE0fZ4fVm41WgSBkQ06LNXRSNBVicUfVujoU=;
        b=fOEziz36jffSVEOWsf1VF+wDilWAyDEP7f5cuS7YOeGKMvNglWFiCeJgJT4CZXSA7K
         q224hGCSQlQJwXjReHij8tD9J/KBh0w2aUH2jLbt/qRJ+50yGoxrxxvse9TlkROC3ghl
         oC0A/yVS5LFpith7m7/BdrAwy++1++xst85PnIj0daoojkMoXWWuAIrzlISd55CHrcku
         85FA2pEz8gVyScOYAkfVaqHKnY/gsBFtKZAWV/sRP4HlhfsJl26gRSyXtayUp38GyulC
         A1cFhgClHImUTthA3JdTm6VIw1kJdniqqlU3PL1jWAK16jtuoFfXvyuHDHQbQuGsfe+O
         6yqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tG11UApdE0fZ4fVm41WgSBkQ06LNXRSNBVicUfVujoU=;
        b=U2YBMm0RxDBxsCsF0ZeRGufw5mEiViKUf62T2SnOVLS8dXhv1Ds9Yj3IqkiDSqQYBL
         JSUt6GYzZv62IXyK6L+zAbKgHWS0co5qIQGTFF89bqLOQuwCSmRPLfez1qlOtvk79Ib9
         mGfngoDvl9sthHotRPV8gdSDSc81JCXjdSuowdN5uKHO22ndZYKybMw9ClF97Kt9IX3J
         /4U0JtOvctNIplJpAoje7prr40LziDjzShhOKmLfZndRFviSNttDMz2UoHL8lSdIMgym
         Ub4giz87E4IAD8F2c+rufRHHYvtivL3eRrw8mBuptMxbConj8QnL0HyMwoxRW9fO8Pqj
         U9pw==
X-Gm-Message-State: APjAAAX4o6DN39c3AtiXaYG8yHlkd9Lfjg3m2hMcWweR2XdihV3S7X4R
        PBNdXY1iIFGFrfxGHychigO6kQ==
X-Google-Smtp-Source: APXvYqzG9eUioj55pOe05u86Q4URqNNLOizYdSOIkbebbmiHcoErmhEqLUSgeubaBc90wPLp18e48Q==
X-Received: by 2002:aca:5184:: with SMTP id f126mr24879419oib.44.1555459806092;
        Tue, 16 Apr 2019 17:10:06 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li808-42.members.linode.com. [104.237.132.42])
        by smtp.gmail.com with ESMTPSA id q23sm22714722oic.45.2019.04.16.17.10.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 17:10:04 -0700 (PDT)
Date:   Wed, 17 Apr 2019 08:09:59 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/4] dt-bindings: arm: coresight: Add new compatible
 for static replicator
Message-ID: <20190417000959.GB6202@leoy-ThinkPad-X240s>
References: <20190412102738.12679-1-leo.yan@linaro.org>
 <20190412102738.12679-2-leo.yan@linaro.org>
 <CANLsYkw1vaevcJZfjQfF9BeUvi1THGNtu+SH+LR008LjZOc7fA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkw1vaevcJZfjQfF9BeUvi1THGNtu+SH+LR008LjZOc7fA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 02:18:40PM -0600, Mathieu Poirier wrote:
> Hi Leo,
> 
> On Fri, 12 Apr 2019 at 04:28, Leo Yan <leo.yan@linaro.org> wrote:
> >
> > CoreSight uses below bindings for replicator:
> >
> >   Dynamic replicator, aka. configurable replicator:
> >     "arm,coresight-dynamic-replicator", "arm,primecell";
> >
> >   Static replicator, aka. non-configurable replicator:
> >     "arm,coresight-replicator";
> >
> > The compatible string "arm,coresight-replicator" is not an explicit
> > naming to express the replicator is 'static'.  To unify the naming
> > convention, this patch introduces a new compatible string
> > "arm,coresight-static-replicator" for the static replicator; the
> > compatible string "arm,coresight-replicator" is kept for backward
> > compatibility, but tag it as obsolete and suggest to use the new
> > compatible string.
> >
> > As result CoreSight replicator have below bindings:
> >
> >   Dynamic replicator:
> >     "arm,coresight-dynamic-replicator", "arm,primecell";
> >
> >   Static replicator:
> >     "arm,coresight-static-replicator";
> >     "arm,coresight-replicator"; (obsolete)
> >
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/arm/coresight.txt | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
> > index f8aff65ab921..d02d160fa8ac 100644
> > --- a/Documentation/devicetree/bindings/arm/coresight.txt
> > +++ b/Documentation/devicetree/bindings/arm/coresight.txt
> > @@ -69,7 +69,10 @@ its hardware characteristcs.
> >
> >         * compatible: Currently supported value is (note the absence of the
> >           AMBA markee):
> > -               - "arm,coresight-replicator"
> > +               - Coresight Non-configurable Replicator:
> > +                       "arm,coresight-static-replicator";
> > +                       "arm,coresight-replicator"; (OBSOLETE. For backward
> > +                               compatibility and will be removed)
> >
> >         * port or ports: see "Graph bindings for Coresight" below.
> >
> > @@ -169,7 +172,7 @@ Example:
> >                 /* non-configurable replicators don't show up on the
> >                  * AMBA bus.  As such no need to add "arm,primecell".
> >                  */
> > -               compatible = "arm,coresight-replicator";
> > +               compatible = "arm,coresight-static-replicator";
> >
> >                 out-ports {
> >                         #address-cells = <1>;
> > --
> > 2.17.1
> 
> Since this is a binding patch it needs to be sent on its own.

Thanks for reminding, Mathieu.

Since this is the second time you remind me to send DT binding related
patches separately, so I may misunderstand your meaning and want to get
clarification to avoid making the same mistake for many times.

Before I remembered in one patch set we need to organise patches with
sending document patch (or document changing patch) ahead and then
followed by the corresponding code change patch.  So this can give the
reviewers more clear context;  and this also can present the merging
dependency between document change patches and the code change patches.

This is the rule I followed in this patch set and I sent to CoreSight
and DT maintainers (and mailing lists) together.

Please let me know what you think about this?  And also welcome
Rob/Mark's suggestions.

Thanks,
Leo Yan
