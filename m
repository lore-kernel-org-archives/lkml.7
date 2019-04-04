Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F15C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5532D206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbfDDPwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:52:51 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43023 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfDDPwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 11:52:50 -0400
Received: by mail-qt1-f196.google.com with SMTP id v32so3770516qtc.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 08:52:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PVngM7uF6M93IOSHKxEjJoU1wIvtG/W5QemiBaE3w2A=;
        b=CtSrq0IBqQZxXhYaidznVYJYj+48B6IkC1AeV/hrEFGuaGlp/7XxqmcB8bs2+Lf+OR
         M/iLBsXz/fUhRL5inZ43JS18uwbyWDvGE/eR21uWH9OOO9aCelSDozEu18JjMY+CRZEX
         0CWqBFzIQDMiohERAYO3FzA4edHEnfeATAlHaT843OmXlr3cVs27E6ZdtI5wjKWRZlnS
         gUz03aWpt5nGnBjObKuiVFQuxj4Prgd/AJ/p9jfhIlE4pghLr0udo1MuE4iVnKpLPyB8
         4c7tcQSHQ0a/lrtySGxsLoed1CT2CXurdy0aQFsIx6CTffhhLRcRpYnklwNqKBL6lSor
         a7kg==
X-Gm-Message-State: APjAAAVjHWCIAxTqQ07w+BWXTWB/K1oopCFhxb2g0xoXtKCBDDZoMFmS
        5IsWXw9Ix8eWN2aHEO4hVPkLqQ==
X-Google-Smtp-Source: APXvYqy+k3xQQcos8yrOxQt5H2n3lVfT+mshyqa5DP9cT6VBV/tl6cbJmw3NI8BEakHxBrDUUwVtrQ==
X-Received: by 2002:a0c:d21a:: with SMTP id m26mr5646369qvh.100.1554393169546;
        Thu, 04 Apr 2019 08:52:49 -0700 (PDT)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id x125sm11433039qkd.42.2019.04.04.08.52.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 08:52:48 -0700 (PDT)
Date:   Thu, 4 Apr 2019 11:52:46 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH RFC 0/4] vsock/virtio: optimizations to increase the
 throughput
Message-ID: <20190404114643-mutt-send-email-mst@kernel.org>
References: <20190404105838.101559-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404105838.101559-1-sgarzare@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 12:58:34PM +0200, Stefano Garzarella wrote:
> This series tries to increase the throughput of virtio-vsock with slight
> changes:
>  - patch 1/4: reduces the number of credit update messages sent to the
>               transmitter
>  - patch 2/4: allows the host to split packets on multiple buffers,
>               in this way, we can remove the packet size limit to
>               VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE
>  - patch 3/4: uses VIRTIO_VSOCK_MAX_PKT_BUF_SIZE as the max packet size
>               allowed
>  - patch 4/4: increases RX buffer size to 64 KiB (affects only host->guest)
> 
> RFC:
>  - maybe patch 4 can be replaced with multiple queues with different
>    buffer sizes or using EWMA to adapt the buffer size to the traffic
> 
>  - as Jason suggested in a previous thread [1] I'll evaluate to use
>    virtio-net as transport, but I need to understand better how to
>    interface with it, maybe introducing sk_buff in virtio-vsock.
> 
> Any suggestions?
> 
> Here some benchmarks step by step. I used iperf3 [2] modified with VSOCK
> support:
> 
>                         host -> guest [Gbps]
> pkt_size    before opt.   patch 1   patches 2+3   patch 4
>   64            0.060       0.102       0.102       0.096
>   256           0.22        0.40        0.40        0.36
>   512           0.42        0.82        0.85        0.74
>   1K            0.7         1.6         1.6         1.5
>   2K            1.5         3.0         3.1         2.9
>   4K            2.5         5.2         5.3         5.3
>   8K            3.9         8.4         8.6         8.8
>   16K           6.6        11.1        11.3        12.8
>   32K           9.9        15.8        15.8        18.1
>   64K          13.5        17.4        17.7        21.4
>   128K         17.9        19.0        19.0        23.6
>   256K         18.0        19.4        19.8        24.4
>   512K         18.4        19.6        20.1        25.3
> 
>                         guest -> host [Gbps]
> pkt_size    before opt.   patch 1   patches 2+3
>   64            0.088       0.100       0.101
>   256           0.35        0.36        0.41
>   512           0.70        0.74        0.73
>   1K            1.1         1.3         1.3
>   2K            2.4         2.4         2.6
>   4K            4.3         4.3         4.5
>   8K            7.3         7.4         7.6
>   16K           9.2         9.6        11.1
>   32K           8.3         8.9        18.1
>   64K           8.3         8.9        25.4
>   128K          7.2         8.7        26.7
>   256K          7.7         8.4        24.9
>   512K          7.7         8.5        25.0
> 
> Thanks,
> Stefano

I simply love it that you have analysed the individual impact of
each patch! Great job!

For comparison's sake, it could be IMHO benefitial to add a column
with virtio-net+vhost-net performance.

This will both give us an idea about whether the vsock layer introduces
inefficiencies, and whether the virtio-net idea has merit.

One other comment: it makes sense to test with disabling smap
mitigations (boot host and guest with nosmap).  No problem with also
testing the default smap path, but I think you will discover that the
performance impact of smap hardening being enabled is often severe for
such benchmarks.


> [1] https://www.spinics.net/lists/netdev/msg531783.html
> [2] https://github.com/stefano-garzarella/iperf/
> 
> Stefano Garzarella (4):
>   vsock/virtio: reduce credit update messages
>   vhost/vsock: split packets to send using multiple buffers
>   vsock/virtio: change the maximum packet size allowed
>   vsock/virtio: increase RX buffer size to 64 KiB
> 
>  drivers/vhost/vsock.c                   | 35 ++++++++++++++++++++-----
>  include/linux/virtio_vsock.h            |  3 ++-
>  net/vmw_vsock/virtio_transport_common.c | 18 +++++++++----
>  3 files changed, 44 insertions(+), 12 deletions(-)
> 
> -- 
> 2.20.1
