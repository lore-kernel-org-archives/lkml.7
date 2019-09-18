Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A9CC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 13:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35800218AF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 13:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X57m6I5u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731569AbfIRNe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 09:34:57 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38606 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731480AbfIRNey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 09:34:54 -0400
Received: by mail-io1-f68.google.com with SMTP id k5so16184785iol.5;
        Wed, 18 Sep 2019 06:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z7DBqMKpu8EzrBgPlSX/swxD/iXqKeDnzas5M8XpMNM=;
        b=X57m6I5uEdcM7IOv9cwHXfJKmMwICvxVrcmsxGyL0hsBKBo0S2UGhLBiSKA1mPSEmH
         ImSJbIaUnaB9C/PnaGsrREbbmVhcXFwdkvzopGcD3rO1DdFWggbMPkIM4PBQJnPuFAuY
         Yd9LdvxrerRCpSak8mQO61eVY1Go42pccz1qBbUry2lV3YS7U3I5K9ejahYOBpLUj4+Y
         NnOqXuVov0Tkc8BFiTFPQYu0mpTKQ7mrH7DLd7iM6bnPA8oApaJZBCyfwhkZStXuO8x0
         q18zKHQ80Ffoh1t3nGrhiO99Jy9xU8lt/9dWTnNNgG9C9KCLvhA/FMtnP+ggDg4Ycm27
         cwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z7DBqMKpu8EzrBgPlSX/swxD/iXqKeDnzas5M8XpMNM=;
        b=R4c4Hijp1g1ApSWEGF4bgv7RC5ZBStweXw1sO/QKWKfWy9h/A6D9aKWsCaCaEFiYPL
         LNgUDKBiJfjaALFmf4BvJWzwjpcgShLA+5Qq8CA7RGxy2u3/SgKFq8lok3k6YFtccmJN
         kntzbP3V5ZaP8zGn+hf2ej7rTZ+2HC2CyIhXU88uYg2grGp4Gatca8Ww2ytgLspzPH2O
         4/EaoCIVhmINKM+lRYrEFBKjSYIgLSVGOtPxzDykddB9UlVfbE4VBRW6A8VwEoQAmDRs
         pDXE2iRto3lEmA/DCx5R6bVScMUT8ooCdaeEM8ViaOpD17Ne/3yBxT7q/FtJyPXq2nnH
         RpoA==
X-Gm-Message-State: APjAAAWKw/JvVU4lYvTvsAjniLWcknBJXdAQ1Gm96v04g9ZQ2ZijTng4
        xDJQPNBcP8QhfV4cWX3LlGZFFVr6tBLB6XyW5Uc=
X-Google-Smtp-Source: APXvYqyPfI9/m7GnP1eANreUWIaOOQA0gr9DlEx7bsFmpyWiTYmXn7+hz85mRymp7juNdZnEMSA1GLfP1jKOSjVOKi4=
X-Received: by 2002:a5e:960a:: with SMTP id a10mr5401041ioq.87.1568813692672;
 Wed, 18 Sep 2019 06:34:52 -0700 (PDT)
MIME-Version: 1.0
References: <1568626884-5189-1-git-send-email-peng.fan@nxp.com>
 <1568626884-5189-2-git-send-email-peng.fan@nxp.com> <20190917183115.3e40180f@donnerap.cambridge.arm.com>
 <CABb+yY2CP1i9fZMoPua=-mLCUpYrcO28xF5UXDeRD2XTYe7mEg@mail.gmail.com> <AM0PR04MB44811AE46803D10FD8A5B8B0888E0@AM0PR04MB4481.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB44811AE46803D10FD8A5B8B0888E0@AM0PR04MB4481.eurprd04.prod.outlook.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Wed, 18 Sep 2019 08:34:41 -0500
Message-ID: <CABb+yY09pPqM-47zNFVGMNM9wrDF9iiVuqKTXrEd4-PdOxBPrQ@mail.gmail.com>
Subject: Re: [PATCH V6 1/2] dt-bindings: mailbox: add binding doc for the ARM
 SMC/HVC mailbox
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 3:53 AM Peng Fan <peng.fan@nxp.com> wrote:

> > >
> > > > +
> > > > +  "#mbox-cells":
> > > > +    const: 1
> > >
> > > Why is this "1"? What is this number used for? It used to be the channel ID,
> > but since you are describing a single channel controller only, this should be 0
> > now.
> > >
> > Yes. I overlooked it and actually queued the patch for pull request.
>
> In Documentation/devicetree/bindings/mailbox/mailbox.txt
> #mbox-cells: Must be at least 1.
>
> So I use 1 here, 0 not work. Because of_mbox_index_xlate expect at least 1 here.
> So I need modify Documentation/devicetree/bindings/mailbox/mailbox.txt
> and add xlate for smc mailbox?
>
No, you just can not use the generic xlate() provided by the api.
Please implement your own xlate() that requires no argument.

Cheers!
