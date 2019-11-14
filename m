Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C94C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 16:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0129D206DB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 16:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573749726;
	bh=vtbCclPT+zYqUalm1ApV+FNGPcRf/b9M6eu8ZE4q16Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GLsFtHFqIRJzP7yXRvk+ffnAg3+ZrWX1uhZEr3xmykecG3JB3co0hST7kmV0hZ493
	 XFd7NXDfplBHK1fzJmfm7QLpV19eVaAPP4C9MfJyf0BG8PFPqBO6knuXxeES2whRF0
	 ik9wrb9rh7qy2ca3xVNkUxCKzKG6/VPfSyr//wBs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfKNQmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 11:42:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:39116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbfKNQmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 11:42:04 -0500
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD51920727;
        Thu, 14 Nov 2019 16:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573749722;
        bh=vtbCclPT+zYqUalm1ApV+FNGPcRf/b9M6eu8ZE4q16Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eSe0IvX2y9Wj/36cOsbQWZo2r/flZoR95ZUx9zbAQ72DT7NfJH7j3KTR29VnrqtoH
         jnNw5uqT7e0Gds5meXc+jFJjbsMH0XhlTSeT7VxkLcBboqkO0SmGsrUM7gUfqQn5RQ
         w/A9jtP+kVlgVy9Aigrw0Nm04tD72R3d5391n1hA=
Received: by mail-qt1-f170.google.com with SMTP id r20so7412342qtp.13;
        Thu, 14 Nov 2019 08:42:02 -0800 (PST)
X-Gm-Message-State: APjAAAVEUW1bwnWbEbl3PzqcTQEuIkJZyW35KEdkZfhB0mIIxhEUlXQ/
        TIqnVXM3JVwufYFat7hEdtYzIWvlrz3+33l7MQ==
X-Google-Smtp-Source: APXvYqxjuNP7BfYPb5x+ylRHTKdxw88/n1phCYuux3ImKi057RYvcMQ05BWyQKmncaEprsWM0Zap0QYGz4BodN4GT7w=
X-Received: by 2002:ac8:3094:: with SMTP id v20mr9302910qta.110.1573749721974;
 Thu, 14 Nov 2019 08:42:01 -0800 (PST)
MIME-Version: 1.0
References: <20191030173216.5993-1-krzk@kernel.org> <20191105194257.GA16066@bogus>
 <20191114125923.GA3084@kozik-lap>
In-Reply-To: <20191114125923.GA3084@kozik-lap>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 14 Nov 2019 10:41:50 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJCps_s1OGt2SvPa4uBj9EQp0ZqyeHVw8fMR+rSSVh9ow@mail.gmail.com>
Message-ID: <CAL_JsqJCps_s1OGt2SvPa4uBj9EQp0ZqyeHVw8fMR+rSSVh9ow@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: power: Convert Generic Power Domain
 bindings to json-schema
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 6:59 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Tue, Nov 05, 2019 at 01:42:58PM -0600, Rob Herring wrote:
> > On Wed, 30 Oct 2019 18:32:15 +0100, Krzysztof Kozlowski wrote:
> > > Convert Generic Power Domain bindings to DT schema format using
> > > json-schema.
> > >
> > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > Acked-by: Stephen Boyd <sboyd@kernel.org>
> > >
> > > ---
> > >
> > > Changes since v2:
> > > 1. Keep description of consumers in power-domain.txt,
> > > 2. Rename power_domain.txt to power-domain.txt,
> > > 3. Indent example with four spaces (more readable).
> > >
> > > Changes since v1:
> > > 1. Select all nodes for consumers,
> > > 2. Remove from consumers duplicated properties with dt-schema,
> > > 3. Fix power domain pattern,
> > > 4. Remove unneeded types.
> > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > ---
> > >  .../devicetree/bindings/arm/arm,scmi.txt      |   2 +-
> > >  .../devicetree/bindings/arm/arm,scpi.txt      |   2 +-
> > >  .../bindings/arm/freescale/fsl,scu.txt        |   2 +-
> > >  .../bindings/clock/renesas,cpg-mssr.txt       |   2 +-
> > >  .../bindings/clock/ti/davinci/psc.txt         |   2 +-
> > >  .../firmware/nvidia,tegra186-bpmp.txt         |   2 +-
> > >  .../bindings/power/amlogic,meson-gx-pwrc.txt  |   2 +-
> > >  .../devicetree/bindings/power/fsl,imx-gpc.txt |   2 +-
> > >  .../bindings/power/fsl,imx-gpcv2.txt          |   2 +-
> > >  .../{power_domain.txt => power-domain.txt}    |  95 +------------
> > >  .../bindings/power/power-domain.yaml          | 133 ++++++++++++++++++
> > >  .../bindings/power/renesas,sysc-rmobile.txt   |   2 +-
> > >  .../bindings/power/xlnx,zynqmp-genpd.txt      |   2 +-
> > >  .../bindings/soc/bcm/brcm,bcm2835-pm.txt      |   2 +-
> > >  .../bindings/soc/mediatek/scpsys.txt          |   2 +-
> > >  .../bindings/soc/ti/sci-pm-domain.txt         |   2 +-
> > >  MAINTAINERS                                   |   2 +-
> > >  17 files changed, 149 insertions(+), 109 deletions(-)
> > >  rename Documentation/devicetree/bindings/power/{power_domain.txt => power-domain.txt} (51%)
> > >  create mode 100644 Documentation/devicetree/bindings/power/power-domain.yaml
> > >
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
>
> The patches should apply cleanly in top of your tree so maybe you can
> pick them up?

I didn't on this one because it touches a lot of files. Though on
second thought, they are all across the tree, so I might as well apply
them.

Rob
