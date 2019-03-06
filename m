Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE667C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA28B2087C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FMYDGQ/W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbfCFSdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:33:17 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35192 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728582AbfCFSdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:33:17 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x26IWsSL043085;
        Wed, 6 Mar 2019 12:32:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1551897175;
        bh=oBIn2LlCBeVvQa2EAXWKLEE2er0kFV9nytsYYqpmFao=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=FMYDGQ/WUUlnRuMsnJejWYP915h8ajK9udf1P1Ckko6414IXn8TogS+GU3MnNQeq6
         lVVhfyF4cDfYjZf6jZBjRCGbK/Y/3DgtEMeUVC5vcgEY2zEg5fWA7wDCprfmgTRbMW
         kJQ36cRIMUMF2Z8ubDEz/onDs51G+TiOuH1bwE/Y=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x26IWs7F094264
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Mar 2019 12:32:54 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 6
 Mar 2019 12:32:54 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 6 Mar 2019 12:32:54 -0600
Received: from [172.22.114.173] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x26IWrsb032111;
        Wed, 6 Mar 2019 12:32:53 -0600
Subject: Re: [RFC][PATCH 5/5 v2] kselftests: Add dma-heap test
To:     John Stultz <john.stultz@linaro.org>
CC:     Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
 <1551819273-640-6-git-send-email-john.stultz@linaro.org>
 <CA+M3ks6AUmmYbXscjTRo+Vr-6cV8okafsDn2Tg3tskvzrV_dbA@mail.gmail.com>
 <7deadc25-c8b2-3b58-1867-86f7db3188fa@ti.com>
 <CALAqxLU9aq6Qj1qJKQK=a5AbnLc1Hwxvb0nX9JemoW=29gDVoA@mail.gmail.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <5fbeb711-62f9-1619-cc50-15594713551f@ti.com>
