Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A40AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3762206DD
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551721394;
	bh=ozRreU3RmIrmPBt2VbxbTZQcQKmj4OKXbuQN0ktJiHg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Cirylejb6v8zyFO+j8MQc+H8zoOnP3p3BoAT1642rd6R9RHBrtYZaaVQ8eGeMQodR
	 Nkgr6VyvUpnixzwGUQMtCN/I8/bYYp++8HMypoWoDZ+/P+K01qpwCLtvXFSJziFygb
	 eZfinsoab6c+hW6sPk2SLH6vQuTff3JGgiBk+/Ns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfCDRnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 12:43:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:40244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727268AbfCDRnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 12:43:12 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14E1520823;
        Mon,  4 Mar 2019 17:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551721391;
        bh=ozRreU3RmIrmPBt2VbxbTZQcQKmj4OKXbuQN0ktJiHg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GMOnVWgAvagoRM2SpqMMHVdtABAlrvIJdPnolQey3SwQZ8y0cJDsgjI5DDWb8eYtB
         smyS9ckPZxLc78cCJll9EBq9KZEPTiQgxyNDySvY3Eq8uFKXK8hFEBq/+iPq4xnvMW
         ccr7IYcV7v4p2iuhnViCjw9635ZP5jECPKXUMFtI=
Received: by mail-qt1-f171.google.com with SMTP id s1so6031236qte.5;
        Mon, 04 Mar 2019 09:43:11 -0800 (PST)
X-Gm-Message-State: APjAAAVmo0cA1MmYVfGgniuMniwfsuou6eTu7vxMHdoqM4rEsJHIyZWo
        KweNOJo0TiEDeqrhd0g7eVGns6A01pCxDDvfdg==
X-Google-Smtp-Source: APXvYqyEPlo0AQygH5BSbkv/lOmajyJh/zF7vfHmYltzEGg5k86upZNLjDJVK8+51GzTwm/8d3lNQBk1ZpDVZxltIkY=
X-Received: by 2002:a0c:91bb:: with SMTP id n56mr15662943qvn.77.1551721390309;
 Mon, 04 Mar 2019 09:43:10 -0800 (PST)
MIME-Version: 1.0
References: <1550561795-31132-1-git-send-email-min.guo@mediatek.com>
 <1550561795-31132-2-git-send-email-min.guo@mediatek.com> <20190222164923.GA26413@bogus>
 <1551058604.12020.34.camel@mhfsdcap03>
In-Reply-To: <1551058604.12020.34.camel@mhfsdcap03>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 4 Mar 2019 11:42:58 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKb_afdZFaOoB5yvs2hX-T9HPVy_d30zu7f7yiqaRPaLg@mail.gmail.com>
Message-ID: <CAL_JsqKb_afdZFaOoB5yvs2hX-T9HPVy_d30zu7f7yiqaRPaLg@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] dt-bindings: usb: musb: Add support for MediaTek
 musb controller
To:     Min Guo <min.guo@mediatek.com>
Cc:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Tony Lindgren <tony@atomide.com>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2019 at 7:36 PM Min Guo <min.guo@mediatek.com> wrote:
>
> Hi Rob,
> On Fri, 2019-02-22 at 10:49 -0600, Rob Herring wrote:
> > On Tue, Feb 19, 2019 at 03:36:30PM +0800, min.guo@mediatek.com wrote:
> > > From: Min Guo <min.guo@mediatek.com>
> > >
> > > This adds support for MediaTek musb controller in
> > > host, peripheral and otg mode.
> > >
> > > Signed-off-by: Min Guo <min.guo@mediatek.com>
> > > ---
> > > changes in v5:
> > > suggested by Rob:
> > > 1. Modify compatible as
> > > - compatible : should be one of:
> > >                "mediatek,mt-2701"
> > >                ...
> > >                followed by "mediatek,mtk-musb"
> > > 2. Add usb connector child node
> > >
> > > changes in v4:
> > > suggested by Sergei:
> > > 1. String alignment
> > >
> > > changes in v3:
> > > 1. no changes
> > >
> > > changes in v2:
> > > suggested by Bin:
> > > 1. Modify DRC to DRD
> > > suggested by Rob:
> > > 2. Drop the "<soc-model>-musb" in compatible
> > > 3. Remove phy-names
> > > 4. Add space after comma in clock-names
> > > ---
> > >  .../devicetree/bindings/usb/mediatek,musb.txt      | 54 ++++++++++++++++++++++
> > >  1 file changed, 54 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/usb/mediatek,musb.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/usb/mediatek,musb.txt b/Documentation/devicetree/bindings/usb/mediatek,musb.txt
> > > new file mode 100644
> > > index 0000000..0632e6e
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/usb/mediatek,musb.txt
> > > @@ -0,0 +1,54 @@
> > > +MediaTek musb DRD/OTG controller
> > > +-------------------------------------------
> > > +
> > > +Required properties:
> > > + - compatible      : should be one of:
> > > +                     "mediatek,mt-2701"
> >
> > That looks like a top-level SoC compatible and doesn't match the
> > example.
> "mediatek,mt-2701" is an example, just to describe a specific SOC.
> May I modify compatibel like:
> compatible : should be "mediatek,mtk-musb"

No, you should fix the example adding "mediatek,mtk-musb".

Rob
