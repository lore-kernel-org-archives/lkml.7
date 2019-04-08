Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3324AC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 06:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0375120870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 06:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfDHGnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 02:43:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64785 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfDHGnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 02:43:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D69AA88AB0;
        Mon,  8 Apr 2019 06:43:40 +0000 (UTC)
Received: from [10.72.12.140] (ovpn-12-140.pek2.redhat.com [10.72.12.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 121165D71F;
        Mon,  8 Apr 2019 06:43:29 +0000 (UTC)
Subject: Re: [PATCH RFC 0/4] vsock/virtio: optimizations to increase the
 throughput
To:     Stefano Garzarella <sgarzare@redhat.com>, netdev@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
References: <20190404105838.101559-1-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <a98d194d-e257-41ff-82e7-de2d16d2f4d4@redhat.com>
Date:   Mon, 8 Apr 2019 14:43:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404105838.101559-1-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 08 Apr 2019 06:43:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/4/4 下午6:58, Stefano Garzarella wrote:
> This series tries to increase the throughput of virtio-vsock with slight
> changes:
>   - patch 1/4: reduces the number of credit update messages sent to the
>                transmitter
>   - patch 2/4: allows the host to split packets on multiple buffers,
>                in this way, we can remove the packet size limit to
>                VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE
>   - patch 3/4: uses VIRTIO_VSOCK_MAX_PKT_BUF_SIZE as the max packet size
>                allowed
>   - patch 4/4: increases RX buffer size to 64 KiB (affects only host->guest)
>
> RFC:
>   - maybe patch 4 can be replaced with multiple queues with different
>     buffer sizes or using EWMA to adapt the buffer size to the traffic


Or EWMA + mergeable rx buffer, but if we decide to unify the datapath 
with virtio-net, we can reuse their codes.


>
>   - as Jason suggested in a previous thread [1] I'll evaluate to use
>     virtio-net as transport, but I need to understand better how to
>     interface with it, maybe introducing sk_buff in virtio-vsock.
>
> Any suggestions?


My understanding is this is not a must, but if it makes things easier, 
we can do this.

Another thing that may help is to implement sendpage(), which will 
greatly improve the performance.

Thanks


>
> Here some benchmarks step by step. I used iperf3 [2] modified with VSOCK
> support:
>
>                          host -> guest [Gbps]
> pkt_size    before opt.   patch 1   patches 2+3   patch 4
>    64            0.060       0.102       0.102       0.096
>    256           0.22        0.40        0.40        0.36
>    512           0.42        0.82        0.85        0.74
>    1K            0.7         1.6         1.6         1.5
>    2K            1.5         3.0         3.1         2.9
>    4K            2.5         5.2         5.3         5.3
>    8K            3.9         8.4         8.6         8.8
>    16K           6.6        11.1        11.3        12.8
>    32K           9.9        15.8        15.8        18.1
>    64K          13.5        17.4        17.7        21.4
>    128K         17.9        19.0        19.0        23.6
>    256K         18.0        19.4        19.8        24.4
>    512K         18.4        19.6        20.1        25.3
>
>                          guest -> host [Gbps]
> pkt_size    before opt.   patch 1   patches 2+3
>    64            0.088       0.100       0.101
>    256           0.35        0.36        0.41
>    512           0.70        0.74        0.73
>    1K            1.1         1.3         1.3
>    2K            2.4         2.4         2.6
>    4K            4.3         4.3         4.5
>    8K            7.3         7.4         7.6
>    16K           9.2         9.6        11.1
>    32K           8.3         8.9        18.1
>    64K           8.3         8.9        25.4
>    128K          7.2         8.7        26.7
>    256K          7.7         8.4        24.9
>    512K          7.7         8.5        25.0
>
> Thanks,
> Stefano
>
> [1] https://www.spinics.net/lists/netdev/msg531783.html
> [2] https://github.com/stefano-garzarella/iperf/
>
> Stefano Garzarella (4):
>    vsock/virtio: reduce credit update messages
>    vhost/vsock: split packets to send using multiple buffers
>    vsock/virtio: change the maximum packet size allowed
>    vsock/virtio: increase RX buffer size to 64 KiB
>
>   drivers/vhost/vsock.c                   | 35 ++++++++++++++++++++-----
>   include/linux/virtio_vsock.h            |  3 ++-
>   net/vmw_vsock/virtio_transport_common.c | 18 +++++++++----
>   3 files changed, 44 insertions(+), 12 deletions(-)
>
