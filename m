Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12832C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31A62205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556221140;
	bh=tS+iPox5jtN9Ldjz88oImhdUJkmle0a+FcnNsF7XGsM=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=wv7psQWgoh9ZZ2OWSeU1EFiz/OC9f+S935S3hR1A8QHlEiIPkTZNtgbCoSzaDe4qh
	 Ra8yp/TKjpRuTFea/sDxiOWHlcgOs7JYLDDMfsHwEkKXs1lFXeZ2iofveZEAA36xCP
	 K5IvqsTfuQDwSsQhW8M2QCGTZmPDJ5tVgrGdBApU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730668AbfDYTi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:38:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbfDYTi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:38:57 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C74E020878;
        Thu, 25 Apr 2019 19:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556221136;
        bh=tS+iPox5jtN9Ldjz88oImhdUJkmle0a+FcnNsF7XGsM=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=pMeWqnC69nLOJAccAGey3trTpp3x5bWilCcA901bV+KdjvOxtv9cTACxEop+J45Vx
         7UcXEDAYGprPwqEsmwlO2CX05pCBJfjX9YplfKm/e0pF4+bgLFIPEhuZiEaFjjzmBy
         86kFYHqkpDj5vI5InDs+W3lzdS4x2iQNTlBCttWo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190402125056.21509-8-alexandre.belloni@bootlin.com>
References: <20190402125056.21509-1-alexandre.belloni@bootlin.com> <20190402125056.21509-8-alexandre.belloni@bootlin.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 7/7] clk: at91: add sam9x60 pmc driver
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Message-ID: <155622113579.15276.15900194435736283135@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 25 Apr 2019 12:38:55 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexandre Belloni (2019-04-02 05:50:56)
> diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
> new file mode 100644
> index 000000000000..22bf51c55bdc
> --- /dev/null
> +++ b/drivers/clk/at91/sam9x60.c
> @@ -0,0 +1,307 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/clk-provider.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/slab.h>
> +
> +#include <dt-bindings/clock/at91.h>
> +
> +#include "pmc.h"
> +
> +DEFINE_SPINLOCK(pmc_pll_lock);
> +
> +static const struct clk_master_characteristics mck_characteristics =3D {
> +       .output =3D { .min =3D 140000000, .max =3D 200000000 },
> +       .divisors =3D { 1, 2, 4, 3 },
> +       .have_div3_pres =3D 1,
> +};
> +
> +static const struct clk_master_layout sam9x60_master_layout =3D {
> +       .mask =3D 0x373,
> +       .pres_shift =3D 4,
> +       .offset =3D 0x28,
> +};
> +
> +static struct clk_range plla_outputs[] =3D {

const?

> +       { .min =3D 300000000, .max =3D 600000000 },
> +};
[...]
> +
> +}
> +
> +CLK_OF_DECLARE_DRIVER(sam9x60_pmc, "microchip,sam9x60-pmc", sam9x60_pmc_=
setup);
> --=20

Can't be platform device?

