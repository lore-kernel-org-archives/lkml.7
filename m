Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED3DC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E884F2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LIx/S1ql"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbfDLKym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:54:42 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38973 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfDLKyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:54:41 -0400
Received: by mail-oi1-f193.google.com with SMTP id n187so7569441oih.6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 03:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Um8tlJAC3+HUO4lekEaITInfaofY4ttbay6MKSA4VAw=;
        b=LIx/S1qlUMX6NGtRzHkTwlp8f+MWZiLcW20MXl9pKp9b+HhxYe1nv8Af3qNVAr56NK
         70DoPq/QlMlk+2/Su8IUUnERJYxTTU4D5Fzhy50oBvLfsT03CoIt/Eu+vDcj3W9bHxv2
         Fn74W9RCLpHrHJLFB/6MaP5TQLZ9pCCfOq5C6gd4ZsXSLHQVZguuQjn/z8nxwr2BXq0+
         3hiQ2A2ZKbWoxjv4LN7IbKarfBY0NVR3l7LfdZXahCLqsROodkNPYzh8hUhMgZ/VGkPn
         nnMjw7khefeI0uxQitorUEI4KJ2Gw770m0P9vbsz+FapBMZoI2EZPnyyvfLq/rXh+Od0
         d3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Um8tlJAC3+HUO4lekEaITInfaofY4ttbay6MKSA4VAw=;
        b=lxLZGl3OBbhhn9DpHC32bOMvkBJweXo6mwKKj0qqIlN8e4SF5tb9gWASwteiAkMGJK
         235Z0TVDzOn+1elTYhA+E5etLRQPGKYpdiO4Kc74iqdxo61BTKiKDW1ae85bS9R3iGCi
         JKeWEHWl9SGZkuoCvfEu0eWZfBn5JRPDEbNAby9H4u5c5NxJjmaU3F+4tCe03bJjXRgf
         x++UJiDi0E4jlx0g2DlEU3bwkjj5Nd/LtIVfG40oFsL1C4ObDC67Oia6BBXJTxFMjwtt
         FQTv2U4jrI28HTfD52f7NRs2F7Y5GterBcx4v8oox0mSZHUygDZSWonGwH9bSimWX+XO
         xiEg==
X-Gm-Message-State: APjAAAVyVEM0/BBbGUjfk9fL04AD67SMGbQxURcz2nQUqut8hRakmtZf
        TKjXK8vYF2QD4YrKVCad4T4TiQ==
X-Google-Smtp-Source: APXvYqz2dphczWaAngIEKMdnIlH7zcDduGyhBSGptvIuG6HRTX93LhtrKUGlaGU2viBIA4036QPegw==
X-Received: by 2002:aca:5512:: with SMTP id j18mr9640686oib.65.1555066480986;
        Fri, 12 Apr 2019 03:54:40 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li808-42.members.linode.com. [104.237.132.42])
        by smtp.gmail.com with ESMTPSA id g21sm16283804otk.12.2019.04.12.03.54.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 03:54:39 -0700 (PDT)
Date:   Fri, 12 Apr 2019 18:54:32 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     mathieu.poirier@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/4] dt-bindings: arm: coresight: Add new compatible
 for static replicator
Message-ID: <20190412105432.GA1643@leoy-ThinkPad-X240s>
References: <20190412102738.12679-1-leo.yan@linaro.org>
 <20190412102738.12679-2-leo.yan@linaro.org>
 <a38d1f9e-622e-7fd6-6282-be5601863c11@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a38d1f9e-622e-7fd6-6282-be5601863c11@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 11:40:13AM +0100, Suzuki K Poulose wrote:
> On 04/12/2019 11:27 AM, Leo Yan wrote:
> > CoreSight uses below bindings for replicator:
> > 
> >    Dynamic replicator, aka. configurable replicator:
> >      "arm,coresight-dynamic-replicator", "arm,primecell";
> > 
> >    Static replicator, aka. non-configurable replicator:
> >      "arm,coresight-replicator";
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
> >    Dynamic replicator:
> >      "arm,coresight-dynamic-replicator", "arm,primecell";
> > 
> >    Static replicator:
> >      "arm,coresight-static-replicator";
> >      "arm,coresight-replicator"; (obsolete)
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >   Documentation/devicetree/bindings/arm/coresight.txt | 7 +++++--
> >   1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
> > index f8aff65ab921..d02d160fa8ac 100644
> > --- a/Documentation/devicetree/bindings/arm/coresight.txt
> > +++ b/Documentation/devicetree/bindings/arm/coresight.txt
> > @@ -69,7 +69,10 @@ its hardware characteristcs.
> >   	* compatible: Currently supported value is (note the absence of the
> >   	  AMBA markee):
> > -		- "arm,coresight-replicator"
> > +		- Coresight Non-configurable Replicator:
> > +			"arm,coresight-static-replicator";
> > +			"arm,coresight-replicator"; (OBSOLETE. For backward
> > +				compatibility and will be removed)
> >   	* port or ports: see "Graph bindings for Coresight" below.
> > @@ -169,7 +172,7 @@ Example:
> >   		/* non-configurable replicators don't show up on the
> >   		 * AMBA bus.  As such no need to add "arm,primecell".
> >   		 */
> > -		compatible = "arm,coresight-replicator";
> > +		compatible = "arm,coresight-static-replicator";
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Thanks a lot for quick reviewing, Suzuki.
