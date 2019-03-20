Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D4EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F40262184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUus2bN4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfCTNlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:41:40 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35005 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfCTNlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:41:40 -0400
Received: by mail-io1-f65.google.com with SMTP id x4so2006965ion.2;
        Wed, 20 Mar 2019 06:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yWQxIaGEcNNHwP1PrFRGJbkI50ZXgmB5FyRWhNBglNc=;
        b=iUus2bN480mtgEaJltYKWxaW0/ryDqQY57Cvdda2uqfAFOkagNwb3KrPiLZe8hxKF5
         YYR5dbICZICX1Kb+bYW72bXJV4w0AeJVARoU0bQaTXV85k7icozJGXjFAEalVyMn1Ejz
         gNLeiLqXr9M3W7exVLqJKCDB6QU5EAyFugMClAi6wFWt7T4zS8kraqAVl36h7/Ny2Fcp
         Lk/hL8c1yt6gSDRg3+HytAkA1Q8ujrcNil92uV4QA6g65+Mx9Fe4VL0frUOZ1VCeuZ4u
         P3ufMDpaKHoF/aoSbSnQQOZjfeULFu3sFynb7EbXFsm3yHmhJe7DUoWwLgecrwIaLDLW
         KN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yWQxIaGEcNNHwP1PrFRGJbkI50ZXgmB5FyRWhNBglNc=;
        b=pExfs4GEDubshPcqmfnlSk5EmoCZICG6Vf/ps+mr4FVxQnU79ikFWfoMs69UYKCK5p
         wsPvtStQnTt+A6w0G7dyDjIZG2mwdNqqX0+yoIxdFnAjQEc345peao3uZMLuNMhtGrsb
         Xd3O6TedfCHvuGI21Ro/RNLPu/l2isRaPS9+QhxRIAbAjDpAUEBJTcKOIKarlLepoEzR
         YjV4TOtNuPHXhxO820CBbyqcAe+ToWRE125viqjz8n6q1Fieu4DslqNgT2ej5cMh7b+O
         wYsCoRBwTZJYlmoA6neLR+6v+qcL238AoV0UgSVHq+3jqsADOampLunELoGqSVPqUcBb
         NrpQ==
X-Gm-Message-State: APjAAAVdwb41wRPltuMElDuVbGEKe+c0CmdEInJ8m1cRESChWADCKjVl
        Y7ucap+0iY+aU35EQpWkSkO40QES+Lv0La4fCeM=
X-Google-Smtp-Source: APXvYqzfmL9seQ89XQcHzzGw3+JU372eyRQ+JtrV0SjnPQIQdAjuxmNSans84+uGbEjmazgpuIjow8J30xNAKYADSu0=
X-Received: by 2002:a6b:8f0a:: with SMTP id r10mr5120888iod.22.1553089298997;
 Wed, 20 Mar 2019 06:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190306140402.17122-1-aford173@gmail.com> <20190306140402.17122-2-aford173@gmail.com>
 <20190320124446.GO4980@dragon>
In-Reply-To: <20190320124446.GO4980@dragon>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 20 Mar 2019 08:41:27 -0500
Message-ID: <CAHCN7x+DKh8bR17C90o-zKKnFqWe_Yz5EM68xEiSY0W6ufNARA@mail.gmail.com>
Subject: Re: [PATCH 2/3] ARM: DTS: imx6q-logicpd: Reduce inrush current on start
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     arm-soc <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 7:45 AM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Wed, Mar 06, 2019 at 08:04:00AM -0600, Adam Ford wrote:
> > The main 3.3V regulator sources a series of additional regulators.
> > This patch adds a small delay, so when the 3.3V regulator comes
> > on it delays a bit before the subsequent regulators can come on.
> > This reduces the inrush current a bit on the external DC power
> > supply.
> >
> > Fixes: 1c207f911fe9 ("ARM: dts: imx: Add support for Logic PD
> > i.MX6QD EVM")
>
> Same comment as patch #1.

The sourcing regulator occasionally cuts out because the inrush is so
high.  I would argue that preventing a hardware issue like that would
be a 'fix' and if it helps, I could add that to the description.

>
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
>
> To match the convention, the 'DTS' in subject prefix should be
> lowercase.

I will fix in V2.

>
> Shawn

adam
>
> >
> > diff --git a/arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi b/arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi
> > index fb01fa6e4224..e31b6923cb72 100644
> > --- a/arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi
> > +++ b/arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi
> > @@ -99,6 +99,7 @@
> >               regulator-min-microvolt = <3300000>;
> >               regulator-max-microvolt = <3300000>;
> >               gpio = <&gpio1 26 GPIO_ACTIVE_HIGH>;
> > +             startup-delay-us = <70000>;
> >               enable-active-high;
> >               regulator-always-on;
> >       };
> > --
> > 2.17.1
> >
