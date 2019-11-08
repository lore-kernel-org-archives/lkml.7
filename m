Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9459C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 02:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B272084C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 02:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbfKHCq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 21:46:59 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5746 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725940AbfKHCq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 21:46:59 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4CC2D19B8089BAC1E34C;
        Fri,  8 Nov 2019 10:46:57 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 8 Nov 2019
 10:46:53 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to update dir's i_pino during
 cross_rename
To:     Eric Biggers <ebiggers@kernel.org>
References: <20191107061205.120972-1-yuchao0@huawei.com>
 <20191107170519.GA766@sol.localdomain>
From:   Chao Yu <yuchao0@huawei.com>
CC:     <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
Message-ID: <77ee5340-c9f5-d26e-16c5-5d471f0e78c1@huawei.com>
Date:   Fri, 8 Nov 2019 10:46:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191107170519.GA766@sol.localdomain>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/11/8 1:05, Eric Biggers wrote:
> On Thu, Nov 07, 2019 at 02:12:05PM +0800, Chao Yu wrote:
>> As Eric reported:
>>
>> RENAME_EXCHANGE support was just added to fsstress in xfstests:
>>
>> 	commit 65dfd40a97b6bbbd2a22538977bab355c5bc0f06
>> 	Author: kaixuxia <xiakaixu1987@gmail.com>
>> 	Date:   Thu Oct 31 14:41:48 2019 +0800
>>
>> 	    fsstress: add EXCHANGE renameat2 support
>>
>> This is causing xfstest generic/579 to fail due to fsck.f2fs reporting errors.
>> I'm not sure what the problem is, but it still happens even with all the
>> fs-verity stuff in the test commented out, so that the test just runs fsstress.
>>
>> generic/579 23s ... 	[10:02:25]
>> [    7.745370] run fstests generic/579 at 2019-11-04 10:02:25
>> _check_generic_filesystem: filesystem on /dev/vdc is inconsistent
>> (see /results/f2fs/results-default/generic/579.full for details)
>>  [10:02:47]
>> Ran: generic/579
>> Failures: generic/579
>> Failed 1 of 1 tests
>> Xunit report: /results/f2fs/results-default/result.xml
>>
>> Here's the contents of 579.full:
>>
>> _check_generic_filesystem: filesystem on /dev/vdc is inconsistent
>> *** fsck.f2fs output ***
>> [ASSERT] (__chk_dots_dentries:1378)  --> Bad inode number[0x24] for '..', parent parent ino is [0xd10]
>>
>> The root cause is that we forgot to update directory's i_pino during
>> cross_rename, fix it.
>>
>> Fixes: 32f9bc25cbda0 ("f2fs: support ->rename2()")
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> 
> Tested-by: Eric Biggers <ebiggers@kernel.org>

Thanks for the test.

> 
> The i_pino field is only valid on directories, right?

i_pino is also valid on regular inode, because after sudden power-cut case, we
will recover fsynced file and link it into parent directory which i_pino field
points.

For rename/cross_rename cases, we just tag src/dst regular inode with
parent_lost flag instead of updating its i_pino field, once there is fsync()
comes after rename(), we will trigger checkpoint for such parent lost inode to
keep rename/cross_rename operation as an atomic operation.

Thanks,

> 
> - Eric
> .
> 
