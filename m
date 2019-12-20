Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAF8C2D0C8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 22:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 772812146E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 22:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576879942;
	bh=abgPvh1cAN8OegF/GMVW9qKqXeD6Vo0YP0ogUcVZC/Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sfI4ufop/uG5GDT2ygcTQUi5ciqAaMVHkpiKEmPdnHT8nNwdYH6cyopBvpuFrNEwC
	 DIAQXy4bZgGXh3KKT4fDuvXQFudiQXeYVqc61AHnH5gxbbLK1ytrcg7oyofLuBouGZ
	 IW/vnZb41SnLz+WMTE1DhTHEQwBTKdwtlrXFP9Yo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfLTWMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 17:12:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:35232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727413AbfLTWMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 17:12:21 -0500
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34DA52146E;
        Fri, 20 Dec 2019 22:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576879940;
        bh=abgPvh1cAN8OegF/GMVW9qKqXeD6Vo0YP0ogUcVZC/Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mdUG4wlCOfFUYklEWNJp0dDs6JbBrd4gghWVQMblfiv7oNc7MfwvsU9T0wLx1QiPU
         M2myRXBwePTP2t1/f9Focc9/nSHMFux7AptegAgUbn1BxSd2kpsOjlLMjfujOMvsq/
         CyTRDwi6nQ81X6GlnSSMBkM6CMst0Kemm17gYR9k=
Received: by mail-qk1-f172.google.com with SMTP id w127so8864700qkb.11;
        Fri, 20 Dec 2019 14:12:20 -0800 (PST)
X-Gm-Message-State: APjAAAXng99FhVIMVJ4qTeE3lafzU0aNQXR1wV/KyJWCinWj1JCKi+Nf
        LE847h5tjNM9IT8r4EmjScMCjlUAKly3jXRGQQ==
X-Google-Smtp-Source: APXvYqyAoezf59Vb0TgP/Q6GTEtoJSM8Qlqy3Hir3jvUrfI5dyTJG/NQOPxC/8atEWQcPTR8IY3P9jcPdKcq0ttJCV8=
X-Received: by 2002:a05:620a:1eb:: with SMTP id x11mr15824191qkn.254.1576879939367;
 Fri, 20 Dec 2019 14:12:19 -0800 (PST)
MIME-Version: 1.0
References: <1576069760-11473-1-git-send-email-yamonkar@cadence.com>
 <1576069760-11473-15-git-send-email-yamonkar@cadence.com> <20191219212546.GA30631@bogus>
 <BYAPR07MB5110503F5B2B0A2B9E3E02F5D22D0@BYAPR07MB5110.namprd07.prod.outlook.com>
In-Reply-To: <BYAPR07MB5110503F5B2B0A2B9E3E02F5D22D0@BYAPR07MB5110.namprd07.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 20 Dec 2019 15:12:07 -0700
X-Gmail-Original-Message-ID: <CAL_JsqL=nQTSZ1aQ+EOkE9Shg4Q2JT4T1yhLokC8bxifsS2fzw@mail.gmail.com>
Message-ID: <CAL_JsqL=nQTSZ1aQ+EOkE9Shg4Q2JT4T1yhLokC8bxifsS2fzw@mail.gmail.com>
Subject: Re: [RESEND PATCH v1 14/15] dt-bindings: phy: phy-cadence-torrent:
 Add platform dependent compatible string
To:     Yuti Suresh Amonkar <yamonkar@cadence.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jsarha@ti.com" <jsarha@ti.com>,
        "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>,
        "praneeth@ti.com" <praneeth@ti.com>,
        Milind Parab <mparab@cadence.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 2:43 AM Yuti Suresh Amonkar
<yamonkar@cadence.com> wrote:
>
> Hi,
>
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: Friday, December 20, 2019 2:56
> > To: Yuti Suresh Amonkar <yamonkar@cadence.com>
> > Cc: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;
> > kishon@ti.com; mark.rutland@arm.com; jsarha@ti.com;
> > tomi.valkeinen@ti.com; praneeth@ti.com; Milind Parab
> > <mparab@cadence.com>; Swapnil Kashinath Jakhade
> > <sjakhade@cadence.com>
> > Subject: Re: [RESEND PATCH v1 14/15] dt-bindings: phy: phy-cadence-
> > torrent: Add platform dependent compatible string
> >
> > EXTERNAL MAIL
> >
> >
> > On Wed, Dec 11, 2019 at 02:09:19PM +0100, Yuti Amonkar wrote:
> > > Add a new compatible string used for TI SoCs using Torrent PHY.
> > >
> > > Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
> > > ---
> > >  Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml | 4
> > > +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> > > b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> > > index 8069498..60e024b 100644
> > > --- a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> > > +++ b/Documentation/devicetree/bindings/phy/phy-cadence-
> > torrent.yaml
> > > @@ -15,7 +15,9 @@ maintainers:
> > >
> > >  properties:
> > >    compatible:
> > > -    const: cdns,torrent-phy
> > > +    anyOf:
> >
> > Should be an enum or if both strings can be present then you need 2 oneOf
> > entries for 1 string and 2 strings.
> >
>
> We can have only one compatible string at a time, so should I use like this?
>
> compatible:
>      enum:
>           - cdns,torrent-phy
>           - ti,j721e-serdes-10g

Yes.
