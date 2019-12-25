Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D40FC2D0DA
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 10:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623A120722
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 10:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ioGSWS/G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfLYKVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 05:21:09 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23871 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726106AbfLYKVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 05:21:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577269267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jZKxE5DxO7ifxt1XeLzUb+gx1kehGU9I/C/p8L+AhTw=;
        b=ioGSWS/Gwq2oHcRqn8Am8VUb15FOg831kGmT/hZOZt71+DqDcQS9zui7LWdxrSg4SXRrKe
        u9LxBdK1oZS061DMlNdL4XNRxRxtpEXvKsyxnaPLKCCS2ZuEdG8thQUZXYsVdVN21ZFASD
        ZQEtZLD6lXof35QRVR7q4oCHF6NZrC0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-z3__PXNnPp6giLDjGL74hA-1; Wed, 25 Dec 2019 05:21:06 -0500
X-MC-Unique: z3__PXNnPp6giLDjGL74hA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C25E6DB21;
        Wed, 25 Dec 2019 10:21:04 +0000 (UTC)
Received: from [10.72.12.185] (ovpn-12-185.pek2.redhat.com [10.72.12.185])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A42060BF3;
        Wed, 25 Dec 2019 10:20:56 +0000 (UTC)
Subject: Re: [PATCH v1 2/2] virtio-mmio: add features for virtio-mmio
 specification version 3
To:     Zha Bin <zhabin@linux.alibaba.com>, linux-kernel@vger.kernel.org
Cc:     mst@redhat.com, slp@redhat.com, virtio-dev@lists.oasis-open.org,
        gerry@linux.alibaba.com, jing2.liu@intel.com, chao.p.peng@intel.com
References: <cover.1577240905.git.zhabin@linux.alibaba.com>
 <a11d4c616158c9fb1ca4575ca0530b2e17b952fa.1577240905.git.zhabin@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <229e689d-10f1-2bfb-c393-14dfa9c78971@redhat.com>
Date:   Wed, 25 Dec 2019 18:20:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a11d4c616158c9fb1ca4575ca0530b2e17b952fa.1577240905.git.zhabin@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/12/25 =E4=B8=8A=E5=8D=8810:50, Zha Bin wrote:
> From: Liu Jiang <gerry@linux.alibaba.com>
>
> Userspace VMMs (e.g. Qemu microvm, Firecracker) take advantage of using
> virtio over mmio devices as a lightweight machine model for modern
> cloud. The standard virtio over MMIO transport layer only supports one
> legacy interrupt, which is much heavier than virtio over PCI transport
> layer using MSI. Legacy interrupt has long work path and causes specifi=
c
> VMExits in following cases, which would considerably slow down the
> performance:
>
> 1) read interrupt status register
> 2) update interrupt status register
> 3) write IOAPIC EOI register
>
> We proposed to update virtio over MMIO to version 3[1] to add the
> following new features and enhance the performance.
>
> 1) Support Message Signaled Interrupt(MSI), which increases the
>     interrupt performance for virtio multi-queue devices
> 2) Support per-queue doorbell, so the guest kernel may directly write
>     to the doorbells provided by virtio devices.
>
> The following is the network tcp_rr performance testing report, tested
> with virtio-pci device, vanilla virtio-mmio device and patched
> virtio-mmio device (run test 3 times for each case):
>
> 	netperf -t TCP_RR -H 192.168.1.36 -l 30 -- -r 32,1024
>
> 		Virtio-PCI    Virtio-MMIO   Virtio-MMIO(MSI)
> 	trans/s	    9536	6939		9500
> 	trans/s	    9734	7029		9749
> 	trans/s	    9894	7095		9318
>
> [1] https://lkml.org/lkml/2019/12/20/113


Thanks for the patch. Two questions after a quick glance:

1) In PCI we choose to support MSI-X instead of MSI for having extra=20
flexibility like alias, independent data and address (e.g for affinity)=20
. Any reason for not start from MSI-X? E.g having MSI-X table and PBA=20
(both of which looks pretty independent).
2) It's better to split notify_multiplexer out of MSI support to ease=20
the reviewers (apply to spec patch as well)

Thanks

