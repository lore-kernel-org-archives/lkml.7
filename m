Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E294AC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B0B2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erqyx6SY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbfDPLsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:48:52 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:56153 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfDPLsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:48:51 -0400
Received: by mail-it1-f196.google.com with SMTP id y134so32409625itc.5;
        Tue, 16 Apr 2019 04:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rQHmOCS0aJ97IXgmeD1h88WTQqPDfMto+zKVaZzfKgQ=;
        b=erqyx6SYNI69uWjh7iHUjgcYa8nKrmj7O6d7fqfaE3bKASbQtw+F9lddGsrBxcziU1
         J12FEkDw9FtHXybRJkeic4gOSPPvPZTkxQ/A21U6ipv3pc46UWSULWvwwOo5hjlu788C
         Dl9UttAL7jSOtlIkmqp16IAdE9kruNHgLS1wtLWrpL8gpnwahBxIYiFUn59sEb5JB7aX
         jQ1Si7+zEAQKEON4eN6U9UXE94J5bX07PJsnVwMijnChLZTk1eNZrzTUdv48Bug8R1ND
         Hx6xrrnPTKHLFENDLsXzibcS4vXUIqI+xne7MU96GQKIrusX3VmWGOyXEksdYieDKxgY
         OR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rQHmOCS0aJ97IXgmeD1h88WTQqPDfMto+zKVaZzfKgQ=;
        b=JEx+eoAUs4RyqKMdYij/8TudqNU+rkVzst1Hc3DqKHQmPu1IfIkMWEMk2CZIoQy+r9
         OsRz1uFu8S49y9ssKunsb7sBj7SrhJwqepjP8+UvA6RFlQcXVzDsuo3auDpiYhiBD2Dy
         nnHNeL7VZHxaUzM1OdGiLgwCb08jspJrFhkhuggmcDLgdZeavvtyRVrZ44VI7a0rxMKr
         ozE24W1ZlJOgFg/WF86FXHQzT71e9Uya1y9IiRi6maG+dr6VNk+FBAqFzmEMc3TpXuMC
         Tzcrc/MOyAlPvQRgy8bGi8culJwKPeHApyfw+gw09b6bmldWwQJMGVPwMoADVQ4YsiNX
         eRtA==
X-Gm-Message-State: APjAAAVSp2b3ta04UuklDUgJKdrIeznJ7iQ/g5Rux/ywqUVibsDb31lf
        Hm9X+/Gua1MeVSbX/ck28ugboM35UM57zZZ3iBk=
X-Google-Smtp-Source: APXvYqyBIx2ski6VboxyCrtCnKQs5sxjONWR9aeUdeeK0ukTZbIl4fzwfNpWMciGYV7myozEz8Ed/3EwL38qxZg6Xec=
X-Received: by 2002:a02:c843:: with SMTP id r3mr56313567jao.12.1555415330474;
 Tue, 16 Apr 2019 04:48:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190408075924.2284-1-brgl@bgdev.pl> <20190408075924.2284-2-brgl@bgdev.pl>
 <5f72a26b-428a-c50e-cb6a-7c888ea22329@ti.com> <CAMRc=McGwGh9RKhxxCDnz3aMG_EVjjXzN+pmMZVtE7aChdU3jw@mail.gmail.com>
 <3f6c906b-53b0-8284-bf4d-9b404f341e7b@ti.com> <CAMRc=Me8vppb9vEmKOUcU28YKVR9jJ64sBSn-KwNyNnZA=VB9Q@mail.gmail.com>
 <6ff5711c-b607-1f3a-e362-709b53762179@ti.com> <CAMRc=Mfb4xrpLkJoX0SyoCPU6Au1TPxCtr29EhvU=VsKkSt2xQ@mail.gmail.com>
