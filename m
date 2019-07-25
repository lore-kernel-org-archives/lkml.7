Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5382CC76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 22:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21EA0218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 22:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564093449;
	bh=3JLogo6H+bSfeYeWtbaf6Mngs+H5aQPOTF5AdZi4JbQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VHij+Qd36QgT75tVE9+Q9esc4Iuokfk3Hxgaxyv+VtL8AvtjJAO+B8Wb734E+E6ue
	 Xa+4NXJNsQx11oV2XG2zQLwEMUpVQw7K0vXx7GYW47btzqZcfsOBQRW5VMIDWi3Uk0
	 THsiamheAjBcWGyMVtKFufQi60o6VmvVfB8/L/a0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfGYWYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 18:24:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbfGYWYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 18:24:07 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3672922C7E;
        Thu, 25 Jul 2019 22:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564093446;
        bh=3JLogo6H+bSfeYeWtbaf6Mngs+H5aQPOTF5AdZi4JbQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qQ0pmHASFnfLaGawnik5VEoSJv0ubNcBHj1bRacJYGJRhko66TxkYcoc0ZNJiWtRM
         /okS464Oy2UMDzloZChf/rj6Bx3I39iCuYcOl2CWKKdV+eX2zOLVyfM4V+SctfAXHT
         Rn+V2exDT35fhGJEVrOJoteHZDhoBpSCZFGmrwHA=
Received: by mail-qt1-f169.google.com with SMTP id y26so50697975qto.4;
        Thu, 25 Jul 2019 15:24:06 -0700 (PDT)
X-Gm-Message-State: APjAAAWVDgv1p58BPm8DEpqS45SMDmz5lac/HjvzB4CTR290NP1mwzIE
        t6mwC8PwfbVRdVAOeNXiql9SerLXqAv1i+tesA==
X-Google-Smtp-Source: APXvYqymuR/CfxglS3eGlra1LScgdzgYCXA7Zoh0YgXpzw19WOcSOu4dPi51w8tk0qDx2h76/kSXt+skkFTYNwydBEM=
X-Received: by 2002:aed:3fb0:: with SMTP id s45mr65093826qth.136.1564093445297;
 Thu, 25 Jul 2019 15:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <1562625253-29254-1-git-send-email-yongqiang.niu@mediatek.com>
 <1562625253-29254-6-git-send-email-yongqiang.niu@mediatek.com>
 <20190724201635.GA18345@bogus> <1564024819.2621.4.camel@mtksdaap41>
In-Reply-To: <1564024819.2621.4.camel@mtksdaap41>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 25 Jul 2019 16:23:54 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL439PCnG3B75uqCXb3-OfH2uK6qtU7XpUb-cEnPWRkkQ@mail.gmail.com>
Message-ID: <CAL_JsqL439PCnG3B75uqCXb3-OfH2uK6qtU7XpUb-cEnPWRkkQ@mail.gmail.com>
Subject: Re: [PATCH v4, 05/33] dt-bindings: mediatek: add RDMA1 description
 for mt8183 display
To:     CK Hu <ck.hu@mediatek.com>
Cc:     yongqiang.niu@mediatek.com, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 9:20 PM CK Hu <ck.hu@mediatek.com> wrote:
>
> Hi, Rob:
>
> On Wed, 2019-07-24 at 14:16 -0600, Rob Herring wrote:
> > On Tue, Jul 09, 2019 at 06:33:45AM +0800, yongqiang.niu@mediatek.com wrote:
> > > From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> > >
> > > This patch add RDMA1 description for mt8183 display
> > >
> > > Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> > > ---
> > >  Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> > > index afd3c90..bb9274a 100644
> > > --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> > > +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> > > @@ -30,6 +30,7 @@ Required properties (all function blocks):
> > >     "mediatek,<chip>-disp-ovl"              - overlay (4 layers, blending, csc)
> > >     "mediatek,<chip>-disp-ovl-2l"           - overlay (2 layers, blending, csc)
> > >     "mediatek,<chip>-disp-rdma"             - read DMA / line buffer
> > > +   "mediatek,<chip>-disp-rdma1"            - function is same with RDMA, fifo size is different
> >
> > This can't be determined by which chip it is? IOW, a chip may have both
> > rdma and rdma1?
>
> In MT8183, there are two different rdma. The difference is the fifo size
> in each one. I've a question: is it better to have two compatible string
> for each one, or just one compatible string for both but with a property
> to set fifo size?

If that's the only diff, then a property for fifo size is fine. We
just don't want to be adding a new property for each new difference.
