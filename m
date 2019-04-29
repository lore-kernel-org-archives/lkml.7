Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FDBC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 16:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B36E821530
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 16:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556555169;
	bh=bj7+n3P2zt1GsKkIXPcHMBO06qBROIEGOQ+zCdPaqFs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DDTTreykAMts04yzm3b57D+INW3aBPXtsewNPB2o5WJurCz1c2j6jPaNVTRhx28eH
	 UgjiRTmR/niZTZ3UODr6zL2w8EaU3g9M762vamGSt9Pir/WNBaDF/h1dZ9i80oFcPx
	 jGMDteqCFz810BeSJsYN8+2S1EMyyeLnZU94opZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbfD2Q0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 12:26:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:52118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728518AbfD2Q0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 12:26:08 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8DC32173E;
        Mon, 29 Apr 2019 16:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556555167;
        bh=bj7+n3P2zt1GsKkIXPcHMBO06qBROIEGOQ+zCdPaqFs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Yxj4nj4RhtP2Dp8y/Di6Rzz6NsAcd3KJTq9TajPpD+r5Gpv8iiusYuRWYLRP/Ev17
         OJkUjzbPoUFvwDC86helwDwR7/ou0qo/ZS3tLiMZsOVx+/oeRBhg1DxHke921YYTcA
         i+JXFDh2Yjnbl5k3YHlkRVjeV0rA3JZobObf87P8=
Received: by mail-qt1-f181.google.com with SMTP id b3so12574269qtc.12;
        Mon, 29 Apr 2019 09:26:06 -0700 (PDT)
X-Gm-Message-State: APjAAAWB39dkjkWlCN0miW3oExTEEUj5vDuePIp7AbFsbaGwXGopUKE9
        a0TGQEw5QJXaKeXHRYef15Fl+A8QlTkcjOTcpQ==
X-Google-Smtp-Source: APXvYqxmrpfobhstOL9g61ZfeyOcZLaz4w2E+msmiFaUvM+oogy+DnVE7G6vyrl1NOxtstfN8MjFYEzeOYV5F2BJoGI=
X-Received: by 2002:a0c:d2f2:: with SMTP id x47mr48617546qvh.90.1556555166043;
 Mon, 29 Apr 2019 09:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <1556261237-13823-1-git-send-email-chunfeng.yun@mediatek.com>
 <1556261237-13823-4-git-send-email-chunfeng.yun@mediatek.com>
 <20190426204906.GB15074@bogus> <1556453788.10179.224.camel@mhfsdcap03>
In-Reply-To: <1556453788.10179.224.camel@mhfsdcap03>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 29 Apr 2019 11:25:54 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKXKRetoy4u_yAMgS+RA0vaRhzjR0zpLjKMtgRvFHXn7A@mail.gmail.com>
Message-ID: <CAL_JsqKXKRetoy4u_yAMgS+RA0vaRhzjR0zpLjKMtgRvFHXn7A@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] dt-bindings: usb: mtu3: add properties about USB
 Role Switch
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Min Guo <min.guo@mediatek.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Biju Das <biju.das@bp.renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 28, 2019 at 7:16 AM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
>
> On Fri, 2019-04-26 at 15:49 -0500, Rob Herring wrote:
> > On Fri, Apr 26, 2019 at 02:47:14PM +0800, Chunfeng Yun wrote:
> > > Now the USB Role Switch is supported, so add properties about it
> > >
> > > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > > ---
> > > v4: no changes
> > > v3: no changes
> > >
> > > v2 changes:
> > >   1. fix typo
> > >   2. refer new binding about connector property
> > > ---
> > >  .../devicetree/bindings/usb/mediatek,mtu3.txt          | 10 ++++++++--
> > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt b/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
> > > index 3382b5cb471d..6e004c4a89af 100644
> > > --- a/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
> > > +++ b/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
> > > @@ -27,7 +27,9 @@ Optional properties:
> > >   - ranges : allows valid 1:1 translation between child's address space and
> > >     parent's address space
> > >   - extcon : external connector for vbus and idpin changes detection, needed
> > > -   when supports dual-role mode.
> > > +   when supports dual-role mode; it's consiedered valid for compatibility
> > > +   reasons, and not allowed for new bindings, use the property
> > > +   usb-role-switch instead.
> > >   - vbus-supply : reference to the VBUS regulator, needed when supports
> > >     dual-role mode.
> > >   - pinctrl-names : a pinctrl state named "default" is optional, and need be
> > > @@ -36,7 +38,8 @@ Optional properties:
> > >     is not set.
> > >   - pinctrl-0 : pin control group
> > >     See: Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
> > > -
> > > + - usb-role-switch : use USB Role Switch to support dual-role switch, but
> > > +   not extcon
> >
> > Coordinate with the Renesas and HiSilicon folks implementing the same
> > thing and put this in a common spot.
> I'll prepare a patch for it, and CC Biju and Yu
>
> > However, I think this should not
> > even be needed as knowing the controller capabilities (based on the
> > compatible) and knowing the type of connector should be enough
> > information to tell you if dual role is supported or not.
> Some Dual-Role controller drivers already used extcon framework to
> handle role switch, if try to support the new USB Role Switch framework,
> the driver may want to know which way will be used.

Wouldn't it know by presence of 'extcon' property or not?

> Sometimes users also want to use dual-role even use the type-A, such as
> use sys interface to handle role switch, so only knowing the connector
> type can't tell driver which way to use

That use case doesn't sound like something that should be in DT
though. That would be possible for any controller that supports
dual-role. Though perhaps that requires some specific Vbus wiring? Or
a cable with Vbus disconnected. Either way, doesn't sound USB
compliant.

Rob
