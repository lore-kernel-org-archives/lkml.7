Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CD9C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 11:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0D5120866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 11:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sV3BW+Wy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbfFLLsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 07:48:24 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:37348 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbfFLLsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 07:48:24 -0400
Received: by mail-it1-f194.google.com with SMTP id x22so10049114itl.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 04:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/z0Jdvaew8ZNTrmPwRXBvXU6v+TaVoGCDpIAHDRM6P8=;
        b=sV3BW+Wy3876BAc/isBu+hSuU2nBMUlPeL4Hzw+9a5jlvXaJN52e2OTNm6yiO8J1gP
         eyAqrp4Iz0+TTevNp5Wcgyi47QDpDAUNfeFNDGYSHRDHpy6odAd9SppPd2o1y5s4gkvq
         PhzVdhByu4jiWyTybds5t5QfeWmG9oH1rGD1iVlVmxK78cnWxFoW7OSTFLRJt0vuj8VP
         lYsxvFOK11hP8pNMTLIfcmW1YIxcRVPqzDreMTxG1kbDMMcW/3Tx0n+qjYaDpJykYF8O
         K8HA1txL4xUz9ydyHEOWcBCcL11ld1qNVoSI1744Y7XgmMtfX7ORRQqhk+qBicy4JNhx
         o2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/z0Jdvaew8ZNTrmPwRXBvXU6v+TaVoGCDpIAHDRM6P8=;
        b=ZXxPzxJaCPd7FPoWezCcxD3ad9oG765TS9MTktjjG3oRZ4Z03xRRGMwXMeygfVMfrx
         sBodUnVwB0dk/ShkClVDuG/a53HmssS48TaOH09fCdrn6Fnk5TpANBHvYTb/UqzldF8X
         uAGKy8CmDTj253g5e+YKA7RRduFkBiE1mXa6GDKbT/y1APtj/DSKiPOo8DCq/y96kwbe
         1qU5xeUCBfQ1Hfhm46EGyQ4I6xTPfgmcWSfx6zhCPYdugImFHMt+v1LDe2/5wBzPgGAV
         bwGjTq9q/nKqBxfqwnBjOKeA5iOd1pUckxwChQlmWsO8TqnXeSv76bhhDB+xWhf5mATw
         9OCQ==
X-Gm-Message-State: APjAAAW+K5/DMpghWV5OBQp+bA+vY2/bBkIWkN75c4uqOvoPTyM4eboO
        E14+OIDRZJu+nY7SWO8c1MdtdH0XbGGMrQ2rTzk=
X-Google-Smtp-Source: APXvYqzN4gZSdU1v/0N78zQbpjP/CanYz5Dgld7i+PhumbwMU8L0DHwQqmcZMAiJSxjiA4Ha/MPoKdTEop+HhRr5Kks=
X-Received: by 2002:a05:660c:383:: with SMTP id x3mr21228859itj.44.1560340103393;
 Wed, 12 Jun 2019 04:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190611092144.11194-1-oded.gabbay@gmail.com> <20190611095857.GB24058@kroah.com>
 <20190611151753.GA11404@infradead.org> <20190611152655.GA3972@kroah.com>
 <CAFCwf13A73AxKzaa7Dk3tU-1NDgTFs4+xCO2os7SuSyUHZ9Z3Q@mail.gmail.com>
 <CAFCwf134nTD4FM_9Q+THQ7ZAZzGxhs15O6EheaRJMqM5wxi+aA@mail.gmail.com>
 <CAOSf1CE82uVVni638jkJJpQ7XLXX+HdD7xuB7Wv-f8mn=SBMeg@mail.gmail.com> <20190612065314.GA28838@infradead.org>
In-Reply-To: <20190612065314.GA28838@infradead.org>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Wed, 12 Jun 2019 21:48:12 +1000
Message-ID: <CAOSf1CF=gkGDVbiqT2NM1Rd_-aWKePA9D1hyj4FwY+M+4gPRBQ@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] habanalabs: enable 64-bit DMA mask in POWER9
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Oded Gabbay <oded.gabbay@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>, linuxppc-dev@ozlabs.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 4:53 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Jun 12, 2019 at 04:35:22PM +1000, Oliver O'Halloran wrote:
> > Setting a 48 bit DMA mask doesn't work today because we only allocate
> > IOMMU tables to cover the 0..2GB range of PCI bus addresses.
>
> I don't think that is true upstream, and if it is we need to fix bug
> in the powerpc code.  powerpc should be falling back treating a 48-bit
> dma mask like a 32-bit one at least, that is use dynamic iommu mappings
> instead of using the direct mapping.  And from my reding of
> arch/powerpc/kernel/dma-iommu.c that is exactly what it does.

This is more or less what Alexey's patches fix. The IOMMU table
allocated for the 32bit DMA window is only sized for 2GB in the
platform code, see pnv_pci_ioda2_setup_default_config().
