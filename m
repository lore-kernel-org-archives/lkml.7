Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D15C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91ACB206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556227749;
	bh=fXKxNIi5a/B3PpIuMmHIVsGGXiZch2q1OaB5IXDPSNk=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=sepBZDVDLRni1kiPbGSkWLsmPgbLDSuwBhJebcPGm/U9aXX3VTTG++VJkEdO6QS7n
	 csBV//wIbRUmQ/4/5QTmGOVxI8e1dxHlP108yGkprnyBpa09XUwDgE7y3VhMXakBAJ
	 zmP+lhZywiRw4HqsE9PjX9FdOQTe1r+N6nEqrC3E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbfDYV3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:29:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbfDYV3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 17:29:07 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97B6D20675;
        Thu, 25 Apr 2019 21:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556227746;
        bh=fXKxNIi5a/B3PpIuMmHIVsGGXiZch2q1OaB5IXDPSNk=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=d7U0G8hsoBgurdZXSYEozG88nOcjAM6GmHc6kdo0draNUpwZ3Sh1kyhKw3Ok9k3th
         CugbSicsafaalHPHFjkbB1iU+u22qXon6IreJaxb6OSms4P/WPolzUnPeVmjSHUZ88
         y9qNxLQjqSSaYBBpRvcuFUfdIWCS9blUklzpC+Do=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <31e17283-c374-f16e-df95-09aaf1854435@linaro.org>
References: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org> <1548700381-22376-6-git-send-email-jorge.ramirez-ortiz@linaro.org> <155085910216.77512.12604271825136479370@swboyd.mtv.corp.google.com> <31e17283-c374-f16e-df95-09aaf1854435@linaro.org>
Cc:     vkoul@kernel.org, niklas.cassel@linaro.org,
        georgi.djakov@linaro.org, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, khasim.mohammed@linaro.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 05/14] clk: qcom: apcs-msm8916: get parent clock names from DT
To:     Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>,
        andy.gross@linaro.org, arnd@arndb.de, bjorn.andersson@linaro.org,
        david.brown@linaro.org, enric.balletbo@collabora.com,
        heiko@sntech.de, horms+renesas@verge.net.au,
        jagan@amarulasolutions.com, jassisinghbrar@gmail.com,
        mark.rutland@arm.com, mturquette@baylibre.com, olof@lixom.net,
        robh+dt@kernel.org, sibis@codeaurora.org, will.deacon@arm.com
Message-ID: <155622774551.15276.4140891469702307355@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 25 Apr 2019 14:29:05 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jorge Ramirez (2019-04-22 04:44:50)
> On 2/22/19 19:11, Stephen Boyd wrote:
> > Quoting Jorge Ramirez-Ortiz (2019-01-28 10:32:52)
> >> @@ -61,6 +65,25 @@ static int qcom_apcs_msm8916_clk_probe(struct platf=
orm_device *pdev)
> >>         if (!a53cc)
> >>                 return -ENOMEM;
> >> =20
> >> +       /* check if the parent names are present in the device tree */
> >=20
> > This looks odd.
> >=20
> >> +       ret =3D devm_clk_bulk_get(parent, ARRAY_SIZE(pclks), pclks);
> >> +       if (ret =3D=3D -EPROBE_DEFER)
> >> +               return ret;
> >=20
> > Why can't we use of_clk_parent_fill() if we know this is always a DT
> > platform?  The parent clks may not be registered at the time of probe?
>=20
> yes, and AFAICS the important thing at this point is that the clock is
> registered hence the handling of defer.
>=20
> I could use of_clk_parent_fill and then - if needed - call
> devm_clk_bulk_get but I am not sure of the gains of doing it (wouldnt
> this just make the code more confusing?)

Yeah of_clk_parent_fill() isn't the best approach. But it at least keeps
this driver from using clk consumer APIs?

>=20
>=20
> > Maybe this series should wait for the parent registration stuff I'm
> > working on so that this can be made simpler.
>=20
> the need for the clock name is not intrinsic to this driver (the driver
> itself doesnt use these names) but it just feeds these to the framework.
>=20
> I was looking into your parent registration code and I am not sure how
> can I use it in this particular driver other than simply removing the
> names and hoping that things are handled properly at the lower
> levels.... could you clarify please?
>=20

I think so. I've forgotten the context of this patch, but the general
idea would be to specify the parents with clock-names or DT index in the
DT node for the clks registered here and not use of_clk_parent_fill() or
do any sort of devm_clk_bulk_get() calls. Then the framework will take
care of finding the parents for the clks and hooking things up properly
for the parent-child relationship.

