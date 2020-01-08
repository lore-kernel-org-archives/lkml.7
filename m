Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A044C33C9E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 09:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725262087F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 09:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K/jE8RWo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbgAHJOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 04:14:45 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:34048 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbgAHJOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 04:14:39 -0500
Received: by mail-qv1-f66.google.com with SMTP id o18so1107982qvf.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 01:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SPzHp/TCuO+PA2nHlHMVzeUghB/5uams6CZGUZBj35o=;
        b=K/jE8RWozDdRYmSsW9itFfvjGkVpL/zCzGu39X34ur7j0Be+cWMBI2auPmoluvn4c1
         /S/feNX81zbnksyn4ZVjM/8vfVA6T/7g7v52oVDY/X+5X9Y9F/hAbdyl8xKfHD3iR7ln
         3kR5KrCmE2zxPQDibCfArttMxzqMRbVfVXuiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SPzHp/TCuO+PA2nHlHMVzeUghB/5uams6CZGUZBj35o=;
        b=iFRYgbio6mh26w7UnJl9Ier7+PqwrBHdSUkiB7wblVvRajYEO6lc9+jfD9DcAsBtrF
         3BI7GHh4RWi8z9jBV0axZZCW/gVLm4ZHzylLI7J7GZgWH3V7lILN4nhwNE/CoLnxzjEz
         U5toX+GVAZ7GO3TRgVEm6lOVxH2did++CNnvGOf64sXuqHIiPNAiQAr8LQEVbSiHda+f
         JjfmpHhIqNRq+tOnYQQmR/Bm7r/pPkdMfrzF4zyOaYr7EFvZTbIXtj/yPx/SH3eM+w/m
         zh2JXCB6xVR/EJyzoWJqmLhjLvrzBhuudMxY1ke1dFEXt8ZHT9IFnxcOfnUgPr1D3YGH
         RAZg==
X-Gm-Message-State: APjAAAUg2ZeoKBwXvN+B5wBUKn0S1s6VYb7YL9Iqb57xMLzU1f1TpnOO
        FWEA7YanInACTIE3aFDqAhfTyv8oo2CPMWe1Q62RGw==
X-Google-Smtp-Source: APXvYqxf/pnt/xOzQY9MksejO/BRE5fT3xBR6Oezhn4Kzl/SblH+zp9r0nnNwuErhStHc9QFh2BYf2nQYASas+C1/yI=
X-Received: by 2002:a0c:f703:: with SMTP id w3mr3236524qvn.6.1578474878009;
 Wed, 08 Jan 2020 01:14:38 -0800 (PST)
MIME-Version: 1.0
References: <20191227141405.3396-1-yong.liang@mediatek.com>
 <20191227141405.3396-2-yong.liang@mediatek.com> <CANMq1KD=jAPn4Y7zQZrsg9FB7Cq6tNX0R8OF4qX21Sjy2=0Naw@mail.gmail.com>
In-Reply-To: <CANMq1KD=jAPn4Y7zQZrsg9FB7Cq6tNX0R8OF4qX21Sjy2=0Naw@mail.gmail.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 8 Jan 2020 17:14:27 +0800
Message-ID: <CANMq1KB4PzAUdp03go0Ur_khi2bM3+oNUhHtMK=--V6DmGXiDA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] amr64: dts: modify mt8183.dtsi
To:     Yong Liang <yong.liang@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, wim@linux-watchdog.org,
        linux@roeck-us.net, linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 8, 2020 at 4:56 PM Nicolas Boichat <drinkcat@chromium.org> wrote:
>
> minor nit, s/amr64/arm64/ in the commit title.
>
> On Fri, Dec 27, 2019 at 10:15 PM Yong Liang <yong.liang@mediatek.com> wrote:
> >
> > From: "yong.liang" <yong.liang@mediatek.com>
> >
> > 1. Include mt8183-reset.h and add reset-cells in infracfg
> > in dtsi file

Err, wait, doesn't this depend on
http://lists.infradead.org/pipermail/linux-mediatek/2020-January/026170.html
?

> > 2. Add watchdog device node

Can we have a patch with just this change instead, since you're
sending the binding with it.

> >
> > Signed-off-by: yong.liang <yong.liang@mediatek.com>
>
> Tested-by: Nicolas Boichat <drinkcat@chromium.org>
>
> > ---
> >  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > [snip]