In-Reply-To: <CAMRc=Mfb4xrpLkJoX0SyoCPU6Au1TPxCtr29EhvU=VsKkSt2xQ@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 16 Apr 2019 06:48:42 -0500
Message-ID: <CAHCN7x+CAr9MjckhVP_suBRHY+o8Je1aLz28XTL9bnDBd4WyKA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] ARM: dts: da850: add cpu node and operating points
 to DT
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Sekhar Nori <nsekhar@ti.com>, David Lechner <david@lechnology.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 3:38 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> pon., 15 kwi 2019 o 12:21 Sekhar Nori <nsekhar@ti.com> napisa=C5=82(a):
> >
> > On 12/04/19 9:01 PM, Bartosz Golaszewski wrote:
> > > pt., 12 kwi 2019 o 15:53 Sekhar Nori <nsekhar@ti.com> napisa=C5=82(a)=
:
> > >>
> > >> On 12/04/19 5:41 PM, Bartosz Golaszewski wrote:
> > >>> pt., 12 kwi 2019 o 13:26 Sekhar Nori <nsekhar@ti.com> napisa=C5=82(=
a):
> > >>>>
> > >>>> Hi Bartosz,
> > >>>>
> > >>>> On 08/04/19 1:29 PM, Bartosz Golaszewski wrote:
> > >>>>> From: David Lechner <david@lechnology.com>
> > >>>>>
> > >>>>> This adds a cpu node and operating points to the common da850.dts=
i file.
> > >>>>>
> > >>>>> Additionally, a regulator is added to the LEGO EV3 board along wi=
th
> > >>>>> some board-specific CPU configuration.
> > >>>>>
> > >>>>> Regulators need to be hooked up on other boards to get them worki=
ng.
> > >>>>>
> > >>>>> Signed-off-by: David Lechner <david@lechnology.com>
> > >>>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >>>>
> > >>>> I remember you mentioning about some problems using OCHI and cpufr=
eq
> > >>>> together. Are those resolved now? CPU PLL on DA850 can affect othe=
r
> > >>>> peripheral clock frequencies too. So enabling it should really be =
a
> > >>>> per-board decision.
> > >>>>
> > >>>
> > >>> The problems are still there. I've never been able to find the
> > >>> culprit, but it also occurs on TI BSP in the same way (a couple
> > >>> cpufreq transitions will make the controller unresponsive).
> > >>
> > >> Is that on LCDK as well? As I recall cpufreq was never enabled on LC=
DK
> > >> in TI BSP.
> > >>
> > >
> > > Yes, I just verified that the bug occurs on LCDK with patches from th=
is series.
> > >
> > >> If the OHCI problem is present on LCDK, then there is a user visible
> > >> regression on mainline after this patch. Lets enable cpufreq in LCDK
> > >> only if all working peripherals keep working afterwards.
> > >>
> > >
> > > The OHCI driver doesn't register any cpufreq transition notifier
> > > callbacks. I can't really find anything in the datasheet, but I'm
> > > wondering if we shouldn't do something similar to what the driver for
> > > davinci i2c controller does. I'll try a couple things tomorrow.
> >
> > Even if OHCI issue is fixed, with a fixed regulator like on LCDK, I am
> > not sure the benefits of just frequency scaling will be justifiable eno=
ugh.
> >
> > Fixing the OHCI issue may help in other boards like da850-evm use it
> > though. So that will be a good thing.
> >
>
> I've been trying different things, like suspending the device before
> the transition, resetting the controller or playing with the clock
> during transitions but it always results in the same kind of error:
>
> ohci-da8xx 1e25000.usb: frame counter not updating; disabled
> ohci-da8xx 1e25000.usb: HC died; cleaning up
> usb 1-1: USB disconnect, device number 2
>
> If you have any idea - let me know, otherwise I'll give up.
>
> If we agree on the direction of these patches, then I can go with a
> single enabled OPP for lcdk (456 MHz) and all OPPs up to 375 MHz
> enabled for da850-evm.

One last questions, and this probably directed at Sekhar, but what
happens if you modify the OPP for the boards with fixed regulators to
enable all the frequencies but with the only available voltage.  Is
there harm is running the processor at a higher voltage than
necessary?  I did some quick experiments on a different ARM board and
I saw some changes in power consumption.  I would think some power
savings might be better than none, but I don't know if it causes
damage.

adam
>
> David - do you want to keep the lego board as is?
>
> Bart
>
> > How do you feel about keeping all OPPs disabled by default in da850.dts=
i
> > and enabling only the ones that make sense for a board in <board>.dts?
> >
> > Empty OPP table is illegal, so this does mean that every board must
> > enable at least one OPP.
> >
> > Thanks,
> > Sekhar
