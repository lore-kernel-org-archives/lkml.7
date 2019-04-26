Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0F3C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E84AF206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556288712;
	bh=Cnm5KPIVPM3vConaC0o1H4zR60vCgu7zQshIIzNrT1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IgAUPg7HKv0bw80tpM3oVthmBI/q4GwD++Vws+eNLj6fJDPBqKZb1Otr3t6gymykp
	 zsLlWvClXq+0KMBM8h2qfPfbOgqxCSkZmE4zTeyc/5FN5HnHxoXdkee9nMdsotKlmW
	 TntdEKNznct/j2Qf7RLPfkj9i1B/9+LQnrYJ7rgM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfDZOZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:25:10 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41695 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfDZOZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:25:10 -0400
Received: by mail-oi1-f193.google.com with SMTP id v23so2911652oif.8;
        Fri, 26 Apr 2019 07:25:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aWqo1UFpmIRDnB30jQmwpXG9gfEZ8sd9ampIb2LCeW0=;
        b=IGKMhg+okGY9eAHvJEJyCCGF7hR97eax/mrW6vgWLnRPKica4zNRkm+1gtsaxQkYMW
         /tWw+C4oLGNyPQRpCSovrc5ij3k4jKGPn3oBbcsbluwOrY43ko8YilKYKpdD4T6Yn0Yu
         fXrRMiCaxWCQBqq1hcUYmS9QLDD/JKZQ0oPAWy5TAXKKLabJN7prjT3tiAnQpUkq12I9
         OuQ/kq/r+HZm5JBVOdLzsLiWVNd6YTRl01E0j19K/8pTu0UHTDcVc0Upm0VXTj3VYSyI
         U0AB3kjkSakWGdYdi/9o57JTfbVY1Ti+/W3rvt8Vn4KP5GfWeELUs+Q6Sqx68XOYfRpZ
         rpaA==
X-Gm-Message-State: APjAAAUddGsp86WVI2F8c67EHi6aVMBYHlDBwOYJG1NaAMNkAIplPEur
        wt0CeepbmHWCsbDJUCzLArSsD7M=
X-Google-Smtp-Source: APXvYqzifDIBM00sH2axs4WjBsHqjbsl0SmPUGcKtuYwcX8xiXqAJprl61Bjq2AERdHwoJj1H18wNQ==
X-Received: by 2002:aca:544b:: with SMTP id i72mr6708318oib.51.1556288708767;
        Fri, 26 Apr 2019 07:25:08 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b17sm10440879otq.26.2019.04.26.07.25.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 07:25:08 -0700 (PDT)
Date:   Fri, 26 Apr 2019 09:25:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/4] dt-bindings: arm: coresight: Add new compatible
 for static replicator
Message-ID: <20190426142507.GA8721@bogus>
References: <20190412102738.12679-1-leo.yan@linaro.org>
 <20190412102738.12679-2-leo.yan@linaro.org>
 <CANLsYkw1vaevcJZfjQfF9BeUvi1THGNtu+SH+LR008LjZOc7fA@mail.gmail.com>
 <20190417000959.GB6202@leoy-ThinkPad-X240s>
 <CANLsYkwEBmn519ey-Vg-4-yfKFCaZv8kTDZ4sWpVzNTBOdtC=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkwEBmn519ey-Vg-4-yfKFCaZv8kTDZ4sWpVzNTBOdtC=g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 07:57:50AM -0600, Mathieu Poirier wrote:
> On Tue, 16 Apr 2019 at 18:10, Leo Yan <leo.yan@linaro.org> wrote:
> >
> > On Tue, Apr 16, 2019 at 02:18:40PM -0600, Mathieu Poirier wrote:
> > > Hi Leo,
> > >
> > > On Fri, 12 Apr 2019 at 04:28, Leo Yan <leo.yan@linaro.org> wrote:
> > > >
> > > > CoreSight uses below bindings for replicator:
> > > >
> > > >   Dynamic replicator, aka. configurable replicator:
> > > >     "arm,coresight-dynamic-replicator", "arm,primecell";
> > > >
> > > >   Static replicator, aka. non-configurable replicator:
> > > >     "arm,coresight-replicator";
> > > >
> > > > The compatible string "arm,coresight-replicator" is not an explicit
> > > > naming to express the replicator is 'static'.  To unify the naming
> > > > convention, this patch introduces a new compatible string
> > > > "arm,coresight-static-replicator" for the static replicator; the
> > > > compatible string "arm,coresight-replicator" is kept for backward
> > > > compatibility, but tag it as obsolete and suggest to use the new
> > > > compatible string.
> > > >
> > > > As result CoreSight replicator have below bindings:
> > > >
> > > >   Dynamic replicator:
> > > >     "arm,coresight-dynamic-replicator", "arm,primecell";
> > > >
> > > >   Static replicator:
> > > >     "arm,coresight-static-replicator";
> > > >     "arm,coresight-replicator"; (obsolete)
> > > >
> > > > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > > > ---
> > > >  Documentation/devicetree/bindings/arm/coresight.txt | 7 +++++--
> > > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
> > > > index f8aff65ab921..d02d160fa8ac 100644
> > > > --- a/Documentation/devicetree/bindings/arm/coresight.txt
> > > > +++ b/Documentation/devicetree/bindings/arm/coresight.txt
> > > > @@ -69,7 +69,10 @@ its hardware characteristcs.
> > > >
> > > >         * compatible: Currently supported value is (note the absence of the
> > > >           AMBA markee):
> > > > -               - "arm,coresight-replicator"
> > > > +               - Coresight Non-configurable Replicator:
> > > > +                       "arm,coresight-static-replicator";
> > > > +                       "arm,coresight-replicator"; (OBSOLETE. For backward
> > > > +                               compatibility and will be removed)
> > > >
> > > >         * port or ports: see "Graph bindings for Coresight" below.
> > > >
> > > > @@ -169,7 +172,7 @@ Example:
> > > >                 /* non-configurable replicators don't show up on the
> > > >                  * AMBA bus.  As such no need to add "arm,primecell".
> > > >                  */
> > > > -               compatible = "arm,coresight-replicator";
> > > > +               compatible = "arm,coresight-static-replicator";
> > > >
> > > >                 out-ports {
> > > >                         #address-cells = <1>;
> > > > --
> > > > 2.17.1
> > >
> > > Since this is a binding patch it needs to be sent on its own.
> >
> > Thanks for reminding, Mathieu.
> >
> > Since this is the second time you remind me to send DT binding related
> > patches separately, so I may misunderstand your meaning and want to get
> > clarification to avoid making the same mistake for many times.
> >
> > Before I remembered in one patch set we need to organise patches with
> > sending document patch (or document changing patch) ahead and then
> > followed by the corresponding code change patch.  So this can give the
> > reviewers more clear context;  and this also can present the merging
> > dependency between document change patches and the code change patches.
> >
> > This is the rule I followed in this patch set and I sent to CoreSight
> > and DT maintainers (and mailing lists) together.
> >
> > Please let me know what you think about this?  And also welcome
> > Rob/Mark's suggestions.
> 
> https://www.kernel.org/doc/Documentation/devicetree/bindings/submitting-patches.txt

I'm not clear on what you are asking for. Binding patches should be 
separate patch, but can and should still be in a series if there's 
relevant code changes.

Rob
