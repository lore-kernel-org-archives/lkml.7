Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C786C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 02:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76DCF20B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 02:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfHECi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 22:38:59 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:17597 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726767AbfHECi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 22:38:58 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=chge@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TYeMK0t_1564972735;
Received: from IT-C02YD3Q7JG5H.local(mailfrom:chge@linux.alibaba.com fp:SMTPD_---0TYeMK0t_1564972735)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 05 Aug 2019 10:38:56 +0800
Subject: Re: [Ocfs2-devel] [PATCH 2/3] fs: ocfs2: Fix a possible null-pointer
 dereference in ocfs2_write_end_nolock()
To:     Joseph Qi <joseph.qi@linux.alibaba.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>, mark@fasheh.com,
        jlbec@evilplan.org
Cc:     linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190726033705.32307-1-baijiaju1990@gmail.com>
 <cdec8b79-a854-e9b0-21af-897c7eedc454@linux.alibaba.com>
From:   Changwei Ge <chge@linux.alibaba.com>
Message-ID: <20d02767-6e14-c04f-4fcf-11ed2cbd63a2@linux.alibaba.com>
Date:   Mon, 5 Aug 2019 10:38:55 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <cdec8b79-a854-e9b0-21af-897c7eedc454@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jia-ju,


Could you please point out how ->w_handle can be NULL if we are changing 
disk inode?

I just checked the ocfs2 code but can't find any clue ...

In my opinion, it's impossible to change disk inode without an existed 
journal transaction. If truly so, it's a another problem.


Thanks,

Changwei


On 2019/7/26 5:38 下午, Joseph Qi wrote:
>
> On 19/7/26 11:37, Jia-Ju Bai wrote:
>> In ocfs2_write_end_nolock(), there are an if statement on lines 1976,
>> 2047 and 2058, to check whether handle is NULL:
>>      if (handle)
>>
>> When handle is NULL, it is used on line 2045:
>> 	ocfs2_update_inode_fsync_trans(handle, inode, 1);
>>          oi->i_sync_tid = handle->h_transaction->t_tid;
>>
>> Thus, a possible null-pointer dereference may occur.
>>
>> To fix this bug, handle is checked before calling
>> ocfs2_update_inode_fsync_trans().
>>
>> This bug is found by a static analysis tool STCheck written by us.
>>
>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> Looks good.
> Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
>
>> ---
>>   fs/ocfs2/aops.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
>> index a4c905d6b575..5473bd99043e 100644
>> --- a/fs/ocfs2/aops.c
>> +++ b/fs/ocfs2/aops.c
>> @@ -2042,7 +2042,8 @@ int ocfs2_write_end_nolock(struct address_space *mapping,
>>   		inode->i_mtime = inode->i_ctime = current_time(inode);
>>   		di->i_mtime = di->i_ctime = cpu_to_le64(inode->i_mtime.tv_sec);
>>   		di->i_mtime_nsec = di->i_ctime_nsec = cpu_to_le32(inode->i_mtime.tv_nsec);
>> -		ocfs2_update_inode_fsync_trans(handle, inode, 1);
>> +		if (handle)
>> +			ocfs2_update_inode_fsync_trans(handle, inode, 1);
>>   	}
>>   	if (handle)
>>   		ocfs2_journal_dirty(handle, wc->w_di_bh);
>>
> _______________________________________________
> Ocfs2-devel mailing list
> Ocfs2-devel@oss.oracle.com
> https://oss.oracle.com/mailman/listinfo/ocfs2-devel
