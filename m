Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A217DC74A23
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 13:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7776020861
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 13:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfGJNrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 09:47:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46840 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbfGJNrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 09:47:13 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D7201308330C;
        Wed, 10 Jul 2019 13:47:12 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-204.phx2.redhat.com [10.3.117.204])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 11875B23E7;
        Wed, 10 Jul 2019 13:47:11 +0000 (UTC)
Subject: Re: [PATCH] drm: assure aux_dev is nonzero before using it
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     airlied@linux.ie, dkwon@redhat.com
References: <20190523110905.22445-1-tcamuso@redhat.com>
 <87v9y0mept.fsf@intel.com>
From:   Tony Camuso <tcamuso@redhat.com>
Message-ID: <5111581c-9d73-530d-d3ff-4f6950bf3f8c@redhat.com>
Date:   Wed, 10 Jul 2019 09:47:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <87v9y0mept.fsf@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 10 Jul 2019 13:47:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/19 4:36 AM, Jani Nikula wrote:
> On Thu, 23 May 2019, tcamuso <tcamuso@redhat.com> wrote:
>>  From Daniel Kwon <dkwon@redhat.com>
>>
>> The system was crashed due to invalid memory access while trying to access
>> auxiliary device.
>>
>> crash> bt
>> PID: 9863   TASK: ffff89d1bdf11040  CPU: 1   COMMAND: "ipmitool"
>>   #0 [ffff89cedd7f3868] machine_kexec at ffffffffb0663674
>>   #1 [ffff89cedd7f38c8] __crash_kexec at ffffffffb071cf62
>>   #2 [ffff89cedd7f3998] crash_kexec at ffffffffb071d050
>>   #3 [ffff89cedd7f39b0] oops_end at ffffffffb0d6d758
>>   #4 [ffff89cedd7f39d8] no_context at ffffffffb0d5bcde
>>   #5 [ffff89cedd7f3a28] __bad_area_nosemaphore at ffffffffb0d5bd75
>>   #6 [ffff89cedd7f3a78] bad_area at ffffffffb0d5c085
>>   #7 [ffff89cedd7f3aa0] __do_page_fault at ffffffffb0d7080c
>>   #8 [ffff89cedd7f3b10] do_page_fault at ffffffffb0d70905
>>   #9 [ffff89cedd7f3b40] page_fault at ffffffffb0d6c758
>>      [exception RIP: drm_dp_aux_dev_get_by_minor+0x3d]
>>      RIP: ffffffffc0a589bd  RSP: ffff89cedd7f3bf0  RFLAGS: 00010246
>>      RAX: 0000000000000000  RBX: 0000000000000000  RCX: ffff89cedd7f3fd8
>>      RDX: 0000000000000000  RSI: 0000000000000000  RDI: ffffffffc0a613e0
>>      RBP: ffff89cedd7f3bf8   R8: ffff89f1bcbabbd0   R9: 0000000000000000
>>      R10: ffff89f1be7a1cc0  R11: 0000000000000000  R12: 0000000000000000
>>      R13: ffff89f1b32a2830  R14: ffff89d18fadfa00  R15: 0000000000000000
>>      ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>>      RIP: 00002b45f0d80d30  RSP: 00007ffc416066a0  RFLAGS: 00010246
>>      RAX: 0000000000000002  RBX: 000056062e212d80  RCX: 00007ffc41606810
>>      RDX: 0000000000000000  RSI: 0000000000000002  RDI: 00007ffc41606ec0
>>      RBP: 0000000000000000   R8: 000056062dfed229   R9: 00002b45f0cdf14d
>>      R10: 0000000000000002  R11: 0000000000000246  R12: 00007ffc41606ec0
>>      R13: 00007ffc41606ed0  R14: 00007ffc41606ee0  R15: 0000000000000000
>>      ORIG_RAX: 0000000000000002  CS: 0033  SS: 002b
>>
>> ----------------------------------------------------------------------------
>>
>> It was trying to open '/dev/ipmi0', but as no entry in aux_dir, it returned
>> NULL from 'idr_find()'. This drm_dp_aux_dev_get_by_minor() should have done a
>> check on this, but had failed to do it.
> 
> I think the better question is, *why* does the idr_find() return NULL? I
> don't think it should, under any circumstances. I fear adding the check
> here papers over some other problem, taking us further away from the
> root cause.
> 
> Also, can you reproduce this on a recent upstream kernel? The aux device
> nodes were introduced in kernel v4.6. Whatever you reproduced on v3.10
> is pretty much irrelevant for upstream.
> 
> 
> BR,
> Jani.

