Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56424C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A1A2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="hYcWBuwZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbfD2SNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 14:13:43 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:40807 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbfD2SNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 14:13:42 -0400
Received: by mail-it1-f196.google.com with SMTP id k64so480723itb.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 11:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=2QB4RJLb+6FEgLy4+w2DfbmeovqCpuAG21kyMkfP7XA=;
        b=hYcWBuwZg/dYju1jvYpCEc4yGVpKLo1p/FuOY+cVj7+/Jpy0Mw80hE6psm76KVf1i8
         KpY9I0ahMAcReeV47+0bPMixh6yQufRO1oQxGQhrHNh+I5hVIm4HgefeyLcBEY0YZgvP
         6MJfEAAII4GbchxZO26JIPCDmjhXoZhVrk7P8sslat8s+/XGBgvkTts89RxtQLZ7SOXW
         GMgg/3L9Zui9809LZAVhciqSjpqx6kR70O2XurbBlYHPM0LV6TOjDPFk9+HkyTOKrSe7
         c7AmKwacwdZSG93o7MNnmcUwdAxTf7BpA8HeiroNIqIk+H9PUWgntk2lQSor4Y57Y50l
         bixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=2QB4RJLb+6FEgLy4+w2DfbmeovqCpuAG21kyMkfP7XA=;
        b=IoLVeRUlvaHLjSTZ1NX6ZSrXe0/0SdvciNmorG8w+YNue8jpFCtuD/PhcjNRstFXBh
         FQGE1bUcZuxdmUGyIAd5M5wgL15pyPsvo1qPna/FasCClMLCWMauQj36/S9RiEiO5rp0
         z0np//Wz4YithKMioBWeVNy4utNrjjI35DeibnOSQT5P2nIFWAmWm3lDL96BRTTrXn+o
         KUgNrbd/UiEnGw6n7DKtGxM6SXsMgDyDfs9hujL5fYwKRMVf9NDnVLI7hugMeTL6puGx
         4QDXmjLbpeDb8DmNA2qbr0ctdlpu5iKYYjuU4XX7frTiIzfTjg2iQOh+Fdr4Td7XaKMl
         yHuw==
X-Gm-Message-State: APjAAAW/z9YI3sfBFFyAuWNKLNKTH5JpCJlERkyuRqFHqxUZopYOInKv
        gN+FMqJ7Gvgl9MGpa5o92tcFIQ==
X-Google-Smtp-Source: APXvYqx4XUXqAY+TWlfS929HupQJSdXoLFiGxqPYvRrbV+KHeRkcNZnCuY/p2CVCrXYNGOGlQp8gEw==
X-Received: by 2002:a24:5309:: with SMTP id n9mr329796itb.11.1556561621668;
        Mon, 29 Apr 2019 11:13:41 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id k203sm175872itb.0.2019.04.29.11.13.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 11:13:40 -0700 (PDT)
Date:   Mon, 29 Apr 2019 11:13:40 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Rob Herring <robh@kernel.org>
cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, Paul Walmsley <paul@pwsan.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH 2/6] dt-bindings: riscv: sifive: add YAML documentation
 for the SiFive FU540
In-Reply-To: <20190429180846.GA26021@bogus>
Message-ID: <alpine.DEB.2.21.9999.1904291113140.10713@viisi.sifive.com>
References: <20190411084304.5072-2-paul.walmsley@sifive.com> <20190411084304.5072-3-paul.walmsley@sifive.com> <20190429180846.GA26021@bogus>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Apr 2019, Rob Herring wrote:

> On Thu, Apr 11, 2019 at 01:43:00AM -0700, Paul Walmsley wrote:
> > Add YAML DT binding documentation for the SiFive FU540 SoC.  This
> > SoC is documented at:
> > 
> >     https://static.dev.sifive.com/FU540-C000-v1.0.pdf
> > 
> > Passes dt-doc-validate, as of yaml-bindings commit 4c79d42e9216.

...

> > ---
> >  .../devicetree/bindings/riscv/sifive.yaml     | 26 +++++++++++++++++++
> >  MAINTAINERS                                   |  9 +++++++
> >  2 files changed, 35 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/riscv/sifive.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/riscv/sifive.yaml b/Documentation/devicetree/bindings/riscv/sifive.yaml
> > new file mode 100644
> > index 000000000000..d2808d8d79bb
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/riscv/sifive.yaml
> > @@ -0,0 +1,26 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/riscv/sifive/sifive.yaml#
> 
> The path here should match the file path. IOW, drop 'sifive/'.

Thanks, will do.

- Paul

