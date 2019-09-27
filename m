Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976DAC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 19:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A51621655
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 19:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dr01MoRs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfI0TCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 15:02:49 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41387 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfI0TCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 15:02:49 -0400
Received: by mail-io1-f68.google.com with SMTP id r26so19006021ioh.8;
        Fri, 27 Sep 2019 12:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LO3JdAOU095h41fjVsuAsU+4Z0wmwAMdPedC2Thw3pg=;
        b=dr01MoRs+YBUsJR2Yajv5Gvk1Uuzl8J/B0xZ7BtPxjvHMRUFzNHi1gn2IjV0wXHCzq
         capi/qDYXysLutGkSjtANV/oT80eN4t3epMkMyFfb1YeeWmHa9B56XasKfDrBaj/UgsO
         MRPgpvasw/M/Lmb03EZJA/kFsbdBVMfYO7psdw+1yHdvq6WIeA5iEWS1/Q21rJENUPAU
         i8sw3SqRACaGNwbNZyxa3PEoYHDcCnP3XqMnzL7dbQwY6dcqx6TULVQxAbxzP5//qpyH
         xtlvQ6qOQVSLV5vls0hohFudnvizuTxuk2TL5CkaybbkRGoPMAZj8BeQzWgp1aJOcIUM
         OX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LO3JdAOU095h41fjVsuAsU+4Z0wmwAMdPedC2Thw3pg=;
        b=aVcn1pNPXx0wfzpuSZsYc2XbBP7Hx/ghHhuZHe0ia1XOAhOEtNPqgajsLO6Dvu5LfE
         XPxGfOGXPULB/R9Hz6TuYvI8eRX3zvE1GsbZHt8WOPjzWOLecalb3Dnrb7hzHPgetRfA
         K127GcwJR9xsR/P3YlVDTamIcn5p+mXESCmM4CuXfxoPPKUwZ3phLbMwIxfJg8U7cu5r
         XA/gwtzXq+78LD+q2jOprecBvqEwNzQVKQ1aOYZHvQNI1s0iACteFUyatZcRL/cBl/h7
         OCzEJPd8vohlU+e9sTMmZ+T2yYFJlNLx2vmzRDV4fh9aTDuWVtqH+TbX0f4EJysuEtvr
         zXNw==
X-Gm-Message-State: APjAAAVOqfqqT3sdRaPXHV9IMKEFynL91Coz7wkPQS1CNdlp3OcSPmqT
        LxdLKNivVLlBYNpNkjxj39XIagKoGJPT039rlIk=
X-Google-Smtp-Source: APXvYqwS6ado5j8H/MS9UQpgoe/UkE+sD6PlTwv5ZTRS/6e5bGEdAPsZ4ex2TIbFU5IYmkfVt2tiTgtyAQ59xYbnLxI=
X-Received: by 2002:a02:7810:: with SMTP id p16mr9500549jac.55.1569610967624;
 Fri, 27 Sep 2019 12:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190925184239.22330-1-aford173@gmail.com> <20190925184239.22330-2-aford173@gmail.com>
 <20190927185153.GA982@bogus>
In-Reply-To: <20190927185153.GA982@bogus>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 27 Sep 2019 14:02:35 -0500
Message-ID: <CAHCN7x+V_-PZjhC_1K1kU+fnQYwWM4br1PTPEBd4Kks=sR5K7g@mail.gmail.com>
Subject: Re: [PATCH V3 2/3] dt-bindings: Add Logic PD Type 28 display panel
To:     Rob Herring <robh@kernel.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Adam Ford <adam.ford@logicpd.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 1:51 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Sep 25, 2019 at 01:42:37PM -0500, Adam Ford wrote:
> > This patch adds documentation of device tree bindings for the WVGA panel
> > Logic PD Type 28 display.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > ---
> > V3:  Correct build errors from 'make dt_binding_check'
> > V2:  Use YAML instead of TXT for binding
> >
> > diff --git a/Documentation/devicetree/bindings/display/panel/logicpd,type28.yaml b/Documentation/devicetree/bindings/display/panel/logicpd,type28.yaml
> > new file mode 100644
> > index 000000000000..74ba650ea7a0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/panel/logicpd,type28.yaml
> > @@ -0,0 +1,31 @@
> > +# SPDX-License-Identifier: (GPL-2.0+ OR X11)
>
> (GPL-2.0-only OR BSD-2-Clause) please.
>
> X11 is pretty much never right unless this is copyright X Consortium.
>

I copied the example from
Documentation/devicetree/bindings/display/panel/ronbo,rb070d30.yaml

Is there a better example I can use?  If what I did is wrong, then it
seems like that board is wrong too.

> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/panel/logicpd,type28.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Logic PD Type 28 4.3" WQVGA TFT LCD panel
> > +
> > +maintainers:
> > +  - Adam Ford <aford173@gmail.com>
> > +
>
> You need:
>
> allOf:
>   - $ref: panel-common.yaml#
>
> > +properties:
> > +  compatible:
> > +    const: logicpd,type28
> > +
>
> > +  power-supply:
> > +    description: Regulator to provide the supply voltage
> > +    maxItems: 1
> > +
> > +  enable-gpios:
> > +    description: GPIO pin to enable or disable the panel
> > +    maxItems: 1
> > +
> > +  backlight:
> > +    description: Backlight used by the panel
> > +    $ref: "/schemas/types.yaml#/definitions/phandle"
>
> These 3 are all defined in the common schema, so you just need 'true'
> for the value to indicate they apply to this panel and to make
> 'additionalProperties: false' happy.

Sorry for my ignorance, but I am not familiar with the syntax here,
nor do I understand what is required.  Since there aren't many display
panels with yaml docs, I don't know what is expected and clearly the
one I used as a template didn't do it right either.

Is there a branch  where this stuff is located? I am just using the
latest linux-stable branch.

>
> > +
> > +required:
> > +  - compatible
>
> Are the rest really optional?

From what I can tell, they are optional.  I am just adding some timing
info to an already existing driver.  It's not my driver.


>
> > +
> > +additionalProperties: false
> > --
> > 2.17.1
> >
