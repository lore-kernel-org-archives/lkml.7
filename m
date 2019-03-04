Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB72C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3929F206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iwFuQn8j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfCDRSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 12:18:53 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:55290 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfCDRSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 12:18:53 -0500
Received: by mail-it1-f193.google.com with SMTP id w18so8352247itj.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 09:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wxiYwS0rjQWvabJGNWBq5e3b12c2nD6YhLvIiOfnVjw=;
        b=iwFuQn8jHJRIiED0vITqW4Oh1ygNcBa7yBzRfg7lQNhgV1MkOaW40sE/NU/r18KqvH
         pppHxxDwv/tzPp8g7l9V8M3m50wgX5hOZlaUaBzNpJS3eh/M0Fv2q81tBY3mqA4psocB
         VcK20zE17Wni8cMkU8gvjC/2OPzb940Zs10O2EDj6pGaaPlF3tcEm2GGES31H/HSvR8E
         I90XQQOPvfftnIa5+YCuL2ok7E1iMwT+tcFnPAPFLtyHtnAl2jxpxgdPNQA+BUIqB2Bd
         sj6AR3hEHLzaq8VTwQdxc71Kj5MxJCour1yyc1MsjCIG9RNDoP+mh85cXlr/pfqD+JwG
         n8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wxiYwS0rjQWvabJGNWBq5e3b12c2nD6YhLvIiOfnVjw=;
        b=bAVtKVSs9F1y3HRIarkXSkoJPlzvowIXuMJLQ6UV35DMuHsUTgTXsIEXwY4vmN5867
         v0ibjHtkST3cZbIs8CVkhY8setME7oCvJzdwCdq8yoAoWb2NAcXTcMfLhmaiKfgFocar
         4ydxkSAZiO+9j4wts1gCD8Xuy5jVsa3YG4i6Z04EUjX191+aK+EcDeDRdfEHMbhuPGnr
         3Uqh5CLPCu3Ff7cEP0AOz+zhCBySfYt6JgiiSj1BMTg+ytmn+gvc7pRM87lSKH19rhU1
         R0POkdXt42gfFgaXkxkn/CLHST57U5M+zG9nMXFsWPB0H5Agm14seupICy65JH95Iscl
         bYTg==
X-Gm-Message-State: APjAAAW8jyWWESJDBmBzA+8Weu+myB5FBssW25Ni0x8JuGGC8G1d8mR1
        TjHscUnBYkDSUFkfCev1tvsLn+emWe1gdkK8jxvGHg==
X-Google-Smtp-Source: APXvYqx4/tiR7s+SKpBWiAuAJG7LE/uxNs9zK2Rh3IrDqbAepnoqsRauyPtX+BC8wMjCVHZNqZ+Q7+7dS70NSFqjseA=
X-Received: by 2002:a02:117:: with SMTP id c23mr10726813jad.71.1551719931928;
 Mon, 04 Mar 2019 09:18:51 -0800 (PST)
MIME-Version: 1.0
References: <6496F4728C09F6479CFF21A8E67D33D568F32660@dggema525-mbx.china.huawei.com>
 <20190302125955.GA11385@leoy-ThinkPad-X240s>
In-Reply-To: <20190302125955.GA11385@leoy-ThinkPad-X240s>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 4 Mar 2019 10:18:40 -0700
Message-ID: <CANLsYkzakXjuMR+=ncVpcohE8n-uF60Qa6EAN+Xh=FKBoJtrgg@mail.gmail.com>
Subject: Re: [PATCH v2] dts: arm64: add CoreSight trace support for hi3660
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Shiwanglai <shiwanglai@hisilicon.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "john.stultz@linaro.org" <john.stultz@linaro.org>,
        "xuwei (O)" <xuwei5@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        "Suzuki K. Poulose" <Suzuki.Poulose@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Mar 2019 at 06:00, Leo Yan <leo.yan@linaro.org> wrote:
