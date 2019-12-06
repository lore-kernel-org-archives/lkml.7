Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37100C2BD09
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 17:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA3E2245C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 17:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfLFRma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 12:42:30 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2164 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726287AbfLFRm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 12:42:29 -0500
Received: from lhreml707-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id D1B54F1A6E5362091C9C;
        Fri,  6 Dec 2019 17:42:27 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml707-cah.china.huawei.com (10.201.108.48) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 6 Dec 2019 17:42:27 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Fri, 6 Dec 2019
 17:42:27 +0000
From:   John Garry <john.garry@huawei.com>
Subject: warning from device_links_supplier_sync_state_resume()
To:     <frowand.list@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        "Saravana Kannan" <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Message-ID: <7cb0ca10-8fb2-0cc8-224b-f5f908984998@huawei.com>
Date:   Fri, 6 Dec 2019 17:42:26 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.46]
X-ClientProxiedBy: lhreml702-chm.china.huawei.com (10.201.108.51) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm testing my arm64 system on Linus' master branch at recent commit 
b0d4beaa5a4b.

This system is ACPI based, but I notice that when CONFIG_OF_UNITTEST=y 
(don't ask why...), I get this:

[   18.344208] ------------[ cut here ]------------
[   18.348813] Unmatched sync_state pause/resume!
[   18.348833] WARNING: CPU: 1 PID: 1 at drivers/base/core.c:786 
device_links_supplier_sync_state_resume+0xf8/0x108
[   18.363419] Modules linked in:
[   18.366461] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 
5.4.0-12941-gb0d4beaa5a4b-dirty #683
[   18.374710] Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon 
D05 IT21 Nemo 2.0 RC0 04/18/2018
[   18.383828] pstate: 60000005 (nZCv daif -PAN -UAO)
[   18.388606] pc : device_links_supplier_sync_state_resume+0xf8/0x108
[   18.394858] lr : device_links_supplier_sync_state_resume+0xf8/0x108
[   18.401110] sp : ffff800011c7bd40
[   18.404411] x29: ffff800011c7bd40 x28: 0000000000000008
[   18.409709] x27: ffff80001140e070 x26: ffff80001133b7e8
[   18.415007] x25: ffff800011a56000 x24: ffff800011a56000
[   18.420305] x23: ffff041fa7798000 x22: ffff8000119f0000
[   18.425603] x21: ffff800011879000 x20: ffff800011c7bd88
[   18.430900] x19: ffff8000119f06b0 x18: ffffffffffffffff
[   18.436198] x17: fffffdfffe608a5b x16: 0000000000001400
[   18.441496] x15: ffff8000118798c8 x14: ffff800091c7b9e7
[   18.446793] x13: ffff800011c7b9f5 x12: ffff800011891000
[   18.452091] x11: 0000000005f5e0ff x10: ffff80001187a120
[   18.457389] x9 : ffff800011c7bd40 x8 : 7561702065746174
[   18.462687] x7 : 735f636e79732064 x6 : ffff800011a616b2
[   18.467985] x5 : 0000000000000000 x4 : 0000000000000000
[   18.473283] x3 : 00000000ffffffff x2 : ffff801feaa06000
[   18.478581] x1 : 51ddef120d2f0500 x0 : 0000000000000000
[   18.483880] Call trace:
[   18.486313]  device_links_supplier_sync_state_resume+0xf8/0x108
[   18.492221]  of_platform_sync_state_init+0x18/0x2c
[   18.497000]  do_one_initcall+0x5c/0x1b0
[   18.500824]  kernel_init_freeable+0x1a0/0x248
[   18.505168]  kernel_init+0x10/0x108
[   18.508644]  ret_from_fork+0x10/0x18
[   18.512205] ---[ end trace b280eee6dfb144c3 ]---

It seems the check of_have_populated_dt() is not always the best test 
for this device links state resume call.

Thanks,
John


