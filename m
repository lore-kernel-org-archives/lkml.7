Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA69C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 01:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2585F206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 01:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfKKB56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 20:57:58 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:43155 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726743AbfKKB55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 20:57:57 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=teawaterz@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0ThfhG3L_1573437473;
Received: from C02XQC8CJG5H.local(mailfrom:teawaterz@linux.alibaba.com fp:SMTPD_---0ThfhG3L_1573437473)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 11 Nov 2019 09:57:54 +0800
Subject: Re: [PATCH] zswap: Add shrink_enabled that can disable swap shrink to
 increase store performance
To:     Dan Streetman <ddstreet@ieee.org>
Cc:     Seth Jennings <sjenning@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1571990538-6133-1-git-send-email-teawaterz@linux.alibaba.com>
 <CALZtONCQ1YqpAXfZS6jemHuKpBXhLz440EcxSoWZbxrH0kyLHg@mail.gmail.com>
From:   Hui Zhu <teawaterz@linux.alibaba.com>
Message-ID: <42753fc6-e352-adcb-52c2-6b68472318f5@linux.alibaba.com>
Date:   Mon, 11 Nov 2019 09:57:53 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CALZtONCQ1YqpAXfZS6jemHuKpBXhLz440EcxSoWZbxrH0kyLHg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/11/9 12:04 上午, Dan Streetman wrote:
> On Fri, Oct 25, 2019 at 4:02 AM Hui Zhu <teawaterz@linux.alibaba.com> wrote:
>>
>> zswap will try to shrink pool when zswap is full.
>> This commit add shrink_enabled that can disable swap shrink to increase
>> store performance.  User can disable swap shrink if care about the store
>> performance.
> 
> I don't understand - if zswap is full it can't store any more pages
> without shrinking the current pool.  This commit will just force all
> pages to swap when zswap is full.  This has nothing to do with 'store
> performance'.
> 
> I think it would be much better to remove any user option for this and
> implement some hysteresis; store pages normally until the zpool is
> full, then reject all pages going to that pool until there is some %
> free, at which point allow pages to be stored into the pool again.
> That will prevent (or at least reduce) the constant performance hit
> when a zpool fills up, and just fallback to normal swapping to disk
> until the zpool has some amount of free space again.
> 

This idea is really cool!
Do you mind I make a patch for it?

Thanks,
Hui

>>
>> For example in a VM with 1 CPU 1G memory 4G swap:
>> echo lz4 > /sys/module/zswap/parameters/compressor
>> echo z3fold > /sys/module/zswap/parameters/zpool
>> echo 0 > /sys/module/zswap/parameters/same_filled_pages_enabled
>> echo 1 > /sys/module/zswap/parameters/enabled
>> usemem -a -n 1 $((4000 * 1024 * 1024))
>> 4718592000 bytes / 114937822 usecs = 40091 KB/s
>> 101700 usecs to free memory
>> echo 0 > /sys/module/zswap/parameters/shrink_enabled
>> usemem -a -n 1 $((4000 * 1024 * 1024))
>> 4718592000 bytes / 8837320 usecs = 521425 KB/s
>> 129577 usecs to free memory
>>
>> The store speed increased when zswap shrink disabled.
>>
>> Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
>> ---
>>   mm/zswap.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/mm/zswap.c b/mm/zswap.c
>> index 46a3223..731e3d1e 100644
>> --- a/mm/zswap.c
>> +++ b/mm/zswap.c
>> @@ -114,6 +114,10 @@ static bool zswap_same_filled_pages_enabled = true;
>>   module_param_named(same_filled_pages_enabled, zswap_same_filled_pages_enabled,
>>                     bool, 0644);
>>
>> +/* Enable/disable zswap shrink (enabled by default) */
>> +static bool zswap_shrink_enabled = true;
>> +module_param_named(shrink_enabled, zswap_shrink_enabled, bool, 0644);
>> +
>>   /*********************************
>>   * data structures
>>   **********************************/
>> @@ -947,6 +951,9 @@ static int zswap_shrink(void)
>>          struct zswap_pool *pool;
>>          int ret;
>>
>> +       if (!zswap_shrink_enabled)
>> +               return -EPERM;
>> +
>>          pool = zswap_pool_last_get();
>>          if (!pool)
>>                  return -ENOENT;
>> --
>> 2.7.4
>>
