Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A2CFC6194
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 10:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF307218AE
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 10:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtKeo/LI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731883AbfKHKgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 05:36:47 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44393 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbfKHKgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 05:36:47 -0500
Received: by mail-wr1-f67.google.com with SMTP id f2so6388372wrs.11;
        Fri, 08 Nov 2019 02:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kixiz1UJPCQt5DtJCRrzFnJBbL/5bX50KYeOkVMV+Cg=;
        b=FtKeo/LIB7aGbV2YVnxZmazu978pFj4muuQOd/EP47XiGDBDLPjlOsPrXYkIfRStaF
         3xZ4MWNerylTE+RtIFaewVDHAiPhkbvjvgH48GlwlFjH7fhonZCuiqre+4TEYJmfRCoM
         PeA6rPbFzY4Um9RDNdgXPAIe245W6ccwtfDEZ5TqilAliKHj/VenIhDYKYHsOf7Nojv3
         BvcSI4n+fqPsEPENSNg8bCQztbEHAKtDRoWPzkMAh6lpdAeoilbKPF2qVPazgjKTlfJM
         sT/b0Pf41Rzv22BGJWkW29mX8IY1n04LV+MoBJucdHGLsKdsVCWQ3KWZSrG8wjD03eBJ
         RdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kixiz1UJPCQt5DtJCRrzFnJBbL/5bX50KYeOkVMV+Cg=;
        b=ZvS+AwGDWYzRGSH4Fm2JSILcVSuHl6C0bjptJ6ldUsr0699xLKgmSvaYGGw1Qfjupz
         3IPgppVyDqHnn80i4UuY26aN5KhkZrqr8lk104ojv0eDmvn44N4bKwk13eJVhhxqMRkf
         WdNVEN2g+ryjZvpRIYP+n0uPNwq4GxhJOSOga2klbFSodVBlbUDao2usULPei5KV1WLU
         tDLvOBw2gKXf3euEDDX6aJmoxomLnTOGhbnQcntlH6EWBBUxbNnaw4vc5bsXjGzhgsOX
         UVob9dqyOi+240gzDX/EDdMhBlsIoxaB98CuNiWWtAW0JE+4AqbdDb5IZqxUMIH9KTx1
         wtqA==
X-Gm-Message-State: APjAAAVAuvw77GfrSiKjHGCNxvGvhbf8RLJ9m29A77HAD/H+gVcEwkHJ
        fQs5HwxOr1qWBsgTrT7BpXCMwlztPsi5Fs83SPflbQ==
X-Google-Smtp-Source: APXvYqyNMGT1ZLrWn6Zqu4IpDilJBSDE3A4kImFlIIMvNx8CAAVORQxhKHUTpgbTd2wxKk+qK3e1jtrHUiZVBLfgcLY=
X-Received: by 2002:a5d:678f:: with SMTP id v15mr7368952wru.242.1573209404817;
 Fri, 08 Nov 2019 02:36:44 -0800 (PST)
MIME-Version: 1.0
References: <20191025102915.23677-1-chunyan.zhang@unisoc.com>
 <20191025102915.23677-3-chunyan.zhang@unisoc.com> <20191029214610.GA20831@bogus>
In-Reply-To: <20191029214610.GA20831@bogus>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Fri, 8 Nov 2019 18:36:08 +0800
Message-ID: <CAAfSe-tMrdBYo=CZW=JF=68pvRkfD_nh_Z3-rpM=EzCbnuuqOQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: arm: Add bindings for Unisoc's SC9863A
To:     Rob Herring <robh@kernel.org>
Cc:     Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        DTML <devicetree@vger.kernel.org>, linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Oct 2019 at 05:46, Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Oct 25, 2019 at 06:29:14PM +0800, Chunyan Zhang wrote:
> >
> > Added bindings for Unisoc's SC9863A board and SC9863A SoC.
> >
> > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > ---
> >  Documentation/devicetree/bindings/arm/sprd.txt | 8 ++++++++
> >  1 file changed, 8 insertions(+)
>
> Can you please convert this to DT schema first. See
> Documentation/devicetree/writing-schema.rst.

Ok, will do, thanks.

Chunyan

>
> >
> > diff --git a/Documentation/devicetree/bindings/arm/sprd.txt b/Documentation/devicetree/bindings/arm/sprd.txt
> > index 3df034b13e28..c244c911f8df 100644
> > --- a/Documentation/devicetree/bindings/arm/sprd.txt
> > +++ b/Documentation/devicetree/bindings/arm/sprd.txt
> > @@ -12,3 +12,11 @@ Required root node properties:
> >  SP9860G 3GFHD Board
> >  Required root node properties:
> >       - compatible = "sprd,sp9860g-1h10", "sprd,sc9860";
> > +
> > +SC9863A SoC
> > +Required root node properties:
> > +     - compatible = "sprd,sc9863a"
> > +
> > +SP9863A-1H10 Board
> > +Required root node properties:
> > +     - compatible = "sprd,sp9863a-1h10", "sprd,sc9863a";
> > --
> > 2.20.1
> >
> >
