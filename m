Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A23C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 359CD205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552357538;
	bh=MfZWIGk+NBpb2uuvOdluvqM5AoFk78k5Oo1O/12JqmM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LydAPr7ko6i8BamqLUzDLTPJSyGnnaKMekeAHiUPC4Tb2DqRB3I4VSWY9XS5rvHwp
	 uh5RD4uL30XJ9F9Ud++a4vuVz/CBBLypbvriZgr5PvjxH8PwzYbA+q0F49XhVQuFKC
	 x4d+V/yyuCDkKlyWultAnuGAZ1GK9gcyM1D2xrM8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfCLCZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 22:25:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:42004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbfCLCZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 22:25:35 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14C8E205C9;
        Tue, 12 Mar 2019 02:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552357534;
        bh=MfZWIGk+NBpb2uuvOdluvqM5AoFk78k5Oo1O/12JqmM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YJ7dqgX3lWnNXgN1WlYCYk4gmzORpWhvu78x0V7vZMTyymOKLSnYjpuOOEeKKIW7o
         cF9w6U/bXr8moZERmj4qBTIfaZnEMDmxYfvfuB0ByxHzP0tK6k0g4OYhqFIbfd28O8
         z/FAH+6Jhqh1xMGxRK8kULLBb167oMZbYmX9DGYA=
Received: by mail-wr1-f52.google.com with SMTP id y15so950369wro.4;
        Mon, 11 Mar 2019 19:25:34 -0700 (PDT)
X-Gm-Message-State: APjAAAU6g25hUY5t9J9UzGAZSERuIwAYNxbMc+CrdNB4n3Q57BPltMYr
        KCIDt7coaxkO+1QTX1MBbwG6f7BbrQ8BEmhcXuY=
X-Google-Smtp-Source: APXvYqzUI4mfm2xEx2Vg1HaZbnaXcFJs26MPck0MpVq/q9ujojyfoqOVeiNDDRRu8zFtMrGBZWMnVEGpCO+djQOcBjk=
X-Received: by 2002:adf:ec41:: with SMTP id w1mr22966858wrn.184.1552357532567;
 Mon, 11 Mar 2019 19:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <1552275991-34648-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1552275991-34648-4-git-send-email-hsin-hsiung.wang@mediatek.com>
 <CAGp9LzrWawWy+mX5VpLeqdV85f0iEdRv6JtJbjS5pamN5xfKjA@mail.gmail.com> <20190311220630.GA4082@bogus>
In-Reply-To: <20190311220630.GA4082@bogus>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Mon, 11 Mar 2019 19:25:26 -0700
X-Gmail-Original-Message-ID: <CAGp9LzoCdCNLwr_6ufmox2Oqf3S87N4wyTZM-jU_XkUS+mA0hA@mail.gmail.com>
Message-ID: <CAGp9LzoCdCNLwr_6ufmox2Oqf3S87N4wyTZM-jU_XkUS+mA0hA@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] dt-bindings: mfd: Add compatible for the MediaTek
 MT6358 PMIC
To:     Rob Herring <robh@kernel.org>
Cc:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-mediatek@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 3:06 PM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Mar 11, 2019 at 12:19:32PM -0700, Sean Wang wrote:
> > Hi,
> >
> > Always put the patches about dt-binding changes at the head of the
> > series to let the related maintainer more easily find them.
> >
> > On Sun, Mar 10, 2019 at 8:48 PM Hsin-Hsiung Wang
> > <hsin-hsiung.wang@mediatek.com> wrote:
> > >
> > > This adds compatible for the MediaTek MT6358 PMIC.
> > >
> > > Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> > > ---
> > >  Documentation/devicetree/bindings/mfd/mt6397.txt | 11 ++++++++---
> > >  1 file changed, 8 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
> > > index 0ebd08a..62f1c17 100644
> > > --- a/Documentation/devicetree/bindings/mfd/mt6397.txt
> > > +++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
> > > @@ -17,22 +17,27 @@ Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
> > >  This document describes the binding for MFD device and its sub module.
> > >
> > >  Required properties:
> > > -compatible: "mediatek,mt6397" or "mediatek,mt6323"
> > > +compatible:
> > > +       "mediatek,mt6323" for PMIC MT6323
> > > +       "mediatek,mt6358" for PMIC MT6358
> > > +       "mediatek,mt6397" for PMIC MT6397
> >
> > don't change anything not related MT6358
>
> Reformatting like this is preferred.
>

Sure, it's fine to me for the purpose.

> Rob
