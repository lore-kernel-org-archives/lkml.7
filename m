Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F37C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8C2C20833
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfDIIgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 04:36:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40632 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbfDIIge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 04:36:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7DA057DCE0;
        Tue,  9 Apr 2019 08:36:34 +0000 (UTC)
Received: from [10.72.12.67] (ovpn-12-67.pek2.redhat.com [10.72.12.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C443F69185;
        Tue,  9 Apr 2019 08:36:23 +0000 (UTC)
Subject: Re: [PATCH RFC 0/4] vsock/virtio: optimizations to increase the
 throughput
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Stefano Garzarella <sgarzare@redhat.com>, netdev@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
References: <20190404105838.101559-1-sgarzare@redhat.com>
 <a98d194d-e257-41ff-82e7-de2d16d2f4d4@redhat.com>
 <20190408094416.GQ15001@stefanha-x1.localdomain>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <1484dbc0-0413-b21a-6a48-be58da9cb722@redhat.com>
Date:   Tue, 9 Apr 2019 16:36:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408094416.GQ15001@stefanha-x1.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 09 Apr 2019 08:36:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/4/8 下午5:44, Stefan Hajnoczi wrote:
> On Mon, Apr 08, 2019 at 02:43:28PM +0800, Jason Wang wrote:
>> Another thing that may help is to implement sendpage(), which will greatly
>> improve the performance.
> I can't find documentation for ->sendpage().  Is the idea that you get a
> struct page for the payload and can do zero-copy tx?


Yes.


>   (And can userspace
> still write to the page, invalidating checksums in the header?)
>
> Stefan


Userspace can still write to the page, but for correctness (e.g in the 
case of SPLICE_F_GIFT describe by vmsplice(2)), it should not do this. 
For vmsplice, it may hard to detect the time to reuse the page. Maybe we 
MSG_ZEROCOPY[1] is better.

Anyway, sendpage() could be still useful for sendfile() or splice().

Thanks

[1] https://netdevconf.org/2.1/papers/netdev.pdf

