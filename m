Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4214C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F2E206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbfDDSEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:04:15 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46960 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbfDDSEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 14:04:15 -0400
Received: by mail-qt1-f193.google.com with SMTP id z17so4271464qts.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 11:04:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zAvVyVMCARwzfM/G9djwPa5imgG7WteKsaLURotdmA8=;
        b=qQ71TVhYfWhDGmDNdAtMDuZvhvsB+AqzRpqqjGN7betW6sNB+NiRgvLccyAPVOou7O
         Pl0lBheeckk/Ojafx1/kTz6Ux/hBjkVGcGoesMxN6YA8h4uufUIa1sVzKjq5+8vTZ6jA
         rkfhGqBK/lLIqWmq+meERR1tC2FNpDb+wdeqBZ1wfEdC4tOKT0PQjsdFDPQrP+AoASuc
         PnlZseux3xfIoS9ovP3Fix6jzpweqIXY8Z/3gKL322LQGfjdUFuXLuKiRxmaZgz4NSE6
         Lu5WSimx9/WndOjs3SFVEkTnhQNls4ujATKSkoDnkDnUhdMn19dnA09fru6WIUPmgr4g
         LzfA==
X-Gm-Message-State: APjAAAWGvNnn2gzv7bfWcjQV6pVBnWGtqrwfMx4ci2Kzgn7BzH08i6zH
        mDaLhQhCebsBAy4SxOG7sgQwSQ==
X-Google-Smtp-Source: APXvYqy6Q7mnroz0n4KIXtlptTEPTmRJn3iWMx9R2GOOkKg60CaWGqU9k9CZnFsws4eTuSjTRKo+mQ==
X-Received: by 2002:ac8:18e6:: with SMTP id o35mr6705251qtk.80.1554401054056;
        Thu, 04 Apr 2019 11:04:14 -0700 (PDT)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id w8sm10699052qki.54.2019.04.04.11.04.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 11:04:12 -0700 (PDT)
Date:   Thu, 4 Apr 2019 14:04:10 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH RFC 0/4] vsock/virtio: optimizations to increase the
 throughput
Message-ID: <20190404140345-mutt-send-email-mst@kernel.org>
References: <20190404105838.101559-1-sgarzare@redhat.com>
 <20190404114643-mutt-send-email-mst@kernel.org>
 <20190404164715.sycigtccwq2rziuz@steredhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404164715.sycigtccwq2rziuz@steredhat>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 06:47:15PM +0200, Stefano Garzarella wrote:
> On Thu, Apr 04, 2019 at 11:52:46AM -0400, Michael S. Tsirkin wrote:
> > I simply love it that you have analysed the individual impact of
> > each patch! Great job!
> 
> Thanks! I followed Stefan's suggestions!
> 
> > 
> > For comparison's sake, it could be IMHO benefitial to add a column
> > with virtio-net+vhost-net performance.
> > 
> > This will both give us an idea about whether the vsock layer introduces
> > inefficiencies, and whether the virtio-net idea has merit.
> > 
> 
> Sure, I already did TCP tests on virtio-net + vhost, starting qemu in
> this way:
>   $ qemu-system-x86_64 ... \
>       -netdev tap,id=net0,vhost=on,ifname=tap0,script=no,downscript=no \
>       -device virtio-net-pci,netdev=net0
> 
> I did also a test using TCP_NODELAY, just to be fair, because VSOCK
> doesn't implement something like this.

Why not?

> In both cases I set the MTU to the maximum allowed (65520).
> 
>                         VSOCK                        TCP + virtio-net + vhost
>                   host -> guest [Gbps]                 host -> guest [Gbps]
> pkt_size  before opt. patch 1 patches 2+3 patch 4     TCP_NODELAY
>   64          0.060     0.102     0.102     0.096         0.16        0.15
>   256         0.22      0.40      0.40      0.36          0.32        0.57
>   512         0.42      0.82      0.85      0.74          1.2         1.2
>   1K          0.7       1.6       1.6       1.5           2.1         2.1
>   2K          1.5       3.0       3.1       2.9           3.5         3.4
>   4K          2.5       5.2       5.3       5.3           5.5         5.3
>   8K          3.9       8.4       8.6       8.8           8.0         7.9
>   16K         6.6      11.1      11.3      12.8           9.8        10.2
>   32K         9.9      15.8      15.8      18.1          11.8        10.7
>   64K        13.5      17.4      17.7      21.4          11.4        11.3
>   128K       17.9      19.0      19.0      23.6          11.2        11.0
>   256K       18.0      19.4      19.8      24.4          11.1        11.0
>   512K       18.4      19.6      20.1      25.3          10.1        10.7
> 
> For small packet size (< 4K) I think we should implement some kind of
> batching/merging, that could be for free if we use virtio-net as a transport.
> 
> Note: Maybe I have something miss configured because TCP on virtio-net
> for host -> guest case doesn't exceed 11 Gbps.
> 
>                         VSOCK                        TCP + virtio-net + vhost
>                   guest -> host [Gbps]                 guest -> host [Gbps]
> pkt_size  before opt. patch 1 patches 2+3             TCP_NODELAY
>   64          0.088     0.100     0.101                   0.24        0.24
>   256         0.35      0.36      0.41                    0.36        1.03
>   512         0.70      0.74      0.73                    0.69        1.6
>   1K          1.1       1.3       1.3                     1.1         3.0
>   2K          2.4       2.4       2.6                     2.1         5.5
>   4K          4.3       4.3       4.5                     3.8         8.8
>   8K          7.3       7.4       7.6                     6.6        20.0
>   16K         9.2       9.6      11.1                    12.3        29.4
>   32K         8.3       8.9      18.1                    19.3        28.2
>   64K         8.3       8.9      25.4                    20.6        28.7
>   128K        7.2       8.7      26.7                    23.1        27.9
>   256K        7.7       8.4      24.9                    28.5        29.4
>   512K        7.7       8.5      25.0                    28.3        29.3
> 
> For guest -> host I think is important the TCP_NODELAY test, because TCP
> buffering increases a lot the throughput.
> 
> > One other comment: it makes sense to test with disabling smap
> > mitigations (boot host and guest with nosmap).  No problem with also
> > testing the default smap path, but I think you will discover that the
> > performance impact of smap hardening being enabled is often severe for
> > such benchmarks.
> 
> Thanks for this valuable suggestion, I'll redo all the tests with nosmap!
> 
> Cheers,
> Stefano
