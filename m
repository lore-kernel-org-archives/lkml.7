Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96100C10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 14:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6140F218D0
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 14:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnslFh33"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfDGO0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 10:26:40 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:39202 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfDGO0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 10:26:39 -0400
Received: by mail-yb1-f196.google.com with SMTP id b88so4191884ybi.6;
        Sun, 07 Apr 2019 07:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jmM+6GnFz3hpdL85hjRoMpGQ+HxiKjlG6jI6WtPc+Bw=;
        b=JnslFh33XSWSNltS2/aRNbQLIZsBHHhbVO8gUSTtl7FL/1YW8a6Mf67cMH18YR1eqT
         wdOddsSugiq6EXOhGosTYYxH01dVpAb12gJJ4wvPh/JT6E593kuQlWZQIh9KoFPL93E+
         IxAM6CtP+l1eI6BajLHRD/t8wnCABXgaz21w9PFjla6EIjL3RRdEWFqZN9FK3VDM3iQt
         uxWb+9IDwG/MxHeETI0nbyNXtRvSUz1wE43Ua61rXepMnN0hsDTxoOQ22pc3izuGFqWh
         tNfoaOoPEfY0M8YXpLX4VaemUxYZLXdFLavWYfnAHxA5T3ZMBrcqg3Ad7pcPCY5Dswaw
         c7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jmM+6GnFz3hpdL85hjRoMpGQ+HxiKjlG6jI6WtPc+Bw=;
        b=R9b5qKHI58Q1jbFA7iP3RVueOYhRjmeX4OyesvscpGbAIid8ukr1L1nF9VPMdWZIiC
         h5Uqy1K7iWer/BpWIf+S7/mwrK3IvIaf5sp93h6Em06xjn6nvvfb2OKhxswHfOEwZpMx
         0+Zte+WVYPhxvOel5bdfoKJgYxsYFVjOGUTL5WQFU28iQ52M/B6biYX99di+TbU9Hzs/
         yq5XaCCaHgWLoq9vSMuWOLZ3OkO3KF8PhEaz6qFiMraf4eRdBh53m1ozLf1ScusnBDer
         E+w54EpRXJ85MHzMXqATHjNnBT8sofLMq/b8yCuwI3ZqUPQabJVhUzfrRf9S+al0ajto
         Ld4Q==
X-Gm-Message-State: APjAAAVeZMgDSVmwiTda6Peb2RDHtTrTFlcmC/9BNFvWisxucAbW5Ye4
        JWn8kNDCOTDF7oA6bvcI5kNEs8MkMsqcDyizBKMEd8KXUOQ=
X-Google-Smtp-Source: APXvYqxFDF83y6+5DfwlWaBKHOYPpK6ausc9+vC9oNHk32B5xYdEaUyBc8njcncsNRU5A4vT5Ga7cJWrAHxP4Cr5yuU=
X-Received: by 2002:a25:378c:: with SMTP id e134mr21398829yba.181.1554647198778;
 Sun, 07 Apr 2019 07:26:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190404135736.8491-1-peron.clem@gmail.com> <20190404135736.8491-2-peron.clem@gmail.com>
 <20190405090236.e7vnyjzxmzfke3d6@flea> <CAGb2v65wcEAUTwRhC42iRkPaWXLGX1CJeq+TSzHVTOrT+L=8vA@mail.gmail.com>
 <20190405145005.jmmwsvbateqssbyq@flea> <CAGb2v66cv7dVwj7oyRaHT5Q2XCbNqzuS-Uk9hdNJbVv57QOmUg@mail.gmail.com>
 <20190405150810.zjwtu6crzaz6ufhx@flea> <CAJiuCccfmwxAqK1mTJ3eLO0RggV8sZTTKRy=fxFFenxn1hATvQ@mail.gmail.com>
In-Reply-To: <CAJiuCccfmwxAqK1mTJ3eLO0RggV8sZTTKRy=fxFFenxn1hATvQ@mail.gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sun, 7 Apr 2019 16:27:36 +0200
Message-ID: <CAJiuCcc5_tkmSM8sV2enG7t5=eU21ZrzcCVLUzF+c=8MiZhdFA@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: h6: Add watchdog node
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Samuel Holland <samuel@sholland.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 5 Apr 2019 at 18:24, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>=
 wrote:
