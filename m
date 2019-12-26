Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8445C2D0DA
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 08:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797A92071E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 08:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a0jv/YoK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfLZIJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 03:09:57 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55703 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725815AbfLZIJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 03:09:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577347795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K3FgUA2rvbhgaHkjwQebM6fRpmsQ8B0o7y2GZRAVFEU=;
        b=a0jv/YoKkMWCM9B3AceN1aUrVsqLVdZAkppTP42wJPyCF/t/z88SedawLPFISf0M5giSGz
        J0G+L6Oy+7NApFy5HUQHDlW5nh4IJLkAZrLKsH79XKM2XUUkmm6bnBpL1E/goE93x0ndOO
        gPBBGYL7b5d1oYpLonuywtoD6+sUt2E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187--Ami_yBEPsSjw0kw8pcVtg-1; Thu, 26 Dec 2019 03:09:51 -0500
X-MC-Unique: -Ami_yBEPsSjw0kw8pcVtg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EFBAB189CD08;
        Thu, 26 Dec 2019 08:09:49 +0000 (UTC)
Received: from [10.72.12.162] (ovpn-12-162.pek2.redhat.com [10.72.12.162])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 196606049D;
        Thu, 26 Dec 2019 08:09:33 +0000 (UTC)
Subject: Re: [PATCH v1 2/2] virtio-mmio: add features for virtio-mmio
 specification version 3
To:     "Liu, Jiang" <gerry@linux.alibaba.com>
Cc:     Zha Bin <zhabin@linux.alibaba.com>, linux-kernel@vger.kernel.org,
        mst@redhat.com, slp@redhat.com, virtio-dev@lists.oasis-open.org,
        jing2.liu@intel.com, chao.p.peng@intel.com
References: <cover.1577240905.git.zhabin@linux.alibaba.com>
 <a11d4c616158c9fb1ca4575ca0530b2e17b952fa.1577240905.git.zhabin@linux.alibaba.com>
 <229e689d-10f1-2bfb-c393-14dfa9c78971@redhat.com>
 <0460F92A-3DF6-4F7A-903B-6434555577CC@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <f8b46502-a5a5-c5c6-88df-101dbfd02fda@redhat.com>
Date:   Thu, 26 Dec 2019 16:09:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0460F92A-3DF6-4F7A-903B-6434555577CC@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/12/25 =E4=B8=8B=E5=8D=8811:20, Liu, Jiang wrote:
>
>> On Dec 25, 2019, at 6:20 PM, Jason Wang <jasowang@redhat.com> wrote:
>>
>>
>> On 2019/12/25 =E4=B8=8A=E5=8D=8810:50, Zha Bin wrote:
>>> From: Liu Jiang <gerry@linux.alibaba.com>
>>>
>>> Userspace VMMs (e.g. Qemu microvm, Firecracker) take advantage of usi=
ng
>>> virtio over mmio devices as a lightweight machine model for modern
>>> cloud. The standard virtio over MMIO transport layer only supports on=
e
>>> legacy interrupt, which is much heavier than virtio over PCI transpor=
t
>>> layer using MSI. Legacy interrupt has long work path and causes speci=
fic
>>> VMExits in following cases, which would considerably slow down the
>>> performance:
>>>
>>> 1) read interrupt status register
>>> 2) update interrupt status register
>>> 3) write IOAPIC EOI register
>>>
>>> We proposed to update virtio over MMIO to version 3[1] to add the
>>> following new features and enhance the performance.
>>>
>>> 1) Support Message Signaled Interrupt(MSI), which increases the
>>>     interrupt performance for virtio multi-queue devices
>>> 2) Support per-queue doorbell, so the guest kernel may directly write
>>>     to the doorbells provided by virtio devices.
>>>
>>> The following is the network tcp_rr performance testing report, teste=
d
>>> with virtio-pci device, vanilla virtio-mmio device and patched
>>> virtio-mmio device (run test 3 times for each case):
>>>
>>> 	netperf -t TCP_RR -H 192.168.1.36 -l 30 -- -r 32,1024
>>>
>>> 		Virtio-PCI    Virtio-MMIO   Virtio-MMIO(MSI)
>>> 	trans/s	    9536	6939		9500
>>> 	trans/s	    9734	7029		9749
>>> 	trans/s	    9894	7095		9318
>>>
>>> [1] https://lkml.org/lkml/2019/12/20/113
>>
>> Thanks for the patch. Two questions after a quick glance:
>>
>> 1) In PCI we choose to support MSI-X instead of MSI for having extra f=
lexibility like alias, independent data and address (e.g for affinity) . =
Any reason for not start from MSI-X? E.g having MSI-X table and PBA (both=
 of which looks pretty independent).
> Hi Jason,
> 	Thanks for reviewing patches on Christmas Day:)
> 	The PCI MSI-x has several advantages over PCI MSI, mainly
> 1) support 2048 vectors, much more than 32 vectors supported by MSI.
> 2) dedicated address/data for each vector,
> 3) per vector mask/pending bits.
> The proposed MMIO MSI extension supports both 1) and 2),


Aha right, I mis-read the patch. But more questions comes:

1) The association between vq and MSI-X vector is fixed. This means it=20
can't work for a device that have more than 2047 queues. We probably=20
need something similar to virtio-pci to allow a dynamic association.
2) The mask and unmask control is missed


>   but the extension doesn=E2=80=99t support 3) because
> we noticed that the Linux virtio subsystem doesn=E2=80=99t really make =
use of interrupt masking/unmasking.


Not directly used but masking/unmasking is widely used in irq subsystem=20
which allows lots of optimizations.


>
> On the other hand, we want to simplify VMM implementations as simple as=
 possible, and mimicking the PCI MSI-x
> will cause some complexity to VMM implementations.


I agree to simplify VMM implementation, but it looks to me introducing=20
masking/pending won't cost too much code in the VMM implementation. Just=20
new type of command for VIRTIO_MMIO_MSI_COMMAND.

Thanks


>
>> 2) It's better to split notify_multiplexer out of MSI support to ease =
the reviewers (apply to spec patch as well)
> Great suggestion, we will try to split the patch.
>
> Thanks,
> Gerry
>
>> Thanks

