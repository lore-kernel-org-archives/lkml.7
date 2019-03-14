Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D28FC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC408206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfCNMdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 08:33:03 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35776 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfCNMdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 08:33:03 -0400
Received: by mail-qt1-f194.google.com with SMTP id h39so5783636qte.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 05:33:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HzarW53smR/Xi78U3o4KlEFG6eASYZBPPWNkxc/9+mM=;
        b=eu7r1R9WVviAjuCb0xkLAOOu8/YfqBpOCsoOvIlJNtcW2Lb/A12ENXCylJeZBxVEuy
         e0l9wVLrJwisNhSFY462YgTVKBzT49PfCqYR3gKIsl0aDpm+fGC9AUwVOjWj2eaiyMBK
         xpMU7tSnd/A9zQDN3ax6Q1YhAZtP4dcOJogZuw37qcUiyUZ5bq6m7bCDBlzW8509k22a
         tEBajbuW+pe1Q8K6ud4ESL6kYZn+5xPSo71Lh9pId8sY2A1iTllcP1Z0a2vDOazZhHEt
         sIbpVegNpXnARrh7yQWJDUAfiFLFDqTLwA0xHDVRWFiOaauufzFQ9sr76L5WfhCS1SAB
         YcYA==
X-Gm-Message-State: APjAAAVIeGCLIdr+baAwHMGwum1wC2GlCi/373QaGl3q9dBOmgxMEuID
        jsbBdOrJZdZQlIPaUqsnQTLuDA==
X-Google-Smtp-Source: APXvYqwJGB8SbYWa7ZU+XwzLz+2s5/8HcBbaeppaxUe6lUWv2ti2JrZ2q8Zl4/zvIvYWKOTwmaO5IQ==
X-Received: by 2002:ac8:2850:: with SMTP id 16mr38427650qtr.84.1552566782205;
        Thu, 14 Mar 2019 05:33:02 -0700 (PDT)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id 10sm9720909qtx.40.2019.03.14.05.33.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Mar 2019 05:33:01 -0700 (PDT)
Date:   Thu, 14 Mar 2019 08:32:58 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, axboe@kernel.dk, jasowang@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: virtio-blk: should num_vqs be limited by num_possible_cpus()?
Message-ID: <20190314082926-mutt-send-email-mst@kernel.org>
References: <e4afe4c5-0262-4500-aeec-60f30734b4fc@default>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4afe4c5-0262-4500-aeec-60f30734b4fc@default>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 10:22:46AM -0700, Dongli Zhang wrote:
> I observed that there is one msix vector for config and one shared vector
> for all queues in below qemu cmdline, when the num-queues for virtio-blk
> is more than the number of possible cpus:
> 
> qemu: "-smp 4" while "-device virtio-blk-pci,drive=drive-0,id=virtblk0,num-queues=6"

So why do this?

> # cat /proc/interrupts 
>            CPU0       CPU1       CPU2       CPU3
> ... ...
>  24:          0          0          0          0   PCI-MSI 65536-edge      virtio0-config
>  25:          0          0          0         59   PCI-MSI 65537-edge      virtio0-virtqueues
> ... ...
> 
> 
> However, when num-queues is the same as number of possible cpus:
> 
> qemu: "-smp 4" while "-device virtio-blk-pci,drive=drive-0,id=virtblk0,num-queues=4"
> 
> # cat /proc/interrupts 
>            CPU0       CPU1       CPU2       CPU3
> ... ... 
>  24:          0          0          0          0   PCI-MSI 65536-edge      virtio0-config
>  25:          2          0          0          0   PCI-MSI 65537-edge      virtio0-req.0
>  26:          0         35          0          0   PCI-MSI 65538-edge      virtio0-req.1
>  27:          0          0         32          0   PCI-MSI 65539-edge      virtio0-req.2
>  28:          0          0          0          0   PCI-MSI 65540-edge      virtio0-req.3
> ... ...
> 
> In above case, there is one msix vector per queue.
> 
> 
> This is because the max number of queues is not limited by the number of
> possible cpus.
> 
> By default, nvme (regardless about write_queues and poll_queues) and
> xen-blkfront limit the number of queues with num_possible_cpus().
> 
> 
> Is this by design on purpose, or can we fix with below?
> 
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 4bc083b..df95ce3 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -513,6 +513,8 @@ static int init_vq(struct virtio_blk *vblk)
>  	if (err)
>  		num_vqs = 1;
>  
> +	num_vqs = min(num_possible_cpus(), num_vqs);
> +
>  	vblk->vqs = kmalloc_array(num_vqs, sizeof(*vblk->vqs), GFP_KERNEL);
>  	if (!vblk->vqs)
>  		return -ENOMEM;
> --
> 
> 
> PS: The same issue is applicable to virtio-scsi as well.
> 
> Thank you very much!
> 
> Dongli Zhang

I don't think this will address the issue if there's vcpu hotplug though.
Because it's not about num_possible_cpus it's about the # of active VCPUs,
right? Does block hangle CPU hotplug generally?
We could maybe address that by switching vq to msi vector mapping in
a cpu hotplug notifier...

-- 
MST
