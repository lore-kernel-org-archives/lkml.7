Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA89C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 531102084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561042372;
	bh=EaDyAtg8euX5pskKcouYfYWBKvYrsXwOMR+jrlOcxls=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YwgSd3eiP9YOkO3k6l7zMhFnRBLMgLiRvrWFhpnGxpJW/JYP4efuGYlUBouVOk7uA
	 S4dRncPH6WYbEgtoc3wo1Cr2bxMLyNu36trKYIiPTQJ1idFzX/dw7L0tPiEO+sYA3P
	 Bw24iHc3UBCxlsmvjII7WOB4YDNYDFN3iPR30SbA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732006AbfFTOwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 10:52:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:52238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbfFTOwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 10:52:50 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEB7420679;
        Thu, 20 Jun 2019 14:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561042369;
        bh=EaDyAtg8euX5pskKcouYfYWBKvYrsXwOMR+jrlOcxls=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0Dnu+BLgZjPnr6dVZfMvc9QRpCCo9QL7NQCYB0LduXY0a3Rubd+QRCxquCtI9ydWN
         modMScwVPqyXLJvh2J8qRhQaLTwUtTKEBMoVLNzMswBHo+Ayr4Z8bcSWxVwN7/yUax
         be55PZYyBWukBftlXgAwMpGKM7cGveaPR1FvCMJg=
Received: by mail-qt1-f169.google.com with SMTP id y57so3482414qtk.4;
        Thu, 20 Jun 2019 07:52:48 -0700 (PDT)
X-Gm-Message-State: APjAAAXQtYlcYe4hl/KwVdz9yOjw26xnfjHR80HHPeaCOhPGEf6/TMU0
        FmBruWlJu/vu4b+fty6hmYOI1z4ZdgnGnqDbXw==
X-Google-Smtp-Source: APXvYqyR3TdgTdHL9HJ+C/MH0tWTCoy8T6RDUCj3s/Rtzv9hCbDuW8dyF53jU3kMLWuDuPl6q2X9SvIBU++c4EcOkzw=
X-Received: by 2002:aed:3fb0:: with SMTP id s45mr59844862qth.136.1561042368214;
 Thu, 20 Jun 2019 07:52:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190619215156.27795-1-robh@kernel.org> <20190620090122.GB26689@ulmo>
In-Reply-To: <20190620090122.GB26689@ulmo>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 20 Jun 2019 08:52:36 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKC-RDjdMQWM6yk_HiWu-WwuU+vUf946t=TDJAxnqMW7Q@mail.gmail.com>
Message-ID: <CAL_JsqKC-RDjdMQWM6yk_HiWu-WwuU+vUf946t=TDJAxnqMW7Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] dt-bindings: display: Convert common panel
 bindings to DT schema
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 3:01 AM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Wed, Jun 19, 2019 at 03:51:53PM -0600, Rob Herring wrote:
> > Convert the common panel bindings to DT schema consolidating scattered
> > definitions to a single schema file.
> >
> > The 'simple-panel' binding just a collection of properties and not a
> > complete binding itself. All of the 'simple-panel' properties are
> > covered by the panel-common.txt binding with the exception of the
> > 'no-hpd' property, so add that to the schema.
> >
> > As there are lots of references to simple-panel.txt, just keep the file
> > with a reference to panel-common.yaml for now until all the bindings are
> > converted.
> >
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Cc: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > Note there's still some references to panel-common.txt that I need to
> > update or just go ahead and convert to schema.
> >
> >  .../bindings/display/panel/panel-common.txt   | 101 -------------
> >  .../bindings/display/panel/panel-common.yaml  | 143 ++++++++++++++++++
> >  .../bindings/display/panel/panel.txt          |   4 -
> >  .../bindings/display/panel/simple-panel.txt   |  29 +---
> >  4 files changed, 144 insertions(+), 133 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/display/panel/panel-common.txt
> >  create mode 100644 Documentation/devicetree/bindings/display/panel/panel-common.yaml
>
> I know it was this way before, but perhaps remove the redundant panel-
> prefix while at it?

Sure.


> > diff --git a/Documentation/devicetree/bindings/display/panel/panel-common.yaml b/Documentation/devicetree/bindings/display/panel/panel-common.yaml
> > new file mode 100644
> > index 000000000000..6fe87254edad
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/panel/panel-common.yaml
> > @@ -0,0 +1,143 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/panel/panel-common.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Common Properties for Display Panels
> > +
> > +maintainers:
> > +  - Thierry Reding <thierry.reding@gmail.com>
> > +  - Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > +
> > +description: |
> > +  This document defines device tree properties common to several classes of
> > +  display panels. It doesn't constitue a device tree binding specification by
> > +  itself but is meant to be referenced by device tree bindings.
> > +
> > +  When referenced from panel device tree bindings the properties defined in this
> > +  document are defined as follows. The panel device tree bindings are
> > +  responsible for defining whether each property is required or optional.
> > +
> > +
>
> Are the two blank lines here on purpose?

No.

> The original document had two
> blank lines here, but that was mostly for readability I would guess. The
> YAML format doesn't really need additional formatting for readability,
> so perhaps just remove the extra blank line?
>
> > +properties:
> > +  # Descriptive Properties
> > +  width-mm:
> > +    description: The width-mm and height-mm specify the width and height of the
> > +      physical area where images are displayed. These properties are expressed
> > +      in millimeters and rounded to the closest unit.
> > +
> > +  height-mm:
> > +    description: The width-mm and height-mm specify the width and height of the
> > +      physical area where images are displayed. These properties are expressed
> > +      in millimeters and rounded to the closest unit.
>
> I suppose there's no way in YAML to share the description between both
> the width-mm and height-mm properties? It's a little unfortunate that we
> have to copy, but if there's no better way, guess we'll have to live
> with it.

I could make it a comment instead, but then we loose being able to
parse it. I should probably just reword them to be separate:

"Specifies the height of the physical area where images are displayed.
The property is expressed in millimeters and rounded to the closest
unit."

Also, just realized I need to make these 2 dependencies on either
other (i.e. not valid to only have one).

> > +  label:
> > +    description: |
> > +      The label property specifies a symbolic name for the panel as a
> > +      string suitable for use by humans. It typically contains a name inscribed
> > +      on the system (e.g. as an affixed label) or specified in the system's
> > +      documentation (e.g. in the user's manual).
> > +
> > +      If no such name exists, and unless the property is mandatory according to
> > +      device tree bindings, it shall rather be omitted than constructed of
> > +      non-descriptive information. For instance an LCD panel in a system that
> > +      contains a single panel shall not be labelled "LCD" if that name is not
> > +      inscribed on the system or used in a descriptive fashion in system
> > +      documentation.
> > +
> > +  rotation:
> > +    description:
> > +      Display rotation in degrees counter clockwise (0,90,180,270)
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > +      - enum: [ 0, 90, 180, 270 ]
> > +
> > +  # Display Timings
> > +  panel-timing:
>
> Am I the only one bugged by the redundancy in this property name? What
> else is the timing going to express if not the timing of the panel that
> it's part of. "timing" really would be enough. Anyway, not much we can
> do about it now.

I'm just happy we have a defined name.

Rob
