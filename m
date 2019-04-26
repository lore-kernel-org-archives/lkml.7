Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B343EC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78C7C2084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KcNjMvlL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfDZPDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:03:42 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41838 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfDZPDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:03:41 -0400
Received: by mail-pl1-f193.google.com with SMTP id d9so1709945pls.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 08:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3yyhOcD4ij0K/rsq9Q1YvKWk+pXbI5mPS9uEahIaKCk=;
        b=KcNjMvlL5VK6X7LpVpOeIbEBUVG1IIg3dJeflDsaMziVHR0UazPvTheWDACyma/PaQ
         EC7XCqtXIOGnraLBMz6fwNEmAkChMxjfaehy9xC+8OF3dx4V99fSHP8OYeK+ggXeE2yL
         rgzndD4R1qYxfDSwbSryILwlEmn2RaLrIdMHY4gG1w07dHyMefVySauL9BHDaBaeGYvt
         Ezs5XhLF+kxqiTsBGDMZGyvM447Y99qBe/o1B9vJ8TCqeMWdtW2anCiMDk5+zdZXpK9A
         /voEYM21sZAvaic+XM6T1coVlZkD7QXCKQwoM+KNpf6wIPyB/854hAmHuyX7jiNtIvdu
         +SAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3yyhOcD4ij0K/rsq9Q1YvKWk+pXbI5mPS9uEahIaKCk=;
        b=WEMD0B3Vb20XZ85kXcf+++0S8KByAuCQv4yGbJbDfp2SYAa9g+oK0F2tfeJn+XB7Uq
         086MDDGb8D+JhTTxgXxFveGOw6CSdeBUUQv8Ltp8P0sbt8cnGTkY57kOpc9odhrkBitI
         vlMNoaP/yq8NlyLqDPo3PXKSb9JSmiEHcK2w83WJKhiMFqWXKpYnt5okk+b45UIk8iNg
         e06zO8Z0nrC2FDZUhBbHCI39JKhg/DfrPBETr39UvxJyGGNspEGobBicaR13IYLWf337
         bgHops/+Kxny05/KGmh2hrkI6f6DjdEdVNO0+BZcBSws9gWcXCp/MWsmuIuGtGdt8FGi
         tPvA==
X-Gm-Message-State: APjAAAWHOLc96/LCWFBVuE22sPieCvhvtBXdswEwjnuFbieg7Vgs7sfs
        aafoORTgVriIeDoPmqyah4RelA==
X-Google-Smtp-Source: APXvYqwh5UrfSVfccpSk68sCcL9vh5VQ77fMkcwHEJU59RBADTuiJ7xuZBcItaZwlKmajz5JYz6v7w==
X-Received: by 2002:a17:902:2dc3:: with SMTP id p61mr46604897plb.308.1556291020489;
        Fri, 26 Apr 2019 08:03:40 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id g4sm45046250pfm.115.2019.04.26.08.03.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 08:03:39 -0700 (PDT)
Date:   Fri, 26 Apr 2019 09:03:37 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/4] dt-bindings: arm: coresight: Add new compatible
 for static replicator
Message-ID: <20190426150337.GA1851@xps15>
References: <20190412102738.12679-1-leo.yan@linaro.org>
 <20190412102738.12679-2-leo.yan@linaro.org>
 <CANLsYkw1vaevcJZfjQfF9BeUvi1THGNtu+SH+LR008LjZOc7fA@mail.gmail.com>
 <20190417000959.GB6202@leoy-ThinkPad-X240s>
 <CANLsYkwEBmn519ey-Vg-4-yfKFCaZv8kTDZ4sWpVzNTBOdtC=g@mail.gmail.com>
 <20190426142507.GA8721@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426142507.GA8721@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 09:25:07AM -0500, Rob Herring wrote:
