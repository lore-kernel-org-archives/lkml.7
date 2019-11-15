Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F989C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 01:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2391520725
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 01:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oS+L4APa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbfKOBfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 20:35:17 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38001 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbfKOBfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 20:35:17 -0500
Received: by mail-wr1-f67.google.com with SMTP id i12so9156015wro.5;
        Thu, 14 Nov 2019 17:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B2XNQuUR8Wh6kRLjMqlhXvwKQ8d9fAfymRV8s7wKrPI=;
        b=oS+L4APaOZrpJXEc1LLhVdt8mkJ12CUna5vRiYhGh4GfIXHelKvs9BXZXdDQkJISzl
         pFx9HsScYfYTw51MURxTbA7Z5Vku8km4XuZs5prR0VxkFNEMBO7j/Tdd3ufqo4S3ehas
         0RjA21mxGrsYWpjnvT2vYkCh1NKOtz21qBr1KQACAZajhdd2VGjaI9ny1cJU6mJyHXWR
         FOZzXQJts1qA0FZ8f6hEo52ulY+VGodgXRQVLsg0RGudlRovFOXdEoCi7Cs/zfVlmEwN
         K9W/eA0EwgkQyNZXVpfb/BJXdjyft2a8KV/5H0a81JANtQwsdHMXKze+WIsz3Za5GNTW
         tmpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B2XNQuUR8Wh6kRLjMqlhXvwKQ8d9fAfymRV8s7wKrPI=;
        b=U4gwJL1VOlE5//2feZsggLKkGtGhZAkNSfLfO1K37lIHYcM9qPTxrH7NF6k8MjCKgW
         hjqlkyS7/rnz4J1UW0h+Zm3L8xtgo8G6Mfs8I1/sIKg2/PohBpr+GUGnzc9VduEw4Sex
         osMOLG6s5+iDCjTzcdazxRLKCqmqEWWSCKEqdFL7agsxz7rnLdJnVYJAzdtgmXRFD8HD
         ot7rWLi0Jf4LpcbQ/A/HAojSFNxorMO5BoM91tNYIuvr93jr63fio4VoCuyziQDBEULn
         xn9TLtqCql6g7JaTcFFg3ezXBfmwrRs9IA+vl28eedxpqPo0GVFQiYmMEKuFkh7o3Aih
         zsNA==
X-Gm-Message-State: APjAAAU36KlbreJ38/HMBI2TQAidANrJu5Fp7fxXF70yWXSQZ3uZE7Kj
        FUh5/1MSUCQ3pg/yWiqk4/zBmUcwQbEQ8dsj/jg=
X-Google-Smtp-Source: APXvYqwRXz+nyq3UvXDsIXwlYqr0wfbLRVw8mbwknO68m+ZoU3fcqdhkspiN8I/+JjRfETY84SFGP6yFGTBxFQ9aeik=
X-Received: by 2002:adf:9786:: with SMTP id s6mr12669139wrb.188.1573781714445;
 Thu, 14 Nov 2019 17:35:14 -0800 (PST)
MIME-Version: 1.0
References: <20191111090230.3402-1-chunyan.zhang@unisoc.com>
 <20191111090230.3402-3-chunyan.zhang@unisoc.com> <20191114205235.GA16668@bogus>
In-Reply-To: <20191114205235.GA16668@bogus>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Fri, 15 Nov 2019 09:34:38 +0800
Message-ID: <CAAfSe-s==xzeK_Y0rVezunR0T86b7ZcASo4HcW6g74qH7v-vbg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] dt-bindings: serial: Convert sprd-uart to json-schema
To:     Rob Herring <robh@kernel.org>
Cc:     Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Nov 2019 at 04:52, Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Nov 11, 2019 at 05:02:27PM +0800, Chunyan Zhang wrote:
> >
> > Convert the sprd-uart binding to DT schema using json-schema.
> >
> > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > ---
> >  .../devicetree/bindings/serial/sprd-uart.txt  | 32 ---------
> >  .../devicetree/bindings/serial/sprd-uart.yaml | 69 +++++++++++++++++++
> >  2 files changed, 69 insertions(+), 32 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/serial/sprd-uart.txt
> >  create mode 100644 Documentation/devicetree/bindings/serial/sprd-uart.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/serial/sprd-uart.txt b/Documentation/devicetree/bindings/serial/sprd-uart.txt
> > deleted file mode 100644
> > index 9607dc616205..000000000000
> > --- a/Documentation/devicetree/bindings/serial/sprd-uart.txt
> > +++ /dev/null
> > @@ -1,32 +0,0 @@
> > -* Spreadtrum serial UART
> > -
> > -Required properties:
> > -- compatible: must be one of:
> > -  * "sprd,sc9836-uart"
> > -  * "sprd,sc9860-uart", "sprd,sc9836-uart"
> > -
> > -- reg: offset and length of the register set for the device
> > -- interrupts: exactly one interrupt specifier
> > -- clock-names: Should contain following entries:
> > -  "enable" for UART module enable clock,
> > -  "uart" for UART clock,
> > -  "source" for UART source (parent) clock.
> > -- clocks: Should contain a clock specifier for each entry in clock-names.
> > -  UART clock and source clock are optional properties, but enable clock
> > -  is required.
> > -
> > -Optional properties:
> > -- dma-names: Should contain "rx" for receive and "tx" for transmit channels.
> > -- dmas: A list of dma specifiers, one for each entry in dma-names.
> > -
> > -Example:
> > -     uart0: serial@0 {
> > -             compatible = "sprd,sc9860-uart",
> > -                          "sprd,sc9836-uart";
> > -             reg = <0x0 0x100>;
> > -             interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
> > -             dma-names = "rx", "tx";
> > -             dmas = <&ap_dma 19>, <&ap_dma 20>;
> > -             clock-names = "enable", "uart", "source";
> > -             clocks = <&clk_ap_apb_gates 9>, <&clk_uart0>, <&ext_26m>;
> > -     };
> > diff --git a/Documentation/devicetree/bindings/serial/sprd-uart.yaml b/Documentation/devicetree/bindings/serial/sprd-uart.yaml
> > new file mode 100644
> > index 000000000000..0cc4668a9b9c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/serial/sprd-uart.yaml
> > @@ -0,0 +1,69 @@
> > +# SPDX-License-Identifier: GPL-2.0
>
> Dual license please. If you are okay with that on both patches, I can
> fix them and apply patches 1-4.

Sure, thanks for your help.

Chunyan

>
> Rob
