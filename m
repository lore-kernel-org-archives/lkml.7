Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9388CC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6166620855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aBwGgNMM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfDDDmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 23:42:18 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40443 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDDDmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 23:42:17 -0400
Received: by mail-lj1-f196.google.com with SMTP id q66so736616ljq.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 20:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=29X/AC/PrHlHS0OMXZfselge/eOaCEenzhRC+wnkd8o=;
        b=aBwGgNMMbdYvO1VZSa7VNW2WMYZ2q9ZgnPP6BH+SBoSLH3Wae0qqRxXpHvKHKUw/+y
         GCCBp6QpqX2s7b23Y/Ixr4Ich3cE+Y12kxZf8/QsU6Mvz7h8AU1O+TpCTXAKZP7B1X5l
         pYmFTRwFlMjswkBWX+jC9vR1d+Z2GvXU5lYK/phCDbqQyeKx2eqSO8FeMSPc2E+zgxwB
         Pfe3a5ehl+668ClY9GmEuk7+S0sdPwgAKfjBq0IgyVx9ojRsqi8AvDk/xcrtfjsPkE5t
         MQlRxuyTLvnNBm1EPl2a37XYrxv0g5rdxbfsfNQ821R7qaBTd5tumFrjFjLuIgjOydkU
         hHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=29X/AC/PrHlHS0OMXZfselge/eOaCEenzhRC+wnkd8o=;
        b=jkkT2vlITsWhKU9F/wpUY78/suibEX8TIlr6PjilBJrTPTjnJMmOFSP6SH0GI3f0ED
         acsKac7wd7tSWVHgXnMqfV4IhdgSzB1DsGxdpKow08DXaLDDhv1zEGSy6neXHMSzpVN1
         iMJpfegHTbAGGwHoyhK7UmIue3X5fqWex1vNpF+2gl4vYDJ3H1vp9V2V12H7DwLkD0Lk
         skGmBwE/kfMKsOy8SZI60qTpkxCunPYkOBo7e7HLJkd9TD6o9q2jke7QBFA91CE6CaNl
         oX0K9ofl12US/gDfuG1Aa7b51CJGr+sjhFLjr5SLzeOxbRTkzb1RwhuFJQYtYAm3QNwl
         DPgg==
X-Gm-Message-State: APjAAAU5XwPhjmc0f9qjHO+gjT1rkqNao5JIaECCnf2NWzpxq4d8PJ8a
        LM9q8o8OgH0K0E2MeyeGTunyK0Zvo2Cc6RcFhYPxHj7x
X-Google-Smtp-Source: APXvYqw4e+JidrHrHBXzWRWVeG/v6WdG5mRe2YaSaMe+B1YnJVi9rHe+KmuK4u+5iR2Qx3Wd4MV1Fl7Kq8Ic6KVi0P4=
X-Received: by 2002:a2e:5d94:: with SMTP id v20mr1823342lje.138.1554349335486;
 Wed, 03 Apr 2019 20:42:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190314163725.7918-1-jbrunet@baylibre.com> <20190314163725.7918-2-jbrunet@baylibre.com>
 <20190330212830.GA28281@bogus> <722ef39685fb3b519d09c00a3444708abd685f9d.camel@baylibre.com>
In-Reply-To: <722ef39685fb3b519d09c00a3444708abd685f9d.camel@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 4 Apr 2019 10:42:03 +0700
Message-ID: <CACRpkdahO0rQ+qLuWOqeMTECsH6JwRL7Eh+hb2iNH4JwgzJkOQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: meson: Add drive-strength property
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Rob Herring <robh@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
        Guillaume La Roque <glaroque@baylibre.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 2:04 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
> On Sun, 2019-03-31 at 01:40 -0500, Rob Herring wrote:
> > On Thu, Mar 14, 2019 at 05:37:24PM +0100, Jerome Brunet wrote:
> > > From: Guillaume La Roque <glaroque@baylibre.com>

> > > +Optional properties :
> > > + - drive-strength: Drive strength for the specified pins in uA.
> >
> > The standard definition says this is in mA.
>
> Yes, the problem we have and the solutions we are thinking about are explained
> in detail in the cover letter of this patchset. Could you share your opinion
> on it ?

I like your idea with drive-strength-uA but I need the second opinion from the
device tree people.

Yours,
Linus Walleij
