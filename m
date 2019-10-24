Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD06CA9EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 03:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C37EA20679
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 03:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="OBRZe8/Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437311AbfJXDfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 23:35:40 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:33900 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392415AbfJXDfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 23:35:40 -0400
Received: by mail-ua1-f67.google.com with SMTP id q11so6725162uao.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 20:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5eHAy5g6BybQ88VHhygUcQ4uuZpadj5DXgBi++hn24Y=;
        b=OBRZe8/Qv/iVv/75Ql+bWxECH1E8sxfxH8EZMeAMymnFnb2mqNTCBs/qWZGMzmp7gJ
         jq+8lIi9jLkw3WlSm8f8U8j2gpsIgZP8PIaq6tvJa03udwJRQoZHPWoxt2NsAM1QmOVE
         aSGyCBJ9nra1PSwGNt0VQSkey8CV87uqgxrtum5bj2K6VkQwt0zFv49KfS1QCOhiKtAv
         LIBDPyiiR6b7PCTj5rL8dqNKquSr62g//mwuICvi3OLN1nVYAKZd4/VqYGR0rlI/+fdM
         pc0BZX6kiC0HJ9I4hb3hEZHPkb3dgDH0GCznuBlEBK4py1EizcS+534rFrf7j0mU7r7M
         hqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5eHAy5g6BybQ88VHhygUcQ4uuZpadj5DXgBi++hn24Y=;
        b=RFD4o3SFOTXduphzBUBdyedLbujhKjQPy6fqQBJj5Xxlq3ftH2TYyYYOqOyuPG+zua
         nx6zVyQfNvNsc++YlajVGwr3E9/Nj9MxjhcSTj2TzTd6ywl2ZjOpQMr+SlKo/qrjir1Q
         NujD6NOcjyfDAvifhGJLrNmZbIlgP+qU2Fqbj2J77+U3Gqnugm1NF955//dip2nEZGtv
         sJf1iu/+y7VnzcIVQBVs4IBUgGNcXh/cn8Flww8Bh56++jc+OPnYa6BJY4Fw9liK5Ap1
         Y4dnfAlJO3KeVUW8lmOufx0Tq7pS7ZNAjA4cSOvMY2Go/9bLDYJjVZqL3WyVrkmysyfF
         T2Hg==
X-Gm-Message-State: APjAAAX92ujTaehK02mw+f0DeNZnf2Ms68e+FpX0amMNb+dNBBRwg5fl
        hVyWmnudybBQ2mIozQUoY96BvBf7RYwcHXHeZo7yQw==
X-Google-Smtp-Source: APXvYqwXiwAtoW7PtJxlbPPM0v8rMppIEj7lMyPuE1rx53BYFEnZDCcZLJjPRgzdX5SdJHjItg1dnViyDSrNaeYgVOg=
X-Received: by 2002:ab0:252:: with SMTP id 76mr7464423uas.32.1571888138737;
 Wed, 23 Oct 2019 20:35:38 -0700 (PDT)
MIME-Version: 1.0
References: <20191023211235.GA236419@google.com> <20191023214325.GA30290@google.com>
In-Reply-To: <20191023214325.GA30290@google.com>
From:   Jian-Hong Pan <jian-hong@endlessm.com>
Date:   Thu, 24 Oct 2019 11:35:01 +0800
Message-ID: <CAPpJ_ee6iqJ8G2dpyjHWKNJV0mmGXk8Lv_BXC-9rAP2gFaKOvA@mail.gmail.com>
Subject: Re: [PATCH] PCI/MSI: Fix restoring of MSI-X vector control's mask bit
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Matthew Wilcox <willy@linux.intel.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas <helgaas@kernel.org> =E6=96=BC 2019=E5=B9=B410=E6=9C=8824=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=885:43=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, Oct 23, 2019 at 04:12:35PM -0500, Bjorn Helgaas wrote:
> > On Tue, Oct 08, 2019 at 11:42:39AM +0800, Jian-Hong Pan wrote:
> > > MSI-X vector control's bit 0 is the mask bit, which masks the
> > > corresponding interrupt request, or not. Other reserved bits might be
> > > used for other purpose by device vendors. For example, the values of
> > > Kingston NVMe SSD's MSI-X vector control are neither 0, nor 1, but ot=
her
> > > values [1].
> > >
> > > The original restoring logic in system resuming uses the whole MSI-X
> > > vector control value as the flag to set/clear the mask bit. However,
> > > this logic conflicts the idea mentioned above. It may mislead system =
to
> > > disable the MSI-X vector entries. That makes system get no interrupt
> > > from Kingston NVMe SSD after resume and usually get NVMe I/O timeout
> > > error.
> > >
> > > [  174.715534] nvme nvme0: I/O 978 QID 3 timeout, completion polled
> > >
> > > This patch takes only the mask bit of original MSI-X vector control
> > > value as the flag to fix this issue.
> > >
> > > [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D204887#c8
> > >
> > > Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=3D204887
> > > Fixed: f2440d9acbe8 ("PCI MSI: Refactor interrupt masking code")
> > > Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
> > > ---
> > >  drivers/pci/msi.c | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> > > index 0884bedcfc7a..deae3d5acaf6 100644
> > > --- a/drivers/pci/msi.c
> > > +++ b/drivers/pci/msi.c
> > > @@ -433,6 +433,7 @@ static void __pci_restore_msi_state(struct pci_de=
v *dev)
> > >  static void __pci_restore_msix_state(struct pci_dev *dev)
> > >  {
> > >     struct msi_desc *entry;
> > > +   u32 flag;
> > >
> > >     if (!dev->msix_enabled)
> > >             return;
> > > @@ -444,8 +445,10 @@ static void __pci_restore_msix_state(struct pci_=
dev *dev)
> > >                             PCI_MSIX_FLAGS_ENABLE | PCI_MSIX_FLAGS_MA=
SKALL);
> > >
> > >     arch_restore_msi_irqs(dev);
> > > -   for_each_pci_msi_entry(entry, dev)
> > > -           msix_mask_irq(entry, entry->masked);
> > > +   for_each_pci_msi_entry(entry, dev) {
> > > +           flag =3D entry->masked & PCI_MSIX_ENTRY_CTRL_MASKBIT;
> > > +           msix_mask_irq(entry, flag);
> >
> > This makes good sense: before your patch, when we restore, we set the
> > mask bit if *any* bits in the Vector Control register are set.
> >
> > There are other paths leading to __pci_msix_desc_mask_irq(), so I
> > think it would be better to do the masking there, e.g.,
> >
> >   if (flag & PCI_MSIX_ENTRY_CTRL_MASKBIT)
> >     mask_bits |=3D PCI_MSIX_ENTRY_CTRL_MASKBIT;
> >
> > I think the other paths all pass either 0 or 1, so they're all safe
> > today.  But doing the masking in __pci_msix_desc_mask_irq() removes
> > that assumption from the callers.
> >
> > I applied the patch below to pci/msi, let me know if it doesn't work
> > for you.
> >
> > > +   }
> > >
> > >     pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
> > >  }
> >
> > commit 1a828a554650
> > Author: Jian-Hong Pan <jian-hong@endlessm.com>
> > Date:   Tue Oct 8 11:42:39 2019 +0800
> >
> >     PCI/MSI: Fix incorrect MSI-X masking on resume
> >
> >     When a driver enables MSI-X, msix_program_entries() reads the MSI-X=
 Vector
