Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CE8C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 17:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E6442084B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 17:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lUsxVGOo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732125AbfFYRhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 13:37:53 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45704 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729974AbfFYRhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 13:37:53 -0400
Received: by mail-lj1-f196.google.com with SMTP id m23so17075822lje.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 10:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DNAZwCZByYTbwclhe+TRUuG+E9r9+02rmdbcNH7Mmz8=;
        b=lUsxVGOoG1NO6l4C8BzqvLJGYIHn9NBTvfi1hvl8sbq9UfISi/DiG7NAMTPX3A/i0E
         5rWz/pMBO/E3d0f9sMm9kXE75gp95sALBgULgsfBhzxf5z12LDfTN/01qbcpA3ZzhHeT
         dwUc3LuFJyfUXlzHJ3/iezOHVorIUIrL9+sdryXG2MCffezNXIso9yvtiWIZOdAX6UbR
         jg49EGCvuOpuQDO20Km1UaTjuWU0WeHrdv2dZKReL3eIF+pPQnhmhknzU4uwE9AC/BH3
         jIX8WwQyF/8smrzi9HPNxpOH97gNbas05jDQK36KHgVuKxUa09Xu2yy1XAkmyyMNT76M
         vixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DNAZwCZByYTbwclhe+TRUuG+E9r9+02rmdbcNH7Mmz8=;
        b=guyoyDo6xYb6X1XyI3Fb3iMrT0V4RM7R370P8REv/k2MM6sADgTGv5SUG2YWkVBnTn
         UwLqNmypfEzSsphEUk6rt1NjDhy9MeaQ9q1GDysptWv45XlyYN6KYRtjDSU2ZIp3ZBOc
         eZX/ayCegB1wNiwoWTFa38EzJ4zBw/iv2ki7jEBTCFh1jVpqrypF/riOt7RW2nFwBvEE
         22wvykLgguiP7eVfWbH0lf//qJIUPlWCIRbZQacQ1CtPGLLF8NzMLA8hmzElEt7VQACj
         zcJmUDLu1QAqMUMTw+UD6gbkAYIyQENhYwGtkiiApNqsi4QJEBY/6LulkKhCZzI7hFf+
         G6Jw==
X-Gm-Message-State: APjAAAWf/+E17dqunjBlrvheYsL0DK8yo8I3yc/dS8b1/h9rwHYaw9UJ
        hDEivjw2NrMDAEliY01niuTlAaItYt5I+WMndMd6kg==
X-Google-Smtp-Source: APXvYqyiObVIKA2qPWuAhfgFDYhZGh15UieP1P60TReILtL0Ua81Cv/VdkMO8Y95D5uCov0sYjjTNCX5npohSrG/GLU=
X-Received: by 2002:a2e:9b81:: with SMTP id z1mr22408671lji.101.1561484271278;
 Tue, 25 Jun 2019 10:37:51 -0700 (PDT)
MIME-Version: 1.0
References: <1561420642-21186-1-git-send-email-alan.mikhak@sifive.com> <39cc44bb-28b8-0daf-b059-b78791c77eb1@intel.com>
In-Reply-To: <39cc44bb-28b8-0daf-b059-b78791c77eb1@intel.com>
From:   Alan Mikhak <alan.mikhak@sifive.com>
Date:   Tue, 25 Jun 2019 10:37:40 -0700
Message-ID: <CABEDWGy1X_HfmnMF05VKzMW7pNMaY+EMRFkTFPmc7Y0evoWZqQ@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Avoid leak if pci_p2pmem_virt_to_bus() returns null
To:     "Heitke, Kenneth" <kenneth.heitke@intel.com>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com, axboe@fb.com,
        Christoph Hellwig <hch@lst.de>, sagi@grimberg.me,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 10:10 AM Heitke, Kenneth
<kenneth.heitke@intel.com> wrote:
>
>
>
> On 6/24/2019 5:57 PM, Alan Mikhak wrote:
> > Modify nvme_alloc_sq_cmds() to call pci_free_p2pmem()
> > to free the memory it allocated using pci_alloc_p2pmem()
> > in case pci_p2pmem_virt_to_bus() returns null.
> >
> > Make sure not to call pci_free_p2pmem() if pci_alloc_p2pmem()
> > returned null which can happen if CONFIG_PCI_P2PDMA is not
> > configured.
> >
> > Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
> > ---
> >   drivers/nvme/host/pci.c | 14 +++++++++-----
> >   1 file changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index 524d6bd6d095..5dfa067f6506 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -1456,11 +1456,15 @@ static int nvme_alloc_sq_cmds(struct nvme_dev *dev, struct nvme_queue *nvmeq,
> >
> >       if (qid && dev->cmb_use_sqes && (dev->cmbsz & NVME_CMBSZ_SQS)) {
> >               nvmeq->sq_cmds = pci_alloc_p2pmem(pdev, SQ_SIZE(depth));
> > -             nvmeq->sq_dma_addr = pci_p2pmem_virt_to_bus(pdev,
> > -                                             nvmeq->sq_cmds);
> > -             if (nvmeq->sq_dma_addr) {
> > -                     set_bit(NVMEQ_SQ_CMB, &nvmeq->flags);
> > -                     return 0;
> > +             if (nvmeq->sq_cmds) {
> > +                     nvmeq->sq_dma_addr = pci_p2pmem_virt_to_bus(pdev,
> > +                                                     nvmeq->sq_cmds);
> > +                     if (nvmeq->sq_dma_addr) {
> > +                             set_bit(NVMEQ_SQ_CMB, &nvmeq->flags);
> > +                             return 0;
> > +                     }
> > +
> > +                     pci_free_p2pmem(pdev, nvmeq->sq_cmds, SQ_SIZE(depth));
>
> Should the pointer be set to NULL here, just in case?

Thanks Kenneth. The pointer gets immediately reassigned by the return
value of the
code that follows. There is no intervening reference to it between the calls to
pci_free_p2pmem() and dma_alloc_coherent(). It should be safe without
setting it to NULL.

        nvmeq->sq_cmds = dma_alloc_coherent(dev->dev, nvmeq->cq_size,
                                &nvmeq->sq_dma_addr, GFP_KERNEL);

>
> >               }
> >       }
> >
> >
