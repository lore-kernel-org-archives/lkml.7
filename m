Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA153ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A66B32070B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730479AbfJAQbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:31:47 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43581 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390015AbfJAQ3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:29:47 -0400
Received: by mail-qt1-f195.google.com with SMTP id c3so22346429qtv.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 09:29:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0zO73icoSPJ3pNVWiNNF9L9OEEbriWKwEbaN0EtJRPI=;
        b=Tsg+Giwtb9vEFQq8cmb+LwT6HAsYySoWGoTlcKuMP9PgGqXnPN5k5asSFSd99SyOLj
         42VONpB1QvKyv+KCCpqg0+jEWnzF9kcZZwNh7cmsu6p7JLArwqfBAglCC5uWgHryX07Y
         Aak4wCsBFq46LITl1oHwIMU8jGeh5ttKcd1Y+sOsRRxzpTLNUUaZRK7H+l2iBqUX4MaK
         dk2VfOjy5oJkcI30A0HbgljPIpUV4qjjQ+uvwZOoEJIY79HcHEf4Dncml///uBrGJbb8
         VceSnBFHR8ZY1kcoMfM6b6ZrPa8KVwCQlfc7z0H0ccZzTBr5jBcCFwMkpQfXO9QHTYzm
         DTBg==
X-Gm-Message-State: APjAAAW85jpCTdMVqr0vmk+Fq6Ar1qRAPFC35gXnGESsM2btCouoiZ4l
        cf5dPTqUssGlFNxPW8dt8klDQLgpDcBACcjx7rA=
X-Google-Smtp-Source: APXvYqxkgIX2gcVaLjsRtcgaC+7CiGnoTPy8gmARgU5xbBtCjA5leLB24V7ISErrIwWtMs8YA3rGRE+qoQ6Sf7PgVcI=
X-Received: by 2002:ac8:1a2e:: with SMTP id v43mr31469917qtj.204.1569947386677;
 Tue, 01 Oct 2019 09:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <20191001142026.1124917-1-arnd@arndb.de> <bb58c7cc-209d-7a2f-0e5b-95a9605ffe7b@linux.intel.com>
 <CAK8P3a3Js2dNhnRhP7PLadWZ69DZr1mz6DowN9HDJL4CFDAAFw@mail.gmail.com> <e4b90233-846c-bfc1-68a3-a7b7c28b60bd@linux.intel.com>
In-Reply-To: <e4b90233-846c-bfc1-68a3-a7b7c28b60bd@linux.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 1 Oct 2019 18:29:30 +0200
Message-ID: <CAK8P3a1vHECVV86JHxEZmo7jQOosHO=H33v784keqLMNiiHSxA@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: SOF: imx: fix reverse
 CONFIG_SND_SOC_SOF_OF dependency
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>, Hulk Robot <hulkci@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 1, 2019 at 6:03 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
> On 10/1/19 10:41 AM, Arnd Bergmann wrote:
> > On Tue, Oct 1, 2019 at 5:32 PM Pierre-Louis Bossart
> > <pierre-louis.bossart@linux.intel.com> wrote:

> >
> > The same could be done with a Kconfig-only solution avoiding
> > 'select' such as:
> >
> > config SND_SOC_SOF_IMX8_SUPPORT
> >           bool "SOF support for i.MX8"
> >           depends on IMX_SCU
> >           depends on IMX_DSP
> >
> >   config SND_SOC_SOF_IMX8
> >           def_tristate SND_SOC_SOF_OF
> >           depends on SND_SOC_SOF_IMX8_SUPPORT
>
> Ah, nice, thanks for the suggestion! That would be my preference, we
> have a similar select for PCI and ACPI parts in sound/soc/sof/Kconfig
> and I was looking for a means to do this more elegantly.
> I can submit a new fix or let you sent a v2, whatever is more convenient.

Ok, please send a patch then, I can add it to my randconfig test tree to
make sure it covers all corner cases.

    Arnd