> >     Control register for each vector and saves it in desc->masked.  Eac=
h
> >     register is 32 bits and bit 0 is the actual Mask bit.
> >
> >     When we restored these registers during resume, we previously set t=
he Mask
> >     bit if *any* bit in desc->masked was set instead of when the Mask b=
it
> >     itself was set:
> >
> >       pci_restore_state
> >         pci_restore_msi_state
> >           __pci_restore_msix_state
> >             for_each_pci_msi_entry
> >               msix_mask_irq(entry, entry->masked)   <-- entire u32 word
> >                 __pci_msix_desc_mask_irq(desc, flag)
> >                   mask_bits =3D desc->masked & ~PCI_MSIX_ENTRY_CTRL_MAS=
KBIT
> >                   if (flag)       <-- testing entire u32, not just bit =
0
> >                     mask_bits |=3D PCI_MSIX_ENTRY_CTRL_MASKBIT
> >                   writel(mask_bits, desc_addr + PCI_MSIX_ENTRY_VECTOR_C=
TRL)
> >
> >     This means that after resume, MSI-X vectors were masked when they s=
houldn't
> >     be, which leads to timeouts like this:
> >
> >       nvme nvme0: I/O 978 QID 3 timeout, completion polled
> >
> >     On resume, set the Mask bit only when the saved Mask bit from suspe=
nd was
> >     set.
> >
> >     This should remove the need for 19ea025e1d28 ("nvme: Add quirk for =
Kingston
> >     NVME SSD running FW E8FK11.T").
> >
> >     [bhelgaas: commit log, move fix to __pci_msix_desc_mask_irq()]
> >     Fixes: f2440d9acbe8 ("PCI MSI: Refactor interrupt masking code")
> >     Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D204887
> >     Link: https://lore.kernel.org/r/20191008034238.2503-1-jian-hong@end=
lessm.com
> >     Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
> >     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

The modified patch also fixes the issue.

> I forgot; this probably should be marked for stable, too.

Oh!  Yes, please!

Thank you,
Jian-Hong Pan

> > diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> > index 0884bedcfc7a..771041784e64 100644
> > --- a/drivers/pci/msi.c
> > +++ b/drivers/pci/msi.c
> > @@ -213,12 +213,13 @@ u32 __pci_msix_desc_mask_irq(struct msi_desc *des=
c, u32 flag)
> >
> >       if (pci_msi_ignore_mask)
> >               return 0;
> > +
> >       desc_addr =3D pci_msix_desc_addr(desc);
> >       if (!desc_addr)
> >               return 0;
> >
> >       mask_bits &=3D ~PCI_MSIX_ENTRY_CTRL_MASKBIT;
> > -     if (flag)
> > +     if (flag & PCI_MSIX_ENTRY_CTRL_MASKBIT)
> >               mask_bits |=3D PCI_MSIX_ENTRY_CTRL_MASKBIT;
> >
> >       writel(mask_bits, desc_addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
> >
> > _______________________________________________
> > Linux-nvme mailing list
> > Linux-nvme@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-nvme