>
> On Sat, Mar 02, 2019 at 09:45:22AM +0000, Shiwanglai wrote:
>
> [...]
>
> > > +           /* Top internals */
> > > +           funnel@ec031000 {
> > > +                   compatible = "arm,coresight-funnel", "arm,primecell";
> > > +                   reg = <0 0xec031000 0 0x1000>;
> > > +                   clocks = <&crg_ctrl HI3660_PCLK>;
> > > +                   clock-names = "apb_pclk";
> > > +
> > > +                   out-ports {
> > > +                           port {
> > > +                                   top_funnel_out: endpoint {
> > > +                                           remote-endpoint =
> > > +                                                   <&top_etf_in>;
> > > +                                   };
> > > +                           };
> > > +                   };
> > > +
> > > +                   in-ports {
> > > +                           #address-cells = <1>;
> > > +                           #size-cells = <0>;
> > > +
> > > +                           port@0 {
> > > +                                   reg = <0>;
> > > +                                   top_funnel_in0: endpoint {
> > > +                                           remote-endpoint =
> > > +                                                   <&cluster0_etf_out>;
> > > +                                   };
> > > +                           };
> > > +
> > > +                           port@1 {
> > > +                                   reg = <0>;
> >
> > Here should s/<0>/<1>; otherwise DTC will complain warning for mismatching between 'port@1' and 'reg = <0>'.
>
> > -- if reg set to 1, then there's no data output from cluster 1 to top.
>
> Thanks for the info, Wanglai.  Now I see why write as it is.
>
> I can confirm if directly use your patch with perf with mainline
> kernel I can capture CoreSight trace data successfully on Hikey960
> board.
>
> But since this DT binding will introduce DTC warning, I personally
> think we can improve for this with below method:
>
> We can create a funnel node named "funnel_combo", and we don't need to
> specify register address range for it; and cluster 0 and cluster 1 will
> output to "funnel_combo" and "funnel_combo" will output to the top
> funnel.  Thus the DT binding will write as below.
>
> To support for a funnel without any register address range (we have
> support replicator like this mode), we also need to extend the driver
> drivers/hwtracing/coresight/coresight-funnel.c.
>
> Mathieu, Mike, Suzuki, could you help confirm this is the right
> direction we should move forward to?

Leo, thanks for testing this out.  Shiwanglai, please add Suzuki and
myself to future revision of this set - this will help you getting a
timely response for your work.

As Leo pointed out we already have support for replicators that don't
have a register map and the same thing should be done in this case.
But contrary to what was done for replicators, I think we should keep
the drivers in the same file as Russell did here[1].  That way we can
keep all things funnel at the same place and reduce the amount of
kernel configuration options.

Regards,
Mathieu

[1]. https://elixir.bootlin.com/linux/latest/source/drivers/tty/serial/amba-pl011.c#L2819

>
> ---8<---
>         /* An invisible combo funnel between clusters and top funnel */
>         funnel_combo {
>                 compatible = "arm,coresight-funnel";
>                 clocks = <&crg_ctrl HI3660_PCLK>;
>                 clock-names = "apb_pclk";
>
>                 out-ports {
>                         port {
>                                 combo_funnel_out: endpoint {
>                                         remote-endpoint =
>                                                 <&top_funnel_in>;
>                                 };
>                         };
>                 };
>
>                 in-ports {
>                         #address-cells = <1>;
>                         #size-cells = <0>;
>
>                         port@0 {
>                                 reg = <0>;
>                                 combo_funnel_in0: endpoint {
>                                         remote-endpoint =
>                                                 <&cluster0_etf_out>;
>                                 };
>                         };
>
>                         port@1 {
>                                 reg = <1>;
>                                 combo_funnel_in1: endpoint {
>                                         remote-endpoint =
>                                                 <&cluster1_etf_out>;
>                                 };
>                         };
>                 };
>         };
>
>         /* Top internals */
>         funnel@ec031000 {
>                 compatible = "arm,coresight-funnel", "arm,primecell";
>                 reg = <0 0xec031000 0 0x1000>;
>                 clocks = <&crg_ctrl HI3660_PCLK>;
>                 clock-names = "apb_pclk";
>
>                 out-ports {
>                         port {
>                                 top_funnel_out: endpoint {
>                                         remote-endpoint =
>                                                 <&top_etf_in>;
>                                 };
>                         };
>                 };
>
>                 in-ports {
>                         #address-cells = <1>;
>                         #size-cells = <0>;
>
>                         port@0 {
>                                 reg = <0>;
>                                 top_funnel_in: endpoint {
>                                         remote-endpoint =
>                                                 <&combo_funnel_out>;
>                                 };
>                         };
>                 };
>         };
>
> --->8---
>
> [...]
>
> Thanks,
> Leo Yan
