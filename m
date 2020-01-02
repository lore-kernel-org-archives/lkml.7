Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B8FC2D0DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 06:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ACD720863
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 06:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W7XXflk0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgABG3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 01:29:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25317 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725788AbgABG3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 01:29:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577946562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Wy4DlJwntDGG8Dw5wwsUzHgZ7JZO21FMH3YX0CC+uQ=;
        b=W7XXflk0C9E5la+QbcoIq25vLb9qlwP7n79RCcgn/JLokXFsnUpnx05UHP6RVl33P7Il6g
        4hptOvVLS4OLN4jQFGCRhzOPAoCGD/8pv5zIYMql8b8iiXXFOER6b4NanOhSp4VVAInUxI
        4gxC1VZY1CcHwX1O/BkltFe1DK9X8ZE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-rcyrE958ODmgO_pURC9TVg-1; Thu, 02 Jan 2020 01:29:21 -0500
X-MC-Unique: rcyrE958ODmgO_pURC9TVg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B549710054E3;
        Thu,  2 Jan 2020 06:29:19 +0000 (UTC)
Received: from [10.72.12.230] (ovpn-12-230.pek2.redhat.com [10.72.12.230])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A7B460BFB;
        Thu,  2 Jan 2020 06:28:59 +0000 (UTC)
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
 <f8b46502-a5a5-c5c6-88df-101dbfd02fda@redhat.com>
 <56703BDA-B7AE-4656-8061-85FD1A130597@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <16000124-bf6f-5762-845c-80514d1e6ea7@redhat.com>
Date:   Thu, 2 Jan 2020 14:28:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <56703BDA-B7AE-4656-8061-85FD1A130597@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/12/26 =E4=B8=8B=E5=8D=889:16, Liu, Jiang wrote:
>
>> On Dec 26, 2019, at 4:09 PM, Jason Wang <jasowang@redhat.com> wrote:
>>
>>
>> On 2019/12/25 =E4=B8=8B=E5=8D=8811:20, Liu, Jiang wrote:
>>>> On Dec 25, 2019, at 6:20 PM, Jason Wang <jasowang@redhat.com> wrote:
>>>>
>>>>
>>>> On 2019/12/25 =E4=B8=8A=E5=8D=8810:50, Zha Bin wrote:
>>>>> From: Liu Jiang <gerry@linux.alibaba.com>
>>>>>
>>>>> Userspace VMMs (e.g. Qemu microvm, Firecracker) take advantage of u=
sing
>>>>> virtio over mmio devices as a lightweight machine model for modern
>>>>> cloud. The standard virtio over MMIO transport layer only supports =
one
>>>>> legacy interrupt, which is much heavier than virtio over PCI transp=
ort
>>>>> layer using MSI. Legacy interrupt has long work path and causes spe=
cific
>>>>> VMExits in following cases, which would considerably slow down the
>>>>> performance:
>>>>>
>>>>> 1) read interrupt status register
>>>>> 2) update interrupt status register
>>>>> 3) write IOAPIC EOI register
>>>>>
>>>>> We proposed to update virtio over MMIO to version 3[1] to add the
>>>>> following new features and enhance the performance.
>>>>>
>>>>> 1) Support Message Signaled Interrupt(MSI), which increases the
>>>>>     interrupt performance for virtio multi-queue devices
>>>>> 2) Support per-queue doorbell, so the guest kernel may directly wri=
te
>>>>>     to the doorbells provided by virtio devices.
>>>>>
>>>>> The following is the network tcp_rr performance testing report, tes=
ted
>>>>> with virtio-pci device, vanilla virtio-mmio device and patched
>>>>> virtio-mmio device (run test 3 times for each case):
>>>>>
>>>>> 	netperf -t TCP_RR -H 192.168.1.36 -l 30 -- -r 32,1024
>>>>>
>>>>> 		Virtio-PCI    Virtio-MMIO   Virtio-MMIO(MSI)
>>>>> 	trans/s	    9536	6939		9500
>>>>> 	trans/s	    9734	7029		9749
>>>>> 	trans/s	    9894	7095		9318
>>>>>
>>>>> [1] https://lkml.org/lkml/2019/12/20/113
>>>> Thanks for the patch. Two questions after a quick glance:
>>>>
>>>> 1) In PCI we choose to support MSI-X instead of MSI for having extra=
 flexibility like alias, independent data and address (e.g for affinity) =
