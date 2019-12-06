Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6EAC2D0B1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 05:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34C8F2245C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 05:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwk8aQjr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfLFFoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 00:44:37 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41339 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfLFFoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 00:44:37 -0500
Received: by mail-ed1-f66.google.com with SMTP id c26so4794710eds.8;
        Thu, 05 Dec 2019 21:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jG4VeHKyYrwbwzbvzBFt4Gx2edRiCsdmF+I1yIWaGOQ=;
        b=hwk8aQjrxoq7/cMpTn3R/vI7AwL8vcmF8odckxSgFkQ7S5l8xjksnJ8GXpTauf6VxW
         FbIV50+Finemz9inqv8p8j41pxeEKHNNiTaBbub+pgk7JxY5lpgS3hYLG8ATCX7ZFVUJ
         uwcoARmbktnQSOrOAabeGjejFiovi03QBCyaK5qjJgTgfHABaIwl6sLey6iCxrHLGHc2
         s6D4pmKTdaB48kvXcyRq90VKOHsjA4vR4zDhHYOKpEn9UfjSjHsv60cvhXqF5r0DK0p1
         0hkd08vUqnTd6gqZMDG6fgBSNT1VzMrWRhfLztWMZtiOdx5zqQ+SaGXPRwBQMCWdQdDB
         Gpwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jG4VeHKyYrwbwzbvzBFt4Gx2edRiCsdmF+I1yIWaGOQ=;
        b=sR7N41nbiQGsPPkUeaImK66VFXttJq4w3Be24/ZQlBh574GnDSa7NTECidJ4O8ZM5q
         m8G7TVC1WB+gUhmlT/KGS4D0HIoOztc++V8pMoNzyH0cUZbdGxLQG1OlSeVJ4hZcX9+L
         Phing4XrS0HvfJNfEOs/1mFIeMpsx6jOj7bEzDOcB+v25JU3cz4RSSlS4A5ts+OUKXWU
         Lnw6LI9hqrgYu8027eA3FQ4aJmraVKAQjak8MujzRJ6iO/AlGNHGIM5sFMzo/hsL04yc
         EVY7rhshxPcRFQXoWaTcufTTYFv35/qSzxQVpHjZ4v+mZmVARteJagmJosxHBFGQqshL
         tMsw==
X-Gm-Message-State: APjAAAUUhaxIBVXqpa2xCS8/k+Tq2X6U1cSYD06djeL80nuwciIzi9Dw
        QODySDSlTN2IQRsecaZO+bqgbQu1+BlPVrNeCBU=
X-Google-Smtp-Source: APXvYqyDDeni3gnBiyE0+HxIAg+g/Cy0WoARGXH+7cPG3f7z554qdeBuocYEs/PL7lODC/WIgmE8dBBlC+DWW7zBBjU=
X-Received: by 2002:a05:6402:12d1:: with SMTP id k17mr14585333edx.291.1575611074979;
 Thu, 05 Dec 2019 21:44:34 -0800 (PST)
MIME-Version: 1.0
References: <1574679352-2989-1-git-send-email-shubhrajyoti.datta@gmail.com> <20191205181740.GA26684@bogus>
In-Reply-To: <20191205181740.GA26684@bogus>
From:   Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date:   Fri, 6 Dec 2019 11:14:23 +0530
Message-ID: <CAKfKVtHnnFbgmtpRJYS7V97SvZdipnhf7Pe1kOxPpJh+30bEFA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: Add dt bindings for flex noc Performance Monitor
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-doc@vger.kernel.org,
        corbet@lwn.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 5, 2019 at 11:47 PM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Nov 25, 2019 at 04:25:50PM +0530, shubhrajyoti.datta@gmail.com wrote:
> > From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> >
> > Add dt bindings for flexnoc Performance Monitor.
> > The flexnoc counters for read and write response and requests are
> > supported.
> >
> > Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> > ---
> > changes from RFC:
> > moved to schema / yaml
> >
> >  .../devicetree/bindings/perf/xlnx-flexnoc-pm.yaml  | 45 ++++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/perf/xlnx-flexnoc-pm.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/perf/xlnx-flexnoc-pm.yaml b/Documentation/devicetree/bindings/perf/xlnx-flexnoc-pm.yaml
> > new file mode 100644
> > index 0000000..bd0f345
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/perf/xlnx-flexnoc-pm.yaml
> > @@ -0,0 +1,45 @@
> > +# SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause
>
> () around the licenses.
>
> Are you good with GPL v10? Make it 'GPL-2.0-only' instead.
fixed in v2

>
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/perf/xlnx-flexnoc-pm.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Xilinx flexnoc Performance Monitor device tree bindings
> > +
> > +maintainers:
> > +  - Arnd Bergmann <arnd@arndb.de>
> > +  - Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> This should be someone familar with this h/w (you).
>
fixed in v2
> > +
> > +properties:
> > +  compatible:
> > +    # Versal SoC based boards
> > +    items:
> > +      - enum:
> > +          - xlnx,flexnoc-pm-2.7
> > +
> > +  reg:
> > +    items:
> > +      - description: funnel registers
> > +      - description: baselpd registers
> > +      - description: basefpd registers
> > +
> > +  reg-names:
> > +    # The core schema enforces this is a string array
> > +    items:
> > +      - const: funnel
> > +      - const: baselpd
> > +      - const: basefpd
> > +
> > +required:
> > +  - compatible
> > +  - reg
>
> No point having 'reg-names' if not required.
this I am using to get the addresses.

>
>
> Add:
>
> additionalProperties: false

updated in v2.
>
> > +
> > +examples:
> > +  - |
> > +    performance-monitor@f0920000 {
> > +        compatible = "xlnx,flexnoc-pm-2.7";
> > +        reg-names = "funnel", "baselpd", "basefpd";
> > +        reg = <0x0 0xf0920000 0x0 0x1000>,
> > +              <0x0 0xf0980000 0x0 0x9000>,
> > +              <0x0 0xf0b80000 0x0 0x9000>;
> > +    };
> > --
> > 2.1.1
> >
