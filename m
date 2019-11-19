Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A311DC43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B6EA222A9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574173940;
	bh=1aEll8z1CeW98RoAv0j3QdSEeThTrt3K/OFXPeoKmGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wqg4a4V9jDD7VSDNbnxE4PfcEnxXLxrDoqeiZ+xjaV62+yiIQy9+/vwHdLLruEjhr
	 VWN1kRhCZP+j8JyK40J9iGYYaObHzw1GrldtvXWnJT9aGfbcEK53TdkMe9c1D7QDz7
	 DG7v11QTnzrYHInOzL38HFWZrJ5eMW/JN8LOghOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbfKSOcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 09:32:19 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41427 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbfKSOcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 09:32:19 -0500
Received: by mail-pl1-f193.google.com with SMTP id d29so11854545plj.8;
        Tue, 19 Nov 2019 06:32:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eBb56gUBpWkIX0FYW+z97CZQ4gz538W2egeN9/8KSE8=;
        b=pZXXu3lBLRApHusvZrYkz2ouGihJZRI8gQ44a4dmRKQHcBZO7yODWVqgNEoRN781vE
         H9ILCAWDXG7KJbWOkpr9g6EPgbrUQhSOL06m2U0pNBavdBSTLUTT3aVMMPsFtRwsoD6T
         sUCNxtQLSo2jnLf2WyJRbgCH1IPEYFV7mBcy2HFhNtIqmUKYB8XcXMsH2gqd2l9EinZD
         L4UZavYG0HisciKki9I9cINZEO5+bL4YeSG0ql2h+d5FqKax9oDT9wd9K8g0jGu0WiQb
         jUBBB91lC9Km+MOroiXk0wnlqLS24eWxiBDM7PupsZ2I1jBdXo+ECV4VQwAnS5Bw2FqV
         hYDQ==
X-Gm-Message-State: APjAAAWq/buJeUyG9W3WnFse8GD1fpPTKr+0RjekoSuJoSN+04ppKg6d
        5yHJnM8+XER6J8eFvbfmH7naQevb
X-Google-Smtp-Source: APXvYqwwGsoq53FUp+0XzND+b9LLSYSKvrjBZwNTHzre77bCa3jKZ67sI4NXD0mR6B+oWVnerf80Lg==
X-Received: by 2002:a17:90a:5d17:: with SMTP id s23mr6591558pji.55.1574173937748;
        Tue, 19 Nov 2019 06:32:17 -0800 (PST)
Received: from kozik-lap ([118.189.143.39])
        by smtp.googlemail.com with ESMTPSA id z62sm28857634pfz.135.2019.11.19.06.32.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Nov 2019 06:32:16 -0800 (PST)
Date:   Tue, 19 Nov 2019 22:32:11 +0800
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: power: Convert Generic Power Domain
 bindings to json-schema
Message-ID: <20191119143211.GA7804@kozik-lap>
References: <20191030173216.5993-1-krzk@kernel.org>
 <20191105194257.GA16066@bogus>
 <20191114125923.GA3084@kozik-lap>
 <CAL_JsqJCps_s1OGt2SvPa4uBj9EQp0ZqyeHVw8fMR+rSSVh9ow@mail.gmail.com>
 <CAMuHMdXYg4u1SF+j=doJqaDFw+O61g2th8ppt+CBrez8QAgJRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdXYg4u1SF+j=doJqaDFw+O61g2th8ppt+CBrez8QAgJRA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 10:58:11AM +0100, Geert Uytterhoeven wrote:
> Hi Rob, Krzysztof,
> 
> On Thu, Nov 14, 2019 at 5:42 PM Rob Herring <robh@kernel.org> wrote:
> > On Thu, Nov 14, 2019 at 6:59 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > On Tue, Nov 05, 2019 at 01:42:58PM -0600, Rob Herring wrote:
> > > > On Wed, 30 Oct 2019 18:32:15 +0100, Krzysztof Kozlowski wrote:
> > > > > Convert Generic Power Domain bindings to DT schema format using
> > > > > json-schema.
> > > > >
> > > > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > > > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > Acked-by: Stephen Boyd <sboyd@kernel.org>
> > > > >
> > > > > ---
> > > > >
> > > > > Changes since v2:
> > > > > 1. Keep description of consumers in power-domain.txt,
> > > > > 2. Rename power_domain.txt to power-domain.txt,
> > > > > 3. Indent example with four spaces (more readable).
> > > > >
> > > > > Changes since v1:
> > > > > 1. Select all nodes for consumers,
> > > > > 2. Remove from consumers duplicated properties with dt-schema,
> > > > > 3. Fix power domain pattern,
> > > > > 4. Remove unneeded types.
> > > > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > > > ---
> > > > >  .../devicetree/bindings/arm/arm,scmi.txt      |   2 +-
> > > > >  .../devicetree/bindings/arm/arm,scpi.txt      |   2 +-
> > > > >  .../bindings/arm/freescale/fsl,scu.txt        |   2 +-
> > > > >  .../bindings/clock/renesas,cpg-mssr.txt       |   2 +-
> > > > >  .../bindings/clock/ti/davinci/psc.txt         |   2 +-
> > > > >  .../firmware/nvidia,tegra186-bpmp.txt         |   2 +-
> > > > >  .../bindings/power/amlogic,meson-gx-pwrc.txt  |   2 +-
> > > > >  .../devicetree/bindings/power/fsl,imx-gpc.txt |   2 +-
> > > > >  .../bindings/power/fsl,imx-gpcv2.txt          |   2 +-
> > > > >  .../{power_domain.txt => power-domain.txt}    |  95 +------------
> > > > >  .../bindings/power/power-domain.yaml          | 133 ++++++++++++++++++
> > > > >  .../bindings/power/renesas,sysc-rmobile.txt   |   2 +-
> > > > >  .../bindings/power/xlnx,zynqmp-genpd.txt      |   2 +-
> > > > >  .../bindings/soc/bcm/brcm,bcm2835-pm.txt      |   2 +-
> > > > >  .../bindings/soc/mediatek/scpsys.txt          |   2 +-
> > > > >  .../bindings/soc/ti/sci-pm-domain.txt         |   2 +-
> > > > >  MAINTAINERS                                   |   2 +-
> > > > >  17 files changed, 149 insertions(+), 109 deletions(-)
> > > > >  rename Documentation/devicetree/bindings/power/{power_domain.txt => power-domain.txt} (51%)
> > > > >  create mode 100644 Documentation/devicetree/bindings/power/power-domain.yaml
> > > > >
> > > >
> > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > >
> > > The patches should apply cleanly in top of your tree so maybe you can
> > > pick them up?
> >
> > I didn't on this one because it touches a lot of files. Though on
> > second thought, they are all across the tree, so I might as well apply
> > them.
> 
> There are still several leftover references to power_domain.txt.
> Krzysztof: Do you plan to convert these, too, or do you expect the
> individual maintainers to handle that?

Ahh, I think that's my fault after one of iterations of the patchset. I
can fix it up fast and maybe let's queue it through the same tree (Rob's).

Best regards,
Krzysztof

