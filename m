Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B387C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 12:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF84020C01
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 12:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="nQ6gegFm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfEGM63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 08:58:29 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41666 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbfEGM62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 08:58:28 -0400
Received: by mail-io1-f65.google.com with SMTP id a17so5968852iot.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 05:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d1BYInvs1oFf7Gbsgx4CY3rSRVa9DYGZ8/CYy23V2us=;
        b=nQ6gegFmujDnuKXP6cFCYr0axTyHf4uFwZaIrUljHKVC9068oWSqJkAfk9Gh17PHyE
         uuCAjcmQeEOEjMHmCxUBI66XpnjQXroNYqsF+bbQt/09H+irkR7ubMcF5QEqvKJmmrN5
         2R8R63oORKLnObh4WCc2I0C7S4zjFiYauYq3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d1BYInvs1oFf7Gbsgx4CY3rSRVa9DYGZ8/CYy23V2us=;
        b=EqBIQmbNOnWHuqeit9xdKYDikJaaBmkqrmKkbNazqYhU8CWJCdTaVIaRF6y038qgkE
         2M+S48NVcpaV8FZ2ex49yPv2DuZ5uxj0D4Oi4ET2XsAClZmYv9He7Dnro7tVATL9MofF
         hnx8Ff5k+vPCrH3aSgO4udF8ht+Ak5Gn4VEmqvVpcX3ATQ+jTOM77x33miQLrkztOQKQ
         bDvYw9EjU0CVI4iwTLRv2f0AF+g8eay06j9s1onmgXrxy8Hw45CgAGmhfJtxgSjOnW/V
         ZkynkAHaupWjra2d2OgRGo7or9kie4CX3pjHQOio47trOgNUH8+LRoCteU6lCQeW3vU6
         cVaQ==
X-Gm-Message-State: APjAAAVBUaJMbrOZYO3zMfEpR+bVvUGiVBkJ7Mq+Ig3hUBxcQ7dQ6YV+
        /g9BZ0BgBcpyiXXe5rlfuaxtxGoC4dlvtH7mCti9KA==
X-Google-Smtp-Source: APXvYqwhx0sRi8/kQiro3wLZ7MDPkblbSgfSAjdeAhU/iYZfl1yQK/PGVAnga6qoHKYhXx/3TZGLyhlEorR953lTIZc=
X-Received: by 2002:a5d:9a11:: with SMTP id s17mr892216iol.267.1557233908042;
 Tue, 07 May 2019 05:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190503115928.27662-1-jagan@amarulasolutions.com>
 <20190503144651.ttqfha656dykqjzo@flea> <CAMty3ZCQTiX5OvCG_uMRS02vFu0c1-bkcyauLD6oaFcd=y3RNA@mail.gmail.com>
 <20190507070617.h7loqiqvznqvvprq@flea>
In-Reply-To: <20190507070617.h7loqiqvznqvvprq@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 7 May 2019 18:28:16 +0530
Message-ID: <CAMty3ZB0+uAKzoi=LpbE0nty2BHxqwY=0Pm36uiNnjuc5TKCdg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: allwinner: h6: orangepi-one-plus: Add Ethernet support
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 7, 2019 at 12:36 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Mon, May 06, 2019 at 03:03:15PM +0530, Jagan Teki wrote:
> > On Fri, May 3, 2019 at 8:16 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > On Fri, May 03, 2019 at 05:29:28PM +0530, Jagan Teki wrote:
> > > > Add Ethernet support for orangepi-one-plus board,
> > > >
> > > > - Ethernet port connected via RTL8211E PHY
> > > > - PHY suppiled with
> > > >   GMAC-2V5, fixed regulator with GMAC_EN pin via PD6
> > > >   GMAC-3V, which is supplied by VCC3V3-MAC via aldo2
> > > > - RGMII-RESET pin connected via PD14
> > > >
> > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > >
> > > Your commit log should be improved. We can get those informations from
> > > the patch itself...
> >
> > Thought it was a clear commit log :)  will update anyway.
>
> Well, yes and no. The commit log is clear indeed, but it doesn't
> provide what it's supposed to provide.
>
> You shouldn't put *what* is being done by the patch. That's pretty
> easy to figure out by reading the patch itself. You have to explain
> why and how you did it, which is lacking in that case.

Make sense, will rework.