I have not been able to reproduce this problem.

However, whatever the reason idr_find() returns NULL, isn't it good form to
check it before using it? What would be the software engineering reason not
to do this?

> 
> 
> 
> 
>>
>> ----------------------------------------------------------------------------
>> /usr/src/debug/kernel-3.10.0-957.12.1.el7/linux-3.10.0-957.12.1.el7.x86_64/include/linux/idr.h: 114
>>       114 	struct idr_layer *hint = rcu_dereference_raw(idr->hint);
>> 0xffffffffc0a58998 <drm_dp_aux_dev_get_by_minor+0x18>:	mov    0x8a41(%rip),%rax        # 0xffffffffc0a613e0 <aux_idr>
>> /usr/src/debug/kernel-3.10.0-957.12.1.el7/linux-3.10.0-957.12.1.el7.x86_64/include/linux/idr.h: 116
>>       116 	if (hint && (id & ~IDR_MASK) == hint->prefix)
>>       117 		return rcu_dereference_raw(hint->ary[id & IDR_MASK]);
>> 0xffffffffc0a5899f <drm_dp_aux_dev_get_by_minor+0x1f>:	test   %rax,%rax
>> 0xffffffffc0a589a2 <drm_dp_aux_dev_get_by_minor+0x22>:	je     0xffffffffc0a589ac <drm_dp_aux_dev_get_by_minor+0x2c>
>> 0xffffffffc0a589a4 <drm_dp_aux_dev_get_by_minor+0x24>:	mov    %ebx,%edx
>> 0xffffffffc0a589a6 <drm_dp_aux_dev_get_by_minor+0x26>:	xor    %dl,%dl
>> 0xffffffffc0a589a8 <drm_dp_aux_dev_get_by_minor+0x28>:	cmp    (%rax),%edx
>> 0xffffffffc0a589aa <drm_dp_aux_dev_get_by_minor+0x2a>:	je     0xffffffffc0a589f0 <drm_dp_aux_dev_get_by_minor+0x70>
>> /usr/src/debug/kernel-3.10.0-957.12.1.el7/linux-3.10.0-957.12.1.el7.x86_64/include/linux/idr.h: 119
>>       119 	return idr_find_slowpath(idr, id);
>> 0xffffffffc0a589ac <drm_dp_aux_dev_get_by_minor+0x2c>:	mov    %ebx,%esi
>> 0xffffffffc0a589ae <drm_dp_aux_dev_get_by_minor+0x2e>:	mov    $0xffffffffc0a613e0,%rdi
>> 0xffffffffc0a589b5 <drm_dp_aux_dev_get_by_minor+0x35>:	callq  0xffffffffb09771b0 <idr_find_slowpath>
>> 0xffffffffc0a589ba <drm_dp_aux_dev_get_by_minor+0x3a>:	mov    %rax,%rbx
>> /usr/src/debug/kernel-3.10.0-957.12.1.el7/linux-3.10.0-957.12.1.el7.x86_64/arch/x86/include/asm/atomic.h: 25
>>        25 	return ACCESS_ONCE((v)->counter);
>> 0xffffffffc0a589bd <drm_dp_aux_dev_get_by_minor+0x3d>:	mov    0x18(%rbx),%edx
>>
>> crash> struct file.f_path 0xffff89d18fadfa00
>>    f_path = {
>>      mnt = 0xffff89f23feaa620,
>>      dentry = 0xffff89f1be7a1cc0
>>    }
>> crash> files -d 0xffff89f1be7a1cc0
>>       DENTRY           INODE           SUPERBLK     TYPE PATH
>> ffff89f1be7a1cc0 ffff89f1b32a2830 ffff89d293aa8800 CHR  /dev/ipmi0
>>
>> crash> struct inode.i_rdev ffff89f1b32a2830
>>    i_rdev = 0xf200000
>> crash> eval (0xfffff & 0xf200000)
>> hexadecimal: 0
>>      decimal: 0
>>        octal: 0
>>       binary: 0000000000000000000000000000000000000000000000000000000000000000
>> ----------------------------------------------------------------------------
>>
>> As the index value was 0 and aux_idr had value 0 for all, it can have value
>> NULL from idr_find() function, but the below function doesn't check and just
>> tries to use it.
>>
>> ----------------------------------------------------------------------------
>> crash> aux_idr
>> aux_idr = $8 = {
>>    hint = 0x0,
>>    top = 0x0,
>>    id_free = 0x0,
>>    layers = 0x0,
>>    id_free_cnt = 0x0,
>>    cur = 0x0,
>>    lock = {
>>      {
>>        rlock = {
>>          raw_lock = {
>>            val = {
>>              counter = 0x0
>>            }
>>          }
>>        }
>>      }
>>    }
>> }
>>
>> crash> edis -f drm_dp_aux_dev_get_by_minor
>> /usr/src/debug/kernel-3.10.0-957.12.1.el7/linux-3.10.0-957.12.1.el7.x86_64/drivers/gpu/drm/drm_dp_aux_dev.c: 57
>>
>>        56 static struct drm_dp_aux_dev *drm_dp_aux_dev_get_by_minor(unsigned index)
>>        57 {
>>        58 	struct drm_dp_aux_dev *aux_dev = NULL;
>>        59
>>        60 	mutex_lock(&aux_idr_mutex);
>>        61 	aux_dev = idr_find(&aux_idr, index);
>>        62 	if (!kref_get_unless_zero(&aux_dev->refcount))
>>        63 		aux_dev = NULL;
>>        64 	mutex_unlock(&aux_idr_mutex);
>>        65
>>        66 	return aux_dev;
>>        67 }
>> ----------------------------------------------------------------------------
>>
>> To avoid this kinds of situation, we should make a safeguard for the returned
>> value. Changing the line 62 with the below would do.
>>
>>        62 	if (aux_dev && !kref_get_unless_zero(&aux_dev->refcount))
>>                      ^^^^^^^^^^
>>  From Tony Camuso <tcamuso@redhat.com>
>> I built a patched kernel for several architectures.
>> Booted the kernel, and ran the following for 100 iterations.
>>     rmmod ipmi kmods to remove /dev/ipmi0.
>>     Invoked ipmitool
>>     insmod ipmi kmods
>> Did not see any crashes or call traces.
>>
>> Suggested-by: Daniel Kwon <dkwon@redhat.com>
>> Signed-off-by: Tony Camuso <tcamuso@redhat.com>
>> ---
>>   drivers/gpu/drm/drm_dp_aux_dev.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/drm_dp_aux_dev.c b/drivers/gpu/drm/drm_dp_aux_dev.c
>> index 0e4f25d63fd2d..0b11210c882ee 100644
>> --- a/drivers/gpu/drm/drm_dp_aux_dev.c
>> +++ b/drivers/gpu/drm/drm_dp_aux_dev.c
>> @@ -60,7 +60,7 @@ static struct drm_dp_aux_dev *drm_dp_aux_dev_get_by_minor(unsigned index)
>>   
>>   	mutex_lock(&aux_idr_mutex);
>>   	aux_dev = idr_find(&aux_idr, index);
>> -	if (!kref_get_unless_zero(&aux_dev->refcount))
>> +	if (aux_dev && !kref_get_unless_zero(&aux_dev->refcount))
>>   		aux_dev = NULL;
>>   	mutex_unlock(&aux_idr_mutex);
> 

