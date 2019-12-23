Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B28AC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 21:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A9EF206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 21:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTCbj/0X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfLWVoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 16:44:32 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:43188 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfLWVoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 16:44:32 -0500
Received: by mail-io1-f67.google.com with SMTP id n21so15883742ioo.10;
        Mon, 23 Dec 2019 13:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=koCPH0cxDF98YbtxSO0x6h+giqorikDtjWlhEuBq+TE=;
        b=HTCbj/0XVTGB/KTu/PdEO4PeXaUwXec4k2rZhUz2+pFW1HTk9BpyyrF2q7eFYEE63n
         I37QuNMYtTdCFN+K93pQff9cqpDlV5e0ngY8oIW1jgIkmtNUbEa8U3LvfZWiRzUmmFyc
         2a4GVb44gvYUcxj7BRngqqXDn2/sxqQtk0y/23GoA0M/skPKloTFiPWxgrRNgcQJnS+n
         +wNOH+yszpOVh9+9BwbaL3PQO5VR9Xxc5ZD5cH24s8WhgyWkG1EuNjd7wVxaOUzyiDz8
         zTWEgeqLZ5I3ummZ+H3O8+sBQhcbTez7mmPvtlKlhyuwuMRz9+BHL+324fl97D2vi/aj
         vy/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=koCPH0cxDF98YbtxSO0x6h+giqorikDtjWlhEuBq+TE=;
        b=AWVMKfy/AyrMsQxlFxbibWaAReFI7DAg8I7bt3zwnd+YamsmU4xVHywjtTyDO0g0lj
         /WI4bGCtjPtwbt00ofUWdrEkGiuHdT7yAVjzaRpCwNXqxrdNkI/3HjVa+qJNj7PuZH6b
         hDFkgnz6KJfzg+q6kJFavVZaMh/CAYus9MetkyUs7IEVigaVhwdTfh/a/sIv+dvVrWoj
         vpUgII5SAp4gknYbwfw73b7/qIYwBF/4jic9Zlk2oOLNAvBpsPSvFZ2CkEy8eXdAkuR3
         9OAfIZ9GJUrvRt0A94Y6p+AdN97kvJYS8G0HlgKvA9AgVBKsifMKmfBJfeLT0UFTgQ5O
         QcOQ==
X-Gm-Message-State: APjAAAVV2JGJY+5/jtFK8S0kEpM0/aazBdTgqGzX3AC0Z3Vm5dVrlSEe
        JXjBGXKyu51KwWidus0bwyxvb6ij59/Ukqp+KwQ=
X-Google-Smtp-Source: APXvYqyu46ajAJWwSKClwA3Ac23soXJMDMYYyY/c2MylFWpxaO6OKoAWs4fUYI7wX7F4yfyuIR8jIEmZ6TniFrsXx0s=
X-Received: by 2002:a02:2a8e:: with SMTP id w136mr6107392jaw.117.1577137471307;
 Mon, 23 Dec 2019 13:44:31 -0800 (PST)
MIME-Version: 1.0
References: <20191210003124.32376-1-jassisinghbrar@gmail.com> <20191219194000.GA23698@bogus>
In-Reply-To: <20191219194000.GA23698@bogus>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Mon, 23 Dec 2019 15:44:20 -0600
Message-ID: <CABb+yY3COBOHLQXkQMzB_DWh-yXsrtJqnD9vi9FfMPYBTgVuyg@mail.gmail.com>
Subject: Re: [PATCHv1 1/2] dt-bindings: max3421-udc: add dt bindings for
 MAX3420 UDC
To:     Rob Herring <robh@kernel.org>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 1:40 PM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Dec 09, 2019 at 06:31:24PM -0600, jassisinghbrar@gmail.com wrote:
> > From: Jassi Brar <jaswinder.singh@linaro.org>
> >
> > Add YAML dt bindings for Maxim MAX3420 UDC controller.
> >
> > Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> > ---
> >  .../bindings/usb/maxim,max3420-udc.yaml       | 60 +++++++++++++++++++
> >  1 file changed, 60 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/maxim,max3420-udc.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/usb/maxim,max3420-udc.yaml b/Documentation/devicetree/bindings/usb/maxim,max3420-udc.yaml
> > new file mode 100644
> > index 000000000000..cf4eec8a618e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/maxim,max3420-udc.yaml
> > @@ -0,0 +1,60 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
>
> Dual license new bindings please:
>
> (GPL-2.0-only OR BSD-2-Clause)
>
ok

> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/usb/maxim,max3420-udc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: MAXIM MAX3420/1 USB Peripheral Controller
> > +
> > +maintainers:
> > +  - Jassi Brar <jaswinder.singh@linaro.org>
> > +
> > +description: |
> > +  The controller provices USB2.0 compliant FullSpeed peripheral
> > +  implementation over the  SPI interface.
>
> space                        ^
>
ok

> > +
> > +  Specifications about the part can be found at:
> > +    http://datasheets.maximintegrated.com/en/ds/MAX3420E.pdf
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - maxim,max3420-udc
> > +      - maxim,max3421-udc
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    minItems: 1
> > +    maxItems: 2
> > +    items:
> > +      - const: udc
> > +      - const: vbus
>
> interrupts are integers, not strings. Should be interrupt-names?
>
yes

> > +
> > +  spi-max-frequency:
> > +    maximum: 26000000
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - interrupt-names
>
> Add:
>
> additionalProperties: false
>
ok

Thanks.
