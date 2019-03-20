Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1628C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8977218A5
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/1LToRC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfCTREu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:04:50 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44440 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbfCTREu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:04:50 -0400
Received: by mail-lf1-f68.google.com with SMTP id u9so2423450lfe.11;
        Wed, 20 Mar 2019 10:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mLVzHO1dIbiYcvX6Ao4KI3q1rS7zqplkW3u9s5kL/oQ=;
        b=b/1LToRC6Y7HhNjC0aZ158JKVQO1QYTdecoKoyYZ+Bf9TEplws1xTPIWmv56Z4S7Cl
         xdmhfAb/FI1jbUPwyT8ax4v53EUSNYX9Pa4ekwOO1YY+hhJOqzL07cSLy8Jk68WXtE1A
         xFVlmSrMtO5vVB+Z6YSBoKkK4Y5CygV/8Sgna/jiy+bdoCySqx3bztLI7lYjkYrBurm0
         N4tIelC3wAAiuwOmC9BqvyBOksKLPpSHIXuksEBEK5NuMVJfm3c0XNQg9fOxssWoXEwU
         xPLxKEh1hJ6dgHMXcE3n5NLd0VfEziDbDXL15dZBqbTqvqx1nu8aujI6f0gizeZf8klD
         8xVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mLVzHO1dIbiYcvX6Ao4KI3q1rS7zqplkW3u9s5kL/oQ=;
        b=aKWC5jHJQHxqrolvz6j7Ue2hzR5f5cRtvi4s6i7Tx/dDptPvGVpCNOze663gBUOU0a
         k6GA0EpAO6Bl0vvtFK/ezuBxKVCsYSwnwlABKenkDRIsC0REqDCn5VdWyK+Nlt9yHnF4
         ySc9DoIJAquaM2Y+v1lcCMHvoTdWAV90rPjmUqD+j/L7SbvXghH5xQNJtTYieLK/rVkg
         Z/BdPWg0fgR24yjQokgq6ghDi5VZOfHSUF/le/j1O5XgZ5gob7waeKBBbUQtjwR6mk2L
         jXfs50ofuFXND1hwTKivQWIN5GrIM7LIp8uzyGvGhkkte0kERczOJFUGUuOtKDXKld9A
         FSRw==
X-Gm-Message-State: APjAAAXiLUBPUfPC6764qBqefYzAKqcbiQg6kc11hchGFn0gUFMHm8z9
        EQCTRS9vMK/25xeQyn4p5ROnjAQmxa+aKRg/aus=
X-Google-Smtp-Source: APXvYqzkzvWroh8DDnyh4XKhK2VCuC5gE5Ma6lT5ARm7z0coUYKawBT7qCGKEa7sxyIua+dvI07vUUFC4l/yzgad5UI=
X-Received: by 2002:ac2:4561:: with SMTP id k1mr15865784lfm.95.1553101487397;
 Wed, 20 Mar 2019 10:04:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190320120604.7D99B3FBE9@swsrvapps-01.diasemi.com>
 <CAOMZO5AHzQJzz3vd5MzYgSSxzPjU9xan1dFh9473BXeiRCOzzg@mail.gmail.com> <VI1PR10MB2352C3A55BE8FABAF3B02681FE410@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <VI1PR10MB2352C3A55BE8FABAF3B02681FE410@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 20 Mar 2019 14:04:42 -0300
Message-ID: <CAOMZO5By8=j7gZRAdf2-h-5ak-Qo34rqwDL4+HA_97cMXTAnEQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6qdl-sabresd: change phy-mode to use rgmii-id
To:     Steve Twiss <stwiss.opensource@diasemi.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        DEVICETREE <devicetree@vger.kernel.org>,
        LINUX-ARM-KERNEL <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

[Adding Andrew]

On Wed, Mar 20, 2019 at 1:03 PM Steve Twiss
<stwiss.opensource@diasemi.com> wrote:
>
> Hi Fabio,
>
> On 20 March 2019 12:17, Fabio Estevam wrote:
> > Subject: Re: [PATCH] ARM: dts: imx6qdl-sabresd: change phy-mode to use rgmii-id
> >
> > Hi Steve,
> >
> > On Wed, Mar 20, 2019 at 9:06 AM Steve Twiss
> > <stwiss.opensource@diasemi.com> wrote:
> > >
> > > The PHY used on the Freescale i.MX6Q/DL SABRE boards is qualified as
> > > 'rgmii' instead of 'rgmii-id'. Meaning the RX and TX delays that were
> >
> > This patch declares it as 'rgmii-id', which contradicts the commit log.
>
> The PHY used on the Freescale i.MX6Q/DL SABRE boards is qualified as
> 'rgmii' instead of 'rgmii-id'.
>
> Can that be read two ways?
> I meant the phy-mode is currently qualified as 'rgmii' instead of what it
> should be: 'rgmii-id'.

Thanks for the clarification.

>
> [...]
>
> > > This patch fixes the network problems seen on the Freescale i.MX6Q/DL
> >
> > Please provide a Fixes tag. It would be good to know if this fix needs
> > to be applied to older kernels.
>
> I didn't put a Fixes tag in because I find this patch fixes v5.1-rc1 (which I see as broken).
> But the patch is not needed in v5.0 because I see that as working.
> So didn't see the need for a Cc: stable.

It seems we have other boards that need to be fixed and we can not
have an old dtb with functional Ethernet with a new kernel.

Does anyone know if this issue is AR8031 specific?

Thanks
