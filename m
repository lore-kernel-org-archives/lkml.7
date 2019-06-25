Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322F3C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 17:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F36EF2063F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 17:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="GXRap7s5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731251AbfFYR1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 13:27:21 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43502 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbfFYR1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 13:27:21 -0400
Received: by mail-lf1-f65.google.com with SMTP id j29so13209914lfk.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 10:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EzzLn0GswMFcyMLNaQ7ggxi30GgEafznXlfGyBwbniM=;
        b=GXRap7s5jEiN/yj8znTw5VoaIeXeTRZCA56SzbEgqrRSfr1R32FibRI3wBA7cG9NLs
         q1G4QUquAYQe0O39WbBEa8WsKHH7bGeEZl6cjOxEc2L1ZIWrJOURVZ8TJu0dDJ//w7ck
         bNCIgX2ypyFZT5lsTK/jWhcdiSTTu28EMnpJMrm6anadT+0OVbTZ7SBYAoSxCqtk71h+
         8jOvlf4DiKJZCGH6tASAOzF9RxNndGi2c1qhz88dnEFInYMU9hP6or0aCD24oremwdGY
         0PV/CrEP60RgzkVRW//JzKvIUs+kvFj/5hjqT/ST60egaNav6AKYXwUK0IaPvUBkfLFm
         MKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EzzLn0GswMFcyMLNaQ7ggxi30GgEafznXlfGyBwbniM=;
        b=BpsVlslZGYdsTDuxoToq7p3uLt3PyGF/FyNVZGMGl0YH1leoNQiGhnUoKyJjCok1eF
         Mbxh5m9uLvG3xMzFP8pY9xbPSXlecbWzid/o1wnEgRf+YsStHENG1Gy2hb/uqeN6FCEh
         aMlpasEcEkDQyuk/LCBjsXicMF4EXfmcXPNysav+nM2x/hhE56TOYH+BYFOLj143F7CF
         oXUOLvCDnkJgBYQhYjKlVCf1gMYHs1zc47cwoTm7WNMf0kggFYSVYGU/SlaogL92+Nhb
         IUVNRUd5xyIJkZotWI3r259AH4BziH3kzlRUsxJJM272YYjEwjvHb/VeDOjFkWyaiJkP
         1Plw==
X-Gm-Message-State: APjAAAU1q0G59fRCcmrlnfyNILV2xFmV6ILuIhWMnVsoh9iqGySQO83T
        Jc8HBBLuGdLano/HgGHtoBTCWYUO6bxneHwJFxDBwq/RUqE=
X-Google-Smtp-Source: APXvYqy+QhX5osc0RLcDyxsQWP6kDZm1kRoyl/PY8XBTQo2HfuAmAJJdplI2GZmDxo7qZE1w8c0pIqXD800Dt7VAH+o=
X-Received: by 2002:a19:f00a:: with SMTP id p10mr43511314lfc.68.1561483639083;
 Tue, 25 Jun 2019 10:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <1561420642-21186-1-git-send-email-alan.mikhak@sifive.com> <20190625070835.GC30123@lst.de>
In-Reply-To: <20190625070835.GC30123@lst.de>
From:   Alan Mikhak <alan.mikhak@sifive.com>
Date:   Tue, 25 Jun 2019 10:27:08 -0700
Message-ID: <CABEDWGymQopo4nPZnnTGXNH5GajUsccCCtQS6cmmhVa+HbFc2w@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Avoid leak if pci_p2pmem_virt_to_bus() returns null
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com, axboe@fb.com, sagi@grimberg.me,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 12:09 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Jun 24, 2019 at 04:57:22PM -0700, Alan Mikhak wrote:
> > Modify nvme_alloc_sq_cmds() to call pci_free_p2pmem()
> > to free the memory it allocated using pci_alloc_p2pmem()
> > in case pci_p2pmem_virt_to_bus() returns null.
> >
> > Make sure not to call pci_free_p2pmem() if pci_alloc_p2pmem()
> > returned null which can happen if CONFIG_PCI_P2PDMA is not
> > configured.
>
> Can you
>

I mean this patch makes sure not to call pci_free_p2pmem() if nothing
was allocated by pci_alloc_p2pmem().

> >
> > Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
> > ---
> >  drivers/nvme/host/pci.c | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
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
> pci_p2pmem_virt_to_bus should only fail when
> pci_p2pmem_virt_to_bus failed.  That being said I think doing the
> error check on pci_alloc_p2pmem instead of relying on
> pci_p2pmem_virt_to_bus "passing through" the error seems odd, I'd
> rather check the pci_alloc_p2pmem return value directly.

Thanks Christoph. I could see the existing code should not leak but only after
inspecting pci_p2pmem_virt_to_bus() and gen_pool_virt_to_phys(). I wondered
what if these functions changed and broke the relation but that seems unlikely.
Checking the return value directly may require less from the reader,
if that's a good
outcome.

Alan