. Any reason for not start from MSI-X? E.g having MSI-X table and PBA (bo=
th of which looks pretty independent).
>>> Hi Jason,
>>> 	Thanks for reviewing patches on Christmas Day:)
>>> 	The PCI MSI-x has several advantages over PCI MSI, mainly
>>> 1) support 2048 vectors, much more than 32 vectors supported by MSI.
>>> 2) dedicated address/data for each vector,
>>> 3) per vector mask/pending bits.
>>> The proposed MMIO MSI extension supports both 1) and 2),
>>
>> Aha right, I mis-read the patch. But more questions comes:
>>
>> 1) The association between vq and MSI-X vector is fixed. This means it=
 can't work for a device that have more than 2047 queues. We probably nee=
d something similar to virtio-pci to allow a dynamic association.
> We have considered both the PCI MSI-x like dynamic association design a=
nd fix mapping design.
> The fix mapping design simplifies both the interrupt configuration proc=
ess and VMM implementations.


Well, for VMM just an indirection and for guest, it can choose to use=20
fixed mapping, just need to program once during probe.


> And the virtio mmio transport layer is mainly used by light VMMs to sup=
port small scale virtual machines,


Let's not limit the interface to be used by a specific case :).=20
Eliminating PCIE would be appealing for other scenarios.


>    2048 vectors should be enough for these usage cases.
> So the fix mapping design has been used.
>
>> 2) The mask and unmask control is missed
>>
>>
>>>   but the extension doesn=E2=80=99t support 3) because
>>> we noticed that the Linux virtio subsystem doesn=E2=80=99t really mak=
e use of interrupt masking/unmasking.
>>
>> Not directly used but masking/unmasking is widely used in irq subsyste=
m which allows lots of optimizations.
>>
>>
>>> On the other hand, we want to simplify VMM implementations as simple =
as possible, and mimicking the PCI MSI-x
>>> will cause some complexity to VMM implementations.
>>
>> I agree to simplify VMM implementation, but it looks to me introducing=
 masking/pending won't cost too much code in the VMM implementation. Just=
 new type of command for VIRTIO_MMIO_MSI_COMMAND.
> We want to make VMM implementations as simple as possible:)
> And based on following observations, we have disabled support of mask/u=
nmask,
> 1) MSI is edge triggering, which means it won=E2=80=99t be shared with =
other interrupt sources,


Is this true? I think the spec does not forbid such usages, e.g using=20
the same MSI address/command for different queues or devices?


> so masking/unmasking won=E2=80=99t be used for normal interrupt managem=
ent logic.
> 2) Linux virtio mmio transport layer doesn=E2=80=99t support  suspend/r=
esume yet, so there=E2=80=99s no need to quiesce the device by masking in=
terrupts.


Yes, but it's a limitation only for virtio mmio transport. We can add it.


> 3) The legacy PCI 2.2 devices doesn=E2=80=99t support irq masking/unmas=
king, so irq masking/unmasking may be optional operations.


Yes, but as you said, it helps for performance and some other cases. I=20
still prefer to implement that consider it is not complex. If we do MSI=20
without masking/unmasking, I suspect we will implement MSI-X finally=20
somedays then maintaining MSI will become a burden... (still takes=20
virtio-pci as an example, it choose to implement MSI-X not MSI).


> So we skipped support of irq masking/unmasking. We will recheck whether=
 irq masking/unmasking is mandatory for MMIO devices.
> On the other hand, we may enhance the spec to define command codes for =
masking/unmasking, and VMM may optionally support masking/unmasking.


Yes, thanks.


>
> Thanks,
> Gerry
>
>> Thanks
>>
>>
>>>> 2) It's better to split notify_multiplexer out of MSI support to eas=
e the reviewers (apply to spec patch as well)
>>> Great suggestion, we will try to split the patch.
>>>
>>> Thanks,
>>> Gerry
>>>
>>>> Thanks

