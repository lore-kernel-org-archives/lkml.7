Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5150C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 17:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 821EB21473
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 17:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hs0SyxyG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbfEVR4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 13:56:35 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37724 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbfEVR4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 13:56:35 -0400
Received: by mail-io1-f65.google.com with SMTP id u2so2610167ioc.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 10:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IUYJTTUKU/r+xzqhgLBKHt03JAr1T1iEO6fP09np6HY=;
        b=hs0SyxyGyvJnojGG+976Q9dJvM5n1Bzo/RPzJ2Ugt9eaolkymjZhuL/Mz0YKvxhO/4
         AyxmzY3fq3iLf2FN0elzG5nTX2MCd6kGGZTY1ho6V9Olnw/odN9/vFY+vRIQemxYiV9i
         qXtLXFsBDdsOEnRJ7MxT++1/fvkDWjuc4tpqN6z21T7jMr4ObArgrI/0jweGpGr9twJr
         1Vk8xxdG6GrKfTvPFBY4HLyqgLWtUOMCX1nqidbQ3OHxt3Hh+AsUXlUjcKIqh8lPR8mo
         PMT9dPtO80kkyHYjfT96DjeJqd7fGhHmaE2zrUeQ7DBpbna7PU5GHENch6LuagKvnoMw
         1TYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IUYJTTUKU/r+xzqhgLBKHt03JAr1T1iEO6fP09np6HY=;
        b=WkAqqNggZQNbdvYnZCQ0FR1lXTctFMWyAkoq/tzm3fdAz8tHKiEi/GoTK9WmCtkfty
         zOS/LY5mdzDERqyAabff7GASfmBQmx7JJUhJ90cVCIl0tZFhyktvMzmvkR4ljcfKks0H
         Q7J2AilI3U6nHXHmoN9CoYHfQlcXAy00yjyzZDvvZBpu+y2HeWUBTaeVoJUs9zKZ42bp
         5zxMZhLbOle3vdl4uiSI1+9iCEwbJRUQFqm2THjVkQqTZ14zpTYS1WNg0FATj/D5pcgk
         DyqG+b3R3h/01TZk6rTaXxTLoFVgfqHP1PZGm/dManEUGhe072WJCBrnVW5LIiKDzJgh
         kB6g==
X-Gm-Message-State: APjAAAWQUDHC5YULl6qVfoZHOuNdYYt+awaK4SYBG2iMsMNVTIAhmH0Z
        lPswglH5VZD/h5B9bPIAQN0oARiWQy/KJadxNvc=
X-Google-Smtp-Source: APXvYqwctojGn7ATOKQEqWOGBngjhjHG3LMCAv2n0E0oeiLPvz8OoR4Ua4HOLixLVOOaJiPcY4Vu3KUZzFWOvIMGqBo=
X-Received: by 2002:a6b:5117:: with SMTP id f23mr13610280iob.263.1558547794283;
 Wed, 22 May 2019 10:56:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190522071227.31488-1-andrew.smirnov@gmail.com>
 <20190522071227.31488-3-andrew.smirnov@gmail.com> <1558517601.2624.32.camel@pengutronix.de>
In-Reply-To: <1558517601.2624.32.camel@pengutronix.de>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Wed, 22 May 2019 10:56:23 -0700
Message-ID: <CAHQ1cqHQWqpJdZjeBiOhEC5JjfcHdY+uA+kbCxzj6kRk9SLUXQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: dts: imx6: rdu2: Limit USBH1 to Full Speed
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Chris Healy <cphealy@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 2:33 AM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Hi Andrey,
>
> Am Mittwoch, den 22.05.2019, 00:12 -0700 schrieb Andrey Smirnov:
> > Cabling used to connect devices to USBH1 on RDU2 does not meet USB
> > spec cable quality and cable length requirements to operate at High
> > Speed, so limit the port to Full Speed only.
>
> Really? I thought this issue is specific to the RDU1, but you've been
> looking at this USB stuff for a lot longer than me.
>

I am merely a messenger here. I didn't personally verify this to be
the case, so your knowledge is probably as good as mine. Chris
reported this based on feedback from their EE team, so he should know
all of the details better.

Thanks,
Andrey Smirnov