Date:   Wed, 6 Mar 2019 12:32:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CALAqxLU9aq6Qj1qJKQK=a5AbnLc1Hwxvb0nX9JemoW=29gDVoA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/19 12:19 PM, John Stultz wrote:
> On Wed, Mar 6, 2019 at 10:15 AM Andrew F. Davis <afd@ti.com> wrote:
>>
>> On 3/6/19 10:14 AM, Benjamin Gaignard wrote:
>>> Le mar. 5 mars 2019 à 21:54, John Stultz <john.stultz@linaro.org> a écrit :
>>>>
>>>> Add very trivial allocation test for dma-heaps.
>>>>
>>>> TODO: Need to actually do some validation on
>>>> the returned dma-buf.
>>>>
>>>> Cc: Laura Abbott <labbott@redhat.com>
>>>> Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
>>>> Cc: Greg KH <gregkh@linuxfoundation.org>
>>>> Cc: Sumit Semwal <sumit.semwal@linaro.org>
>>>> Cc: Liam Mark <lmark@codeaurora.org>
>>>> Cc: Brian Starkey <Brian.Starkey@arm.com>
>>>> Cc: Andrew F. Davis <afd@ti.com>
>>>> Cc: Chenbo Feng <fengc@google.com>
>>>> Cc: Alistair Strachan <astrachan@google.com>
>>>> Cc: dri-devel@lists.freedesktop.org
>>>> Signed-off-by: John Stultz <john.stultz@linaro.org>
>>>> ---
>>>> v2: Switched to use reworked dma-heap apis
>>>> ---
>>>>  tools/testing/selftests/dmabuf-heaps/Makefile      | 11 +++
>>>>  tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c | 96 ++++++++++++++++++++++
>>>>  2 files changed, 107 insertions(+)
>>>>  create mode 100644 tools/testing/selftests/dmabuf-heaps/Makefile
>>>>  create mode 100644 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
>>>>
>>>> diff --git a/tools/testing/selftests/dmabuf-heaps/Makefile b/tools/testing/selftests/dmabuf-heaps/Makefile
>>>> new file mode 100644
>>>> index 0000000..c414ad3
>>>> --- /dev/null
>>>> +++ b/tools/testing/selftests/dmabuf-heaps/Makefile
>>>> @@ -0,0 +1,11 @@
>>>> +# SPDX-License-Identifier: GPL-2.0
>>>> +CFLAGS += -static -O3 -Wl,-no-as-needed -Wall
>>>> +#LDLIBS += -lrt -lpthread -lm
>>>> +
>>>> +# these are all "safe" tests that don't modify
>>>> +# system time or require escalated privileges
>>>> +TEST_GEN_PROGS = dmabuf-heap
>>>> +
>>>> +
>>>> +include ../lib.mk
>>>> +
>>>> diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
>>>> new file mode 100644
>>>> index 0000000..06837a4
>>>> --- /dev/null
>>>> +++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
>>>> @@ -0,0 +1,96 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +
>>>> +#include <dirent.h>
>>>> +#include <errno.h>
>>>> +#include <fcntl.h>
>>>> +#include <stdio.h>
>>>> +#include <string.h>
>>>> +#include <unistd.h>
>>>> +#include <sys/ioctl.h>
>>>> +#include <sys/mman.h>
>>>> +#include <sys/types.h>
>>>> +
>>>> +#include "../../../../include/uapi/linux/dma-heap.h"
>>>> +
>>>> +#define DEVPATH "/dev/dma_heap"
>>>> +
>>>> +int dmabuf_heap_open(char *name)
>>>> +{
>>>> +       int ret, fd;
>>>> +       char buf[256];
>>>> +
>>>> +       ret = sprintf(buf, "%s/%s", DEVPATH, name);
>>>> +       if (ret < 0) {
>>>> +               printf("sprintf failed!\n");
>>>> +               return ret;
>>>> +       }
>>>> +
>>>> +       fd = open(buf, O_RDWR);
>>>> +       if (fd < 0)
>>>> +               printf("open %s failed!\n", buf);
>>>> +       return fd;
>>>> +}
>>>> +
>>>> +int dmabuf_heap_alloc(int fd, size_t len, unsigned int flags, int *dmabuf_fd)
>>>> +{
>>>> +       struct dma_heap_allocation_data data = {
>>>> +               .len = len,
>>>> +               .flags = flags,
>>>> +       };
>>>> +       int ret;
>>>> +
>>>> +       if (dmabuf_fd == NULL)
>>>> +               return -EINVAL;
>>>> +
>>>> +       ret = ioctl(fd, DMA_HEAP_IOC_ALLOC, &data);
>>>> +       if (ret < 0)
>>>> +               return ret;
>>>> +       *dmabuf_fd = (int)data.fd;
>>>> +       return ret;
>>>> +}
>>>> +
>>>> +#define ONE_MEG (1024*1024)
>>>> +
>>>> +void do_test(char *heap_name)
>>>> +{
>>>> +       int heap_fd = -1, dmabuf_fd = -1;
>>>> +       int ret;
>>>> +
>>>> +       printf("Testing heap: %s\n", heap_name);
>>>> +
>>>> +       heap_fd = dmabuf_heap_open(heap_name);
>>>> +       if (heap_fd < 0)
>>>> +               return;
>>>> +
>>>> +       printf("Allocating 1 MEG\n");
>>>> +       ret = dmabuf_heap_alloc(heap_fd, ONE_MEG, 0, &dmabuf_fd);
>>>> +       if (ret)
>>>> +               goto out;
>>>> +
>>>> +       /* DO SOMETHING WITH THE DMABUF HERE? */
>>>
>>> You can do a call to mmap and write a pattern in the buffer.
>>>
>>
>> mmap is optional for DMA-BUFs, only attach/map are required. To test
>> those we would need a dummy device, so a test kernel module may be
>> needed to really exercise this.
>>
>> I have one I use for ION buffer testing, it consumes a DMA-BUF passed
>> from userspace, attach/maps it to a dummy device then return the
>> physical address of the first page of the buffer for validation. Might
>> be a good test, but dummy devices don't always have the proper dma
>> attributes set like a real device does, so it may also fail for some
>> otherwise valid buffers.
> 
> Cool! Do you mind sharing that? I might try to rework and integrate it
> into this patchset?
> 

Sure, top two patches here:

> https://git.ti.com/ti-analog-linux-kernel/afd-analog/commits/dma-buf-to-phys

Andrew

> thanks
> -john
> 
