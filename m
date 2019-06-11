Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1360CC43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 11:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C954420673
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 11:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vv+GAz2s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390024AbfFKLsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 07:48:11 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:45679 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389938AbfFKLsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 07:48:10 -0400
Received: by mail-vs1-f67.google.com with SMTP id n21so7680401vsp.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 04:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NfXWa5vJHtfDSlKtJZpTkWHlan092D7i8v0e5V8wptM=;
        b=Vv+GAz2sEEWpigR0jPuLuAtDrj1NEb1s3AN+Rz2TJhiYciULlN/+u33HFK50qT0y+R
         dTIB5E5NRg+GPCrAdVVzF5kUGO6tdWjaBhrDoTJD78yCWrewcTF1q/aScfBxC/Ns5Oyr
         J34dT18zLv/X49UPBAbYegcFKTZsCYbpkhLglp79csdxWqu2b+ktAJPaDMnyPjg6ZBI2
         gd2/rbZkKU1fSTdHy3Stdt3wduHz3eqRfBJm9Y12vENhxt8QhugHzdr0jXJ39vMqfyao
         sCdysJ09rdCgQZ3z/rCGYViql99/zDUw81JI0DkJTJqKDHwlWEEeJ+zQHvU6OqBg2Rda
         cwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NfXWa5vJHtfDSlKtJZpTkWHlan092D7i8v0e5V8wptM=;
        b=SjTuaBe2FjRyb0jng6gF+Dl/uHboG0J/pfYst0qnaqv18MGOsaC3T3xH2gEIPYO0zK
         9KB8UMEqmmzas5DOB+ODH0phPcgs90FOX4Wym0ZSDj2OBuI/jFY+yXOxwBE0p5nm+aEo
         5Ch7gA2GH6UngBM6rMtamkm4TKXutFSCadtsRsiqBqcfTcV6ohMVO/vCrQ9PjYA1exot
         jl+Qe0TgWX120ul2OMWmqiiMbT5v+xZT6c6brxX7DZ7jsI/ozqYvdePTAdFGEGlzAUZ5
         14Qqqx/IOgYAZcZA1vR4tR/oLvS7ph0yYWi5ZgZvTAdETN1axKUE6u910I29hdNvpitY
         du7g==
X-Gm-Message-State: APjAAAViG1LNmSmrO2L8JslHAMOmX63M+oRC24bhJ3W+X5CuWTxeVKM5
        o8PDKfmvo0yT+eZ7pcMsA7H0RjHgCDCkgpTDEME9JtPX
X-Google-Smtp-Source: APXvYqyqXeBg405IGlv4cXFteYc3Qnyh/9/wsu0915NOmx+eeihWDb0X+INGcYZhnrsQ5ldNrZrsGvnjatewnASwUEc=
X-Received: by 2002:a67:eada:: with SMTP id s26mr24797291vso.163.1560253689778;
 Tue, 11 Jun 2019 04:48:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190611092144.11194-1-oded.gabbay@gmail.com> <20190611095857.GB24058@kroah.com>
In-Reply-To: <20190611095857.GB24058@kroah.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Tue, 11 Jun 2019 14:47:43 +0300
Message-ID: <CAFCwf11ef=DaB3bD_xzvTbrPYUS-C7KujX8jRW5WhzSTpt2LYA@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] habanalabs: enable 64-bit DMA mask in POWER9
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 12:59 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jun 11, 2019 at 12:21:44PM +0300, Oded Gabbay wrote:
> > +bool hl_pci_parent_is_phb4(struct hl_device *hdev)
> > +{
> > +     struct pci_dev *parent_port = hdev->pdev->bus->self;
> > +
> > +     if ((parent_port->vendor == PCI_VENDOR_ID_IBM) &&
> > +                     (parent_port->device == PCI_DEVICE_ID_IBM_PHB4)) {
> > +             hdev->power9_64bit_dma_enable = 1;
> > +             return true;
> > +     }
> > +
> > +     hdev->power9_64bit_dma_enable = 0;
> > +     return false;
> > +}
>
> That feels like a big hack.
I agree but so far I found no other way.

>> ppc doesn't have any "what arch am I
> running on?" runtime call?  Did you ask on the ppc64 mailing list?  I'm
> ok to take this for now, but odds are you need a better fix for this
> sometime...
I talked to a couple of people and they didn't know about such a thing.
I'll also dug in the code and didn't find anything.
I'll post a "formal" question to the ppc64 mailing list and dig again
and I will update if I find anything.

Thanks,
Oded

>
> thanks,
>
> greg k-h
