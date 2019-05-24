Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197BEC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA80A217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390616AbfEXKsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 06:48:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33276 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389448AbfEXKse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 06:48:34 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1673230821F8;
        Fri, 24 May 2019 10:48:34 +0000 (UTC)
Received: from [10.3.116.116] (ovpn-116-116.phx2.redhat.com [10.3.116.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5303561354;
        Fri, 24 May 2019 10:48:33 +0000 (UTC)
Subject: Re: [PATCH] drm: assure aux_dev is nonzero before using it
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     airlied@linux.ie, dkwon@redhat.com
References: <20190523110905.22445-1-tcamuso@redhat.com>
 <87v9y0mept.fsf@intel.com>
From:   tony camuso <tcamuso@redhat.com>
Message-ID: <04ae1fb0-02ab-88e9-94b3-e36f48cc65d5@redhat.com>
Date:   Fri, 24 May 2019 06:48:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87v9y0mept.fsf@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 24 May 2019 10:48:34 +0000 (UTC)
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

That's a very good question.

> Also, can you reproduce this on a recent upstream kernel? The aux device
> nodes were introduced in kernel v4.6. Whatever you reproduced on v3.10
> is pretty much irrelevant for upstream.

I will look into this deeper, using the upstream kernel.

> 
> 
> BR,
> Jani.

-- snip --