> On Wed, Apr 17, 2019 at 07:57:50AM -0600, Mathieu Poirier wrote:
> > On Tue, 16 Apr 2019 at 18:10, Leo Yan <leo.yan@linaro.org> wrote:
> > >
> > > On Tue, Apr 16, 2019 at 02:18:40PM -0600, Mathieu Poirier wrote:
> > > > Hi Leo,
> > > >
> > > > On Fri, 12 Apr 2019 at 04:28, Leo Yan <leo.yan@linaro.org> wrote:
> > > > >
> > > > > CoreSight uses below bindings for replicator:
> > > > >
> > > > >   Dynamic replicator, aka. configurable replicator:
> > > > >     "arm,coresight-dynamic-replicator", "arm,primecell";
> > > > >
> > > > >   Static replicator, aka. non-configurable replicator:
> > > > >     "arm,coresight-replicator";
> > > > >
> > > > > The compatible string "arm,coresight-replicator" is not an explicit
> > > > > naming to express the replicator is 'static'.  To unify the naming
> > > > > convention, this patch introduces a new compatible string
> > > > > "arm,coresight-static-replicator" for the static replicator; the
> > > > > compatible string "arm,coresight-replicator" is kept for backward
> > > > > compatibility, but tag it as obsolete and suggest to use the new
> > > > > compatible string.
> > > > >
> > > > > As result CoreSight replicator have below bindings:
> > > > >
> > > > >   Dynamic replicator:
> > > > >     "arm,coresight-dynamic-replicator", "arm,primecell";
> > > > >
> > > > >   Static replicator:
> > > > >     "arm,coresight-static-replicator";
> > > > >     "arm,coresight-replicator"; (obsolete)
> > > > >
> > > > > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > > > > ---
> > > > >  Documentation/devicetree/bindings/arm/coresight.txt | 7 +++++--
> > > > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
> > > > > index f8aff65ab921..d02d160fa8ac 100644
> > > > > --- a/Documentation/devicetree/bindings/arm/coresight.txt
> > > > > +++ b/Documentation/devicetree/bindings/arm/coresight.txt
> > > > > @@ -69,7 +69,10 @@ its hardware characteristcs.
> > > > >
> > > > >         * compatible: Currently supported value is (note the absence of the
> > > > >           AMBA markee):
> > > > > -               - "arm,coresight-replicator"
> > > > > +               - Coresight Non-configurable Replicator:
> > > > > +                       "arm,coresight-static-replicator";
> > > > > +                       "arm,coresight-replicator"; (OBSOLETE. For backward
> > > > > +                               compatibility and will be removed)
> > > > >
> > > > >         * port or ports: see "Graph bindings for Coresight" below.
> > > > >
> > > > > @@ -169,7 +172,7 @@ Example:
> > > > >                 /* non-configurable replicators don't show up on the
> > > > >                  * AMBA bus.  As such no need to add "arm,primecell".
> > > > >                  */
> > > > > -               compatible = "arm,coresight-replicator";
> > > > > +               compatible = "arm,coresight-static-replicator";
> > > > >
> > > > >                 out-ports {
> > > > >                         #address-cells = <1>;
> > > > > --
> > > > > 2.17.1
> > > >
> > > > Since this is a binding patch it needs to be sent on its own.
> > >
> > > Thanks for reminding, Mathieu.
> > >
> > > Since this is the second time you remind me to send DT binding related
> > > patches separately, so I may misunderstand your meaning and want to get
> > > clarification to avoid making the same mistake for many times.
> > >
> > > Before I remembered in one patch set we need to organise patches with
> > > sending document patch (or document changing patch) ahead and then
> > > followed by the corresponding code change patch.  So this can give the
> > > reviewers more clear context;  and this also can present the merging
> > > dependency between document change patches and the code change patches.
> > >
> > > This is the rule I followed in this patch set and I sent to CoreSight
> > > and DT maintainers (and mailing lists) together.
> > >
> > > Please let me know what you think about this?  And also welcome
> > > Rob/Mark's suggestions.
> > 
> > https://www.kernel.org/doc/Documentation/devicetree/bindings/submitting-patches.txt
> 
> I'm not clear on what you are asking for. Binding patches should be 
> separate patch, but can and should still be in a series if there's 
> relevant code changes.

The fault is mine - I reviewed Leo's patchset while seriously jet lagged and
sent him in the weeds.  Apologies for the confusion.

Mathieu

> 
> Rob
