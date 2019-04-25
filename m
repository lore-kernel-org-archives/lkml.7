Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CD4C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF602077C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556225894;
	bh=8m5+haKLvhFLfF1z86HrpUJs3hxsLdAiFKGFP5CKDf8=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=gP9nPWlXg+RHCuAG7NnPwrJwRpj6/APrZ+koQVYrLiHmy9bLPC/naYUrVJc2FFHI5
	 bsifna0JIv+o13J58BGJvr3UQDdEWycnyvwZCd4DqK5PmpUPhxC0JMFznSMJJs8tNX
	 gvpbyDdEE0my34Uy2WE8cH7ZpxJhl6AVvJsNrJQ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfDYU6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 16:58:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:60304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbfDYU6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 16:58:12 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C347206BF;
        Thu, 25 Apr 2019 20:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556225892;
        bh=8m5+haKLvhFLfF1z86HrpUJs3hxsLdAiFKGFP5CKDf8=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=fjc1pXU15rRcX8MvSe2qKPdkxu7boJVCvBSM5cEBGyd9nN6WKHFt2rNpBQ4bN7DjD
         oOA81PwYZrMm/IiJeggPhNPJL7RdGBpPRzcaUTg4at/+uKgqC6GoZt2TKsRN1t+TzT
         Af2AnmwAPREgiUfaPlJD7pLZlgib2EWd+pWjX8xM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190425203139.GO14604@piout.net>
References: <20190402125056.21509-1-alexandre.belloni@bootlin.com> <20190402125056.21509-8-alexandre.belloni@bootlin.com> <155622113579.15276.15900194435736283135@swboyd.mtv.corp.google.com> <20190425203139.GO14604@piout.net>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 7/7] clk: at91: add sam9x60 pmc driver
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Message-ID: <155622589096.15276.8583738150370510787@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 25 Apr 2019 13:58:10 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexandre Belloni (2019-04-25 13:31:39)
> On 25/04/2019 12:38:55-0700, Stephen Boyd wrote:
> > Quoting Alexandre Belloni (2019-04-02 05:50:56)
> > > diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
> > > new file mode 100644
> > > index 000000000000..22bf51c55bdc
> > > --- /dev/null
> > > +++ b/drivers/clk/at91/sam9x60.c
> > > @@ -0,0 +1,307 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +#include <linux/clk-provider.h>
> > > +#include <linux/mfd/syscon.h>
> > > +#include <linux/slab.h>
> > > +
> > > +#include <dt-bindings/clock/at91.h>
> > > +
> > > +#include "pmc.h"
> > > +
> > > +DEFINE_SPINLOCK(pmc_pll_lock);
> > > +
> > > +static const struct clk_master_characteristics mck_characteristics =
=3D {
> > > +       .output =3D { .min =3D 140000000, .max =3D 200000000 },
> > > +       .divisors =3D { 1, 2, 4, 3 },
> > > +       .have_div3_pres =3D 1,
> > > +};
> > > +
> > > +static const struct clk_master_layout sam9x60_master_layout =3D {
> > > +       .mask =3D 0x373,
> > > +       .pres_shift =3D 4,
> > > +       .offset =3D 0x28,
> > > +};
> > > +
> > > +static struct clk_range plla_outputs[] =3D {
> >=20
> > const?
> >=20
>=20
> Right, can you fix that up or should I send a new version?
>=20

I can fix it.

> > > +       { .min =3D 300000000, .max =3D 600000000 },
> > > +};
> > [...]
> > > +
> > > +}
> > > +
> > > +CLK_OF_DECLARE_DRIVER(sam9x60_pmc, "microchip,sam9x60-pmc", sam9x60_=
pmc_setup);
> > > --=20
> >=20
> > Can't be platform device?
> >=20
>=20
> IIRC two clocks are used by the clocksource and having it as a platform
> device make the clocksource driver fail with -EPROBE_DEFER.
>=20

Ok. I'll add a comment in the driver. It needs to be
CLK_OF_DECLARE_DRIVER() because it's used somewhere else too? Or it can
be CLK_OF_DECLARE() instead?
