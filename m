Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2ABC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 479FE20693
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="EyvQcSNn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbfDWQIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:08:17 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38378 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727754AbfDWQIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:08:16 -0400
Received: by mail-qt1-f193.google.com with SMTP id d13so16714268qth.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 09:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qj9kbZXTr7zKXSHE2IT9VClpI1Uyp0gtKR/7siF1Glk=;
        b=EyvQcSNnml041xkaDLLIO5BeLznQlgg4BzXua5XmF+zKQuIdaxoK4xv8Ab6lOm8hVT
         uxxkZZYgYVb2HH/CpDeBq/daRO6WmuPv4h3bfUAGo1c0IlPttssyADTEPaGFoLDb7ISs
         yJ7ZJ9WH7uxzclDSm2Ks0LY2gK/HYkXN3ya49aUtH4z+V4aJ5f6x7/4gxUg9cBFeOBdQ
         SBY0sblmRYZzehOakw5F2fLqXIdUCKjjb2D3T4a2tRUk4fRYMjB4PYMKewhXRbkOAs5w
         QkJD55d1ALn2HSjkTQ5HIqNyPYYjrMO6+2iPZxGwgk2VJWQePi+bb4bXMHfsEvp3IRGV
         F1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qj9kbZXTr7zKXSHE2IT9VClpI1Uyp0gtKR/7siF1Glk=;
        b=cooeftDgVwSVrLjBkxQgacocr6FXKcpEEGVPmvIrCwNsNnIJue2mhNHcjAbeh0QlWp
         xavZ7ylhcZ/QUDlJcR5UFjZ9iT/4rf/ffEHtrhqnbOu4a5U4UpY0NHgzL6Z8QomjaZg+
         AO7KK0lgJ+63fsBg1sDzMRXM/PBdkV/ovO03KiFx0J4MQhPhfIpJxauLUBmr5zMEELUr
         kjAfRym+gSx9cmqMyoaGrZLfa71kp3Y4cZVbUeX+i3L382Tm4r9elb9GhXJqSxyNVMsB
         PsxTL2rkRcdQux+ywR8HAe0yWHkHp0c4OlaCurJskYn90l8QiGY+wDiXIbaLqhymqsl9
         Q1ZA==
X-Gm-Message-State: APjAAAWsDptRPuWr3aHr18QEWHdbEP0arf0F0LSSILKVc9QXg0NhAV5V
        s6ry89/HN8dUb8PIB87A+STtgaY2kMrlXahONe+AiA==
X-Google-Smtp-Source: APXvYqzLdCVPIVDntZf49wW20ABsFtDhDuMTwyIRRq8MruJKVGpP4y3iTg1QpqsEeXOwH9LkwwD8jqyUGsFwDFCtPSE=
X-Received: by 2002:ac8:33b8:: with SMTP id c53mr21096700qtb.11.1556035695704;
 Tue, 23 Apr 2019 09:08:15 -0700 (PDT)
MIME-Version: 1.0
References: <1551289652-7377-1-git-send-email-mw@semihalf.com>
 <20190228093627.vtfglsl2djenohlm@shell.armlinux.org.uk> <CAPv3WKdj+EKr2VR+NcBHQrS9xoxHoMzZOri65G61CH6xLL8jFw@mail.gmail.com>
In-Reply-To: <CAPv3WKdj+EKr2VR+NcBHQrS9xoxHoMzZOri65G61CH6xLL8jFw@mail.gmail.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Tue, 23 Apr 2019 18:08:00 +0200
Message-ID: <CAPv3WKcDgY_LY_u8mY47ZZqT2iVL9fp5n3Le0UVWsyO4QDYP-A@mail.gmail.com>
Subject: Re: [net: PATCH] net: mvpp2: disable link IRQ waiting for IDLE frames
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        netdev <netdev@vger.kernel.org>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
        nadavh@marvell.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Tomasz Nowicki <tn@semihalf.com>,
        Stefan Chulski <stefanc@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David, Rusell,

czw., 28 lut 2019 o 14:58 Marcin Wojtas <mw@semihalf.com> napisa=C5=82(a):
>
> Hi Russell,
>
> czw., 28 lut 2019 o 10:36 Russell King - ARM Linux admin
> <linux@armlinux.org.uk> napisa=C5=82(a):
> >
> > On Wed, Feb 27, 2019 at 06:47:32PM +0100, Marcin Wojtas wrote:
> > > Current version of the driver was configuring XLG MAC
> > > in a way to wait 3 IDLE frames before allowing for the
> > > link-up interrupt to be triggered. This resulted in an
> > > issue, preventing to detect the link change during RX
> > > traffic on the interface. Fix that.
> >
> > What about noise sensitivity?  Does this now mean that on boards such a=
s
> > Macchiatobin Single Shot or Clearfog GT9k where the serdes is connected
> > directly to a SFP cage, that noise on the serdes lines triggers a link
> > indication?
> >
>
> Afaik waiting for idle frames is not required by any standard. In fact
> this feature of the XLG MAC caused a risk that after dropping the link
> during data transfer it would never go up again until remote peer
> stops it.
>
> I tested it on 3 different boards with SerDes directly connected to
> the SFP cage and I'm also not aware of any reporte about
> noise-triggered false link interrupts in XLG MAC (proprietary Marvell
> mvpp2x driver did not use waiting 3 idle frames feature). I'd rather
> assume the MAC is not vulnerable to it, and only properly established
> link can trigger an event.
>

This patch seems to get forgotten - any objections to merge it?

Best regards,
Marcin

> Best regards,
> Marcin
>
> > >
> > > Fixes: 4bb043262878 ("net: mvpp2: phylink support")
> > > Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> > > ---
> > >  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/driver=
s/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > > index 16066c2..f1378f9 100644
> > > --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > > +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > > @@ -4532,8 +4532,7 @@ static void mvpp2_xlg_config(struct mvpp2_port =
*port, unsigned int mode,
> > >               ctrl0 |=3D MVPP22_XLG_CTRL0_RX_FLOW_CTRL_EN;
> > >
> > >       ctrl4 &=3D ~MVPP22_XLG_CTRL4_MACMODSELECT_GMAC;
> > > -     ctrl4 |=3D MVPP22_XLG_CTRL4_FWD_FC | MVPP22_XLG_CTRL4_FWD_PFC |
> > > -              MVPP22_XLG_CTRL4_EN_IDLE_CHECK;
> > > +     ctrl4 |=3D MVPP22_XLG_CTRL4_FWD_FC | MVPP22_XLG_CTRL4_FWD_PFC;
> > >
> > >       writel(ctrl0, port->base + MVPP22_XLG_CTRL0_REG);
> > >       writel(ctrl4, port->base + MVPP22_XLG_CTRL4_REG);
> > > --
> > > 2.7.4
> > >
> > >
> > > _______________________________________________
> > > linux-arm-kernel mailing list
> > > linux-arm-kernel@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > >
> >
> > --
> > RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> > FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622k=
bps up
> > According to speedtest.net: 11.9Mbps down 500kbps up
