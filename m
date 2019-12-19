Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876EBC3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 14:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 550BA24672
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 14:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HLNFk9RB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfLSOcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 09:32:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31442 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726757AbfLSOcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 09:32:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576765938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NwBEqCubzVnj+8bLk/KLa5gTYkK9euORDuufTcOhUmI=;
        b=HLNFk9RBwa/DqYW3U8iZoMVv849Tt2ro7iccMFzbrQX8GwRvVhWjUGu0RoFt33UWi1p3dS
        wvo5qC77psxpc+verR/7GQupN+DeKNctaYHm6ONXO8b5l4K5iVrTyW9J9jYsXQFuq6qwxz
        HDCHyc2iM8bnXRZCw0W8mpOwA/+AYzA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-HvvlPQhTMM-pR3OpYDFoSw-1; Thu, 19 Dec 2019 09:32:17 -0500
X-MC-Unique: HvvlPQhTMM-pR3OpYDFoSw-1
Received: by mail-qv1-f69.google.com with SMTP id g15so3739198qvk.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 06:32:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NwBEqCubzVnj+8bLk/KLa5gTYkK9euORDuufTcOhUmI=;
        b=sjYw0b3yEvh6OwbpUfDpN4adPktS7eY9o0FZT/f+KL2T/0VcV1CvG93BbeA8bXgPln
         Rdts4EaXGPit20MvP9h0DpC1nvLzrgxRSfqJQAhm0KKYX8MvIiAfTjJF04OtPGQAx4d8
         4+vGvNTLJh3ZKWDOv69QX0HkMQ3bLCFA/M7EOFvH9dwJU/p6b3LyUvINNiItEpdpr3ho
         2XYkKEwSp63QY5g4uVq+nEU6OVJi/IJ9CvEKzzM4VJlDpPqat7NTyegTd1jqezKp/VmL
         Bgol6D0b0hbCkRDkJku2PzpdXFtlr5+2qXN6jIzwFHFxCjmtHDZ1143VEmbgH8Pwg3vQ
         2BBw==
X-Gm-Message-State: APjAAAXPr4MBYTmdTi1/zScQsxRKiUrincbIVrqiIJVbHq1gPWzwaZqT
        Otk+c+DQaQnUwF5uJVAS/UEHUDfGKMDEPfa+tvkVcntTgfh6Wk/DB2QUAeVd7wNu3sgac8Dnw9/
        YZFCu2vjkHFHgH1NisRm0Potr
X-Received: by 2002:a0c:f412:: with SMTP id h18mr7962807qvl.124.1576765936784;
        Thu, 19 Dec 2019 06:32:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqzidDOLbWjuQgMrCE7eVF5+d38FlxxwpMmVjH4JPTwrKffyBEPa1+pCu6rWrSa2lsAyvPaZFg==
X-Received: by 2002:a0c:f412:: with SMTP id h18mr7962770qvl.124.1576765936466;
        Thu, 19 Dec 2019 06:32:16 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id f4sm1723999qka.89.2019.12.19.06.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 06:32:15 -0800 (PST)
Date:   Thu, 19 Dec 2019 09:32:14 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ming Lei <minlei@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel-managed IRQ affinity (cont)
Message-ID: <20191219143214.GA50561@xz-x1>
References: <20191216195712.GA161272@xz-x1>
 <20191219082819.GB15731@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191219082819.GB15731@ming.t460p>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 04:28:19PM +0800, Ming Lei wrote:
> Hi Peter,

Hi, Ming,

> 
> On Mon, Dec 16, 2019 at 02:57:12PM -0500, Peter Xu wrote:
> > Hi, Thomas,
> > 
> > (Sorry I must have lost the discussion during an email migration, so
> >  I'll start with a new one)
> > 
> > This is a continued discussion of previous one on kernel managed IRQ
> > affinity [1].  I think at that time the conclusion is that we don't
> > have a usage scenario to change current policy [2].  However recently
> > I noticed that it is probably a very fundamental requirement for some
> > real-time scenarios, even when there's no multi-queue involved.
> > 
> > In my test case, it was a very common realtime guest with 10 vcpus,
> > 0-1 are housekeeping vcpus, 2-9 are realtime vcpus.  The guest has one
> > virtio-blk device as boot disk.  With a distribution very close to
> > latest upstream, we can observe high spikes, probably due to the IRQs.
> > 
> > To guarantee realtime responsiveness, we need to make sure the IRQs
> > will be managable, say, when I run a real-time workload on vcpu9, we
> > should be able to move all the IRQs from vcpu9 to the other vcpus
> > (most probably vcpu0 and vcpu1).  However with the kernel managed IRQs
> > we can't echo to /proc/irq/N/smp_affinity.  Here, vcpu9 gets IRQ 38
> > from the virtio-blk device:
> > 
> >   # cat /proc/interrupts | grep -w 38
> >   38: 0 0 0 0 0 0 0 0 0 15206 PCI-MSI 2621441-edge virtio2-req.0
> >   # cat /proc/irq/38/smp_affinity
> >   3ff
> >   # cat /proc/irq/38/effective_affinity
> >   200
> > 
> > Meanwhile, I don't think there's anything special for VMs, so this
> > issue should exist even for hosts as long as the IRQ is managed in the
> > same way here as the virtio-blk device.
> > 
> > As Ming has mentioned in previous discussions [3], I think it would be
> > at least good if the kernel IRQ system can respect "irqaffinity=" when
> > assigning IRQs to the cores.  Currently it's not.  What would you
> > suggest in this case?  Do you think this is a valid user scenario?
> > 
> > Thanks,
> > 
> > [1] https://lkml.org/lkml/2019/3/18/15
> > [2] https://lkml.org/lkml/2019/3/25/562
> > [3] https://lkml.org/lkml/2019/3/25/308
> 
> The following patch supposes to implementation the requirement for you,
> can you test it by passing 'isolcpus=managed_irq,X-Y'?

I really appreciate your patch!  I'll keep this version, while before
I start to test it...

> 
> With this kind of change, you can't run any IO from any isolated
> CPU core, otherwise, unpredictable error may be triggered, either oops or
> IO hang.

... I'm not sure whether this can be acceptable for a production
environment.

In our case, the IRQ should come from virtio-blk which is the root
disk, so I assume even the RT core could use it at least when loading
the executable into RAM.  So...

> 
> Another conservative approach is to only select effective CPU from
> non-isolated cpus, however, the assigned CPUs may not be balanced among
> interrupt vectors. But it is safer, since the system still works even if
> someone submits IO from any isolated cpu core.

... this one seems to be more appealing at least to me.

Thanks,

-- 
Peter Xu

