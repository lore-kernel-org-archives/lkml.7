Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6515C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97450222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfLSMDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 07:03:55 -0500
Received: from mga11.intel.com ([192.55.52.93]:25457 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbfLSMDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 07:03:55 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Dec 2019 04:03:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,331,1571727600"; 
   d="scan'208";a="222273880"
Received: from kuha.fi.intel.com ([10.237.72.53])
  by fmsmga001.fm.intel.com with SMTP; 19 Dec 2019 04:03:51 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 19 Dec 2019 14:03:50 +0200
Date:   Thu, 19 Dec 2019 14:03:50 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Mat King <mathewk@google.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v3 1/2] firmware: google: Expose CBMEM over sysfs
Message-ID: <20191219120350.GD22923@kuha.fi.intel.com>
References: <20191128125100.14291-1-patrick.rudolph@9elements.com>
 <20191128125100.14291-2-patrick.rudolph@9elements.com>
 <CAODwPW8Koy1BvKGJU6PKexYx+PNE+WY7+m69gcxT689vBy+AoQ@mail.gmail.com>
 <CAOxpaSXUgNXaZ40ScZKZQ+iDEQ=vqPytLgicBx==hxp5uL_+dA@mail.gmail.com>
 <CAL_quvScPUuocogrghzH_vNb2uxyBupBKYikG0Bwf4OcfSRWsQ@mail.gmail.com>
 <5df87d6e.1c69fb81.f0643.a6b6@mx.google.com>
 <CAL_quvS_3o7UNmqP+QDCcHosw8JkQ03Kx5NjgUxFhO5FO=_-Mg@mail.gmail.com>
 <20191218094729.GC22923@kuha.fi.intel.com>
 <CAL_quvSKHwOTeatoju=nTmhyf6iTRGD3zY1Nxv=DcJrzQNV3sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_quvSKHwOTeatoju=nTmhyf6iTRGD3zY1Nxv=DcJrzQNV3sg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 04:35:29PM -0700, Mat King wrote:
