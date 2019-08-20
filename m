Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629A4C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 04:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 347D3216F4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 04:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbfHTED7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 00:03:59 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:57177 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726535AbfHTED6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 00:03:58 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=luoben@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TZyVkOR_1566273830;
Received: from bn0418deMacBook-Pro.local(mailfrom:luoben@linux.alibaba.com fp:SMTPD_---0TZyVkOR_1566273830)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 20 Aug 2019 12:03:51 +0800
Subject: Re: [PATCH v3 0/3] genirq/vfio: Introduce update_irq_devid and
 optimize VFIO irq ops
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        tao.ma@linux.alibaba.com, gerry@linux.alibaba.com,
        nanhai.zou@linux.alibaba.com, linyunsheng@huawei.com
References: <cover.1565857737.git.luoben@linux.alibaba.com>
 <20190819145150.2d30669b@x1.home>
From:   luoben <luoben@linux.alibaba.com>
Message-ID: <a1a8f8bc-07c0-2304-8550-7c302704fa4e@linux.alibaba.com>
Date:   Tue, 20 Aug 2019 12:03:50 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819145150.2d30669b@x1.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2019/8/20 上午4:51, Alex Williamson 写道:
> On Thu, 15 Aug 2019 21:02:58 +0800
> Ben Luo <luoben@linux.alibaba.com> wrote:
>
>> Currently, VFIO takes a lot of free-then-request-irq actions whenever
>> a VM (with device passthru via VFIO) sets irq affinity or mask/unmask
>> irq. Those actions only change the cookie data of irqaction or even
>> change nothing. The free-then-request-irq not only adds more latency,
>> but also increases the risk of losing interrupt, which may lead to a
>> VM hung forever in waiting for IO completion
> What guest environment is generating this?  Typically I don't see that
> Windows or Linux guests bounce the interrupt configuration much.
> Thanks,
>
> Alex

By tracing centos5u8 on host, I found it keep masking and unmasking 
interrupt like this:

[1566032533709879] index:28 irte_hi:000000010004a601 
irte_lo:adb54bc000b98001
[1566032533711242] index:28 irte_hi:0000000000000000 
irte_lo:0000000000000000
[1566032533711258] index:28 irte_hi:000000000004a601 
irte_lo:00003fff00ac002d
[1566032533711269] index:28 irte_hi:000000000004a601 
irte_lo:00003fff00ac002d
[1566032533711291] index:28 irte_hi:000000000004a601 
irte_lo:00003fff00ac002d
[1566032533711321] index:28 irte_hi:0000000000000000 
irte_lo:0000000000000000
[1566032533711340] index:28 irte_hi:000000000004a601 
irte_lo:00003fff00ac002d
[1566032533711361] index:28 irte_hi:000000000004a601 
irte_lo:00003fff00ac002d
[1566032533711376] index:28 irte_hi:000000010004a601 
irte_lo:adb54bc000b98001
[1566032533713368] index:28 irte_hi:0000000000000000 
irte_lo:0000000000000000
[1566032533713385] index:28 irte_hi:000000000004a601 
irte_lo:00003fff00ac002d
[1566032533713396] index:28 irte_hi:000000000004a601 
irte_lo:00003fff00ac002d
[1566032533713416] index:28 irte_hi:000000000004a601 
irte_lo:00003fff00ac002d
[1566032533713447] index:28 irte_hi:0000000000000000 
irte_lo:0000000000000000
[1566032533713464] index:28 irte_hi:000000000004a601 
irte_lo:00003fff00ac002d
[1566032533713485] index:28 irte_hi:000000000004a601 
irte_lo:00003fff00ac002d
[1566032533713499] index:28 irte_hi:000000010004a601 
irte_lo:adb54bc000b98001
[1566032533718855] index:28 irte_hi:0000000000000000 
irte_lo:0000000000000000
[1566032533718871] index:28 irte_hi:000000000004a601 
irte_lo:00003fff00ac002d
[1566032533718882] index:28 irte_hi:000000000004a601 
irte_lo:00003fff00ac002d
[1566032533718902] index:28 irte_hi:000000000004a601 
irte_lo:00003fff00ac002d
[1566032533718932] index:28 irte_hi:0000000000000000 
irte_lo:0000000000000000
[1566032533718949] index:28 irte_hi:000000000004a601 
irte_lo:00003fff00ac002d
[1566032533718969] index:28 irte_hi:000000000004a601 
irte_lo:00003fff00ac002d
[1566032533718984] index:28 irte_hi:000000010004a601 
irte_lo:adb54bc000b98001
[1566032533719873] index:28 irte_hi:0000000000000000 
irte_lo:0000000000000000
[1566032533719889] index:28 irte_hi:000000000004a601 
irte_lo:00003fff00ac002d
[1566032533719900] index:28 irte_hi:000000000004a601 
irte_lo:00003fff00ac002d
[1566032533719921] index:28 irte_hi:000000000004a601 
irte_lo:00003fff00ac002d
[1566032533719954] index:28 irte_hi:0000000000000000 
irte_lo:0000000000000000
[1566032533719971] index:28 irte_hi:000000000004a601 
irte_lo:00003fff00ac002d
[1566032533719992] index:28 irte_hi:000000000004a601 
irte_lo:00003fff00ac002d
[1566032533720007] index:28 irte_hi:000000010004a601 
irte_lo:adb54bc000b98001

"[1566032533720007]" is timestamp in μs, so centos5u8 tiggers 30+ irte 
modification within 10ms

Thanks,

     Ben

>> This patchset solved the issue by:
>> Patch 2 introduces update_irq_devid to only update dev_id of irqaction
>> Patch 3 make use of update_irq_devid and optimize irq operations in VFIO
>>
>> changes from v2:
>>   - reformat to avoid quoted string split across lines and etc.
>>
>> changes from v1:
>>   - add Patch 1 to enhance error recovery etc. in free irq per tglx's comments
>>   - enhance error recovery code and debugging info in update_irq_devid
>>   - use __must_check in external referencing of update_irq_devid
>>   - use EXPORT_SYMBOL_GPL for update_irq_devid
>>   - reformat code of patch 3 for better readability
>>
>> Ben Luo (3):
>>    genirq: enhance error recovery code in free irq
>>    genirq: introduce update_irq_devid()
>>    vfio_pci: make use of update_irq_devid and optimize irq ops
>>
>>   drivers/vfio/pci/vfio_pci_intrs.c | 101 +++++++++++++++++++++-------------
>>   include/linux/interrupt.h         |   3 ++
>>   kernel/irq/manage.c               | 110 +++++++++++++++++++++++++++++++++-----
>>   3 files changed, 164 insertions(+), 50 deletions(-)
>>
