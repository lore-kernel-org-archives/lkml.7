Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC5AC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 02:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DD5E20854
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 02:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfCGCkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 21:40:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51674 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726715AbfCGCkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 21:40:32 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 219EE356E5;
        Thu,  7 Mar 2019 02:40:32 +0000 (UTC)
Received: from [10.72.12.83] (ovpn-12-83.pek2.redhat.com [10.72.12.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4D61960C1B;
        Thu,  7 Mar 2019 02:40:21 +0000 (UTC)
Subject: Re: [RFC PATCH V2 4/5] vhost: introduce helpers to get the size of
 metadata area
To:     Christophe de Dinechin <christophe.de.dinechin@gmail.com>
Cc:     mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterx@redhat.com,
        linux-mm@kvack.org, aarcange@redhat.com
References: <1551856692-3384-1-git-send-email-jasowang@redhat.com>
 <1551856692-3384-5-git-send-email-jasowang@redhat.com>
 <608E47C2-5130-41DE-9D52-02807EBCDD43@dinechin.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <f61076eb-93ec-b924-2ad9-96af0df45830@redhat.com>
Date:   Thu, 7 Mar 2019 10:40:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <608E47C2-5130-41DE-9D52-02807EBCDD43@dinechin.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 07 Mar 2019 02:40:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/3/6 下午6:56, Christophe de Dinechin wrote:
>> On 6 Mar 2019, at 08:18, Jason Wang<jasowang@redhat.com>  wrote:
>>
>> Signed-off-by: Jason Wang<jasowang@redhat.com>
>> ---
>> drivers/vhost/vhost.c | 46 ++++++++++++++++++++++++++++------------------
>> 1 file changed, 28 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> index 2025543..1015464 100644
>> --- a/drivers/vhost/vhost.c
>> +++ b/drivers/vhost/vhost.c
>> @@ -413,6 +413,27 @@ static void vhost_dev_free_iovecs(struct vhost_dev *dev)
>> 		vhost_vq_free_iovecs(dev->vqs[i]);
>> }
>>
>> +static size_t vhost_get_avail_size(struct vhost_virtqueue *vq, int num)
> Nit: Any reason not to make `num` unsigned or size_t?
>

Let me use unsigned int to match the definition of vq->num.

Thanks


