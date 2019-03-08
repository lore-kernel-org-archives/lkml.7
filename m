Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03222C10F09
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 08:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4BA920811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 08:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfCHIbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 03:31:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50694 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbfCHIbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 03:31:39 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E0B2310C6C;
        Fri,  8 Mar 2019 08:31:38 +0000 (UTC)
Received: from [10.72.12.27] (ovpn-12-27.pek2.redhat.com [10.72.12.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C3731611D1;
        Fri,  8 Mar 2019 08:31:31 +0000 (UTC)
Subject: Re: [RFC PATCH V2 5/5] vhost: access vq metadata through kernel
 virtual address
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterx@redhat.com, linux-mm@kvack.org, aarcange@redhat.com
References: <1551856692-3384-1-git-send-email-jasowang@redhat.com>
 <1551856692-3384-6-git-send-email-jasowang@redhat.com>
 <20190306092837-mutt-send-email-mst@kernel.org>
 <15105894-4ec1-1ed0-1976-7b68ed9eeeda@redhat.com>
 <20190307101708-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <92dfa6cc-a86c-0cef-6384-98aeb8b9e567@redhat.com>
Date:   Fri, 8 Mar 2019 16:31:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190307101708-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 08 Mar 2019 08:31:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/3/7 下午11:34, Michael S. Tsirkin wrote:
> On Thu, Mar 07, 2019 at 10:45:57AM +0800, Jason Wang wrote:
>> On 2019/3/7 上午12:31, Michael S. Tsirkin wrote:
>>>> +static void vhost_set_vmap_dirty(struct vhost_vmap *used)
>>>> +{
>>>> +	int i;
>>>> +
>>>> +	for (i = 0; i < used->npages; i++)
>>>> +		set_page_dirty_lock(used->pages[i]);
>>> This seems to rely on page lock to mark page dirty.
>>>
>>> Could it happen that page writeback will check the
>>> page, find it clean, and then you mark it dirty and then
>>> invalidate callback is called?
>>>
>>>
>> Yes. But does this break anything?
>> The page is still there, we just remove a
>> kernel mapping to it.
>>
>> Thanks
> Yes it's the same problem as e.g. RDMA:
> 	we've just marked the page as dirty without having buffers.
> 	Eventually writeback will find it and filesystem will complain...
> 	So if the pages are backed by a non-RAM-based filesystem, it’s all just broken.


Yes, we can't depend on the pages that might have been invalidated. As 
suggested, the only suitable place is the MMU notifier callbacks.

Thanks


> one can hope that RDMA guys will fix it in some way eventually.
> For now, maybe add a flag in e.g. VMA that says that there's no
> writeback so it's safe to mark page dirty at any point?
>
>
>
>
>
