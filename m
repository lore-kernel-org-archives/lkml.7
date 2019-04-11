Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09903C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF01320818
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCZxgyF+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfDKPJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:09:45 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:45886 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfDKPJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 11:09:45 -0400
Received: by mail-yw1-f65.google.com with SMTP id j128so2164707ywg.12;
        Thu, 11 Apr 2019 08:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Tqx8ZuggGN72tgSa9PsmG5waNYm7PqHVS8d44MpgSeY=;
        b=WCZxgyF+D2l1qMIuu1RuobVTBWmhViF6PdquQnYqW1ttQSbYxnDKGfHn56oQxCofCV
         Wa3cH+bt1Xa27sj99lzlX665WxKJIGuOawEuK/6jdl+OdDgu7nvOMQhNPmLt41zHmMFG
         mB23w1pbJY1uWsPJ73gSHb+XrHvY4oYkHH6+mw2XSFvPOmxhBOqy7heNjA4SBqYqRmze
         lBckhm+5wv3jrEGs/AY1GwT+6KIgQQeuhc3LkrmNj9qn+j2rxUn+IsYE20zcybEfnOyd
         1TC9HjUUdm1qP0EuAw0Oshwamwp1+m8bWdm/rW+WJlGHI+kaJMmLm3kGscVWXpGAnRtb
         SoBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Tqx8ZuggGN72tgSa9PsmG5waNYm7PqHVS8d44MpgSeY=;
        b=sx6Pk/DXHGeBGEFHvDigI6fi337EeB1H8d/Lo8UiVglz67dNtU5pFDhAasnkwN6a2M
         sqo2C8a3LLwcrTuZXqQ7EZhM6ypaygjtv3KbLjBWGIIw9/Y3GkrOTTwLqeDFxUAT2js3
         /PcLFybuq9GdcYwe3rWmxFPWpPp9aUQn7ao9VUsw3YpOLY8TFacTvLCVivXysmQtp95I
         n4hcp7Lhl83V4/NQRQ9XmoptkknOR/bLU1hI1hgwUsQYsa1PpKLkniKOMI5On7eqj/c1
         DjV10rucu0ilqq50kjmqULITnS8stm2vy03KOFWJKmSifJSE3FI7V42M4fz5En9kaYIp
         lR6Q==
X-Gm-Message-State: APjAAAWrSSY8hmrR2xVQ67YIe/+W/k+a8hQKADV74JvQJuvB4sM/h/cP
        h5G+7PVo6Kqfs1PCmhZCv7BXCOLxdwX1BiTYl2k=
X-Google-Smtp-Source: APXvYqxvGycB2zkL1JRB6/rw812IdfHdVK8vIym8jl/N0ImTtGOM3KWXobGfWX7POqAYioULdmkM57U8AfzSTKUZig8=
X-Received: by 2002:a81:7895:: with SMTP id t143mr40159711ywc.156.1554995384250;
 Thu, 11 Apr 2019 08:09:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190411105720.32357-1-peron.clem@gmail.com> <20190411123223.zyumngnlwhlvk6mf@flea>
 <2219012.spPdo1bsEq@jernej-laptop>
In-Reply-To: <2219012.spPdo1bsEq@jernej-laptop>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Thu, 11 Apr 2019 17:09:20 +0200
Message-ID: <CAJiuCcejA16mKVHeKEf-YmzNsS-w=mjrzbG4hR3DoepiZr_J8Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Add Allwinner H6 Mali Midgard GPU
To:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 11 Apr 2019 at 17:01, Jernej =C5=A0krabec <jernej.skrabec@siol.net>=
 wrote:
>
> Hi!
>
> Dne =C4=8Detrtek, 11. april 2019 ob 14:32:23 CEST je Maxime Ripard napisa=
l(a):
> > On Thu, Apr 11, 2019 at 12:57:12PM +0200, Cl=C3=A9ment P=C3=A9ron wrote=
:
> > > Hi,
> > >
> > > The Allwinner H6 has a Mali-T720 MP2. The drivers are
> > > out-of-tree so this series only introduce the dt-bindings.
> > >
> > > The first patch is from Neil Amstrong and has been already
> > > merged in linux-amlogic. It is required for this series.
> > >
> > > The second patch is from Icenowy Zheng where I changed the
> > > order has required by Rob Herring.
> > > See: https://patchwork.kernel.org/patch/10699829/
> > >
> > > The GPU opp table was taken from Jernej =C5=A0krabec's patch
> > > on LibreELEC.tv.
> >
> > One valuable information here would be which stack did you use,
> > panfrost and mesa or the ARM stack? If so, with which driver and which
> > blob?
All of this work has be done by Jernej so he could answer better than me.

He uses the ARM stack r22p0-01rel0 + patches
https://github.com/LibreELEC/LibreELEC.tv/commit/5273f889964c42e88fe0228929=
0c3c6cb6086770

Blob are also from Jernej too (taken from ???) :
https://github.com/jernejsk/H6-mali-userspace

Regards,
Clement

>
> I'm using similar binding (different clock and interrupt names, but other=
wise
> same) for quiet some time now on LibreELEC with ARM proprietary userspace=
 and
> kernel space driver (32-bit GBM version) and it works well.
>
> It's true that I'm using OPP table, but most (if not all) of the time GPU=
 is
> set to lowest setting as there is not much to do when rendering GUI.
>
> Best regards,
> Jernej
>
>
