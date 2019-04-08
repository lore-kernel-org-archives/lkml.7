Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B095C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 06:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D150420833
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 06:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfDHGfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 02:35:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60218 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbfDHGfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 02:35:52 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A573959473;
        Mon,  8 Apr 2019 06:35:51 +0000 (UTC)
Received: from [10.72.12.140] (ovpn-12-140.pek2.redhat.com [10.72.12.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D3C31A267;
        Mon,  8 Apr 2019 06:35:38 +0000 (UTC)
Subject: Re: [PATCH RFC 4/4] vsock/virtio: increase RX buffer size to 64 KiB
To:     Stefan Hajnoczi <stefanha@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     netdev@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Stefano Garzarella <sgarzare@redhat.com>
References: <20190404105838.101559-1-sgarzare@redhat.com>
 <20190404105838.101559-5-sgarzare@redhat.com>
 <20190405084414.GE25152@stefanha-x1.localdomain>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <947d9806-f661-a739-5752-ca6cd6500bd2@redhat.com>
Date:   Mon, 8 Apr 2019 14:35:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405084414.GE25152@stefanha-x1.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 08 Apr 2019 06:35:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/4/5 下午4:44, Stefan Hajnoczi wrote:
> On Thu, Apr 04, 2019 at 12:58:38PM +0200, Stefano Garzarella wrote:
>> In order to increase host -> guest throughput with large packets,
>> we can use 64 KiB RX buffers.
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>   include/linux/virtio_vsock.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>> index 6d7a22cc20bf..43cce304408e 100644
>> --- a/include/linux/virtio_vsock.h
>> +++ b/include/linux/virtio_vsock.h
>> @@ -10,7 +10,7 @@
>>   #define VIRTIO_VSOCK_DEFAULT_MIN_BUF_SIZE	128
>>   #define VIRTIO_VSOCK_DEFAULT_BUF_SIZE		(1024 * 256)
>>   #define VIRTIO_VSOCK_DEFAULT_MAX_BUF_SIZE	(1024 * 256)
>> -#define VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE	(1024 * 4)
>> +#define VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE	(1024 * 64)
> This patch raises rx ring memory consumption from 128 * 4KB = 512KB to
> 128 * 64KB = 8MB.
>
> Michael, Jason: Any advice regarding rx/tx ring sizes and buffer sizes?
>
> Depending on rx ring size and the workload's packet size, different
> values might be preferred.
>
> This could become a tunable in the future.  It determines the size of
> the guest driver's rx buffers.


In virtio-net, we have mergeable rx buffer and estimate the rx buffer 
size through EWMA.

That's another reason I suggest to squash the vsock codes into virtio-net.

Thanks

