Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6A2C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C573F206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tHtvYLxi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732318AbfDQN6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 09:58:02 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:56038 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729940AbfDQN6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 09:58:01 -0400
Received: by mail-it1-f194.google.com with SMTP id y134so4673278itc.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 06:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r5h32+drSoE54EyvHLyIsrM6JZG0yPGOI/3krhxwzbQ=;
        b=tHtvYLxiK8ft+wJ7IbmVKufEezCX/JUVctfVpTD7kQ89k2Zu55rObYNZmD7pGWTxtr
         RolIv6ujTiCuXyUvK5CnxCVBKQ6SWLjNVcgLN9vGfv8LKUh1lFa1B3r1tEWY6IyFrYld
         4syb8Ia918gVL39IHxVHELhSDJSHOTvpV4AOd/8Gp0hEV2eMGkYf27r0XrT50z20fDtA
         lvXHT9RJrimjArD1uEoJKnwnh22tB2dKEeoadvKtU/KpZ5sHUIFsvtjahLIE26ly6q3W
         HYaj7xamOtKZs3e4Ywhrua9ROaLP0X50uTyldUfwkTJCKVt3c6d3Itsj7aPgMl+RZ+Uk
         JyXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r5h32+drSoE54EyvHLyIsrM6JZG0yPGOI/3krhxwzbQ=;
        b=JTQjbV8FrU9erUAZP4jbz3S4PXa+GL9+uPxrSY9QoBG1SDb554+y94no6Zd2bJNQXu
         HTTmrHnDJzV4QIlVYjDIub0YFGoaj9VsR+FGPrXLuXmX+/ak3vxgK7Ked7HD3VUuAcuC
         6s997/bI9iFziSDFFw/CYnA1jNMON21vgtHEGIFob8yL0C6qHTFh3YrzhPoCeEKIEC3P
         +fxs+vVBNsQWifje6E/X3FqUEDwLnI7AMOZr/M78ak5bnL9BY8/lYzyc7UzPiduymp8t
         EDuFWwrcO4mxrP4mLFFAe/00M2mp8xJEODHbG0n89L3N4+7gwVBu/DwUkUSStFJ3J074
         QBBg==
X-Gm-Message-State: APjAAAUu9AETOovXmNvN+9RPPq60D1uB3bS1EfczRZZX6dGNElplJ+b8
        DgimBNq3m16vPWWe6XJoySIGIJ3pT4qALhTtK/vAwA==
X-Google-Smtp-Source: APXvYqztMwK1QRhYP119Nie/vqUAxuwnAGSKS4TeeOGW+tVyW7XIfBVB13GwGATJwSHN/Ol+7MbzWO+SBCD3wVP7f5s=
X-Received: by 2002:a24:ee83:: with SMTP id b125mr32363980iti.43.1555509480777;
 Wed, 17 Apr 2019 06:58:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190412102738.12679-1-leo.yan@linaro.org> <20190412102738.12679-2-leo.yan@linaro.org>
 <CANLsYkw1vaevcJZfjQfF9BeUvi1THGNtu+SH+LR008LjZOc7fA@mail.gmail.com> <20190417000959.GB6202@leoy-ThinkPad-X240s>
In-Reply-To: <20190417000959.GB6202@leoy-ThinkPad-X240s>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 17 Apr 2019 07:57:50 -0600
Message-ID: <CANLsYkwEBmn519ey-Vg-4-yfKFCaZv8kTDZ4sWpVzNTBOdtC=g@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] dt-bindings: arm: coresight: Add new compatible
 for static replicator
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2019 at 18:10, Leo Yan <leo.yan@linaro.org> wrote:
>
> On Tue, Apr 16, 2019 at 02:18:40PM -0600, Mathieu Poirier wrote:
> > Hi Leo,
> >
> > On Fri, 12 Apr 2019 at 04:28, Leo Yan <leo.yan@linaro.org> wrote:
> > >
> > > CoreSight uses below bindings for replicator:
> > >
> > >   Dynamic replicator, aka. configurable replicator:
> > >     "arm,coresight-dynamic-replicator", "arm,primecell";
> > >
> > >   Static replicator, aka. non-configurable replicator:
> > >     "arm,coresight-replicator";
> > >
> > > The compatible string "arm,coresight-replicator" is not an explicit
> > > naming to express the replicator is 'static'.  To unify the naming
> > > convention, this patch introduces a new compatible string
> > > "arm,coresight-static-replicator" for the static replicator; the
> > > compatible string "arm,coresight-replicator" is kept for backward
> > > compatibility, but tag it as obsolete and suggest to use the new
> > > compatible string.
> > >
> > > As result CoreSight replicator have below bindings:
> > >
> > >   Dynamic replicator:
> > >     "arm,coresight-dynamic-replicator", "arm,primecell";
> > >
> > >   Static replicator:
> > >     "arm,coresight-static-replicator";
> > >     "arm,coresight-replicator"; (obsolete)
> > >
> > > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > > ---
> > >  Documentation/devicetree/bindings/arm/coresight.txt | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
> > > index f8aff65ab921..d02d160fa8ac 100644
> > > --- a/Documentation/devicetree/bindings/arm/coresight.txt
> > > +++ b/Documentation/devicetree/bindings/arm/coresight.txt
> > > @@ -69,7 +69,10 @@ its hardware characteristcs.
> > >
> > >         * compatible: Currently supported value is (note the absence of the
> > >           AMBA markee):
> > > -               - "arm,coresight-replicator"
> > > +               - Coresight Non-configurable Replicator:
> > > +                       "arm,coresight-static-replicator";
> > > +                       "arm,coresight-replicator"; (OBSOLETE. For backward
> > > +                               compatibility and will be removed)
> > >
> > >         * port or ports: see "Graph bindings for Coresight" below.
> > >
> > > @@ -169,7 +172,7 @@ Example:
> > >                 /* non-configurable replicators don't show up on the
> > >                  * AMBA bus.  As such no need to add "arm,primecell".
> > >                  */
> > > -               compatible = "arm,coresight-replicator";
> > > +               compatible = "arm,coresight-static-replicator";
> > >
> > >                 out-ports {
> > >                         #address-cells = <1>;
> > > --
> > > 2.17.1
> >
> > Since this is a binding patch it needs to be sent on its own.
>
> Thanks for reminding, Mathieu.
>
> Since this is the second time you remind me to send DT binding related
> patches separately, so I may misunderstand your meaning and want to get
> clarification to avoid making the same mistake for many times.
>
> Before I remembered in one patch set we need to organise patches with
> sending document patch (or document changing patch) ahead and then
> followed by the corresponding code change patch.  So this can give the
> reviewers more clear context;  and this also can present the merging
> dependency between document change patches and the code change patches.
>
> This is the rule I followed in this patch set and I sent to CoreSight
> and DT maintainers (and mailing lists) together.
>
> Please let me know what you think about this?  And also welcome
> Rob/Mark's suggestions.

https://www.kernel.org/doc/Documentation/devicetree/bindings/submitting-patches.txt

>
> Thanks,
> Leo Yan
