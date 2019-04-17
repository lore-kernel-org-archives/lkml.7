Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EA7C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 04:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4399D21773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 04:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEmymZXR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbfDQE0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 00:26:38 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:36606 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbfDQE0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 00:26:37 -0400
Received: by mail-it1-f194.google.com with SMTP id y10so2346859itc.1;
        Tue, 16 Apr 2019 21:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KrEQHtdxnpbYarVakV4JXFvdsq2uHUJmsVf4Dv0SWWM=;
        b=JEmymZXR+lCgLib+PwN05KgmtPTi2sR/tewbBRX7wSq7gTNuJoBYWonvjrcqBprqkC
         dsjC85fd9iceLBBB4jMT7EIFzjcqVEDYW4I0UaB2B83Vb3p0+ELDDZ+KhS0p2deIj/q5
         0zeAoPtsJJWGIVIkX1T/gofxIScd/kecjD9f6ByNbmyJOiXiPEYkKCW0/EhKchXUV1vN
         9GoQx6chyfeqsesXak8Xcr3of7DTsbKH1WVjkN2BKlK15vVjp88DbVBu2OupEte7ppS5
         s0zWuHOHnoowFE/BOMLnow3KPePwdlimXz+yXfUmckZmDJe3YLaiT5to/aH6iBTBjZdZ
         wHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KrEQHtdxnpbYarVakV4JXFvdsq2uHUJmsVf4Dv0SWWM=;
        b=Bgahs0nFQEBw8boU/603oxWGtbdPVT1F/30W/1X+QVPP/tXSgHl4ZgFNNV2fJXjI66
         PLI10KgvBFgaJbSHphtekbQnrLU9tW/QKcrTaVbCKGOCoFq6bTXHS/0DWFakrRxGciOE
         sx/X9SK5ti+LXIWvRbfooe28YJUw85lcNtM7NpXz42fVxzm/X+cG3U/0YxzX7J5dPL9N
         2Gpm2T99SO4mYFIneMG5fwMMbIY1vDxYu6SyyS2ylnSa1YtomokdmBCavQ5bCX9GyzAh
         f5itwwU/JBosD8I6jcQnc9/PeRkwvI+BkjNi6u4ZxfwnEw/alKq9ED8zGzZ+rHE0iNPq
         hmPg==
X-Gm-Message-State: APjAAAW7SWqjMnUzWUYcvuXzuexg0efsJ3TYw7oHkf+d13m/SM8MuLp2
        +Ja8lIjmhC/ZyYLGGas89zLZxvYILz8JROyBPlUvGu71
X-Google-Smtp-Source: APXvYqzwKNP2fNIv9nEBCyXdvC/YRcTI1Vfc1obfhI3i4jMmoaNUNsnEQhTYSpqK9RHv0No1PHqhUR2sQoLXxClRMWk=
X-Received: by 2002:a02:8508:: with SMTP id g8mr11208772jai.68.1555475196615;
 Tue, 16 Apr 2019 21:26:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190412172545.fkxnpnymhcw7xncc@macpro-scc.lancs.ac.uk>
 <CANAwSgSX6q4M2EcWvEA3B6zQuY0DBrh-0_r3v__R--p7dzjs7w@mail.gmail.com> <CAJKOXPeUYw2DNEzRfKGzTmNAtg5mHJObVFHygKJ2eUdDpAFmOQ@mail.gmail.com>
In-Reply-To: <CAJKOXPeUYw2DNEzRfKGzTmNAtg5mHJObVFHygKJ2eUdDpAFmOQ@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 17 Apr 2019 09:56:27 +0530
Message-ID: <CANAwSgR7a_gNGUSCkp1MH=t+V0iUfBEByn0UpO7=5xJXDHv7FA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: exynos: add CCI-400 PMU nodes support to
 Exynos542x SoCs
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Willy Wolff <willy.mh.wolff.ml@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Tue, 16 Apr 2019 at 15:49, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Mon, 15 Apr 2019 at 14:24, Anand Moon <linux.amoon@gmail.com> wrote:
> > Cache Coherent Interface (CCI) among Cortex-A15 and Cortex-A7, G2D, G3D and SSS
> >
> > Level 0 > CPU blocks such as Cortex-A15 (CA15), Cortex-A7 (CA7) are
> > joined as the member of Level 0 CCI bus
> >
> > Level 1 > Display engine block (DISP) and 2D graphic engines (G2D) are
> > directly connected to Level 1.
> >   DISP, MDMA, SSS.
> >
> > Level 2 > While all the other IP is connected to Level 1 bus via Level 2 bus
> >    G3D, MSCL, MFC, ISP, JPEG/Rotator/DMA/PERI, NAND/SD/EMMC.
> >
> > So my question is the mapped with the cci ip block correct.
> > Level 0 (cci_control0)
> > Level 1 (cci_control1)
> > Level 2 (cci_control1)
>
> Hi Anand,
>
> I do not understand the question - what is mapped with correctly or not?
>
> Best regards,
> Krzysztof

Following the https://www.kernel.org/doc/Documentation/devicetree/bindings/arm/cci.txt
CCI node linked to CPU and DMA nodes for example.

On this line below diagram from Exynos 5422 UM show various IP block
linked to CCI level.
Below image just elaborate overall architecture of Exynos 5422 CCI.

[0] https://imgur.com/gallery/0xJSwGQ

So we should map the various IP block to corresponding CCI level.

Best Regards
-Anand
