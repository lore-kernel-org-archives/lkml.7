Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D79C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B01206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfLSKDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 05:03:36 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2209 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726609AbfLSKDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 05:03:36 -0500
Received: from lhreml709-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 966C17D17AC8464734A9;
        Thu, 19 Dec 2019 10:03:34 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml709-cah.china.huawei.com (10.201.108.32) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 19 Dec 2019 10:03:33 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 19 Dec
 2019 10:03:33 +0000
Subject: Re: Warnings in DRM code when removing/unbinding a driver
To:     Daniel Vetter <daniel@ffwll.ch>
CC:     Ezequiel Garcia <ezequiel@collabora.com>,
        "kongxinwei (A)" <kong.kongxinwei@hisilicon.com>,
        "Chenfeng (puck)" <puck.chen@hisilicon.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Linuxarm <linuxarm@huawei.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gerd Hoffmann <kraxel@redhat.com>, <dbueso@suse.de>
References: <07899bd5-e9a5-cff0-395f-b4fb3f0f7f6c@huawei.com>
 <f867543cf5d0fc3fdd0534749326411bcfc5e363.camel@collabora.com>
 <c2e5f5a5-5839-42a9-2140-903e99e166db@huawei.com>
 <fde72f73-d678-2b77-3950-d465f0afe904@huawei.com>
 <CAKMK7uFr03euoB6rY8z9zmRyznP41vwfdaKApZ_0HfYZT4Hq_w@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <fcca5732-c7dc-6e1d-dcbe-bfd914a4295b@huawei.com>
Date:   Thu, 19 Dec 2019 10:03:33 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAKMK7uFr03euoB6rY8z9zmRyznP41vwfdaKApZ_0HfYZT4Hq_w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.46]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/2019 09:54, Daniel Vetter wrote:
> On Wed, Dec 18, 2019 at 7:08 PM John Garry <john.garry@huawei.com> wrote:
>>
>> +
>>
>> So the v5.4 kernel does not have this issue.
>>
>> I have bisected the initial occurrence to:
>>
>> commit 37a48adfba6cf6e87df9ba8b75ab85d514ed86d8
>> Author: Thomas Zimmermann <tzimmermann@suse.de>
>> Date:   Fri Sep 6 14:20:53 2019 +0200
>>
>>       drm/vram: Add kmap ref-counting to GEM VRAM objects
>>
>>       The kmap and kunmap operations of GEM VRAM buffers can now be called
>>       in interleaving pairs. The first call to drm_gem_vram_kmap() maps the
>>       buffer's memory to kernel address space and the final call to
>>       drm_gem_vram_kunmap() unmaps the memory. Intermediate calls to these
>>       functions increment or decrement a reference counter.
>>
>> So this either exposes or creates the issue.
> 
> Yeah that's just shooting the messenger.

OK, so it exposes it.

  Like I said, for most drivers
> you can pretty much assume that their unload sequence has been broken
> since forever. It's not often tested, and especially the hotunbind
> from a device (as opposed to driver unload) stuff wasn't even possible
> to get right until just recently.

Do you think it's worth trying to fix this for 5.5 and earlier, or just 
switch to the device-managed interface for 5.6 and forget about 5.5 and 
earlier?

Thanks,
John
