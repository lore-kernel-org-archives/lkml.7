Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0725C10F00
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 02:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80ACB20854
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 02:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfCGCnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 21:43:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54142 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726597AbfCGCnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 21:43:04 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BE5C5308FB8A;
        Thu,  7 Mar 2019 02:43:03 +0000 (UTC)
Received: from [10.72.12.83] (ovpn-12-83.pek2.redhat.com [10.72.12.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F0E06608C1;
        Thu,  7 Mar 2019 02:42:51 +0000 (UTC)
Subject: Re: [RFC PATCH V2 4/5] vhost: introduce helpers to get the size of
 metadata area
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterx@redhat.com,
        Linux-MM <linux-mm@kvack.org>, aarcange@redhat.com
References: <1551856692-3384-1-git-send-email-jasowang@redhat.com>
 <1551856692-3384-5-git-send-email-jasowang@redhat.com>
 <CAFqt6zYynfCn_SG6w98dHMA5rS6euPb+ihXtQcALE47K0LQb7g@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <035c74bb-71eb-71db-f5f5-ed9d1a12d733@redhat.com>
Date:   Thu, 7 Mar 2019 10:42:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAFqt6zYynfCn_SG6w98dHMA5rS6euPb+ihXtQcALE47K0LQb7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 07 Mar 2019 02:43:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/3/7 上午2:43, Souptick Joarder wrote:
> On Wed, Mar 6, 2019 at 12:48 PM Jason Wang <jasowang@redhat.com> wrote:
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
> Is the change log left with any particular reason ?


Nope, will add the log.

Thanks


>> ---
>>   drivers/vhost/vhost.c | 46 ++++++++++++++++++++++++++++------------------
>>   1 file changed, 28 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> index 2025543..1015464 100644
>> --- a/drivers/vhost/vhost.c
>> +++ b/drivers/vhost/vhost.c
>> @@ -413,6 +413,27 @@ static void vhost_dev_free_iovecs(struct vhost_dev *dev)
>>                  vhost_vq_free_iovecs(dev->vqs[i]);
>>   }
>>
>> +static size_t vhost_get_avail_size(struct vhost_virtqueue *vq, int num)
>> +{
>> +       size_t event = vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
>> +
>> +       return sizeof(*vq->avail) +
>> +              sizeof(*vq->avail->ring) * num + event;
>> +}
>> +
>> +static size_t vhost_get_used_size(struct vhost_virtqueue *vq, int num)
>> +{
>> +       size_t event = vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
>> +
>> +       return sizeof(*vq->used) +
>> +              sizeof(*vq->used->ring) * num + event;
>> +}
>> +
>> +static size_t vhost_get_desc_size(struct vhost_virtqueue *vq, int num)
>> +{
>> +       return sizeof(*vq->desc) * num;
>> +}
>> +
>>   void vhost_dev_init(struct vhost_dev *dev,
>>                      struct vhost_virtqueue **vqs, int nvqs, int iov_limit)
>>   {
>> @@ -1253,13 +1274,9 @@ static bool vq_access_ok(struct vhost_virtqueue *vq, unsigned int num,
>>                           struct vring_used __user *used)
>>
>>   {
>> -       size_t s = vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
>> -
>> -       return access_ok(desc, num * sizeof *desc) &&
>> -              access_ok(avail,
>> -                        sizeof *avail + num * sizeof *avail->ring + s) &&
>> -              access_ok(used,
>> -                       sizeof *used + num * sizeof *used->ring + s);
>> +       return access_ok(desc, vhost_get_desc_size(vq, num)) &&
>> +              access_ok(avail, vhost_get_avail_size(vq, num)) &&
>> +              access_ok(used, vhost_get_used_size(vq, num));
>>   }
>>
>>   static void vhost_vq_meta_update(struct vhost_virtqueue *vq,
>> @@ -1311,22 +1328,18 @@ static bool iotlb_access_ok(struct vhost_virtqueue *vq,
>>
>>   int vq_meta_prefetch(struct vhost_virtqueue *vq)
>>   {
>> -       size_t s = vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
>>          unsigned int num = vq->num;
>>
>>          if (!vq->iotlb)
>>                  return 1;
>>
>>          return iotlb_access_ok(vq, VHOST_ACCESS_RO, (u64)(uintptr_t)vq->desc,
>> -                              num * sizeof(*vq->desc), VHOST_ADDR_DESC) &&
>> +                              vhost_get_desc_size(vq, num), VHOST_ADDR_DESC) &&
>>                 iotlb_access_ok(vq, VHOST_ACCESS_RO, (u64)(uintptr_t)vq->avail,
>> -                              sizeof *vq->avail +
>> -                              num * sizeof(*vq->avail->ring) + s,
>> +                              vhost_get_avail_size(vq, num),
>>                                 VHOST_ADDR_AVAIL) &&
>>                 iotlb_access_ok(vq, VHOST_ACCESS_WO, (u64)(uintptr_t)vq->used,
>> -                              sizeof *vq->used +
>> -                              num * sizeof(*vq->used->ring) + s,
>> -                              VHOST_ADDR_USED);
>> +                              vhost_get_used_size(vq, num), VHOST_ADDR_USED);
>>   }
>>   EXPORT_SYMBOL_GPL(vq_meta_prefetch);
>>
>> @@ -1343,13 +1356,10 @@ bool vhost_log_access_ok(struct vhost_dev *dev)
>>   static bool vq_log_access_ok(struct vhost_virtqueue *vq,
>>                               void __user *log_base)
>>   {
>> -       size_t s = vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
>> -
>>          return vq_memory_access_ok(log_base, vq->umem,
>>                                     vhost_has_feature(vq, VHOST_F_LOG_ALL)) &&
>>                  (!vq->log_used || log_access_ok(log_base, vq->log_addr,
>> -                                       sizeof *vq->used +
>> -                                       vq->num * sizeof *vq->used->ring + s));
>> +                                 vhost_get_used_size(vq, vq->num)));
>>   }
>>
>>   /* Can we start vq? */
>> --
>> 1.8.3.1
>>
