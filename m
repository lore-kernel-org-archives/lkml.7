Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762E6CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 12:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5699020862
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 12:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfJ3MKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 08:10:04 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5654 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726242AbfJ3MKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 08:10:04 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8D31F10FB44CB8F6E8FE;
        Wed, 30 Oct 2019 20:09:59 +0800 (CST)
Received: from [127.0.0.1] (10.133.219.218) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Wed, 30 Oct 2019
 20:09:54 +0800
Message-ID: <5DB97D91.1010500@huawei.com>
Date:   Wed, 30 Oct 2019 20:09:53 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Akinobu Mita <akinobu.mita@gmail.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fault-inject: use DEFINE_DEBUGFS_ATTRIBUTE to define
 debugfs fops
References: <1572423756-59943-1-git-send-email-zhongjiang@huawei.com> <CAC5umygBcEic4HXCWfFKj0ZJHo8RRzPkO959051eYoH7y4C39A@mail.gmail.com>
In-Reply-To: <CAC5umygBcEic4HXCWfFKj0ZJHo8RRzPkO959051eYoH7y4C39A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.133.219.218]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/30 18:29, Akinobu Mita wrote:
> 2019年10月30日(水) 17:26 zhong jiang <zhongjiang@huawei.com>:
>> It is more clear to use DEFINE_DEBUGFS_ATTRIBUTE to define debugfs file
>> operation rather than DEFINE_SIMPLE_ATTRIBUTE.
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>>  lib/fault-inject.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/lib/fault-inject.c b/lib/fault-inject.c
>> index 8186ca8..4e61326 100644
>> --- a/lib/fault-inject.c
>> +++ b/lib/fault-inject.c
>> @@ -164,7 +164,7 @@ static int debugfs_ul_get(void *data, u64 *val)
>>         return 0;
>>  }
>>
>> -DEFINE_SIMPLE_ATTRIBUTE(fops_ul, debugfs_ul_get, debugfs_ul_set, "%llu\n");
>> +DEFINE_DEBUGFS_ATTRIBUTE(fops_ul, debugfs_ul_get, debugfs_ul_set, "%llu\n");
>>
>>  static void debugfs_create_ul(const char *name, umode_t mode,
>>                               struct dentry *parent, unsigned long *value)
> Nowadays we have debugfs_create_ulong(), so should we use it instead of
> debugfs_create_ul() defined in this file and remove the definision
> altogether?
>
> .
yes, you are right. That is better. I will repost in v2. Thanks

Sincerely,
zhong jiang
>


