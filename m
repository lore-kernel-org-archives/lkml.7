Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DA4CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 01:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009502080F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 01:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfJaBvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 21:51:00 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58640 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725926AbfJaBu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 21:50:59 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8F4D698C7D8E304773C3;
        Thu, 31 Oct 2019 09:50:55 +0800 (CST)
Received: from [127.0.0.1] (10.133.219.218) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Thu, 31 Oct 2019
 09:50:53 +0800
Message-ID: <5DBA3DFD.2020601@huawei.com>
Date:   Thu, 31 Oct 2019 09:50:53 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Akinobu Mita <akinobu.mita@gmail.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] fault-inject: Use debugfs_create_ulong() instead of
 debugfs_create_ul()
References: <1572440776-50318-1-git-send-email-zhongjiang@huawei.com> <CAC5umyhRiJ9LHD1fhhSUygmWtXMe28WL4KB9=5DXv0rU6rJ0vg@mail.gmail.com>
In-Reply-To: <CAC5umyhRiJ9LHD1fhhSUygmWtXMe28WL4KB9=5DXv0rU6rJ0vg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.133.219.218]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/30 21:39, Akinobu Mita wrote:
> 2019年10月30日(水) 22:10 zhong jiang <zhongjiang@huawei.com>:
>> debugfs_create_ulong() has implemented the function of debugfs_create_ul()
>> in lib/fault-inject.c. hence we can replace it.
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>>  lib/fault-inject.c | 43 ++++++++++++++-----------------------------
>>  1 file changed, 14 insertions(+), 29 deletions(-)
>>
>> diff --git a/lib/fault-inject.c b/lib/fault-inject.c
>> index 8186ca8..326fc1d 100644
>> --- a/lib/fault-inject.c
>> +++ b/lib/fault-inject.c
>> @@ -151,10 +151,13 @@ bool should_fail(struct fault_attr *attr, ssize_t size)
>>  EXPORT_SYMBOL_GPL(should_fail);
>>
>>  #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
>> +#ifdef CONFIG_FAULT_INJECTION_STACKTRACE_FILTER
>>
>> -static int debugfs_ul_set(void *data, u64 val)
>> +static int debugfs_stacktrace_depth_set(void *data, u64 val)
>>  {
>> -       *(unsigned long *)data = val;
>> +       *(unsigned long *)data =
>> +               min_t(unsigned long, val, MAX_STACK_TRACE_DEPTH);
>> +
>>         return 0;
>>  }
>>
>> @@ -164,26 +167,8 @@ static int debugfs_ul_get(void *data, u64 *val)
>>         return 0;
>>  }
>>
>> -DEFINE_SIMPLE_ATTRIBUTE(fops_ul, debugfs_ul_get, debugfs_ul_set, "%llu\n");
>> -
>> -static void debugfs_create_ul(const char *name, umode_t mode,
>> -                             struct dentry *parent, unsigned long *value)
>> -{
>> -       debugfs_create_file(name, mode, parent, value, &fops_ul);
>> -}
>> -
>> -#ifdef CONFIG_FAULT_INJECTION_STACKTRACE_FILTER
>> -
>> -static int debugfs_stacktrace_depth_set(void *data, u64 val)
>> -{
>> -       *(unsigned long *)data =
>> -               min_t(unsigned long, val, MAX_STACK_TRACE_DEPTH);
>> -
>> -       return 0;
>> -}
>> -
>> -DEFINE_SIMPLE_ATTRIBUTE(fops_stacktrace_depth, debugfs_ul_get,
>> -                       debugfs_stacktrace_depth_set, "%llu\n");
>> +DEFINE_DEBUGFS_ATTRIBUTE(fops_stacktrace_depth, debugfs_ul_get,
>> +                        debugfs_stacktrace_depth_set, "%llu\n");
>>
> The commit message doesn't describe the s/SIMPLE/DEBUGFS/ change
> for fops_stacktrace_depth.
>
> It is better to prepare another patch and I think debugfs_create_file()
> in debugfs_create_stacktrace_depth() can now be replaced by
> debugfs_create_file_unsafe().
>
> .
Thanks for you suggestion.  I will repost as your proposal.

Sincerely,
zhong jiang
>


