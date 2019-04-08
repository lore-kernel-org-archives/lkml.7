Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A89C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D888B21473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YtgoKlpx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfDHOMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:12:20 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34020 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfDHOMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 10:12:19 -0400
Received: by mail-pf1-f195.google.com with SMTP id b3so7712412pfd.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 07:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CSE12Di9vovu1Muo5qQd1ef/R1QZIPn35Nb8uVVAHxY=;
        b=YtgoKlpx2b5UvW9Z0o2C7WSAr4DReWgK4k6PJiMx11bnsZXbMwRQC9JwIkiPzyRr1b
         qS2qh4lQTacKaJNkk27M6GyjrfZGxZpTVxJEBYBZ9vyXl+pOMX9s5Sbmhj0yAmaAHuFl
         epZgfAO5aa+swJbdUxtz8MVxB151lce+I9YyzhvZn04OFSIaj+2fn03E7Qj3EHDMtTXV
         VlMLPAAsfrxdwtFXV65TCQTKjAe7yPa5Mh4NBlJ+pftX6cOGQ5LB8xKwa/H1ZUOyvjIv
         anlVnHzgFes/qNm7i/rIURFmGuDylCoqbeVyHdTTFwD2cFC2fMhG5M/rDDu/8rjEiaMl
         XXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CSE12Di9vovu1Muo5qQd1ef/R1QZIPn35Nb8uVVAHxY=;
        b=HHeD7sKHrLrZYobtHy0XFowwCLtcG+4JlEWv4C3xY4Z4xoJYnyl8hf4tN8eEqgbwg2
         X3xfhdSsu8279xshKnXE6tWtnABSIE5b/Ugc0YEGqmFKbItGktc1xs270ZY1f3Qm2uqh
         2pOgnRF3eHIFGs3GCHczhrWB/zeZO/s96UetxnhRoOlv5uS8DWhYfd9DxTCN2vGXSBJ8
         8JGlHb//i5fUBuYGRsSVXx1wqOdIlvcksFTcrL6VwDfoOq/hcspmPxcXTdgZOWxaVw8l
         5Jt8t7OlBbDrucVtKtkT0EJdBlHBydCHEJhSTh9pRRp90oHuXZb4+A/b+3YZ77Fx886i
         iXRw==
X-Gm-Message-State: APjAAAUiZE51SBU7udECL9wy8XnM+d5CZPShjNigUksTSOkASy7X9Lp8
        sQTPo4LHR17z0DGAUevPCXpqyYE0ig1iYnf3zq0t/Q==
X-Google-Smtp-Source: APXvYqxJzlFal7RKcFq07KVEB4BHqL8fGmKWq1chHgBCBsiipsUzdzW3/Nap/Y7OxmYfnr7sUpwtJqZ8PvaReXGHCQY=
X-Received: by 2002:a62:61c2:: with SMTP id v185mr30310167pfb.117.1554732738636;
 Mon, 08 Apr 2019 07:12:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190404152544.214988-1-venture@google.com> <8c412bc4-6528-4496-a912-f098604e707b@www.fastmail.com>
In-Reply-To: <8c412bc4-6528-4496-a912-f098604e707b@www.fastmail.com>
From:   Patrick Venture <venture@google.com>
Date:   Mon, 8 Apr 2019 07:12:07 -0700
Message-ID: <CAO=notwTSPCg6AfTEftNE09agZyG-F_2BdY9aZNZm_Rv2uyZsg@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] dt-bindings: misc: aspeed-p2a-ctrl: add support
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 7, 2019 at 7:03 PM Andrew Jeffery <andrew@aj.id.au> wrote:
>
>
>
> On Fri, 5 Apr 2019, at 01:55, Patrick Venture wrote:
> > Document the ast2400, ast2500 PCI-to-AHB bridge control driver bindings.
> >
> > Signed-off-by: Patrick Venture <venture@google.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> > Changes for v9:
> >  - Added missing details about syscon parent
> > Changes for v8:
> > - None
> > Changes for v7:
> > - Moved node under the syscon node it requires
> > Changes for v6:
> > - None
> > Changes for v5:
> > - None
> > Changes for v4:
> > - None
> > Changes for v3:
> > - None
> > Changes for v2:
> > - Added comment about syscon required parameter.
> > ---
> >  .../bindings/misc/aspeed-p2a-ctrl.txt         | 56 +++++++++++++++++++
> >  1 file changed, 56 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> >
> > diff --git a/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> > b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> > new file mode 100644
> > index 0000000000000..05ed654848b60
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> > @@ -0,0 +1,56 @@
> > +======================================================================
> > +Device tree bindings for Aspeed AST2400/AST2500 PCI-to-AHB Bridge
> > Control Driver
> > +======================================================================
> > +
> > +The bridge is available on platforms with the VGA enabled on the
> > Aspeed device.
> > +In this case, the host has access to a 64KiB window into all of the
> > BMC's
> > +memory.  The BMC can disable this bridge.  If the bridge is enabled,
> > the host
> > +has read access to all the regions of memory, however the host only
> > has read
> > +and write access depending on a register controlled by the BMC.
> > +
> > +Required properties:
> > +===================
> > +
> > + - compatible: must be one of:
> > +     - "aspeed,ast2400-p2a-ctrl"
> > +     - "aspeed,ast2500-p2a-ctrl"
> > +
> > +Optional properties:
> > +===================
> > +
> > +- memory-region: A phandle to a reserved_memory region to be used for
> > the PCI
> > +             to AHB mapping
> > +
> > +The p2a-control node should be the child of a syscon node with the
> > required
> > +property:
> > +
> > +- compatible : Should be one of the following:
> > +             "aspeed,ast2400-scu", "syscon", "simple-mfd"
> > +             "aspeed,g4-scu", "syscon", "simple-mfd"
> > +             "aspeed,ast2500-scu", "syscon", "simple-mfd"
> > +             "aspeed,g5-scu", "syscon", "simple-mfd"
> > +
> > +The aspeed-p2a-ctrl node should be the child of a syscon node with the
> > required
> > +property:
> > +
> > +- compatible : Should be one of the following:
> > +             "aspeed,ast2400-scu", "syscon", "simple-mfd"
> > +             "aspeed,g4-scu", "syscon", "simple-mfd"
> > +             "aspeed,ast2500-scu", "syscon", "simple-mfd"
> > +             "aspeed,g5-scu", "syscon", "simple-mfd"
>
> Agh, now the info's here twice!

Agh!  I don't even know how that happened.  Perhaps I was overzealous
in my pasting!  I can fix it.

>
> Next time, surely :D
>
> Unless Greg or Rob want to chop one out as they apply it? It looks good to
> me otherwise.
>
> Andrew
>
> > +
> > +Example
> > +===================
> > +
> > +g4 Example
> > +----------
> > +
> > +syscon: scu@1e6e2000 {
> > +     compatible = "aspeed,ast2400-scu", "syscon", "simple-mfd";
> > +     reg = <0x1e6e2000 0x1a8>;
> > +
> > +     p2a: p2a-control {
> > +             compatible = "aspeed,ast2400-p2a-ctrl";
> > +             memory-region = <&reserved_memory>;
> > +     };
> > +};
> > --
> > 2.21.0.392.gf8f6787159e-goog
> >
> >