> On Wed, Dec 18, 2019 at 2:47 AM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > On Tue, Dec 17, 2019 at 01:16:33PM -0700, Mat King wrote:
> > > On Tue, Dec 17, 2019 at 12:02 AM Stephen Boyd <swboyd@chromium.org> wrote:
> > > >
> > > > Quoting Mat King (2019-12-13 13:31:46)
> > > > > On Mon, Dec 9, 2019 at 11:57 PM Julius Werner <jwerner@chromium.org> wrote:
> > > > > > > +static int cbmem_probe(struct coreboot_device *cdev)
> > > > > > > +{
> > > > > > > +       struct device *dev = &cdev->dev;
> > > > > > > +       struct cb_priv *priv;
> > > > > > > +       int err;
> > > > > > > +
> > > > > > > +       priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> > > > > > > +       if (!priv)
> > > > > > > +               return -ENOMEM;
> > > > > > > +
> > > > > > > +       memcpy(&priv->entry, &cdev->cbmem_entry, sizeof(priv->entry));
> > > > > > > +
> > > > > > > +       priv->remap = memremap(priv->entry.address,
> > > > > > > +                              priv->entry.entry_size, MEMREMAP_WB);
> > > > > >
> > > > > > We've just been discussing some problems with CBMEM areas and memory
> > > > > > mapping types in Chrome OS. CBMEM is not guaranteed to be page-aligned
> > > > > > (at least not the "small" entries), but the kernel can only assign
> > > > > > memory attributes for a page at a time (and refuses to map the same
> > > > > > area twice with two different memory types, for good reason). So if
> > > > > > CBMEM entries sharing a page are mapped as writeback by one driver but
> > > > > > uncached by the other, things break.
> > > > > >
> > > > > > There are some CBMEM entries that need to be mapped uncached (e.g. the
> > > > > > ACPI UCSI table, which isn't even handled by anything using this CBMEM
> > > > > > code) and others for which it would make more sense (e.g. the memory
> > > > > > console, where firmware may add more lines at runtime), but I don't
> > > > > > think there are any regions that really *need* to be writeback. None
> > > > > > of the stuff accessing these areas should access them often enough
> > > > > > that caching matters, and I think it's generally more common to map
> > > > > > firmware memory areas as uncached anyway. So how about we standardize
> > > > > > on mapping it all uncached to avoid any attribute clashes? (That would
> > > > > > mean changing the existing VPD and memconsole drivers to use
> > > > > > ioremap(), too.)
> > > > >
> > > > > I don't think that uncached would work here either because the acpi
> > > > > driver will have already mapped some of these regions as write-back
> > > > > before this driver is loaded so the mapping will fail.
> > > >
> > > > Presumably the ucsi driver is drivers/usb/typec/ucsi/ucsi_acpi.c? Is
> > > > that right? And on ACPI based systems is this I/O memory or just some
> > > > carved out memory region that is used to communicate something to the
> > > > ACPI firmware? From looking at the ucsi driver it seems like it should
> > > > be mapped with memremap() instead of ioremap() given that it's not
> > > > actual I/O memory that has any sort of memory barrier or access width
> > > > constraints. It looks more like some sort of memory region that is being
> > > > copied into and out of while triggering some DSM. Can it at least be
> > > > memremap()ed with MEMREMAP_WT?
> > >
> > > Yes this is the ucsi_acpi.c driver that has caused this issue to come
> > > up. It does just use a region of memory carved in the BIOS out for the
> > > purpose of this device. The kernel can write to this memory and call a
> > > _DSM to push data to an EC or call the _DSM to pull from the EC into
> > > this memory region. See
> > > https://www.intel.com/content/dam/www/public/us/en/documents/white-papers/bios-implementation-of-ucsi.pdf
> > > . The driver is very explicit about using uncached memory and I
> > > suspect that is why memremap() was not used, but I am not sure why
> > > uncahed memory is needed. The only consumers of this memory are the
> > > driver itself and the ACPI asl code in the _DSM which as far as I know
> > > is being exectued by the kernel directly. Are there any other reasons
> > > to use uncached memory when dealing with ACPI asl code?
> >
> > The reason why I did not use memremap() was because I was convinced
> > that there will soon be physical devices such as PD controllers that
> > supply the interface, and with those the memory resource given to the
> > driver would be real bus memory. But that was already years ago,
> > and there still are no such devices that I know of, so if you guys
> > want to change the driver so that it uses memremap() instead of
> > ioremap(), I'm not going to be against it. But just be warned: We can
> > not guarantee that there isn't going to be IO side effects in every
> > case.
> 
> I am a little confused how this hypothetical PD controller would look
> with regards to the ACPI table. Would it still have an OperationRegion
> for the MMIO address of the controllers mailbox? Would the _CRS point
> to the MMIO of the mailbox directly or would it still use physical
> memory? If it is pointing to the MMIO mailbox is the _DSM essentially
> a noop?

In this case I believe the idea is exactly like you said. The OpRegion
would just be SystemIO OpRegion instead of SystemMemory OpRegion, and
the _DSD may or may not do something.

The goal appears to be to be able to support the same UCSI device
driver (in Windows) regardless of which component actually supplies
the interface (USB PD controller, EC firmware...), and regardless how
that component is attached to the SOC (I2C, PCI, mailbox...). The real
hardware is meant to be hidden in AML. The problem with that is of
course that UCSI now always depends on ACPI.

I think the main problem is that the mailbox was never separated from
the UCSI interface like it should have. If the ACPI mailbox was
separated from the interface (or generalized) it could have been
handled as a bus in the operating system, fake bus that looks like
SMBus (or I2C). We would have needed a separate "fake I2C host
adapter" driver for the mailbox, but now if a real USB PD controller
I2C slave device supplies the UCSI interface (most of them are I2C
slave devices), the same UCSI driver would still work without any
changes needed.

But I guess it's too late to change that now :-(.

thanks,

-- 
heikki
