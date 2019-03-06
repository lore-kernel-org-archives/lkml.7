Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92DFC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7A2720684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbfCFKtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 05:49:08 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46028 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbfCFKtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 05:49:08 -0500
Received: by mail-qk1-f194.google.com with SMTP id v139so6473860qkb.12;
        Wed, 06 Mar 2019 02:49:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=epWvn+RLfp14vrAtwiF1NcHhwp8ZZ9/6sQ/IaOSIzTs=;
        b=YCiDxxLK/Pza26gxSxLYKprxrqjh81SagLGPcMiJCvCm4tcC/gPABXlLE45t7uHKdW
         agk0sbxHUJJ0IVGpgQhkvTY7OToM15ShzcmSZtq81zQjqvhUdc4HV8wMtO/rnlrrWrXX
         FeDyUmFQ/vny2cy0Dx5Y7yrLF8X9m6We1fTWHFJw4uvX7RZmyDjut8+LHuZMLoTDBnQ/
         RafKDTZ+c55+RxVdg54AF//qOhi9R0d5P2Lx6UW6El04WrocYG2fdS+lmYlaqIhIU/fE
         8hEEuSTpnpc8kCfbJPQ5V3iBurlQFT/Q9csNgTqsyJdztEgHEN8d3yM3G2afFAxKX2Om
         zBFQ==
X-Gm-Message-State: APjAAAXV/5AhOqNuGaEkr1q+pJAkDy+8iki3o9JaZAXytm3hyBoQTWAQ
        P6Jx4eHTNr5cZk1o6LvXDBIgnybHcqKmHaxLw+gemW8J
X-Google-Smtp-Source: APXvYqxGmS0iaHj/jTX8fUQW6vmMIkwCB0Hwlci+4x04oFhQQkZHR6zDNuiziJ3GKpu4o2QtEf54uWWnB8LjIWC1K6Y=
X-Received: by 2002:ae9:dec2:: with SMTP id s185mr4966307qkf.107.1551869346673;
 Wed, 06 Mar 2019 02:49:06 -0800 (PST)
MIME-Version: 1.0
References: <1551735420-16202-1-git-send-email-eajames@linux.ibm.com>
 <1551735420-16202-3-git-send-email-eajames@linux.ibm.com> <CAK8P3a0eS11_T9wk4iLRT7A94Lh9gSf5QNGH4--pdA5HdEGMCw@mail.gmail.com>
 <84551e54-0382-6042-48cb-842d79214a98@linux.ibm.com>
In-Reply-To: <84551e54-0382-6042-48cb-842d79214a98@linux.ibm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 6 Mar 2019 11:48:49 +0100
Message-ID: <CAK8P3a2kcaVGXifqrBLt9PfD1n2M6WCBxDDcaF8d7EdYxGRvVg@mail.gmail.com>
Subject: Re: [PATCH 2/6] drivers/misc: Add Aspeed XDMA engine driver
To:     Eddie James <eajames@linux.ibm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>, linux-aspeed@lists.ozlabs.org,
        Andrew Jeffery <andrew@aj.id.au>,
        gregkh <gregkh@linuxfoundation.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 10:45 PM Eddie James <eajames@linux.ibm.com> wrote:
> On 3/5/19 2:01 AM, Arnd Bergmann wrote:
> > On Mon, Mar 4, 2019 at 10:37 PM Eddie James <eajames@linux.ibm.com> wrote:
> >> The XDMA engine embedded in the AST2500 SOC performs PCI DMA operations
> >> between the SOC (acting as a BMC) and a host processor in a server.
> >>
> >> This commit adds a driver to control the XDMA engine and adds functions
> >> to initialize the hardware and memory and start DMA operations.
> >>
> >> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> > Hi Eddie,
> >
> > Thanks for your submission! Overall this looks well-implemented, but
> > I fear we already have too many ways of doing the same thing at
> > the moment, and I would hope to avoid adding yet another user space
> > interface for a specific hardware that does this.
> >
> > Your interface appears to be a fairly low-level variant, just doing
> > single DMA transfers through ioctls, but configuring the PCIe
> > endpoint over sysfs.
>
> Hi, thanks for the quick response!
>
> There is actually no PCIe configuration done in this driver. The two
> sysfs entries control the system control unit (SCU) on the AST2500
> purely to enable and disable entire PCIe devices. It might be possible
> to control those devices more finely with a PCI endpoint driver, but
> there is no need to do so. The XDMA engine does that by itself to
> perform DMA fairly automatically.
>
> If the sysfs entries are really troublesome, we can probably remove
> those and find another way to control the SCU.

I think the main advantage of tying this to a PCIe endpoint driver
is that this would give us a logical object in the kernel that we
can add the user space interface to, and have the protocol on
top of it be portable between different SoCs.

> > Please have a look at the drivers/pci/endpoint framework first
> > and see if you can work on top of that interface instead.
> > Even if it doesn't quite do what you need here, we may be
> > able to extend it in a way that works for you, and lets others
> > use the same user interface extensions in the future.
> >
> > It may also be necessary to split out the DMA engine portion
> > into a regular drivers/dma/ back-end to make that fit in with
> > the PCIe endpoint framework.
>
> Right, I did look into the normal DMA framework. There were a couple of
> problems. First and foremost, the "device" (really, host processor)
> address that we use is 64 bit, but the AST2500 is of course 32 bit. So I
> couldn't find a good way to get the address through the DMA API into the
> driver. It's entirely possible I missed something there though.

32-bit ARM SoCs can be built with a 64-bit dma_addr_t. Would that
help you here?

> The other issue was that the vast majority of the DMA framework was
> unused, resulting in a large amount of boilerplate that did nothing
> except satisfy the API... I thought simplicity would be better in this case.

Simplicity is important indeed, but we have to weigh it against
having a consistent interface. What the dmaengine driver would
give us in combination with the PCIe endpoint driver is that it abstracts
the hardware from the protocol on top, which could then be done
in a way that is not specific to an AST2xxx chip.

> Let me know what you think... I could certainly switch to ioctl instead
> of the write() if that's better. Or if you really think the DMA
> framework is required here, let me know.

I don't think that replacing the ioctl() with a write() call specifically
would make much of a difference here. The question I'd like to
discuss further is what high-level user space interface you actually
need in order to implement what kind of functionality. We can then
look at whether this interface can be implemented on top of a
PCIe endpoint and a dmaengine driver in a portable way. If all
of those are true, then I'd definitely go with the modular approach
of having two standard drivers for the PCIe endpoint (should be
a trivial wrapper) and the dma engine (not trivial, but there are
many examples), plus a generic front-end in
drivers/pci/endpoint/functions/.

     Arnd
