Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24912C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 23:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED661206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 23:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H05M40Xn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfKUXm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 18:42:59 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33069 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfKUXm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 18:42:58 -0500
Received: by mail-wm1-f68.google.com with SMTP id t26so4973820wmi.0;
        Thu, 21 Nov 2019 15:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wxmEJjNaN9UTvvRKWXFpb21tVPam5jQwSvyjPenrGBo=;
        b=H05M40Xn/dR0wjIjpQoGFoggLf1X6IvXsgp+JnAwyfyJkP3rQEkIqIkyAHjY6Rjh4R
         +eIi15gB7+9TE+/FyU2goWDpG6k9I00lIXyQHgFcmdtY2/PZsOzRPdWvwFSDljzvYk9u
         FujEQLjcp1dp6oy/rkYvF4NTpc+bc9hoqvD0EzdB9is5kti62VCJ4dI82huGgLKzOH4z
         6Q3mU7K/vuqZrbINBhkNaFL9wkmuddbOlqE9mqXQpYNeu+qIFUmXbrEU530FNefKsi8U
         9ebYaDQkttwWxHACN/YGgYeoowm4hGstttozUGe8Z5hhLooqI08nLOLOp0KvtcvqoHRs
         eIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wxmEJjNaN9UTvvRKWXFpb21tVPam5jQwSvyjPenrGBo=;
        b=YPZ9IuSWG3B50NLdHIUW2PDzYMJSpjZoI5ZsSmNkCCIRWaI47q+HWmbkW7xHzkM9If
         u8hfWCT7/SkzGG2cJn/AQNY5I7QOp4PorPWxvCwkBnZ3cslSmUO4h3LeZKKIGsP3gH1v
         SdDvuyQyH2rDIW2TU7HQUSA9z4hljv1diaZahoaVsU2pVJlnzBDVJE58OEpz7vv183Sm
         VueJXV+itPmu5TtW9kfjYrUOcIVbaha3iFIWCsmxNg8r36yB2NwYoNuILwQwZrf5urm+
         nv+ud2AGYZXnWpyb3m4oi2CpZ8hTjoqZLQP+m1tTCg5RDR9NTYIZTtozIE3Z5o1fcW7o
         hbPw==
X-Gm-Message-State: APjAAAXLs1PwwCMo2M1sRX6JU6rfhOh8YbxkeOWpN0/nysVzjUrZg/Yu
        h65Vb0XGrtvyzhLwhu08gZ7Q+mF1DMupe5cQ+Oo=
X-Google-Smtp-Source: APXvYqygYqD1TIkLgSi6B2OMFPzSOf+RwOdotX0s/cjy6WJ/5YxX4P8TF7VXPc7D+s8DspwovPAOHykcIs8EHs3DBB8=
X-Received: by 2002:a7b:c08f:: with SMTP id r15mr12987890wmh.45.1574379776241;
 Thu, 21 Nov 2019 15:42:56 -0800 (PST)
MIME-Version: 1.0
References: <20191121190124.1936-1-jdk@ti.com> <CAL_JsqJhWj1RoT9LWe5-gA91aAkCYrJ6S6vm1DEkqwx56WNEGQ@mail.gmail.com>
In-Reply-To: <CAL_JsqJhWj1RoT9LWe5-gA91aAkCYrJ6S6vm1DEkqwx56WNEGQ@mail.gmail.com>
From:   Jason Kridner <jkridner@gmail.com>
Date:   Thu, 21 Nov 2019 18:42:45 -0500
Message-ID: <CA+T6QP=FO=YqA=okd5LuJXNZJOzHBqAczk3hECi+O6Ourrw3Hw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Add vendor prefix for BeagleBoard.org
To:     Rob Herring <robh+dt@kernel.org>, Caleb Robey <c-robey@ti.com>
Cc:     devicetree@vger.kernel.org,
        Robert Nelson <robertcnelson@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jason Kridner <jdk@ti.com>, Jyri Sarha <jsarha@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 6:17 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Thu, Nov 21, 2019 at 1:02 PM Jason Kridner <jkridner@gmail.com> wrote:
> >
> > Add vendor prefix for BeagleBoard.org Foundation
> >
> > Signed-off-by: Jason Kridner <jdk@ti.com>
>
> Author and Sob emails don't match.

I'll set the from address to jdk@ti.com in another submission.

>
> > ---
> >  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > index 967e78c5ec0a..3e3d8e3c28d3 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > @@ -139,6 +139,8 @@ patternProperties:
> >      description: Shenzhen AZW Technology Co., Ltd.
> >    "^bananapi,.*":
> >      description: BIPAI KEJI LIMITED
> > +  "^beagleboard.org,.*":
>
> '.' would need need to be escaped as this is a regex.
>
> The '.' may cause some problems with schemas. We can adapt or just
> drop the '.org'.
>

I tried to run some YAML syntax checkers and they didn't like a
backslash ('\') before the period ('.').  YAML specification
documentation didn't specify how to escape a period.

My preference is to keep beagleboard.org, but, out of simplicity and
brevity, I can resubmit without it.

The device tree submission for BeagleBone AI will need to updated accordingly.

-- 
https://beagleboard.org/about
