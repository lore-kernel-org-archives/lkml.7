Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EAEC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 03:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14C9620835
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 03:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbfI0D12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 23:27:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38514 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbfI0D11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 23:27:27 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 890AE58;
        Fri, 27 Sep 2019 03:27:27 +0000 (UTC)
Received: from [10.72.12.160] (ovpn-12-160.pek2.redhat.com [10.72.12.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B8DEF60BE2;
        Fri, 27 Sep 2019 03:27:14 +0000 (UTC)
Subject: Re: [PATCH] vhost: introduce mdev based hardware backend
To:     Tiwei Bie <tiwei.bie@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     alex.williamson@redhat.com, maxime.coquelin@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        dan.daly@intel.com, cunming.liang@intel.com,
        zhihong.wang@intel.com, lingshan.zhu@intel.com
References: <20190926045427.4973-1-tiwei.bie@intel.com>
 <20190926042156-mutt-send-email-mst@kernel.org> <20190926131439.GA11652@___>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <8ab5a8d9-284d-bba5-803d-08523c0814e1@redhat.com>
Date:   Fri, 27 Sep 2019 11:27:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190926131439.GA11652@___>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 27 Sep 2019 03:27:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/9/26 下午9:14, Tiwei Bie wrote:
> On Thu, Sep 26, 2019 at 04:35:18AM -0400, Michael S. Tsirkin wrote:
>> On Thu, Sep 26, 2019 at 12:54:27PM +0800, Tiwei Bie wrote:
> [...]
>>> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
>>> index 40d028eed645..5afbc2f08fa3 100644
>>> --- a/include/uapi/linux/vhost.h
>>> +++ b/include/uapi/linux/vhost.h
>>> @@ -116,4 +116,12 @@
>>>   #define VHOST_VSOCK_SET_GUEST_CID	_IOW(VHOST_VIRTIO, 0x60, __u64)
>>>   #define VHOST_VSOCK_SET_RUNNING		_IOW(VHOST_VIRTIO, 0x61, int)
>>>   
>>> +/* VHOST_MDEV specific defines */
>>> +
>>> +#define VHOST_MDEV_SET_STATE	_IOW(VHOST_VIRTIO, 0x70, __u64)
>>> +
>>> +#define VHOST_MDEV_S_STOPPED	0
>>> +#define VHOST_MDEV_S_RUNNING	1
>>> +#define VHOST_MDEV_S_MAX	2
>>> +
>>>   #endif
>> So assuming we have an underlying device that behaves like virtio:
> I think they are really good questions/suggestions. Thanks!
>
>> 1. Should we use SET_STATUS maybe?
> I like this idea. I will give it a try.
>
>> 2. Do we want a reset ioctl?
> I think it is helpful. If we use SET_STATUS, maybe we
> can use it to support the reset.
>
>> 3. Do we want ability to enable rings individually?
> I will make it possible at least in the vhost layer.


Note the API support e.g set_vq_ready().


>
>> 4. Does device need to limit max ring size?
>> 5. Does device need to limit max number of queues?
> I think so. It's helpful to have ioctls to report the max
> ring size and max number of queues.


An issue is the max number of queues is done through a device specific 
way, usually device configuration space. This is supported by the 
transport API, but how to expose it to userspace may need more thought.

Thanks


>
> Thanks!
