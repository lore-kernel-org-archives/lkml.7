Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DB8C31E50
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 18:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C865020862
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 18:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="dZFfXxgA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfFPSgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 14:36:21 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34889 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfFPSgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 14:36:20 -0400
Received: by mail-ed1-f68.google.com with SMTP id p26so12528431edr.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2019 11:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Ih0vMtka/CWfK/DMqpVIf0q0omD2Of2trUIRIXOZFek=;
        b=dZFfXxgAdt2O+dYVBMW3wJzfwc4UBN3EZExhIR/TbD3aG5hCZCvkOe9x49gecVFzMI
         t6fF0X0ojWIcHedqbNSLq1PzMZpQrP5qatpgSV4CIsDu6PdtlxU/4jgWYBuCTgduGBOW
         GuVbJ9cnlPmFw1NDKG6SKZZQlGhEA7I2ZkIfis164iAB7fOCBXe2M6fMIgtQmSTiB6dC
         RYiSvoe0Hm0sxBwZL16TOatKfcZEJdv9Bz8qNMb1vjn2HqS0HRsTjP+ITsNvzrTR3Kj4
         3JJzfNpso1y6HU2n3/bZuCzt5A9fgy71aaZmd9NsT+aya5FJNmn1Co4mZuHlet5I4lHC
         0d+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Ih0vMtka/CWfK/DMqpVIf0q0omD2Of2trUIRIXOZFek=;
        b=T3+W322yGeeMEXhxsURYKc2DOIU5cPb+rFYfSgE+UcfiDgm7QGe/1EyiSqVA5OZu6A
         t9HLO8QNkc3ZhloldEm4Cb0EHZgJmn4+BoVXFiVdKOvJdY9Dkre8qrTZMer6nErROPNZ
         QPLPmlk+7Cg+JqQzkZ8+G4x62RhgdT+qGMFasvS+oBa74G0YPdLqwT2MWqZHeKZbzlMR
         CirfJRcvxFGWx75I2K8eQRlo4YhiL4O2PBKwvauhP/3ABAn1GYpfbiv1E7pY9rpdX17C
         Lx2K9i565Xm6cJeWy6XAlxK3vrZaV1eEwflE+95ASRX0vvwj2KLrwrVrjd/ebNkRWIbI
         0BNQ==
X-Gm-Message-State: APjAAAVkt+s6e37JFompQLXGrIHkLvBfJ/MupUNM7rB2AF4xtDCvSpNP
        KZgBFX8+lWa021uCYEF8XjXHnw==
X-Google-Smtp-Source: APXvYqywYn66JZCdeecFBIyEmRV6m0nV6+A+DDXidbrSGQ1fVKYOysZbvUAbi5kyFzXQC9UVsq5ptw==
X-Received: by 2002:a17:906:d549:: with SMTP id gk9mr75132621ejb.268.1560710179023;
        Sun, 16 Jun 2019 11:36:19 -0700 (PDT)
Received: from localhost ([81.92.102.43])
        by smtp.gmail.com with ESMTPSA id w35sm541055edd.32.2019.06.16.11.36.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 16 Jun 2019 11:36:18 -0700 (PDT)
Date:   Sun, 16 Jun 2019 11:36:16 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Antony Pavlov <antonynpavlov@gmail.com>
cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Paul Walmsley <paul@pwsan.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 5/5] riscv: dts: add initial board data for the SiFive
 HiFive Unleashed
In-Reply-To: <20190609091819.2d1a97c90c0b44aa9120d373@gmail.com>
Message-ID: <alpine.DEB.2.21.9999.1906161135160.26914@viisi.sifive.com>
References: <20190602080500.31700-1-paul.walmsley@sifive.com> <20190602080500.31700-6-paul.walmsley@sifive.com> <20190609091819.2d1a97c90c0b44aa9120d373@gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jun 2019, Antony Pavlov wrote:

> On Sun,  2 Jun 2019 01:05:00 -0700
> Paul Walmsley <paul.walmsley@sifive.com> wrote:
> 
> Hi!
> 
> > Add initial board data for the SiFive HiFive Unleashed A00.

...

> > new file mode 100644
> > index 000000000000..1de4ea1577d5
> > --- /dev/null
> > +++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> > @@ -0,0 +1,67 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > +/* Copyright (c) 2018-2019 SiFive, Inc */
> > +
> > +/dts-v1/;
> > +
> > +#include "fu540-c000.dtsi"
> 
> You already have "/dts-v1/;" in the fu540-c000.dtsi file.
> 
> You can omit it in the hifive-unleashed-a00.dts file.

Thanks for the comment.  Dropped the line, per your suggestion.


- Paul