>
> Hi,
>
> On Fri, 5 Apr 2019 at 17:08, Maxime Ripard <maxime.ripard@bootlin.com> wr=
ote:
> >
> > On Fri, Apr 05, 2019 at 10:59:35PM +0800, Chen-Yu Tsai wrote:
> > > On Fri, Apr 5, 2019 at 10:50 PM Maxime Ripard <maxime.ripard@bootlin.=
com> wrote:
> > > >
> > > > On Fri, Apr 05, 2019 at 10:35:08PM +0800, Chen-Yu Tsai wrote:
> > > > > On Fri, Apr 5, 2019 at 5:02 PM Maxime Ripard <maxime.ripard@bootl=
in.com> wrote:
> > > > > >
> > > > > > On Thu, Apr 04, 2019 at 03:57:36PM +0200, Cl=C3=A9ment P=C3=A9r=
on wrote:
> > > > > > > Allwinner H6 has a watchog compatible with A31.
> > > > > > >
> > > > > > > Declare it in the device tree.
> > > > > > >
> > > > > > > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > > > > >
> > > > > > Applied both, thanks!
> > > > > > Maxime
> > > > >
> > > > > IIRC there are 3 watchdogs on the H6. One is the trusted watchdog=
,
> > > > > which should be reserved for underlying firmware.
> > > > >
> > > > > The other two are the normal and R-block watchdog. Although they
> > > > > look the same, the "normal" one can't reset the system. :(
> > > > > That one is actually the one ATF currently uses. So reboot doesn'=
t
> > > > > work on the H6.
>
> Some users report that the reboot on the PineH64 actually works.
>
> Clement
>
> > > >
> > > > So that patch will not do anything then?

Did some test and only interrupts are working right now. If the WDOG
is configured to make the board reboot the system will be stuck :S
Maybe better to disabled it for now and leave a comment.
I will try to ask some Pine H64 users to do the same tests.

Test done on my Beelink GS1 :
/* This should reset the system after 0.5s */
# devmem $((0x030090a0 + 0x0014))
0x00000001
# devmem $((0x030090a0 + 0x0018))
0x00000000
# devmem $((0x030090a0 + 0x0018)) 32 0x1
#
/* System is Stuck*/

/* This should reset the system after 1s */
# devmem $((0x030090a0 + 0x0014))
0x00000001
# devmem $((0x030090a0 + 0x0018))
0x00000000
# devmem $((0x030090a0 + 0x0018)) 32 $((0x1 << 4 | 0x1))
#
/* System is Stuck*/

/* This should reset the system after 1s (as recommended in the User Manual=
) */
# devmem $((0x030090a0 + 0x0014))
0x00000001
# devmem $((0x030090a0 + 0x0018))
0x00000000
# devmem $((0x030090a0 + 0x0018)) 32 $((0x1 << 4))
# devmem $((0x030090a0 + 0x0018))
0x00000010
# devmem $((0x030090a0 + 0x0018)) 32 $((0x1 << 4 | 0x1))
#
/* System is Stuck*/

/* This should trig an interrupt after 0.5s */
# devmem $((0x030090a0 + 0x0014)) 32 0x32
# devmem $((0x030090a0 + 0x0014))
0x00000002
# devmem $((0x030090a0 + 0x0018))
0x00000000
# devmem $((0x030090a0 + 0x0018)) 32 $((0x1 << 4 | 0x1))
# devmem $((0x030090a0 + 0x0004))
0x00000001
/* INT is triggered */

Regards,
Clement

> > >
> > > I'm still on vacation, so I haven't checked the address of the new de=
vice.
> > > If it's the normal one, then yeah, it won't do anything. I've tried t=
hat.
> > > IIRC Samuel (or someone else) on IRC also mentioned this.
> >
> > It's the one in the timer that we've used since pretty much day 1 on
> > older SoCs, so I guess it qualifies as the normal one :)
> >
> > Maxime
> >
> > --
> > Maxime Ripard, Bootlin
> > Embedded Linux and Kernel engineering
> > https://bootlin.com
