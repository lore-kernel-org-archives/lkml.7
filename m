Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A3CC17445
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 10:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C6B0214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 10:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/zMtGeO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfKKKbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 05:31:20 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34313 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfKKKbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 05:31:20 -0500
Received: by mail-ed1-f65.google.com with SMTP id b72so11528093edf.1;
        Mon, 11 Nov 2019 02:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2uBfmf0jH0jW8Ak0g/jqH8W5nvxj13Znc64ubl99LEk=;
        b=j/zMtGeO0BmSNrdrMu1SrfaRsr4kigGMqwYv0UE8ouLUl0QDdAy7Vq7okOCjjiczEI
         AJSlSD12qhlSltHaaDllK52o2Lx5tRVWiAmru4rU/7QDtDYi+4GMVTqhIdFAY7ZY4C9H
         nizOi5STW/rjZCCb+R/gICoFmHmybIoh0sYpC4IEtGQVvo8C3hBPO1oH/QZuiMbxf05D
         I7Ho9imA4KVUgXtAvuePxP4ocgRXdNyiGa/PtJynLhQQNJu5m4AVAOmzi0RfnJUommCd
         ULvVXSf/igtLDOanbypmSP6SQ/gLhDNYTxggh2EJqGMU8WzLZ0BMK8mLuUe9OPxJNMCg
         JNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2uBfmf0jH0jW8Ak0g/jqH8W5nvxj13Znc64ubl99LEk=;
        b=ZM8ctCv8kgFo8+TlydR4+YX1Ouh7Mp96U01YzIkHg8DpZRcPoIKJnjR2lbD8E9FiKT
         rcmJ8Fm0Btq9Qt/B5kiXo17obP2EEg+mamv5OUOVKZl8KPE7emorvs1I1uymsn+Uln//
         tja2gha5GVJ3RsPgtuJj7vibjzB0gIKf+SiuSasKKcKDh+0HXEvHhj1mr0sjhOkfHJAH
         A/cIOYJ9aTaMqHWxqG1PwqycGhxtp2sZP4bJROkLNjFMJ6aSIs0cDEryV96Lxqt8zJoA
         epJ+/HPfoqksMXfiVBtDqi500Q+tC2EEwUsDCVOHGpm3EhUjkIFVDRIz6fqulKjIEESv
         Lm0g==
X-Gm-Message-State: APjAAAUE28RD0ncEggse8KXPhpVhEnzwt/4mssMP3MueC3tw2cBJTAOf
        jNiSqb9eaXLrdVaMdt97rcpaKyB5DZqGp+3tKpgwkh4x
X-Google-Smtp-Source: APXvYqwIRl3G1diHLMcxzPXPFWdQZe1LF8G9C/IgjC26glYSasbKQj+LOcE8QAX5/X4q48KWqOHZ9LlZj/uZgBX9dE4=
X-Received: by 2002:a17:906:1d19:: with SMTP id n25mr21347136ejh.151.1573468276893;
 Mon, 11 Nov 2019 02:31:16 -0800 (PST)
MIME-Version: 1.0
References: <20191107122115.6244-1-linux@rasmusvillemoes.dk> <ea802f081d1f1d4c5359707ff4553004@www.loen.fr>
In-Reply-To: <ea802f081d1f1d4c5359707ff4553004@www.loen.fr>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Mon, 11 Nov 2019 12:31:05 +0200
Message-ID: <CA+h21ho-P3P+ZwVp4uYHYrTzF0V-b+OsBkMKVo3rHC_OV5Y_6Q@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] Add support for Layerscape external interrupt lines
To:     Marc Zyngier <maz@kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        lkml <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
        Kurt Kanzenbach <kurt@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Nov 2019 at 12:24, Marc Zyngier <maz@kernel.org> wrote:
>
> On 2019-11-07 13:30, Rasmus Villemoes wrote:
> > In v7, I've tried to change from a custom binding to use
> > interrupt-map, modelled on the recent addition of the
> > renesas,rza1-irqc (commits a644ccb819bc and 5e27a314a11f). It's
> > possible that the interrupt-map parsing code can be factored to a
> > common helper, but it's a bit hard to generalize from two examples to
> > know what a good interface would look like.
> >
> > The interrupt-map-mask is a bit arbitrary. 0xff would likely work
> > just
> > as well (but I think the ls2088a has 32 external lines, so it has to
> > be a least 0x1f).
> >
> > Also, this drops the fsl,bit-reverse property and instead reads the
> > SCFGREVCR register to determine if bit-reversing is needed.
> >
> > The dt/bindings patch now comes first in accordance with
> > Documentation/devicetree/bindings/submitting-patches.txt.
> >
> > Earlier versions can be found here:
> >
> > v6:
> > https://lore.kernel.org/lkml/20190923101513.32719-1-kurt@linutronix.de/
> > v5:
> >
> > https://lore.kernel.org/lkml/20180223210901.23480-1-rasmus.villemoes@prevas.dk/
> >
> > Rasmus Villemoes (2):
> >   dt/bindings: Add bindings for Layerscape external irqs
> >   irqchip: add support for Layerscape external interrupt lines
> >
> >  .../interrupt-controller/fsl,ls-extirq.txt    |  49 +++++
> >  drivers/irqchip/Kconfig                       |   4 +
> >  drivers/irqchip/Makefile                      |   1 +
> >  drivers/irqchip/irq-ls-extirq.c               | 197
> > ++++++++++++++++++
> >  4 files changed, 251 insertions(+)
> >  create mode 100644
> >
> > Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
> >  create mode 100644 drivers/irqchip/irq-ls-extirq.c
>
> Applied to irqchip-next.
>
> Thanks,
>
>          M.
> --
> Jazz is not dead. It just smells funny...

A bit late, but for what it's worth,

Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Background: https://www.spinics.net/lists/netdev/msg611505.html

Thanks,
-Vladimir
