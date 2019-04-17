Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23367C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA88121773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555487102;
	bh=X/KVqE9jCOjbsWOwWkL4ilBHdfReleeOKfr0zWv6Ys0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=U8yw46n3WLkl73I2MkUAhZMiMxfGogg2SFXtX2upYyrz6zrRidTUNde1uDZMTgDjd
	 xvPeDKgDyxDST70UIeJIPu4C6PJ0GIP9MwpvsBDwYGqBlgoMqb9g8o57md8h4iPvKX
	 vF9+f0oQosc1noo16D6Ow/jxP+5rC7lsMl/1qCzg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731191AbfDQHpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 03:45:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:32886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726237AbfDQHpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 03:45:01 -0400
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 278D72176F;
        Wed, 17 Apr 2019 07:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555487100;
        bh=X/KVqE9jCOjbsWOwWkL4ilBHdfReleeOKfr0zWv6Ys0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fBekZvM52j6mk+uJHJ0+DSHwZx6mJhWV+SX0dawIxbPVzoNgUD+oV24Yhvi5ai3rn
         F9PakeaJjoegJ+/4oYd8vOZk2R28+kY/0LlOeAm0WLvKf1/RJKF52jDhPf/8mSc2LF
         0Av+tP2EEKV5jW625N+DLDhgAo5oCriSpNpMqp84=
Received: by mail-lj1-f182.google.com with SMTP id y6so21480834ljd.12;
        Wed, 17 Apr 2019 00:45:00 -0700 (PDT)
X-Gm-Message-State: APjAAAUWMRzjQ3S+mu4FmcvgJvard7qsCQWJ+LipFK/rr+cuBepDj70s
        N8KE42wKSTJ8ROTgOKmSbdmD1wpCiG+mLWTjOsY=
X-Google-Smtp-Source: APXvYqx+hiPpTxbr3IOBPGYxizISaKT1pQQoy/WF3Do3PPknf9oxRwwf6Ms2PRNq5/mbJ73Aq8QKNZBP0G0xjx7JUJQ=
X-Received: by 2002:a2e:808e:: with SMTP id i14mr48752595ljg.103.1555487098428;
 Wed, 17 Apr 2019 00:44:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190412172545.fkxnpnymhcw7xncc@macpro-scc.lancs.ac.uk>
 <CANAwSgSX6q4M2EcWvEA3B6zQuY0DBrh-0_r3v__R--p7dzjs7w@mail.gmail.com>
 <CAJKOXPeUYw2DNEzRfKGzTmNAtg5mHJObVFHygKJ2eUdDpAFmOQ@mail.gmail.com> <CANAwSgR7a_gNGUSCkp1MH=t+V0iUfBEByn0UpO7=5xJXDHv7FA@mail.gmail.com>
In-Reply-To: <CANAwSgR7a_gNGUSCkp1MH=t+V0iUfBEByn0UpO7=5xJXDHv7FA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 17 Apr 2019 09:44:47 +0200
X-Gmail-Original-Message-ID: <CAJKOXPf-CLMh1kLux0ev4FkT4x8CB+5O1wSNFmkjhFtVatX8jQ@mail.gmail.com>
Message-ID: <CAJKOXPf-CLMh1kLux0ev4FkT4x8CB+5O1wSNFmkjhFtVatX8jQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: exynos: add CCI-400 PMU nodes support to
 Exynos542x SoCs
To:     Anand Moon <linux.amoon@gmail.com>
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

On Wed, 17 Apr 2019 at 06:26, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Hi Krzysztof,
>
> On Tue, 16 Apr 2019 at 15:49, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > On Mon, 15 Apr 2019 at 14:24, Anand Moon <linux.amoon@gmail.com> wrote:
> > > Cache Coherent Interface (CCI) among Cortex-A15 and Cortex-A7, G2D, G3D and SSS
> > >
> > > Level 0 > CPU blocks such as Cortex-A15 (CA15), Cortex-A7 (CA7) are
> > > joined as the member of Level 0 CCI bus
> > >
> > > Level 1 > Display engine block (DISP) and 2D graphic engines (G2D) are
> > > directly connected to Level 1.
> > >   DISP, MDMA, SSS.
> > >
> > > Level 2 > While all the other IP is connected to Level 1 bus via Level 2 bus
> > >    G3D, MSCL, MFC, ISP, JPEG/Rotator/DMA/PERI, NAND/SD/EMMC.
> > >
> > > So my question is the mapped with the cci ip block correct.
> > > Level 0 (cci_control0)
> > > Level 1 (cci_control1)
> > > Level 2 (cci_control1)
> >
> > Hi Anand,
> >
> > I do not understand the question - what is mapped with correctly or not?
> >
> > Best regards,
> > Krzysztof
>
> Following the https://www.kernel.org/doc/Documentation/devicetree/bindings/arm/cci.txt
> CCI node linked to CPU and DMA nodes for example.
>
> On this line below diagram from Exynos 5422 UM show various IP block
> linked to CCI level.
> Below image just elaborate overall architecture of Exynos 5422 CCI.
>
> [0] https://imgur.com/gallery/0xJSwGQ
>
> So we should map the various IP block to corresponding CCI level.

Willy's patch did not touch cci_control{0,1} nor any other CCI levels
so I do not get what are you commenting. As for other CCI ports - we
do not define them and I do not see any users of device CCI API
(cci_enable_port_by_device() and cci_disable_port_by_device()). But
feel free to propose patches changing this. In general - it is easier
to discuss if you show the code/patch, not talk about some theoretical
change.

Best regards,
Krzysztof
