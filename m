Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038ACC3A5A6
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDEF923426
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="1L+6bgks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbfH3QBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 12:01:03 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42174 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbfH3QBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:01:03 -0400
Received: by mail-ot1-f65.google.com with SMTP id g111so4341364otg.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 09:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ySfHoB8l/xyw8qkOA35nwr7iHxPZP1YOxL7hVP9E3h4=;
        b=1L+6bgkshAql1vjG+F+Qinh4kK7fAjxpP05HH8wUoQj50+FjvvLvLw2lUiddjp4fCD
         noU3eenfi5DgIeiNL9zxQqZeDXFSMyZ3qHwRG3NQkjzUooWqvHEKlpZlSLBCF3794JMk
         fnmYt7eukhwAVo+a6mQkArQsFL9ZhzgsPsi4npqNWXbsgRK6JqtMR+iVIP0MMU1NC1rR
         FLVKCFrATvforvUK0oSB3NTRZUCVlC+HGnp7P8j6iaU/8EfaVARXv80wrGl9MsrQrTVF
         UUTOaKMZnD6L41iWBj3RS2hrOARNoTFdqEwqw6gai0kO5CO64Wyc71BoGnXINKP9kx9/
         /lVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ySfHoB8l/xyw8qkOA35nwr7iHxPZP1YOxL7hVP9E3h4=;
        b=NYE233PMnvmdSbIet56TdGc9Bqytue5dKgxGs3mCUBw7z39sQmSpbVbbtEMzlnVbzc
         wISFiYTgCTF40DDKCvDJZK88Je0+gL3TcxN/9axjrLtMwFF1IYqw0bvuCk4gJg+LxXYx
         5CFcnHoRYF3yKQthMS6+f7bXAeyBaFOXAPzHV4r/5NgEf17+C5Gyzk/ZtL8zAc2UhOkR
         rRjnNQ53A05lyPBpBA44tpTVQvLl1DljPRuaf/9GTvAQg4HGCFromJEUH45uq8NDM1VH
         pwBzRvI/yvA+hjQaAV+qf5Y4btqX6ok6vfFeGQc0TOLfPB8+x1JATznUqi+twIx82tD8
         B74A==
X-Gm-Message-State: APjAAAVTPPTsdE5PissjszD70AwgposuG8p+PyI9ePdVk7ky6ZrPXTmo
        vyNc4n9vHSZ+FnuuT3OoYmH1Ne6wWG0OnMDxhsiI6Q==
X-Google-Smtp-Source: APXvYqyipA8UNkC9jFwZFjWhmNOU4RjajQwMFnKJMHl6vT1i7F+SkTBCCB9CI5CTCSa+8tEnJCkS/xbKemvtfvD0nNs=
X-Received: by 2002:a05:6830:458:: with SMTP id d24mr12543472otc.126.1567180861989;
 Fri, 30 Aug 2019 09:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <156712139395.1614755.3489977733530873708.stgit@dwillia2-desk3.amr.corp.intel.com>
 <63de1aac-ff06-729e-0db4-bc1a8a799dc0@silicom-usa.com>
