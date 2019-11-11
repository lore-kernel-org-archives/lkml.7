Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F96EC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C88206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfKKSLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:11:47 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37330 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfKKSLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:11:47 -0500
Received: by mail-oi1-f195.google.com with SMTP id y194so12325855oie.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 10:11:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3pgVptoZYzsTOg+Xnbn8wJxFJTLIjKkmJmwvN7XoJgQ=;
        b=i9ch4lILRaYqfz/biLOzhARRxhRCCeK3gnVplQShtM/nd+5UbGdqmLYsR4tPaMnvI8
         rU8IX4XJ1RembDWbHn9/sJ+e8tJV/laUzzjIBHFMeSQarQkEjliPeJw4B3Di1Iux8h1w
         uBcLlToGB33i6Gpb5sjZqMf73JEiORYGDmOKqY5ggBLWwSjxgPKxELtKOHLiyMG+RiKR
         sOIWk+uQ5sdPG8uhsZutjfrlq09+BFLi5TCrEiRl9hzwOKTIOD5oIhHTP5JnGNvnVmZw
         Z4NqFP+Vimio1Y/iJHx7Maj4hxEtpcnCBKm1gE9OMacV4wCyudog46ejd5l5JlVflGBl
         LNwA==
X-Gm-Message-State: APjAAAWbJM5laRBlAP1Iv0+lrnMfgJhiDbnSdBOAByyEYZGa1OkyO6+p
        RQEdqVCoKjdiCi43jBuHkyRy2ssE
X-Google-Smtp-Source: APXvYqy1X0wUWZC/1e18BAMqn7WeVSGS3O2hmYUeKDVYF64U8jTw3M0qNMsxoRWRrfZio7C6Hh1zTg==
X-Received: by 2002:a05:6808:8e9:: with SMTP id d9mr241839oic.29.1573495906199;
        Mon, 11 Nov 2019 10:11:46 -0800 (PST)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com. [209.85.167.174])
        by smtp.gmail.com with ESMTPSA id z13sm5118596otq.29.2019.11.11.10.11.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2019 10:11:45 -0800 (PST)
Received: by mail-oi1-f174.google.com with SMTP id l20so12289218oie.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 10:11:45 -0800 (PST)
X-Received: by 2002:aca:1702:: with SMTP id j2mr240762oii.13.1573495904943;
 Mon, 11 Nov 2019 10:11:44 -0800 (PST)
MIME-Version: 1.0
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
 <20191108130123.6839-48-linux@rasmusvillemoes.dk> <CADRPPNQwnmPCh8nzQ5vBTLoieO-r2u0huh17mwcinhfhNgo04A@mail.gmail.com>
 <14894529-a6bd-9b7e-eacc-06d5e49cc8e8@rasmusvillemoes.dk>
In-Reply-To: <14894529-a6bd-9b7e-eacc-06d5e49cc8e8@rasmusvillemoes.dk>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Mon, 11 Nov 2019 12:11:33 -0600
X-Gmail-Original-Message-ID: <CADRPPNQHtRhZOw0DuTQoPF_RgFHSFG4rGCtETFvCCSS8H6i=iQ@mail.gmail.com>
Message-ID: <CADRPPNQHtRhZOw0DuTQoPF_RgFHSFG4rGCtETFvCCSS8H6i=iQ@mail.gmail.com>
Subject: Re: [PATCH v4 47/47] soc: fsl: qe: remove PPC32 dependency from CONFIG_QUICC_ENGINE
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     lkml <linux-kernel@vger.kernel.org>, Scott Wood <oss@buserror.net>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Qiang Zhao <qiang.zhao@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 1:36 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 09/11/2019 00.48, Li Yang wrote:
> > On Fri, Nov 8, 2019 at 7:05 AM Rasmus Villemoes
> > <linux@rasmusvillemoes.dk> wrote:
> >>
> >> There are also ARM and ARM64 based SOCs with a QUICC Engine, and the
> >> core QE code as well as net/wan/fsl_ucc_hdlc and tty/serial/ucc_uart
> >> has now been modified to not rely on ppcisms.
> >>
> >> So extend the architectures that can select QUICC_ENGINE, and add the
> >> rather modest requirements of OF && HAS_IOMEM.
> >>
> >> The core code as well as the ucc_uart driver has been tested on an
> >> LS1021A (arm), and it has also been tested that the QE code still
> >> works on an mpc8309 (ppc).
> >>
> >> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> >> ---
> >>  drivers/soc/fsl/qe/Kconfig | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/soc/fsl/qe/Kconfig b/drivers/soc/fsl/qe/Kconfig
> >> index cfa4b2939992..f1974f811572 100644
> >> --- a/drivers/soc/fsl/qe/Kconfig
> >> +++ b/drivers/soc/fsl/qe/Kconfig
> >> @@ -5,7 +5,8 @@
> >>
> >>  config QUICC_ENGINE
> >>         bool "QUICC Engine (QE) framework support"
> >> -       depends on FSL_SOC && PPC32
> >> +       depends on OF && HAS_IOMEM
> >> +       depends on PPC32 || ARM || ARM64 || COMPILE_TEST
> >
> > Can you also add PPC64?  It is also used on some PPC64 platforms
> > (QorIQ T series).
>
> Sure, but if that's the only thing in the whole series, perhaps you
> could amend it when applying instead of me sending all 47 patches again.

Sure.  I can do that.

>
> Should PPC32 || PPC64 be spelled PPC?

Yes.  That will be good.

Regards,
Leo
