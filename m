Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D326C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 12:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 486372084F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 12:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vccxxMMM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732397AbfCAM0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 07:26:06 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42678 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfCAM0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 07:26:06 -0500
Received: by mail-ed1-f66.google.com with SMTP id j89so19818859edb.9;
        Fri, 01 Mar 2019 04:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dbNJQpynLWU5i9a8FTIDGTIY3X4GjAWXrowSwX5OxAk=;
        b=vccxxMMMWrt5mEhgKEeLObBGuH6Ovqjf+L8+Zdt7nd54yG4dDPeAlE3lANNmN2ZAbl
         OFuKIK0P6DzcQso+xQxkVt4wo6YLVhrE6ArbEyckhwGXbPqPKS5TI+zKreBH2fDyUcwD
         ZDSjmYiVXpwRzhwtP8gkFMpTavv1Orq7MQ8Id1ZB/FQ5DbAWW7PtoA5b1MUNzkpFchdJ
         ihXkqRxYPeIq/dyNmuNWE3YmbNP0RiUYBZ7Kmd8TE7RZ2tT1GdiyKg4YN9NywNDTYon2
         IO85UT8lLNGpdpfT+tPyAo3eIWICrN/E48spfOd6N1OGxMqLkFQD5Pi+luDcoDRGlx/t
         LoIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dbNJQpynLWU5i9a8FTIDGTIY3X4GjAWXrowSwX5OxAk=;
        b=nHe/S1ixGnQT7TVRHypP6pYLG2uwH5T4Qmo7IyPKeTTMMNZ4VPWxoErvXWY3Rh3LOx
         5+I9Fk4n44y96oqbfeYlzF7iF+wjoJimyXRQn3LhQiVlB0x0jcsxt9K+p1RlHwQsd6b+
         4ck7CuM7CBPl957WXbQ/+CmFqp8isVH0rZwrHWSaG8XwX6Woth9r2iB+C04/omplv2kN
         neR4wZC3VcWxiumD2a5DKm2QIgKDqdAJigg8EKyKNIf+affy/yE3frR4xLHyWjKu8Kl8
         cVQ549M0XpXH/Rui93xowR7lwNBdC/Bl5SfSwqtGy+xnfwlHMBcGqB0R85CNkYRmW2mn
         Y5vA==
X-Gm-Message-State: APjAAAXfYrdlMDfxyV+VOZOe9FtpGLIjNVcEm8nZJigUW44i8AXRWUvI
        0ULzV4uc8NWEdSOmUnPAJmeQQA5NRKnESC+Qmdo=
X-Google-Smtp-Source: APXvYqzEs6AnD9s4Ujye8/93FYd73X8WvcPXz/uUGMAfvAB2MGhLJcrmAz18HrCFYPjkb3eQMjJbiUb6ty0ryeRnaMU=
X-Received: by 2002:a50:aa2e:: with SMTP id o43mr3945953edc.67.1551443163953;
 Fri, 01 Mar 2019 04:26:03 -0800 (PST)
MIME-Version: 1.0
References: <20190227063737.24445-1-daniel.baluta@nxp.com> <20190227063737.24445-4-daniel.baluta@nxp.com>
 <CAOMZO5A7fe9U4qYegxiOC1sPApb22LcvpBLVgSz5XMWegDoZRA@mail.gmail.com>
In-Reply-To: <CAOMZO5A7fe9U4qYegxiOC1sPApb22LcvpBLVgSz5XMWegDoZRA@mail.gmail.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Fri, 1 Mar 2019 14:25:52 +0200
Message-ID: <CAEnQRZD7kDh1tHtXx53D8BzVymVGPen72jxETHdd5cqLEaHyTQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] arm64: dts: imx8mq: Add SAI2 node
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        "spencercw@gmail.com" <spencercw@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 8:49 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> On Wed, Feb 27, 2019 at 3:38 AM Daniel Baluta <daniel.baluta@nxp.com> wrote:
>
> > +                       sai2: sai@308b0000 {
> > +                               #sound-dai-cells = <0>;
> > +                               compatible = "fsl,imx8mq-sai",
> > +                                            "fsl,imx6sx-sai";
> > +                               reg = <0x308b0000 0x10000>;
> > +                               interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
> > +                               clocks = <&clk IMX8MQ_CLK_SAI2_IPG>,
> > +                                        <&clk IMX8MQ_CLK_DUMMY>,
> > +                                        <&clk IMX8MQ_CLK_SAI2_ROOT>,
> > +                                        <&clk IMX8MQ_CLK_DUMMY>, <&clk IMX8MQ_CLK_DUMMY>;
> > +                               clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
>
> mclk0 is not a valid entry as per the binding doc.

Indeed, will fix in next version. mclk0 is valid in our internal tree
because fsl_sai.c supports it.
Will remove mclk0 for now and re-add it when I will upstream the SAI patch.

Thanks Fabio for review!
