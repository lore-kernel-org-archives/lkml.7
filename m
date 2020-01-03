Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C2DC3276F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 03:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A722C21D56
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 03:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QdzNEcdX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbgACDZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 22:25:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47614 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726136AbgACDZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 22:25:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578021907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5F0aOfir2KWwuaj3odF4OjIUjbycL5B7KWrBRc4wz5I=;
        b=QdzNEcdXT2ajuOnfvQEMe3l1qluhPJ+inQkFi1Pbqy2iZc/HwWBxA2iSB6xYm3zS2tXwOn
        nQ/RBNNXT9+jAMz+mM/8Noaw5yDWwBQAo66kQ6v9MwuUOyXgG/NPy1P+xnl6dYkBnGbN9y
        o/EH++a18J2GIeK+Fp8g9D/KtYUCDsc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-cjez0EyxOBGgMt5PJLXKoQ-1; Thu, 02 Jan 2020 22:25:05 -0500
X-MC-Unique: cjez0EyxOBGgMt5PJLXKoQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97ECA800D48;
        Fri,  3 Jan 2020 03:25:03 +0000 (UTC)
Received: from [10.72.12.42] (ovpn-12-42.pek2.redhat.com [10.72.12.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7ADC075750;
        Fri,  3 Jan 2020 03:24:55 +0000 (UTC)
Subject: Re: [virtio-dev] Re: [PATCH v1 2/2] virtio-mmio: add features for
 virtio-mmio specification version 3
To:     "Liu, Jing2" <jing2.liu@linux.intel.com>,
        Zha Bin <zhabin@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Cc:     mst@redhat.com, slp@redhat.com, virtio-dev@lists.oasis-open.org,
        gerry@linux.alibaba.com, jing2.liu@intel.com, chao.p.peng@intel.com
References: <cover.1577240905.git.zhabin@linux.alibaba.com>
 <a11d4c616158c9fb1ca4575ca0530b2e17b952fa.1577240905.git.zhabin@linux.alibaba.com>
 <85eeab19-1f53-6c45-95a2-44c1cfd39184@redhat.com>
 <28da67db-73ab-f772-fb00-5a471b746fc5@linux.intel.com>
 <683cac51-853d-c8c8-24c6-b01886978ca4@redhat.com>
 <42346d41-b758-967a-30b7-95aa0d383beb@linux.intel.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <0c3d33de-3940-7895-2fe2-81de8714139c@redhat.com>
Date:   Fri, 3 Jan 2020 11:24:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <42346d41-b758-967a-30b7-95aa0d383beb@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/1/2 =E4=B8=8B=E5=8D=885:13, Liu, Jing2 wrote:
> [...]
>
>>>>
>>>>> +
>>>>> +/* RO: MSI feature enabled mask */
>>>>> +#define VIRTIO_MMIO_MSI_ENABLE_MASK=C2=A0=C2=A0=C2=A0 0x8000
>>>>> +/* RO: Maximum queue size available */
>>>>> +#define VIRTIO_MMIO_MSI_STATUS_QMASK=C2=A0=C2=A0=C2=A0 0x07ff
>>>>> +/* Reserved */
>>>>> +#define VIRTIO_MMIO_MSI_STATUS_RESERVED=C2=A0=C2=A0=C2=A0 0x7800
>>>>> +
>>>>> +#define VIRTIO_MMIO_MSI_CMD_UPDATE=C2=A0=C2=A0=C2=A0 0x1
>>>>
>>>>
>>>> I believe we need a command to read the number of vectors supported=20
>>>> by the device, or 2048 is assumed to be a fixed size here?
>>>
>>> For not bringing much complexity, we proposed vector per queue and=20
>>> fixed relationship between events and vectors.
>>
>>
>> It's a about the number of MSIs not the mapping between queues to=20
>> MSIs.And it looks to me it won't bring obvious complexity, just need=20
>> a register to read the #MSIs. Device implementation may stick to a=20
>> fixed size.
>
> Based on that assumption, the device supports #MSIs =3D #queues +=20
> #config. Then driver need not read the register.
>
> We're trying to make such kind of agreement on spec level.


Ok, I get you now.

But still, having fixed number of MSIs is less flexible. E.g:

- for x86, processor can only deal with about 250 interrupt vectors.
- driver may choose to share MSI vectors [1] (which is not merged but we=20
will for sure need it)

[1] https://lkml.org/lkml/2014/12/25/169


>
>>
>> Having few pages for a device that only have one queue is kind of a=20
>> waste.
>
> Could I ask what's the meaning of few pages here? BTW, we didn't=20
> define MSIx-like tables for virtio-mmio.


I thought you're using a fixed size (2048) for each device. But looks not=
 :)

Thanks


>
> Thanks,
>
> Jing
>
>>
>> Thanks
>>
>>
>>>
>>>
>>> So the number of vectors supported by device is equal to the total=20
>>> number of vqs and config.
>>>
>>> We will try to explicitly highlight this point in spec for later=20
>>> version.
>>>
>>>
>>> Thanks!
>>>
>>> Jing
>>>
>>>>
>>>> --------------------------------------------------------------------=
-
>>>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>>>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.or=
g
>>>>
>>>
>>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>

