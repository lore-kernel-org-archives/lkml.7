Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C193FC6195
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2157D21924
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbfKHUUO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 15:20:14 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42201 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727700AbfKHUUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 15:20:14 -0500
Received: by mail-oi1-f194.google.com with SMTP id i185so6367925oif.9;
        Fri, 08 Nov 2019 12:20:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TTr4MjjfOlkLTqlNf4kUTvL6kdP50wKBKc/067BKT2E=;
        b=rXSu/4MO4L0DAhXV1eOyzj76OqlRIoaH2tBt4edRexuXwFOJNC7Yq86PhQXMQO+O0E
         CBkuy3u8POuSPfE0s4tg8MOuEogOZ+znASobIjPe0Qo+JKp1qt1GFohUFG8csNRKmG+9
         5/1Ef4vydzEm3qmvnnVQh8Q4EXw75zm9miGhetyPy036EQnR75nb5PJQi2Sm47yhT7g9
         VzFM3ILY1aawSMNjQt3rAae68WNq5lWMTYWtJbGeRUIjR3wG2nZ9lwckZ7ME+QCQ4ZvA
         q/+UaBXFZqlh3KJpHy8jP9mg26XnFS9BPtYgwGVrv9Q565lgAD7ZSj+OYPv1KioMZDMW
         0gcQ==
X-Gm-Message-State: APjAAAUvXem8oeTCXwybMC6hiLyD42hlmqLAHhwQLlCDLtFroCwmWxcn
        kbo7oyKaeQIhcNyTvzclWHHFDxBH
X-Google-Smtp-Source: APXvYqx4OzTlh++e0Tu9KcZWFHG/OBQ7xbY38kxMiZmsZvXuN4szra7xwHPL+8xcG4S9DShOOnf0KQ==
X-Received: by 2002:a54:4481:: with SMTP id v1mr11029392oiv.152.1573244412628;
        Fri, 08 Nov 2019 12:20:12 -0800 (PST)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com. [209.85.167.176])
        by smtp.gmail.com with ESMTPSA id m205sm2178604oif.10.2019.11.08.12.20.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2019 12:20:12 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id y194so6398652oie.4;
        Fri, 08 Nov 2019 12:20:12 -0800 (PST)
X-Received: by 2002:aca:913:: with SMTP id 19mr9921384oij.51.1573244411904;
 Fri, 08 Nov 2019 12:20:11 -0800 (PST)
MIME-Version: 1.0
References: <20191105090221.45381-1-wen.he_1@nxp.com> <20191105090221.45381-2-wen.he_1@nxp.com>
 <VE1PR04MB66879681CE5231F5C80F85148F7E0@VE1PR04MB6687.eurprd04.prod.outlook.com>
 <DB7PR04MB51956205E7FE92C9EB00A882E2780@DB7PR04MB5195.eurprd04.prod.outlook.com>
 <20191107225745.1A01C2178F@mail.kernel.org> <DB7PR04MB51959C3CF461F68AE99FA728E27B0@DB7PR04MB5195.eurprd04.prod.outlook.com>
In-Reply-To: <DB7PR04MB51959C3CF461F68AE99FA728E27B0@DB7PR04MB5195.eurprd04.prod.outlook.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Fri, 8 Nov 2019 14:20:00 -0600
X-Gmail-Original-Message-ID: <CADRPPNQ8zf_+205OK=g1FvKpjghFwuyBVW3Wy4zC8VMN2bLdhQ@mail.gmail.com>
Message-ID: <CADRPPNQ8zf_+205OK=g1FvKpjghFwuyBVW3Wy4zC8VMN2bLdhQ@mail.gmail.com>
Subject: Re: [EXT] RE: [v6 2/2] clk: ls1028a: Add clock driver for Display
 output interface
To:     Wen He <wen.he_1@nxp.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-devel@linux.nxdi.nxp.com" <linux-devel@linux.nxdi.nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 7, 2019 at 8:21 PM Wen He <wen.he_1@nxp.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Stephen Boyd <sboyd@kernel.org>
> > Sent: 2019年11月8日 6:58
> > To: Leo Li <leoyang.li@nxp.com>; Mark Rutland <mark.rutland@arm.com>;
> > Michael Turquette <mturquette@baylibre.com>; Rob Herring
> > <robh+dt@kernel.org>; Wen He <wen.he_1@nxp.com>;
> > devicetree@vger.kernel.org; linux-clk@vger.kernel.org;
> > linux-devel@linux.nxdi.nxp.com; linux-kernel@vger.kernel.org
> > Subject: [EXT] RE: [v6 2/2] clk: ls1028a: Add clock driver for Display output
> > interface
> >
> > Caution: EXT Email
> >
> > Quoting Wen He (2019-11-06 19:13:48)
> > >
> > > > > diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile index
> > > > > 0138fb14e6f8..d23b7464aba8 100644
> > > > > --- a/drivers/clk/Makefile
> > > > > +++ b/drivers/clk/Makefile
> > > > > @@ -45,6 +45,7 @@ obj-$(CONFIG_COMMON_CLK_OXNAS)
> > +=
> > > > > clk-oxnas.o
> > > > >  obj-$(CONFIG_COMMON_CLK_PALMAS)            += clk-palmas.o
> > > > >  obj-$(CONFIG_COMMON_CLK_PWM)               += clk-pwm.o
> > > > >  obj-$(CONFIG_CLK_QORIQ)                    += clk-qoriq.o
> > > > > +obj-$(CONFIG_CLK_LS1028A_PLLDIG)   += clk-plldig.o
> > > >
> > > > Wrong ordering.  This section of Makefile requires ordering by
> > > > driver file
> > > > name:
> > > >
> > > > # hardware specific clock types
> > > > # please keep this section sorted lexicographically by file path
> > > > name
> > > >
> > >
> > > Hi Leo,
> > >
> > > Stephen once suggest the Kconfig variable name should be given a more
> > > specific name like CLK_LS1028A_PLLDIG, so I have to changed it.
> > >
> > > Hi Stephen,
> > >
> > > How do you think?
> > >
> >
> >
> > Config name looks fine to me, but you haven't sorted this based on the file
> > name, i.e. clk-plldig.o, so please insert this in the right place in this file.
>
> Wow, Understand now..
>
> Should be sort this file like below, right?
> obj-$(CONFIG_COMMON_CLK_PWM)   += clk-pwm.o
> obj-$(CONFIG_CLK_LS1028A_PLLDIG)   += clk-plldig.o
> obj-$(CONFIG_CLK_QORIQ)           += clk-qoriq.o

No.  The correct order should be:
clk-plldig.o
clk-pwm.o
clk-qoriq.o

Regards,
Leo
