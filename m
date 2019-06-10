Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60458C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 10:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3486E2082E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 10:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DucPq623"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389189AbfFJK7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 06:59:39 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46470 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388912AbfFJK7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 06:59:38 -0400
Received: by mail-qt1-f194.google.com with SMTP id h21so9954770qtn.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 03:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lYS873xwFvgHJlWnAlNcy3+738aq6TAuNgiiGGA4PYI=;
        b=DucPq623iXSUdIpU0sIAvsS6WoDxfPXDCI8M1Z/cLDSvAghOCQhzkn7n7CRUZTV+n4
         D7kno671l158zYXcQ5CcTKS//ZnxFCq2lAzzR8jkfMiXRI7qZOJ39ioMp2roV7C+XDeh
         18gxi0DLvMAiIoesnOPgfWT/y6QIiThSsrAXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lYS873xwFvgHJlWnAlNcy3+738aq6TAuNgiiGGA4PYI=;
        b=PFU7/TI+4b1sQ7DvY4V+fvbWnCwfJDKUhAxAO3nWH0jkggJmynQUeW1GicJlwZbyJc
         9dvBaokQ+1U3uD8cOCf24G2Z0J+NoMzMLeeo/CvlfDUCOW11BdGKR+dSM/cdpMCFU3nT
         T65dlmlQrug7wkybxjdyQch9nIdq8TuWKRHAyw+Jrt1vysccg+6vw8JT/Ws19aklKA9n
         D75+hTxX3vjClhKmusMdF7pPv6CFpzFH1MdI9xW0sPqu6VJ2dNb5iLQ16+HA9fVYARiY
         xAAa/zMbuMf18mvTcLaNLMPcSR2wyFp0gU5egvh/dincZPkpV8ugEGUPxeMK6UfxWYxa
         WHrQ==
X-Gm-Message-State: APjAAAUwnEQiJ3RMII7MnYTScT1ahO/2ao9GkZq8DasvcBuirVel2yeZ
        GQ8PpmutenaSqEdoq73eVN62hKY6TEHqPTWoEEMF7w==
X-Google-Smtp-Source: APXvYqwfm97Zg0Zz9VmQex8hsHuU/WItevpCJwgENnoSKs11e4b9vXzYpWawPLMtR9aoaRwrQ+h4hOapW5NQrVQbggk=
X-Received: by 2002:ac8:42d4:: with SMTP id g20mr58845965qtm.78.1560164377769;
 Mon, 10 Jun 2019 03:59:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190527043336.112854-1-hsinyi@chromium.org> <20190527043336.112854-2-hsinyi@chromium.org>
 <5ced598d.1c69fb81.dabd8.339d@mx.google.com>
In-Reply-To: <5ced598d.1c69fb81.dabd8.339d@mx.google.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 10 Jun 2019 18:59:11 +0800
Message-ID: <CAJMQK-i0z1EHCMK3eTya+SmK6GD_C4Ljvb7BHvsaMWLDxxmwMg@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] fdt: add support for rng-seed
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Miles Chen <miles.chen@mediatek.com>,
        James Morse <james.morse@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 11:53 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Hsin-Yi Wang (2019-05-26 21:33:35)
> > Introducing a chosen node, rng-seed, which is an entropy that can be
> > passed to kernel called very early to increase initial device
> > randomness. Bootloader should provide this entropy and the value is
> > read from /chosen/rng-seed in DT.
> >
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > ---
>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
>

Hi Rob,

Is this series accepted? Or is there any other related concern?

If it's fine, I also have sent a patch for updating
schemas/chosen.yaml document.

Thanks
