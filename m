Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CC3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24BBE20C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="m0eBCrnC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732157AbfB1N6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:58:55 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43171 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727885AbfB1N6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:58:55 -0500
Received: by mail-qk1-f195.google.com with SMTP id f196so12081765qke.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 05:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=758vBfS9FVSzDR5rjnZneg86DRz7Zk633FP3j+m28Wk=;
        b=m0eBCrnCX+Ka+F+y7oxZ8u0ggnGmqtxmwpufEm0RerSMp16I1/iHXMAo/DNfnLFZ1v
         /+Uj7O4DK6WOxhtW58zU95XhdY01QVbfd/jX5CR2hranT/A4F8tRJtLeJ9yH+XZEctI+
         htl45tl1SOnOBg+AwLobTKJQBZ8m1m8uK/l9M/59lWFtKFXhF16bTf1lQhdaidMHPeYt
         zpWHN/x3fm5VZOQrZ+wVnPkXLoimB+E5BuslpN3U/WRKxTZof0ZyzQYpo6W6sKfk2hZp
         SGnUXfuDlcO1/Qw1yUVkCI2eDHb9N9MZewLXeTtZMB8RSDQXkmghCc4BBID9Uwx1JTdL
         oFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=758vBfS9FVSzDR5rjnZneg86DRz7Zk633FP3j+m28Wk=;
        b=g129lW8RdPGwaJPM3wo0zmF6QJc3CmOIcVfjL4gFt72i/4Yze4KWNZpSateQKYQFuJ
         qMRfc3NhN65ZfpgnKLGQDer90Ms7i5hS1FdW6gowFq3kv/TfmkuVVTcazQqBzyJqNpip
         3rxTFBs0C8xoXJcM6x4M+lC9QdWBlsGR1F6IHnnOWsZZ9YiM/LessMx4lJPAkMJOsxsm
         e6hH9iUKaxjmrYHOEz+M1xGCUW2Tlr0ZQkAZq8+eamVJHiNbJyrHSN0DJOQzw/xE8mTY
         KN/hcKSrnDLZlOzECugHI0ThR4o5JHjn4DQzaautvkjqF0BkgqRHd8LfQ2OF9C/sB0E+
         zzpQ==
X-Gm-Message-State: AHQUAuaA3EHG63AkJISHkyVQPjirbAt3mJ3AuaqmwjdvLQfy8a4dNWuN
        qe0edIT5NRRU/HVQOkLxvaE6nQG/U19vp7mhglUG1A==
X-Google-Smtp-Source: AHgI3Ia594tIs2HugEgQqtR1rhm/lNmqDXav+f8NieGdbioR5jxG77M9bmHs6Ma3EHDRHB3fuDqh2ouecdGFGtgmqWI=
X-Received: by 2002:a05:620a:1348:: with SMTP id c8mr6619049qkl.246.1551362333977;
 Thu, 28 Feb 2019 05:58:53 -0800 (PST)
MIME-Version: 1.0
References: <1551289652-7377-1-git-send-email-mw@semihalf.com> <20190228093627.vtfglsl2djenohlm@shell.armlinux.org.uk>
In-Reply-To: <20190228093627.vtfglsl2djenohlm@shell.armlinux.org.uk>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Thu, 28 Feb 2019 14:58:42 +0100
Message-ID: <CAPv3WKdj+EKr2VR+NcBHQrS9xoxHoMzZOri65G61CH6xLL8jFw@mail.gmail.com>
Subject: Re: [net: PATCH] net: mvpp2: disable link IRQ waiting for IDLE frames
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        netdev <netdev@vger.kernel.org>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
        nadavh@marvell.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Stefan Chulski <stefanc@marvell.com>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

czw., 28 lut 2019 o 10:36 Russell King - ARM Linux admin
<linux@armlinux.org.uk> napisa=C5=82(a):
>
> On Wed, Feb 27, 2019 at 06:47:32PM +0100, Marcin Wojtas wrote:
> > Current version of the driver was configuring XLG MAC
> > in a way to wait 3 IDLE frames before allowing for the
> > link-up interrupt to be triggered. This resulted in an
> > issue, preventing to detect the link change during RX
> > traffic on the interface. Fix that.
>
> What about noise sensitivity?  Does this now mean that on boards such as
> Macchiatobin Single Shot or Clearfog GT9k where the serdes is connected
> directly to a SFP cage, that noise on the serdes lines triggers a link
> indication?
>

Afaik waiting for idle frames is not required by any standard. In fact
this feature of the XLG MAC caused a risk that after dropping the link
during data transfer it would never go up again until remote peer
stops it.

I tested it on 3 different boards with SerDes directly connected to
the SFP cage and I'm also not aware of any reporte about
noise-triggered false link interrupts in XLG MAC (proprietary Marvell
mvpp2x driver did not use waiting 3 idle frames feature). I'd rather
assume the MAC is not vulnerable to it, and only properly established
link can trigger an event.

Best regards,
Marcin

> >
> > Fixes: 4bb043262878 ("net: mvpp2: phylink support")
> > Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> > ---
> >  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/=
net/ethernet/marvell/mvpp2/mvpp2_main.c
> > index 16066c2..f1378f9 100644
> > --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > @@ -4532,8 +4532,7 @@ static void mvpp2_xlg_config(struct mvpp2_port *p=
ort, unsigned int mode,
> >               ctrl0 |=3D MVPP22_XLG_CTRL0_RX_FLOW_CTRL_EN;
> >
> >       ctrl4 &=3D ~MVPP22_XLG_CTRL4_MACMODSELECT_GMAC;
> > -     ctrl4 |=3D MVPP22_XLG_CTRL4_FWD_FC | MVPP22_XLG_CTRL4_FWD_PFC |
> > -              MVPP22_XLG_CTRL4_EN_IDLE_CHECK;
> > +     ctrl4 |=3D MVPP22_XLG_CTRL4_FWD_FC | MVPP22_XLG_CTRL4_FWD_PFC;
> >
> >       writel(ctrl0, port->base + MVPP22_XLG_CTRL0_REG);
> >       writel(ctrl4, port->base + MVPP22_XLG_CTRL4_REG);
> > --
> > 2.7.4
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbp=
s up
> According to speedtest.net: 11.9Mbps down 500kbps up