In-Reply-To: <63de1aac-ff06-729e-0db4-bc1a8a799dc0@silicom-usa.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 30 Aug 2019 09:00:50 -0700
Message-ID: <CAPcyv4h2tNRC0w1mKjnt6tuZrUcUTh+y1YCeQKTb+b8HftEWZg@mail.gmail.com>
Subject: Re: [PATCH v3] libata/ahci: Drop PCS quirk for Denverton and beyond
To:     Stephen Douthit <stephend@silicom-usa.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 8:47 AM Stephen Douthit
<stephend@silicom-usa.com> wrote:
>
> On 8/29/19 7:30 PM, Dan Williams wrote:
> > The Linux ahci driver has historically implemented a configuration fixup
> > for platforms / platform-firmware that fails to enable the ports prior
> > to OS hand-off at boot. The fixup was originally implemented way back
> > before ahci moved from drivers/scsi/ to drivers/ata/, and was updated in
> > 2007 via commit 49f290903935 "ahci: update PCS programming". The quirk
> > sets a port-enable bitmap in the PCS register at offset 0x92.
> >
> > This quirk could be applied generically up until the arrival of the
> > Denverton (DNV) platform. The DNV AHCI controller architecture supports
> > more than 6 ports and along with that the PCS register location and
> > format were updated to allow for more possible ports in the bitmap. DNV
> > AHCI expands the register to 32-bits and moves it to offset 0x94.
> >
> > As it stands there are no known problem reports with existing Linux
> > trying to set bits at offset 0x92 which indicates that the quirk is not
> > applicable. Likely it is not applicable on a wider range of platforms,
> > but it is difficult to discern which platforms if any still depend on
> > the quirk.
> >
> > Rather than try to fix the PCS quirk to consider the DNV register layout
> > instead require explicit opt-in. The assumption is that the OS driver
> > need not touch this register, and platforms can be added with a new
> > boad_ahci_pcs7 board-id when / if problematic platforms are found in the
> > future. The logic in ahci_intel_pcs_quirk() looks for all Intel AHCI
> > instances with "legacy" board-ids and otherwise skips the quirk if the
> > board was matched by class-code.
> >
> > Reported-by: Stephen Douthit <stephend@silicom-usa.com>
> > Cc: Christoph Hellwig <hch@infradead.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> > Changes since v2:
> > - Use board_ahci_pcs7 to opt Denverton out of the PCS quirk.
> >
> >   drivers/ata/ahci.c |  116 +++++++++++++++++++++++++++++++---------------------
> >   drivers/ata/ahci.h |    2 +
> >   2 files changed, 71 insertions(+), 47 deletions(-)
> >
> > diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> > index f7652baa6337..3e63294304c7 100644
> > --- a/drivers/ata/ahci.c
> > +++ b/drivers/ata/ahci.c
> > @@ -65,6 +65,12 @@ enum board_ids {
> >       board_ahci_sb700,       /* for SB700 and SB800 */
> >       board_ahci_vt8251,
> >
> > +     /*
> > +      * board IDs for Intel chipsets that support more than 6 ports
> > +      * *and* end up needing the PCS quirk.
> > +      */
> > +     board_ahci_pcs7,
> > +
> >       /* aliases */
> >       board_ahci_mcp_linux    = board_ahci_mcp65,
> >       board_ahci_mcp67        = board_ahci_mcp65,
> > @@ -220,6 +226,12 @@ static const struct ata_port_info ahci_port_info[] = {
> >               .udma_mask      = ATA_UDMA6,
> >               .port_ops       = &ahci_vt8251_ops,
> >       },
> > +     [board_ahci_pcs7] = {
> > +             .flags          = AHCI_FLAG_COMMON,
> > +             .pio_mask       = ATA_PIO4,
> > +             .udma_mask      = ATA_UDMA6,
> > +             .port_ops       = &ahci_ops,
> > +     },
> >   };
> >
> >   static const struct pci_device_id ahci_pci_tbl[] = {
> > @@ -264,26 +276,26 @@ static const struct pci_device_id ahci_pci_tbl[] = {
> >       { PCI_VDEVICE(INTEL, 0x3b2b), board_ahci }, /* PCH RAID */
> >       { PCI_VDEVICE(INTEL, 0x3b2c), board_ahci_mobile }, /* PCH M RAID */
> >       { PCI_VDEVICE(INTEL, 0x3b2f), board_ahci }, /* PCH AHCI */
> > -     { PCI_VDEVICE(INTEL, 0x19b0), board_ahci }, /* DNV AHCI */
> > -     { PCI_VDEVICE(INTEL, 0x19b1), board_ahci }, /* DNV AHCI */
> > -     { PCI_VDEVICE(INTEL, 0x19b2), board_ahci }, /* DNV AHCI */
> > -     { PCI_VDEVICE(INTEL, 0x19b3), board_ahci }, /* DNV AHCI */
> > -     { PCI_VDEVICE(INTEL, 0x19b4), board_ahci }, /* DNV AHCI */
> > -     { PCI_VDEVICE(INTEL, 0x19b5), board_ahci }, /* DNV AHCI */
> > -     { PCI_VDEVICE(INTEL, 0x19b6), board_ahci }, /* DNV AHCI */
> > -     { PCI_VDEVICE(INTEL, 0x19b7), board_ahci }, /* DNV AHCI */
> > -     { PCI_VDEVICE(INTEL, 0x19bE), board_ahci }, /* DNV AHCI */
> > -     { PCI_VDEVICE(INTEL, 0x19bF), board_ahci }, /* DNV AHCI */
> > -     { PCI_VDEVICE(INTEL, 0x19c0), board_ahci }, /* DNV AHCI */
> > -     { PCI_VDEVICE(INTEL, 0x19c1), board_ahci }, /* DNV AHCI */
> > -     { PCI_VDEVICE(INTEL, 0x19c2), board_ahci }, /* DNV AHCI */
> > -     { PCI_VDEVICE(INTEL, 0x19c3), board_ahci }, /* DNV AHCI */
> > -     { PCI_VDEVICE(INTEL, 0x19c4), board_ahci }, /* DNV AHCI */
> > -     { PCI_VDEVICE(INTEL, 0x19c5), board_ahci }, /* DNV AHCI */
> > -     { PCI_VDEVICE(INTEL, 0x19c6), board_ahci }, /* DNV AHCI */
> > -     { PCI_VDEVICE(INTEL, 0x19c7), board_ahci }, /* DNV AHCI */
> > -     { PCI_VDEVICE(INTEL, 0x19cE), board_ahci }, /* DNV AHCI */
> > -     { PCI_VDEVICE(INTEL, 0x19cF), board_ahci }, /* DNV AHCI */
> > +     { PCI_VDEVICE(INTEL, 0x19b0), board_ahci_pcs7 }, /* DNV AHCI */
> > +     { PCI_VDEVICE(INTEL, 0x19b1), board_ahci_pcs7 }, /* DNV AHCI */
> > +     { PCI_VDEVICE(INTEL, 0x19b2), board_ahci_pcs7 }, /* DNV AHCI */
> > +     { PCI_VDEVICE(INTEL, 0x19b3), board_ahci_pcs7 }, /* DNV AHCI */
> > +     { PCI_VDEVICE(INTEL, 0x19b4), board_ahci_pcs7 }, /* DNV AHCI */
> > +     { PCI_VDEVICE(INTEL, 0x19b5), board_ahci_pcs7 }, /* DNV AHCI */
> > +     { PCI_VDEVICE(INTEL, 0x19b6), board_ahci_pcs7 }, /* DNV AHCI */
> > +     { PCI_VDEVICE(INTEL, 0x19b7), board_ahci_pcs7 }, /* DNV AHCI */
> > +     { PCI_VDEVICE(INTEL, 0x19bE), board_ahci_pcs7 }, /* DNV AHCI */
> > +     { PCI_VDEVICE(INTEL, 0x19bF), board_ahci_pcs7 }, /* DNV AHCI */
> > +     { PCI_VDEVICE(INTEL, 0x19c0), board_ahci_pcs7 }, /* DNV AHCI */
> > +     { PCI_VDEVICE(INTEL, 0x19c1), board_ahci_pcs7 }, /* DNV AHCI */
> > +     { PCI_VDEVICE(INTEL, 0x19c2), board_ahci_pcs7 }, /* DNV AHCI */
> > +     { PCI_VDEVICE(INTEL, 0x19c3), board_ahci_pcs7 }, /* DNV AHCI */
> > +     { PCI_VDEVICE(INTEL, 0x19c4), board_ahci_pcs7 }, /* DNV AHCI */
> > +     { PCI_VDEVICE(INTEL, 0x19c5), board_ahci_pcs7 }, /* DNV AHCI */
> > +     { PCI_VDEVICE(INTEL, 0x19c6), board_ahci_pcs7 }, /* DNV AHCI */
> > +     { PCI_VDEVICE(INTEL, 0x19c7), board_ahci_pcs7 }, /* DNV AHCI */
> > +     { PCI_VDEVICE(INTEL, 0x19cE), board_ahci_pcs7 }, /* DNV AHCI */
> > +     { PCI_VDEVICE(INTEL, 0x19cF), board_ahci_pcs7 }, /* DNV AHCI */
>
> I think you want to invert this scheme and mark the old controllers as
> board_ahci_pcs6 and leave Denverton/newer controllers as board_ahci.
>
> Otherwise the quirk below runs for any Intel controllers that matched
> based on the AHCI class code, since their board_id will be board_ahci
> which is < board_ahci_pcs7.

It shouldn't apply for the class code because the id->vendor in that
case will be PCI_ANY_ID not PCI_VENDOR_ID_INTEL.
