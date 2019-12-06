Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DA8C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 02:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C26C2077B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 02:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbfLFCEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 21:04:42 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:53122 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726109AbfLFCEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 21:04:42 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id ADCEB110BE5C4D92B220;
        Fri,  6 Dec 2019 10:04:38 +0800 (CST)
Received: from [127.0.0.1] (10.133.216.73) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Fri, 6 Dec 2019
 10:04:32 +0800
Subject: Re: firmware: dmi-sysfs: why is the access mode of dmi sysfs entries
 restricted to 0400?
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Mike Waychison <mikew@google.com>, <linux-kernel@vger.kernel.org>,
        wanghaibin 00208455 <wanghaibin.wang@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <42bb2db8-66e0-3df4-75b7-98b2b2bcfca8@huawei.com>
 <20191204074133.GA3548765@kroah.com>
 <dac22bed-f138-471e-c19a-e31c5c910d48@huawei.com>
 <20191204092942.GA3557583@kroah.com>
From:   Guoheyi <guoheyi@huawei.com>
Message-ID: <b75e2aac-e27c-8d26-36c7-6fb69b769bbd@huawei.com>
Date:   Fri, 6 Dec 2019 10:04:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191204092942.GA3557583@kroah.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.133.216.73]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2019/12/4 17:29, Greg Kroah-Hartman 写道:
> On Wed, Dec 04, 2019 at 05:01:06PM +0800, Guoheyi wrote:
>> 在 2019/12/4 15:41, Greg Kroah-Hartman 写道:
>>> On Wed, Dec 04, 2019 at 03:31:22PM +0800, Guoheyi wrote:
>>>> Hi,
>>>>
>>>> Why is the access mode of dmi sysfs entries restricted to 0400? Is it for
>>>> security concern? If it is, which information do we consider as privacy?
>>> There's lots of "interesting" information in dmi entries that you
>>> probably do not want all processes reading, which is why they are
>>> restricted.
>>>
>>>> We would like to fetch CPU information from non-root application, is there
>>>> feasible way to do that?
>>> What specific CPU information is not currently exported in /proc/cpuinfo
>>> that only shows up in DMI entries that you are interested in?
>> We'd like to get processor manufacturer, speed and version, and pass the
>> information to qemu virtual machine, for users of VM might be happy to see
>> this instead of "unknown xxx", while qemu may run as non-root.
> Careful about this as if you move that virtual machine around, those
> values will change and if userspace was depending on them being static
> (set up at program start time), then you might have problems.
>
> good luck!

The information will be used as VM DMI/SMBIOS as well, so it will be 
read only once during VM boot. I guess we will be OK :)

Thanks a lot.

Heyi

>
> greg k-h
>
> .

