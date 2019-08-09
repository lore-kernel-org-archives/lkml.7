Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5179C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 23:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77755208C4
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 23:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWeeK/dI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfHIXFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 19:05:51 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39835 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfHIXFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 19:05:50 -0400
Received: by mail-wm1-f68.google.com with SMTP id u25so6886603wmc.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 16:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1VwyOAXo7eohMBN8xZNUOLTE4Y6Up/vz30c30b2901o=;
        b=mWeeK/dI7isF36qGFvVF6s8fzsuKm/X9kRrS0TRtB+fNCmtNJGRZMcHSGY/ib1FnIA
         UY1m7UVvnn1hGBSuYxwSRwze4J00e/39Z8hoJzIXsTzT6nTO0DATxXN2xNqmKBAo1fMp
         Y//GS5xG2Jd4Yb7nw3MbzZrnEzCoDulkPLQwZSHxbAGYYoK+qV/Uf6CQGwU+bVlDZfie
         2mJ84c3HB0fu7y0LUMvtLJJrMnjcQ76pkDy3oi45FO2917t7CXEKcdYTCE2lYtMkf652
         iVQiV15A17GXvulm4iHxskvIlR94Vl+KH3iB2ABI8G2yzjcRTDmJAju6RNUQFnF+b0Ir
         atbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1VwyOAXo7eohMBN8xZNUOLTE4Y6Up/vz30c30b2901o=;
        b=WHReFdsUzHloWIZaGWVr5LwiNONylw3mwKkPggW6q5FBXhgrF1ZtmjGo8DRtI23iz7
         XFx/6siyDwaqnhaI5WIOUCsC28K/VFS6AGO/CAJq71L0Zd5w6daIqgPBtM/b5nOfL8Xn
         ZuXpksowyjyjB3GV2ntvEy7dc0WB0bi3tZ47eiZoqquvJsxdpeKYsG1DYPNGToMaCs3z
         pduDxLx7m7MNJU8z1mmNCjZOnDw4zJpLbgTyzLYSwxITDVu7bMlddCL4QmsWlyLqZmcW
         I/VyQDuiSm8rg+ogeQFDQ9sziVPZpTcg7jagKfzn6HAhu0bGcFdnVxE8ljhvC86gSebq
         fAMA==
X-Gm-Message-State: APjAAAVgecqsyYXmvO+4O+Zg40VJMWTDJtUh8SOMhNw/dG+bVlpcXV5B
        pepa73NvTRMY6ayh34d51ZMWKg+oqAJV5i/G4mc2R2Jkj33Alw==
X-Google-Smtp-Source: APXvYqzJJVoSGjVK7OxaCu55+M8GCaH+jjgQucuB9ktT0bhYJCwiP9IIjubxaz2oeJmm2ZlPndOBlRIAwp1nUkW4edM=
X-Received: by 2002:a05:600c:2144:: with SMTP id v4mr11735016wml.146.1565391948663;
 Fri, 09 Aug 2019 16:05:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190809102310.27246-1-ming.lei@redhat.com> <20190809102310.27246-2-ming.lei@redhat.com>
 <20190809144204.GA28515@localhost.localdomain>
In-Reply-To: <20190809144204.GA28515@localhost.localdomain>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Sat, 10 Aug 2019 07:05:32 +0800
Message-ID: <CACVXFVMT=rkZC7LwK5quXgudS7fb7bQ_LunA1tEE-Z-9s1uvaA@mail.gmail.com>
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

On Fri, Aug 9, 2019 at 10:44 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Fri, Aug 09, 2019 at 06:23:09PM +0800, Ming Lei wrote:
> > One invariant of __irq_build_affinity_masks() is that all CPUs in the
> > specified masks( cpu_mask AND node_to_cpumask for each node) should be
> > covered during the spread. Even though all requested vectors have been
> > reached, we still need to spread vectors among left CPUs. The similar
> > policy has been taken in case of 'numvecs <= nodes'.
> >
> > So remove the following check inside the loop:
> >
> >       if (done >= numvecs)
> >               break;
> >
> > Meantime assign at least 1 vector for left nodes if 'numvecs' vectors
> > have been spread.
> >
> > Also, if the specified cpumask for one numa node is empty, simply not
> > spread vectors on this node.
> >
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Keith Busch <kbusch@kernel.org>
> > Cc: linux-nvme@lists.infradead.org,
> > Cc: Jon Derrick <jonathan.derrick@intel.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  kernel/irq/affinity.c | 33 +++++++++++++++++++++------------
> >  1 file changed, 21 insertions(+), 12 deletions(-)
> >
> > diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> > index 6fef48033f96..bc3652a2c61b 100644
> > --- a/kernel/irq/affinity.c
> > +++ b/kernel/irq/affinity.c
> > @@ -129,21 +129,32 @@ static int __irq_build_affinity_masks(unsigned int startvec,
> >       for_each_node_mask(n, nodemsk) {
> >               unsigned int ncpus, v, vecs_to_assign, vecs_per_node;
> >
> > -             /* Spread the vectors per node */
> > -             vecs_per_node = (numvecs - (curvec - firstvec)) / nodes;
> > -
> >               /* Get the cpus on this node which are in the mask */
> >               cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
> > -
> > -             /* Calculate the number of cpus per vector */
> >               ncpus = cpumask_weight(nmsk);
> > +             if (!ncpus)
> > +                     continue;
>
> This shouldn't be possible, right? The nodemsk we're looping  wouldn't
> have had that node set if no CPUs intersect the node_to_cpu_mask for
> that node, so the resulting cpumask should always have a non-zero weight.

     cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);

It is often true, see the following cases:

1) all CPUs in one node are not present

OR

2) all CPUs in one node are present

>
> > @@ -153,16 +164,14 @@ static int __irq_build_affinity_masks(unsigned int startvec,
> >                       }
> >                       irq_spread_init_one(&masks[curvec].mask, nmsk,
> >                                               cpus_per_vec);
> > +                     if (++curvec >= last_affv)
> > +                             curvec = firstvec;
>
> I'm not so sure about wrapping the vector to share it across nodes. We

The wrapping is always there, not added by this patch.

Most time it won't happen since we spread vectors on remaining
(un-assigned)nodes.  And it only happens when there is remaining
nodes not spread. We have to make sure all nodes are spread.

And the similar policy is applied on the branch of 'numvecs <= nodes' too.

> have enough vectors in this path to ensure each compute node can have
> a unique one, and it's much cheaper to share these within nodes than
> across them.

The patch just moves the wrapping from loop outside into the loop, then
all 'extra_vecs' can be covered because it is always < 'vecs_to_assign'.

What matters is that the following check is removed:

   if (done >= numvecs)
                break;

then all nodes can be covered.

Thanks,
Ming Lei
