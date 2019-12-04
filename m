Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4ADC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 09:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B120205ED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 09:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfLDJBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 04:01:16 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7631 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726166AbfLDJBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 04:01:16 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5852DDA47E66650A345A;
        Wed,  4 Dec 2019 17:01:13 +0800 (CST)
Received: from [127.0.0.1] (10.133.216.73) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Wed, 4 Dec 2019
 17:01:07 +0800
Subject: Re: firmware: dmi-sysfs: why is the access mode of dmi sysfs entries
 restricted to 0400?
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Mike Waychison <mikew@google.com>, <linux-kernel@vger.kernel.org>,
        wanghaibin 00208455 <wanghaibin.wang@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <42bb2db8-66e0-3df4-75b7-98b2b2bcfca8@huawei.com>
 <20191204074133.GA3548765@kroah.com>
From:   Guoheyi <guoheyi@huawei.com>
Message-ID: <dac22bed-f138-471e-c19a-e31c5c910d48@huawei.com>
Date:   Wed, 4 Dec 2019 17:01:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191204074133.GA3548765@kroah.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.133.216.73]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2019/12/4 15:41, Greg Kroah-Hartman Ð´µÀ:
> On Wed, Dec 04, 2019 at 03:31:22PM +0800, Guoheyi wrote:
>> Hi,
>>
>> Why is the access mode of dmi sysfs entries restricted to 0400? Is it for
>> security concern? If it is, which information do we consider as privacy?
> There's lots of "interesting" information in dmi entries that you
> probably do not want all processes reading, which is why they are
> restricted.
>
>> We would like to fetch CPU information from non-root application, is there
>> feasible way to do that?
> What specific CPU information is not currently exported in /proc/cpuinfo
> that only shows up in DMI entries that you are interested in?

We'd like to get processor manufacturer, speed and version, and pass the 
information to qemu virtual machine, for users of VM might be happy to 
see this instead of "unknown xxx", while qemu may run as non-root.

>
> You can always have root change the permissions of a sysfs file if you
> have a service that wants to allow non-root programs to read specific
> entries.

Thanks; we'll try it.

Heyi

>
> thanks,
>
> greg k-h
>
> .

