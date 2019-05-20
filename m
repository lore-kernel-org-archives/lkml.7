Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CDEC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F166A2054F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FY+xDHdl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732777AbfETNaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 09:30:13 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37719 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732069AbfETNaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 09:30:12 -0400
Received: by mail-wm1-f65.google.com with SMTP id 7so13073037wmo.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 06:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8jmGilw1nCQQmkBhHj38AiUSNpWBZe/sVuRM01rHJv0=;
        b=FY+xDHdlrGHpESK8d3dY9mKd1ulBFHyvOVNM4E/E1imXiTfV0C2iFc0rfPluiYI9ti
         MkuGQzvux2dG6tG1e+KiV4OUqVQT5Qm7Yy6WB3PkW8ZWeG7UB4NYbi7D93geMjs6ZkGo
         Fx+yt0kZcrFZHxnA90yAfup2DJJZ8Dn6Y3K7hxCTFDbqFjRvkwbaSodfn5WtHGfthJDo
         3PTdSyM8MM33ZMwBaxKztYfimViCP70xCgakknd24OaIpwTnAaIvV6iT+VaeivDs8E23
         4PeY7+bjmcEHI+4pdtdPQ5ty1/iv+0HT0SoZnbwzxt+BwcB8hC4ZCUQeopMbZDFiDxOM
         jy8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8jmGilw1nCQQmkBhHj38AiUSNpWBZe/sVuRM01rHJv0=;
        b=F2l+BxZqc+0CUf9a0FkGqjnRR3wEjjCN7VwZ+KWVD1bZ7v8dZeSidHsqq2CMOX+Wzi
         ZQuU3VsdKkkD6DwdGoTpbSAG4ufnlDGzNjINRsWtAAIvSCAFVlKkJeDj55hrrteA7TTb
         XgXHnJBBfn+Mg/TTj9XYnkk4TrE+BvhbdmedHUYw3UE8SsWjo8uxqe7ke9HAgvk8edVE
         nJrg7jndteHXDddiEBbbnCq84KC5hZ6oBqOk1RNyPapeYc+Y16e/Nl2lAng1qONAYGzJ
         dXtj9UXDOsl1kDtrjMLvEoBfvmufnaTaHTT/9BcvF0X8rkLvZAspZQjfzMep3ZlAKFwi
         CQrQ==
X-Gm-Message-State: APjAAAXchUcLeSKDrO+iyWkFo5SELTsSw0uheqK21m8hWieUh++U1tHM
        LOC6tSNlnMfIg2h+ohcGiW8WZw==
X-Google-Smtp-Source: APXvYqx2txSUvSVKzjvZhfqtdeKg/VLHgRIYD6Rv9nUdsldKd1EgOPFxeK2Xh7cX5NLv9PmgcLKi1Q==
X-Received: by 2002:a1c:7606:: with SMTP id r6mr11647224wmc.25.1558359009976;
        Mon, 20 May 2019 06:30:09 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id y1sm15465215wma.14.2019.05.20.06.30.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 06:30:09 -0700 (PDT)
Date:   Mon, 20 May 2019 14:30:07 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Brian Masney <masneyb@onstation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Mark Rutland <mark.rutland@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>, Jonathan Marek <jonathan@marek.ca>
Subject: Re: [PATCH] dt-bindings: backlight: lm3630a: correct schema
 validation
Message-ID: <20190520133007.gymbonmq635gp73b@holly.lan>
References: <20190520085846.22320-1-masneyb@onstation.org>
 <CAL_JsqLcycH5e=YT-4AQFo-8O0bosjU7oagCRS5CMTfQNBLrcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLcycH5e=YT-4AQFo-8O0bosjU7oagCRS5CMTfQNBLrcg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 08:14:03AM -0500, Rob Herring wrote:
> On Mon, May 20, 2019 at 3:59 AM Brian Masney <masneyb@onstation.org> wrote:
> >
> > The '#address-cells' and '#size-cells' properties were not defined in
> > the lm3630a bindings and would cause the following error when
> > attempting to validate the examples against the schema:
> >
> > Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.example.dt.yaml:
> > '#address-cells', '#size-cells' do not match any of the regexes:
> > '^led@[01]$', 'pinctrl-[0-9]+'
> >
> > Correct this by adding those two properties.
> >
> > While we're here, move the ti,linear-mapping-mode property to the
> > led@[01] child nodes to correct the following validation error:
> >
> > Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.example.dt.yaml:
> > led@0: 'ti,linear-mapping-mode' does not match any of the regexes:
> > 'pinctrl-[0-9]+'
> >
> > Fixes: 32fcb75c66a0 ("dt-bindings: backlight: Add lm3630a bindings")
> > Signed-off-by: Brian Masney <masneyb@onstation.org>
> > Reported-by: Rob Herring <robh+dt@kernel.org>
> > ---
> >  .../leds/backlight/lm3630a-backlight.yaml     | 20 +++++++++++++------
> >  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

