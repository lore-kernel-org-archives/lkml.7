Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CA8C33C9A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 12:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF56620715
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 12:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573736371;
	bh=PrnTj8KP0RmKwggGVx7XTCKrlDbkXPZSmvYTu0BYnew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hSgti7uav5W/HHIBNEFmno0PxmdqNCxjp+eCv1wQ/yxZnu3cL7VAvDcnYUlhrNC3C
	 i0oANli7y6Gj6A6NHdhWJ1u+2YpRXL9qmSJNEKJIwTmx2TT7FWpU4zAw2qPTu3Jacx
	 QLwApI7faWWVBQtBOMhEsmRbx+I1zLYbnpTsSCnI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfKNM7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 07:59:31 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45436 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfKNM7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 07:59:30 -0500
Received: by mail-pg1-f193.google.com with SMTP id k1so2436871pgg.12;
        Thu, 14 Nov 2019 04:59:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eyKWSvEw/hHVLWaUJkadxXa/8l2eJMrdGGE4pWIJliM=;
        b=s9hasWkiJCMlvxR/t61GLW/4ipMkk1bbf3X1FhKZxaBCZxY++Ui/4VVjXhYMdRnEAF
         jZ9cSUxZ1QFm2hnPV7X+r+UULUHJi/EyLR/H784WfYOLGQiFMrg+WyFeZ2VFvRyiHzHo
         iBHvmfqA5UciEXVh4NxgXt+4JQfxIr/fh7J/KXOBP07ZsxMUYxEO/8FycrXA3W9IMQFz
         jTWE5iD4gKn0n4nCYQKYEfZ6ZO6O8QTjl84os3Md93g0+SKA1LuP7Ot+KAhZ4A1MvEpO
         HZR13s+Whibu/0TXfCTt5gWJqniqYIWCaA/4jD5GsxZwJ8QjoN1p5y06AxvQDiC0BIgb
         d0vg==
X-Gm-Message-State: APjAAAUwZvXszqTC4jX+gX/d+c0w9g8ARejxJjQeJWI2pSk99SQ9JyL+
        /8soyy9BxAImuCeGnRRcR2Y=
X-Google-Smtp-Source: APXvYqypkUITYjtWoFXC49sMS4ND2xYVEJsgTYpdYWvHtnOJ7HXqn3ErH7iuf53NGeK+feek5fBlSA==
X-Received: by 2002:a62:ce41:: with SMTP id y62mr10844056pfg.34.1573736367900;
        Thu, 14 Nov 2019 04:59:27 -0800 (PST)
Received: from kozik-lap ([118.189.143.39])
        by smtp.googlemail.com with ESMTPSA id k66sm3257235pgk.16.2019.11.14.04.59.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Nov 2019 04:59:27 -0800 (PST)
Date:   Thu, 14 Nov 2019 13:59:23 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: power: Convert Generic Power Domain
 bindings to json-schema
Message-ID: <20191114125923.GA3084@kozik-lap>
References: <20191030173216.5993-1-krzk@kernel.org>
 <20191105194257.GA16066@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191105194257.GA16066@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 01:42:58PM -0600, Rob Herring wrote:
> On Wed, 30 Oct 2019 18:32:15 +0100, Krzysztof Kozlowski wrote:
> > Convert Generic Power Domain bindings to DT schema format using
> > json-schema.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Acked-by: Stephen Boyd <sboyd@kernel.org>
> > 
> > ---
> > 
> > Changes since v2:
> > 1. Keep description of consumers in power-domain.txt,
> > 2. Rename power_domain.txt to power-domain.txt,
> > 3. Indent example with four spaces (more readable).
> > 
> > Changes since v1:
> > 1. Select all nodes for consumers,
> > 2. Remove from consumers duplicated properties with dt-schema,
> > 3. Fix power domain pattern,
> > 4. Remove unneeded types.
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  .../devicetree/bindings/arm/arm,scmi.txt      |   2 +-
> >  .../devicetree/bindings/arm/arm,scpi.txt      |   2 +-
> >  .../bindings/arm/freescale/fsl,scu.txt        |   2 +-
> >  .../bindings/clock/renesas,cpg-mssr.txt       |   2 +-
> >  .../bindings/clock/ti/davinci/psc.txt         |   2 +-
> >  .../firmware/nvidia,tegra186-bpmp.txt         |   2 +-
> >  .../bindings/power/amlogic,meson-gx-pwrc.txt  |   2 +-
> >  .../devicetree/bindings/power/fsl,imx-gpc.txt |   2 +-
> >  .../bindings/power/fsl,imx-gpcv2.txt          |   2 +-
> >  .../{power_domain.txt => power-domain.txt}    |  95 +------------
> >  .../bindings/power/power-domain.yaml          | 133 ++++++++++++++++++
> >  .../bindings/power/renesas,sysc-rmobile.txt   |   2 +-
> >  .../bindings/power/xlnx,zynqmp-genpd.txt      |   2 +-
> >  .../bindings/soc/bcm/brcm,bcm2835-pm.txt      |   2 +-
> >  .../bindings/soc/mediatek/scpsys.txt          |   2 +-
> >  .../bindings/soc/ti/sci-pm-domain.txt         |   2 +-
> >  MAINTAINERS                                   |   2 +-
> >  17 files changed, 149 insertions(+), 109 deletions(-)
> >  rename Documentation/devicetree/bindings/power/{power_domain.txt => power-domain.txt} (51%)
> >  create mode 100644 Documentation/devicetree/bindings/power/power-domain.yaml
> > 
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

The patches should apply cleanly in top of your tree so maybe you can
pick them up?

Best regards,
Krzysztof

