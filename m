Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04DCC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0CA220823
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731218AbfCYMvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 08:51:44 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:6417 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731088AbfCYMvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 08:51:44 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2PCkklf030769;
        Mon, 25 Mar 2019 13:51:19 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rddht3r4v-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 25 Mar 2019 13:51:19 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8AAE53A;
        Mon, 25 Mar 2019 12:51:18 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 62ED5571E;
        Mon, 25 Mar 2019 12:51:18 +0000 (GMT)
Received: from [10.48.0.167] (10.75.127.49) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 25 Mar
 2019 13:51:17 +0100
Subject: Re: [RFC PATCH] iio: core: fix a possible circular locking dependency
To:     Jonathan Cameron <jic23@kernel.org>
CC:     <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
References: <1553262846-23126-1-git-send-email-fabrice.gasnier@st.com>
 <20190324154704.277327e2@archlinux>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <123b5f03-e1cc-a8a8-9bba-b92fa14e9aec@st.com>
Date:   Mon, 25 Mar 2019 13:51:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190324154704.277327e2@archlinux>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG4NODE1.st.com (10.75.127.10) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-25_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/19 4:47 PM, Jonathan Cameron wrote:
> On Fri, 22 Mar 2019 14:54:06 +0100
> Fabrice Gasnier <fabrice.gasnier@st.com> wrote:
> 
>> This fixes a possible circular locking dependency detected warning seen
>> with:
>> - CONFIG_PROVE_LOCKING=y
>> - consumer/provider IIO devices (ex: "voltage-divider" consumer of "adc")
>>
>> When using the IIO consumer interface, e.g. iio_channel_get(),
>> the consumer device will likely call iio_read_channel_raw() or similar that
>> rely on 'info_exist_lock' mutex.
>>
>> typically:
>> ...
>> 	mutex_lock(&chan->indio_dev->info_exist_lock);
>> 	if (chan->indio_dev->info == NULL) {
>> 		ret = -ENODEV;
>> 		goto err_unlock;
>> 	}
>> 	ret = do_some_ops()
>> err_unlock:
>> 	mutex_unlock(&chan->indio_dev->info_exist_lock);
>> 	return ret;
>> ...
>>
>> Same mutex is also hold in iio_device_unregister().
>>
>> The following deadlock warning happens when:
>> - the consumer device has called an API like iio_read_channel_raw()
>>   at least once.
>> - the consumer driver is unregistered, removed (unbind from sysfs)
>>
>> ======================================================
>> WARNING: possible circular locking dependency detected
>> 4.19.24 #577 Not tainted
>> ------------------------------------------------------
>> sh/372 is trying to acquire lock:
>> (kn->count#30){++++}, at: kernfs_remove_by_name_ns+0x3c/0x84
>>
>> but task is already holding lock:
>> (&dev->info_exist_lock){+.+.}, at: iio_device_unregister+0x18/0x60
>>
>> which lock already depends on the new lock.
>>
>> the existing dependency chain (in reverse order) is:
>>
>> -> #1 (&dev->info_exist_lock){+.+.}:  
>>        __mutex_lock+0x70/0xa3c
>>        mutex_lock_nested+0x1c/0x24
>>        iio_read_channel_raw+0x1c/0x60
>>        iio_read_channel_info+0xa8/0xb0
>>        dev_attr_show+0x1c/0x48
>>        sysfs_kf_seq_show+0x84/0xec
>>        seq_read+0x154/0x528
>>        __vfs_read+0x2c/0x15c
>>        vfs_read+0x8c/0x110
>>        ksys_read+0x4c/0xac
>>        ret_fast_syscall+0x0/0x28
>>        0xbedefb60
>>
>> -> #0 (kn->count#30){++++}:  
>>        lock_acquire+0xd8/0x268
>>        __kernfs_remove+0x288/0x374
>>        kernfs_remove_by_name_ns+0x3c/0x84
>>        remove_files+0x34/0x78
>>        sysfs_remove_group+0x40/0x9c
>>        sysfs_remove_groups+0x24/0x34
>>        device_remove_attrs+0x38/0x64
>>        device_del+0x11c/0x360
>>        cdev_device_del+0x14/0x2c
>>        iio_device_unregister+0x24/0x60
>>        release_nodes+0x1bc/0x200
>>        device_release_driver_internal+0x1a0/0x230
>>        unbind_store+0x80/0x130
>>        kernfs_fop_write+0x100/0x1e4
>>        __vfs_write+0x2c/0x160
>>        vfs_write+0xa4/0x17c
>>        ksys_write+0x4c/0xac
>>        ret_fast_syscall+0x0/0x28
>>        0xbe906840
>>
>> other info that might help us debug this:
>>
>>  Possible unsafe locking scenario:
>>
>>        CPU0                    CPU1
>>        ----                    ----
>>   lock(&dev->info_exist_lock);
>>                                lock(kn->count#30);
>>                                lock(&dev->info_exist_lock);
>>   lock(kn->count#30);
>>
>>  *** DEADLOCK ***
>> ...
>>
>> So only hold the mutex to:
>> - disable all buffers while 'info' is available
>> - set 'info' to NULL
>> Then release it to call cdev_device_del and so on.
>>
>> Help to reproduce:
>> See example: Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
>> sysv {
>> 	compatible = "voltage-divider";
>> 	io-channels = <&adc 0>;
>> 	output-ohms = <22>;
>> 	full-ohms = <222>;
>> };
>>
>> First, go to iio:deviceX for the "voltage-divider", do one read:
>> $ cd /sys/bus/iio/devices/iio:deviceX
>> $ cat in_voltage0_raw
>>
>> Then, unbind the consumer driver. It triggers above deadlock warning.
>> $ cd /sys/bus/platform/drivers/iio-rescale/
>> $ echo sysv > unbind
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> I'm not in principle against the fix. However it is reordering the
> remove wrt to the probe which I'm not so keen on.
> 

Hi Jonathan,

I also had it in mind. Just one thing confused me:
- The ->info struct is filled in by the device driver before calling one
of the "iio_device_register" routines.
- But it's assigned to NULL inside the unregister routine.
That's also why I've sent it as RFC.

> The cdev register is fundamentally the point where the device
> becomes exposed to userspace, so we naturally want to do it last
> (and remove it first).  I worry that we may have some paths
> in which we don't sanity check the existence of info (which
> is kind of our backup plan to indicate the device has gone
> away).
> 
> Are we safe to instead of reordering, just not take the lock
> until after the problem functions?  Info doesn't go
> away until later so I think we are.  I haven't looked it in that
> much detail though!

Ok, thanks for making up my mind :-). As far as I understand, the
"info_exist_lock" targets the inkern users (e.g. exported routines). So,
cdev_device_del() can probably be called unlocked, without reordering.

> 
> Thanks for raising this as it's a nasty little problem.

I'll send a v2 based on your proposal.

Thanks for your help,
Best Regards,
Fabrice

> 
> Jonathan
> 
> 
>> ---
>>  drivers/iio/industrialio-core.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
>> index 4700fd5..e03d6ff 100644
>> --- a/drivers/iio/industrialio-core.c
>> +++ b/drivers/iio/industrialio-core.c
>> @@ -1745,19 +1745,19 @@ void iio_device_unregister(struct iio_dev *indio_dev)
>>  {
>>  	mutex_lock(&indio_dev->info_exist_lock);
>>  
>> -	cdev_device_del(&indio_dev->chrdev, &indio_dev->dev);
>> -
>> -	iio_device_unregister_debugfs(indio_dev);
>> -
>>  	iio_disable_all_buffers(indio_dev);
>>  
>>  	indio_dev->info = NULL;
>>  
>> +	mutex_unlock(&indio_dev->info_exist_lock);
>> +
>> +	cdev_device_del(&indio_dev->chrdev, &indio_dev->dev);
>> +
>> +	iio_device_unregister_debugfs(indio_dev);
>> +
>>  	iio_device_wakeup_eventset(indio_dev);
>>  	iio_buffer_wakeup_poll(indio_dev);
>>  
>> -	mutex_unlock(&indio_dev->info_exist_lock);
>> -
>>  	iio_buffer_free_sysfs_and_mask(indio_dev);
>>  }
>>  EXPORT_SYMBOL(iio_device_unregister);
> 
