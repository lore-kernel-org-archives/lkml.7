Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67469C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 07:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 318DC21773
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 07:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="tBO/I5yu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfCaHEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 03:04:12 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52310 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbfCaHEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 03:04:12 -0400
Received: by mail-wm1-f65.google.com with SMTP id a184so6765017wma.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 00:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=sJmXGYZIR5w+oPY+YEjpX1bcjRyIcWNvy+pqs0iNf88=;
        b=tBO/I5yubzj5k1eSiTFHhfTtJaSswf2naiXfD/hMWsFnvOuqERd4hr1WWS6mlyyRjW
         ASDKSesJjIjxvVquIMfnlLUcTZwoyMViZDZPrR2O9Dc62beNez0nt7a0BkCkjat3Gi3i
         i0J2kQjO2hK9Lty2+WfQkG8iYgRNjA3TuXnUu+uwUvb/LGstIFGpmgEVv7nnpre8E8tg
         C4EkiinVnNh3zFJYNPmVnl0/LNV07tCpceZBtdlw8WQu5i0xaf9skh1beLZ1apVzvj8y
         OFVXw3Iruk9MbxmbOawknW5G34IxIHf9dXK8QucfmGnp5EfbuNO1nT1HlryW6hyfaY1S
         +9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=sJmXGYZIR5w+oPY+YEjpX1bcjRyIcWNvy+pqs0iNf88=;
        b=U9R2xEEi5P+tNCVHeXEweJpEl4QqkliM11UML3aN7H9sGFjWNGi8cR9Qi60QK4bInL
         GJ7462A/EHa+rQVWLk8vd8d2eyUfHqqgLshkmIvwZoCDjx8aMsFeago0I4kRGns1MJ6n
         BYyDBvmj0twgFCPWUujbCyrQXtpV8RnziuHGfGOTvc5NgvcK7DtT+UtVpAuS1CmcC4Zl
         JBUXmT1igi8LfNpM0fMu//VbWE+G9h9h8BK2KIULRE52onsDzVWgGOwOxxWrNbrqWBLT
         NqLFpRScJYFIi99372DVW/t1gKoGzUbBF/m6JxlQPOCww/Djjkk0TygAaCaRpNYZa/fL
         D8qg==
X-Gm-Message-State: APjAAAVwXf5NQFjGkDrXC6wX+gs6TQE8ceY/oNovDaTeH9eBzocmvYVQ
        LMWyCUNUXNEmgsfzzkE4NjDatg==
X-Google-Smtp-Source: APXvYqxd8udKADMK3DFmPsFOGWd+2yq7EPuJRXBfvhHbD9wh7lyZlzVTp8K07ALh1fGdK4X6qhSXyw==
X-Received: by 2002:a1c:cb0e:: with SMTP id b14mr8626505wmg.149.1554015850615;
        Sun, 31 Mar 2019 00:04:10 -0700 (PDT)
Received: from boomer.baylibre.com (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id g12sm5236162wrw.40.2019.03.31.00.04.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 31 Mar 2019 00:04:09 -0700 (PDT)
Message-ID: <722ef39685fb3b519d09c00a3444708abd685f9d.camel@baylibre.com>
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: meson: Add drive-strength
 property
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Guillaume La Roque <glaroque@baylibre.com>,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Date:   Sun, 31 Mar 2019 09:04:08 +0200
In-Reply-To: <20190330212830.GA28281@bogus>
References: <20190314163725.7918-1-jbrunet@baylibre.com>
         <20190314163725.7918-2-jbrunet@baylibre.com> <20190330212830.GA28281@bogus>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-03-31 at 01:40 -0500, Rob Herring wrote:
> On Thu, Mar 14, 2019 at 05:37:24PM +0100, Jerome Brunet wrote:
> > From: Guillaume La Roque <glaroque@baylibre.com>
> > 
> > Add optional drive-strength property
> > 
> > Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > ---
> >  Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
> > index a47dd990a8d3..4e3d5a27c91c 100644
> > --- a/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
> > +++ b/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
> > @@ -51,6 +51,9 @@ Configuration nodes support the generic properties "bias-disable",
> >  "bias-pull-up" and "bias-pull-down", described in file
> >  pinctrl-bindings.txt
> >  
> > +Optional properties :
> > + - drive-strength: Drive strength for the specified pins in uA.
> 
> The standard definition says this is in mA.

Yes, the problem we have and the solutions we are thinking about are explained
in detail in the cover letter of this patchset. Could you share your opinion
on it ?

Thx

> 
> > +
> >  === Example ===
> >  
> >  	pinctrl: pinctrl@c1109880 {
> > -- 
> > 2.20.1
> > 


