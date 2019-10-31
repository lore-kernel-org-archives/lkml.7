Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDB3CA9ECF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 18:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4DB22086D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 18:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbfJaSfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 14:35:36 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2066 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729027AbfJaSfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 14:35:36 -0400
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id C07284C866CE3C346440;
        Thu, 31 Oct 2019 18:35:34 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml702-cah.china.huawei.com (10.201.108.43) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 31 Oct 2019 18:35:34 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 31 Oct
 2019 18:35:34 +0000
Subject: Re: [PATCH] libata: Ensure ata_port probe has completed before detach
To:     Jens Axboe <axboe@kernel.dk>
CC:     <linux-ide@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>
References: <1571221192-216909-1-git-send-email-john.garry@huawei.com>
 <da5e9c14-a183-70b5-022d-7b107447b1fd@kernel.dk>
From:   John Garry <john.garry@huawei.com>
Message-ID: <cfef4358-aa4c-6d21-1838-5ae2695fab87@huawei.com>
Date:   Thu, 31 Oct 2019 18:35:33 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <da5e9c14-a183-70b5-022d-7b107447b1fd@kernel.dk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml716-chm.china.huawei.com (10.201.108.67) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/2019 20:09, Jens Axboe wrote:
> On 10/16/19 4:19 AM, John Garry wrote:
>> With CONFIG_DEBUG_TEST_DRIVER_REMOVE set, we may find the following WARN:
>>
>> [   23.452574] ------------[ cut here ]------------
>> [   23.457190] WARNING: CPU: 59 PID: 1 at drivers/ata/libata-core.c:6676 ata_host_detach+0x15c/0x168
>> [   23.466047] Modules linked in:
>> [   23.469092] CPU: 59 PID: 1 Comm: swapper/0 Not tainted 5.4.0-rc1-00010-g5b83fd27752b-dirty #296
>> [   23.477776] Hardware name: Huawei D06 /D06, BIOS Hisilicon D06 UEFI RC0 - V1.16.01 03/15/2019
>> [   23.486286] pstate: a0c00009 (NzCv daif +PAN +UAO)
>> [   23.491065] pc : ata_host_detach+0x15c/0x168
>> [   23.495322] lr : ata_host_detach+0x88/0x168
>> [   23.499491] sp : ffff800011cabb50
>> [   23.502792] x29: ffff800011cabb50 x28: 0000000000000007
>> [   23.508091] x27: ffff80001137f068 x26: ffff8000112c0c28
>> [   23.513390] x25: 0000000000003848 x24: ffff0023ea185300
>> [   23.518689] x23: 0000000000000001 x22: 00000000000014c0
>> [   23.523987] x21: 0000000000013740 x20: ffff0023bdc20000
>> [   23.529286] x19: 0000000000000000 x18: 0000000000000004
>> [   23.534584] x17: 0000000000000001 x16: 00000000000000f0
>> [   23.539883] x15: ffff0023eac13790 x14: ffff0023eb76c408
>> [   23.545181] x13: 0000000000000000 x12: ffff0023eac13790
>> [   23.550480] x11: ffff0023eb76c228 x10: 0000000000000000
>> [   23.555779] x9 : ffff0023eac13798 x8 : 0000000040000000
>> [   23.561077] x7 : 0000000000000002 x6 : 0000000000000001
>> [   23.566376] x5 : 0000000000000002 x4 : 0000000000000000
>> [   23.571674] x3 : ffff0023bf08a0bc x2 : 0000000000000000
>> [   23.576972] x1 : 3099674201f72700 x0 : 0000000000400284
>> [   23.582272] Call trace:
>> [   23.584706]  ata_host_detach+0x15c/0x168
>> [   23.588616]  ata_pci_remove_one+0x10/0x18
>> [   23.592615]  ahci_remove_one+0x20/0x40
>> [   23.596356]  pci_device_remove+0x3c/0xe0
>> [   23.600267]  really_probe+0xdc/0x3e0
>> [   23.603830]  driver_probe_device+0x58/0x100
>> [   23.608000]  device_driver_attach+0x6c/0x90
>> [   23.612169]  __driver_attach+0x84/0xc8
>> [   23.615908]  bus_for_each_dev+0x74/0xc8
>> [   23.619730]  driver_attach+0x20/0x28
>> [   23.623292]  bus_add_driver+0x148/0x1f0
>> [   23.627115]  driver_register+0x60/0x110
>> [   23.630938]  __pci_register_driver+0x40/0x48
>> [   23.635199]  ahci_pci_driver_init+0x20/0x28
>> [   23.639372]  do_one_initcall+0x5c/0x1b0
>> [   23.643199]  kernel_init_freeable+0x1a4/0x24c
>> [   23.647546]  kernel_init+0x10/0x108
>> [   23.651023]  ret_from_fork+0x10/0x18
>> [   23.654590] ---[ end trace 634a14b675b71c13 ]---
>>
>> With KASAN also enabled, we may also get many use-after-free reports.
>>
>> The issue is that when CONFIG_DEBUG_TEST_DRIVER_REMOVE is set, we may
>> attempt to detach the ata_port before it has been probed.
>>
>> This is because the ata_ports are async probed, meaning that there is no
>> guarantee that the ata_port has probed prior to detach. When the ata_port
>> does probe in this scenario, we get all sorts of issues as the detach may
>> have already happened.
>>
>> Fix by ensuring synchronisation with async_synchronize_full(). We could
>> alternatively use the cookie returned from the ata_port probe
>> async_schedule() call, but that means managing the cookie, so more
>> complicated.
>>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> ---
>> Note: This has only been boot tested and manual driver remove/add.
>>            My system has no disk attached to the ahci host.
>>
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index 28c492be0a57..74c9b3032d46 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -6708,6 +6708,9 @@ void ata_host_detach(struct ata_host *host)
>>    {
>>    	int i;
>>    
>> +	/* Ensure ata_port probe has completed */
>> +	async_synchronize_full();
>> +
>>    	for (i = 0; i < host->n_ports; i++)
>>    		ata_port_detach(host->ports[i]);
>>    
>>
> 
> Nice debugging, and the fix looks appropriate to me. I don't think
> there's any point in trying to individually synchronize cookies.
> I'll let this simmer on the list for a day or two to let other folks
> take a look at it, before queuing it up.
> 

Hi Jens,

FWIW, I did also now test this on qemu with an emulated disk and it was ok.

Anyway, I don't mind if prefer to queue this early for 5.6 so it can sit 
on next for longer.

Cheers,
John


