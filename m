Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6C2C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 05:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 523AC20842
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 05:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMZ7Kqc9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfHLFHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 01:07:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46008 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbfHLFHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 01:07:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id q12so13163816wrj.12
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2019 22:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aP8VNbJwdQYaSZJ1imIyz0RI5Crt+YbRZvNDlL4/jpQ=;
        b=AMZ7Kqc93TaUacKOBAYc7uklS99HA0k/mkqvk9yP3Zts5PfjWZ32QGlh0AcAmkyyR3
         pz+JT/K2vJJBXZjFY3KylPNT3bcJLuJyh0axFIbghBqA58nXLl8QZFm+FPJ8QHYCkJnx
         Dn8BEplVzVSnW/V084uYmssUioe6RJzX+TCmAb2HaLU5Pij9Aqd3Ls0EY3GUmPexHhCn
         MqCLe+HGHbcmliU6OYooDNMqFTa63lckjB2lqoG6KTEVVceEJq9mcQybrnJOHI08YFTC
         YNIPE2xj0YShqL9hsI/1eNwILNat72Pa4MmFK5UUQjrD6hdBjnsettYCLkHv2GUrM7Ei
         cdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aP8VNbJwdQYaSZJ1imIyz0RI5Crt+YbRZvNDlL4/jpQ=;
        b=SzdJ6o/OpqtWFUfp4CQJzk45/QET4PSSe1E6LJVzc1ClFRj9GswvxUTcTu3J20fl+C
         A3l+yJfNSJ0CGunZlJc/CiQigF6Xvd9Xe+omfMeKkXyXsqso6+PyXmLMABnWbkkqV7EO
         RXO2ie361B9Bl8WaEZrdlrmPDB0rTSC7dhKm4WT7fCpMo1eJckjndv9GV5/eMeYLfonk
         KQXDffiiW42g9LFNr2HGLwJB6kEQ8iTHMbdd4uYMBLY+4EvDstjNbbjUvosC0RgAqF3I
         GsT/KtI/Z641JP22lVZrWJJ3EiuhzkP6sf2NolVZnCxBg+X9gyoqHhRjIw/NlzJw6U7h
         /8eA==
X-Gm-Message-State: APjAAAWAd3kNoVarmHh6HJsGOj/NhxYHHMS/yBrquLPYwzCKTK752PjI
        +VncES28KmpaRXnkwsxyfgK6LQF2j/TXJkmrSZ4=
X-Google-Smtp-Source: APXvYqxQT0vmwxz66zVU1Q++t5xosJoGJRxTW6fYwUtcWL0gm4jiEWPQjRbPqkBh2NsDqmRohe3dSXtbHwQRiQ3/8us=
X-Received: by 2002:adf:91c2:: with SMTP id 60mr40582385wri.334.1565586423303;
 Sun, 11 Aug 2019 22:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190809102310.27246-1-ming.lei@redhat.com> <20190809102310.27246-2-ming.lei@redhat.com>
 <20190809144204.GA28515@localhost.localdomain> <CACVXFVMT=rkZC7LwK5quXgudS7fb7bQ_LunA1tEE-Z-9s1uvaA@mail.gmail.com>
In-Reply-To: <CACVXFVMT=rkZC7LwK5quXgudS7fb7bQ_LunA1tEE-Z-9s1uvaA@mail.gmail.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Mon, 12 Aug 2019 13:06:49 +0800
Message-ID: <CACVXFVNMu3tnEgi0+jcdgv5CD-ZAy7xnff4GxpPrVaKDh_fULA@mail.gmail.com>
Subject: Re: [PATCH 1/2] genirq/affinity: improve __irq_build_affinity_masks()
To:     Keith Busch <kbusch@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 10, 2019 at 7:05 AM Ming Lei <tom.leiming@gmail.com> wrote:
>
> On Fri, Aug 9, 2019 at 10:44 PM Keith Busch <kbusch@kernel.org> wrote:
> >
> > On Fri, Aug 09, 2019 at 06:23:09PM +0800, Ming Lei wrote:
> > > One invariant of __irq_build_affinity_masks() is that all CPUs in the
> > > specified masks( cpu_mask AND node_to_cpumask for each node) should be
> > > covered during the spread. Even though all requested vectors have been
> > > reached, we still need to spread vectors among left CPUs. The similar
> > > policy has been taken in case of 'numvecs <= nodes'.
> > >
> > > So remove the following check inside the loop:
> > >
> > >       if (done >= numvecs)
> > >               break;
> > >
> > > Meantime assign at least 1 vector for left nodes if 'numvecs' vectors
> > > have been spread.
> > >
> > > Also, if the specified cpumask for one numa node is empty, simply not
> > > spread vectors on this node.
> > >
> > > Cc: Christoph Hellwig <hch@lst.de>
> > > Cc: Keith Busch <kbusch@kernel.org>
> > > Cc: linux-nvme@lists.infradead.org,
> > > Cc: Jon Derrick <jonathan.derrick@intel.com>
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >  kernel/irq/affinity.c | 33 +++++++++++++++++++++------------
> > >  1 file changed, 21 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> > > index 6fef48033f96..bc3652a2c61b 100644
> > > --- a/kernel/irq/affinity.c
> > > +++ b/kernel/irq/affinity.c
> > > @@ -129,21 +129,32 @@ static int __irq_build_affinity_masks(unsigned int startvec,
> > >       for_each_node_mask(n, nodemsk) {
> > >               unsigned int ncpus, v, vecs_to_assign, vecs_per_node;
> > >
> > > -             /* Spread the vectors per node */
> > > -             vecs_per_node = (numvecs - (curvec - firstvec)) / nodes;
> > > -
> > >               /* Get the cpus on this node which are in the mask */
> > >               cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
> > > -
> > > -             /* Calculate the number of cpus per vector */
> > >               ncpus = cpumask_weight(nmsk);
> > > +             if (!ncpus)
> > > +                     continue;
> >
> > This shouldn't be possible, right? The nodemsk we're looping  wouldn't
> > have had that node set if no CPUs intersect the node_to_cpu_mask for
> > that node, so the resulting cpumask should always have a non-zero weight.
>
>      cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
>
> It is often true, see the following cases:
>
> 1) all CPUs in one node are not present
>
> OR
>
> 2) all CPUs in one node are present
>
> >
> > > @@ -153,16 +164,14 @@ static int __irq_build_affinity_masks(unsigned int startvec,
> > >                       }
> > >                       irq_spread_init_one(&masks[curvec].mask, nmsk,
> > >                                               cpus_per_vec);
> > > +                     if (++curvec >= last_affv)
> > > +                             curvec = firstvec;
> >
> > I'm not so sure about wrapping the vector to share it across nodes. We
>
> The wrapping is always there, not added by this patch.

We could avoid the wrapping completely given 'numvecs' > 'nodes', and
it can be done by sorting each node's nr_cpus, will do it in V2.


Thanks,
Ming Lei
