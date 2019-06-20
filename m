Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5630C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 22:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9BCA2082C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 22:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561068094;
	bh=JbuElVbN3Z0lxncKmpOc3j7BcuU4pLJzsm2POWaHbOo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RA4g1d3wVHOWiqH1z+U/Xrgb4ZCnjTBH6NK0sc5IjsAov/21drSqhfkkm05qcJ4tq
	 b41tocIDWUZcrczrd9DPptKJXp9YVlAU8peSJXVy0jXtKtPk7Q1Kp+hjJ/P/fSn+lN
	 a3Do/eiJsbNILJf1e6aewqvkcLQ+O2OE9qjpcXNI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbfFTWBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 18:01:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:58250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbfFTWBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 18:01:33 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C31F82082C;
        Thu, 20 Jun 2019 22:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561068091;
        bh=JbuElVbN3Z0lxncKmpOc3j7BcuU4pLJzsm2POWaHbOo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r2ObBBEXMMVIpWzdPcHq+HCuoYoELbl52kWYsuBEcO/MYhbWgIFzfhhIzWmTqg1b7
         u5NNWy2Sd4oq+dXI5MtYmQZ/C+MGQPQebzG9cwK/J3QlPTADjs19n197i/aAu0DUsr
         gnAavpclHADBh73WeYugpvdNKIZXIELjHNx0vldc=
Received: by mail-qk1-f177.google.com with SMTP id i125so3030633qkd.6;
        Thu, 20 Jun 2019 15:01:31 -0700 (PDT)
X-Gm-Message-State: APjAAAUAVA4xP+BSwMKPad0Cvp9T+WKLFw1Sd01Jimz9SdiLRJ2T0F+Q
        f33qYvNEkqSXPSLod1o71Z4V1p9jamZXCrdQyA==
X-Google-Smtp-Source: APXvYqxqswdc7BYIsSMkGt5yP29+KcMyoMC1aGIIaXPNTqblUxRNrTBW56OaKRe6HWPw4iAja6Qj6vVGBKu/Kf9NMWc=
X-Received: by 2002:a37:69c5:: with SMTP id e188mr108358787qkc.119.1561068091034;
 Thu, 20 Jun 2019 15:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190619215156.27795-1-robh@kernel.org> <20190620090122.GB26689@ulmo>
 <CAL_JsqKC-RDjdMQWM6yk_HiWu-WwuU+vUf946t=TDJAxnqMW7Q@mail.gmail.com>
In-Reply-To: <CAL_JsqKC-RDjdMQWM6yk_HiWu-WwuU+vUf946t=TDJAxnqMW7Q@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 20 Jun 2019 16:01:19 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+LME4N4aoUsw946hBGO4y8Q8yBVa2coeSZMr1Ns_XrSg@mail.gmail.com>
Message-ID: <CAL_Jsq+LME4N4aoUsw946hBGO4y8Q8yBVa2coeSZMr1Ns_XrSg@mail.gmail.com>
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

On Thu, Jun 20, 2019 at 8:52 AM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Jun 20, 2019 at 3:01 AM Thierry Reding <thierry.reding@gmail.com> wrote:
> >
> > On Wed, Jun 19, 2019 at 03:51:53PM -0600, Rob Herring wrote:
> > > Convert the common panel bindings to DT schema consolidating scattered
> > > definitions to a single schema file.
> > >
> > > The 'simple-panel' binding just a collection of properties and not a
> > > complete binding itself. All of the 'simple-panel' properties are
> > > covered by the panel-common.txt binding with the exception of the
> > > 'no-hpd' property, so add that to the schema.
> > >
> > > As there are lots of references to simple-panel.txt, just keep the file
> > > with a reference to panel-common.yaml for now until all the bindings are
> > > converted.
> > >
> > > Cc: Thierry Reding <thierry.reding@gmail.com>
> > > Cc: Sam Ravnborg <sam@ravnborg.org>
> > > Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> > > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > Cc: dri-devel@lists.freedesktop.org
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > > Note there's still some references to panel-common.txt that I need to
> > > update or just go ahead and convert to schema.
> > >
> > >  .../bindings/display/panel/panel-common.txt   | 101 -------------
> > >  .../bindings/display/panel/panel-common.yaml  | 143 ++++++++++++++++++
> > >  .../bindings/display/panel/panel.txt          |   4 -
> > >  .../bindings/display/panel/simple-panel.txt   |  29 +---
> > >  4 files changed, 144 insertions(+), 133 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/bindings/display/panel/panel-common.txt
> > >  create mode 100644 Documentation/devicetree/bindings/display/panel/panel-common.yaml
> >
> > I know it was this way before, but perhaps remove the redundant panel-
> > prefix while at it?
>
> Sure.

On 2nd thought, I prefer it as-is. The reason being the schema
including this file are more readable with:

allOf:
  - $ref: panel-common.yaml#

Compared to one of:

$ref: common.yaml#
$ref: /schemas/display/panel/common.yaml#

I suppose we could automagically include a 'common.yaml' file if
existing in the same directory. That's a bigger change though...

Rob
