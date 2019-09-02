Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44024C3A5A4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 01:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 171F221881
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 01:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJFndeRm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbfIBBST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 21:18:19 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:41028 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729147AbfIBBST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 21:18:19 -0400
Received: by mail-io1-f42.google.com with SMTP id j5so25967578ioj.8;
        Sun, 01 Sep 2019 18:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sO42KCp2F1BVVy0mnKBt9Vus/HrCCbUOcWtHspdbidA=;
        b=XJFndeRmSX0J60cBWb5Pl6nwkDYWWu+6m5+hqN3MqlI19bLGRXu21vV2tmTCvzqrkd
         R8jVR/Y+Fz3QNKZkLNCWj8ANMMnkflemBXKMeFTXVYa0yB4q/C05+6dvR/6fC1e00kuF
         AWmg+sRNLNU+GgIpOq51TQr9nSYzbt3NtSXvL8YHi7t0Z3MRL9I8yt1FsT6/jfX/Q/Zs
         rf1EA1kNbi0KJI5QB8lt/RjarO2ZjyxmIS42U1/wBdpB/W+ZhBBR8JhyFgqEtlvy6BTZ
         FcLjl0UWZ/X5ZkKTOV54z5H0h03/KYgZSbJSMJxj1jMRi8BA2w6Xrj0/DsBpduCEY1ml
         1Tbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sO42KCp2F1BVVy0mnKBt9Vus/HrCCbUOcWtHspdbidA=;
        b=QPUTfaBPMbUShTkFfJRZdi4USLVPHZtKk03wpPDElt2EzSBzjjfoAdcPGZcLKarAep
         jrIGZUJfCxolIfLJL+B6Y1ANpP5YHqbWWWIB3rV+7u/oAbZAk65B2Y6Mq65edwqcFjBR
         X3SISZMBNtYhUgZcBiHHfya18LdMLtTwTAW6NISl814SIaoMB7PgafiZDUHiNSgbEPye
         p8k+GC7VyM817JQbftFnww6sJF76UrYcyKrAmd8ytCqrnvVv3bURMheNgu1Nj40LLpjG
         tegKD8EE18dlZSTwU1X3K+n/KHquDYMCR29Qs8kI51ixza2dc42zuYAXiHtAOjziotaq
         jB1Q==
X-Gm-Message-State: APjAAAWX/KoH1vp9SxRrlA1QQdR+Fwa2s20WvYrndF/VqCf4NvJGhvqY
        ZwCOgn4P4XpOzQkQNSU7M/t/P5cMuwdIl2YE6UA=
X-Google-Smtp-Source: APXvYqxMV47N5X/vUxjVExPfpQ++jyOIgMFhA/LhDqItTA2hAXcTqHdda6Q2bPmGBITO9UxVtyqih4ySAUoEPw0fggM=
X-Received: by 2002:a5d:9bd4:: with SMTP id d20mr2538618ion.243.1567387098254;
 Sun, 01 Sep 2019 18:18:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190828202723.1145-1-linux.amoon@gmail.com> <20190828202723.1145-2-linux.amoon@gmail.com>
 <CAFBinCBWq0LcdA1-a5W06zKp0RzGs5_=Mph6StGKXJ7npCgbfg@mail.gmail.com>
 <CANAwSgS+HGYXr290=EvdhKxh3TiBOqfbcuuF4cMAiBVX1ez9+Q@mail.gmail.com> <CAFBinCCLPa64_h0JE4Z_pMuUuhb=HKUXPti2pkUFAuEPO2fE6Q@mail.gmail.com>
In-Reply-To: <CAFBinCCLPa64_h0JE4Z_pMuUuhb=HKUXPti2pkUFAuEPO2fE6Q@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Mon, 2 Sep 2019 06:48:06 +0530
Message-ID: <CANAwSgRVkJXNckcNELKhj4R_Lex62WJn3K4ct1wkuocMjfWAAg@mail.gmail.com>
Subject: Re: [PATCHv1 1/3] arm64: dts: meson: odroid-c2: Add missing regulator
 linked to P5V0 regulator
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Mon, 2 Sep 2019 at 03:23, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Anand,
>
> On Sun, Sep 1, 2019 at 3:58 PM Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > Hi Martin,
> >
> > Thanks for your review comments.
> >
> > Their have been some revision changes in S905 Odroid Schematics.
> > [0] https://dn.odroid.com/S905/Schematic/
> >
> > Well I have make my changes based on old odroid-c2_rev0.2_20151218.pdf
>
> [...]
> > >
> > > according to the schematics there's both:
> > > - VDDIO_AO3V3
> > > - VCC3V3 (which is turned on by VDDIO_AO3V3, see [0])
> > >
> >
> > From the schematics it seams same.
> >
> > VDDIO_AO3V3---DMG340LSQN4 (Q4)---VCC3V3
> yes, they are the same signal. the only difference is that VCC3V3 is
> turned on later in the power-up sequence
>
> > But this name change was done to link TFLASH_VDD_EN to TFLASH_VDD for eMMC
> >
> > VDDIO_AO3V3-----TFLASH_VDD using  TFLASH_VDD_EN gpio pin.
> >
> > Well I have tested this changes on eMMC module.
> I cannot see any of the TFLASH_* regulators being linked to eMMC (they
> are only linked to the SD card slot, I also checked
> odroid-c2_rev0.2_20151218.pdf and odroid-c2_rev0.2_20171114.pdf).
> which page of the odroid-c2_rev0.2_20151218.pdf schematics shows how
> TFLASH_VDD is linked to eMMC?
>
> please note that I don't have an Odroid-C2 board myself (so I cannot
> test any of this).
>
>
> Martin

Thanks I will double check again and re-post then with correction again.

Best Regards
-Anand
