Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D99C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 07:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9D892075C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 07:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfK3H1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 02:27:34 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:49068 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725298AbfK3H1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 02:27:34 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 83080E6B1FE2ADD81028;
        Sat, 30 Nov 2019 15:27:32 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.439.0; Sat, 30 Nov
 2019 15:27:29 +0800
Subject: Re: [PATCH] f2fs: Fix direct IO handling
To:     Ritesh Harjani <riteshh@linux.ibm.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>
CC:     Javier Gonzalez <javier@javigon.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20191126075719.1046485-1-damien.lemoal@wdc.com>
 <20191126083443.F1FD5A405B@b06wcsmtp001.portsmouth.uk.ibm.com>
 <BYAPR04MB5816C82F708612381216895BE7470@BYAPR04MB5816.namprd04.prod.outlook.com>
 <20191128102033.6085952057@d06av21.portsmouth.uk.ibm.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <ad311ee5-fe8f-9fbc-1e7a-7bfc379d268c@huawei.com>
Date:   Sat, 30 Nov 2019 15:27:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191128102033.6085952057@d06av21.portsmouth.uk.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/11/28 18:20, Ritesh Harjani wrote:
> 
> 
> On 11/28/19 7:40 AM, Damien Le Moal wrote:
>> On 2019/11/26 17:34, Ritesh Harjani wrote:
>>> Hello Damien,
>>>
>>> IIUC, you are trying to fix a stale data read by DIO read for the case
>>> you explained in your patch w.r.t. DIO-write forced to write as buffIO.
>>>
>>> Coincidentally I was just looking at the same code path just now.
>>> So I do have a query to you/f2fs group. Below could be silly one, as I
>>> don't understand F2FS in great detail.
>>>
>>> How is the stale data by DIO read, is protected against a mmap
>>> writes via f2fs_vm_page_mkwrite?
>>>
>>> f2fs_vm_page_mkwrite()		 f2fs_direct_IO (read)
>>> 					filemap_write_and_wait_range()
>>> 	-> f2fs_get_blocks()				
>>> 					 -> submit_bio()
>>>
>>> 	-> set_page_dirty()
>>>
>>> Is above race possible with current f2fs code?
>>> i.e. f2fs_direct_IO could read the stale data from the blocks
>>> which were allocated due to mmap fault?
>>
>> The faulted page is locked until the fault is fully processed so direct
>> IO has to wait for that to complete first.
> 
> How about below parallelism?
> 
>   f2fs_vm_page_mkwrite()		 f2fs_direct_IO (read)
>   					filemap_write_and_wait_range()
> 	-> down_read(->i_mmap_sem);
> 	-> lock_page()
> 	-> f2fs_get_blocks()				
>   					 -> submit_bio()
> 
>   	-> set_page_dirty()
> 
> Can above DIO read not expose the stale data from block which was
> allocated in f2fs_vm_page_mkwrite path?

The race can happen, however I doubt the race condition is more complicated
as I described in previous reply of mine, could you check that?

Thanks,

> 
> 
>>
>>>
>>> Am I missing something here?
>>>
>>> -ritesh
>>>
>>> On 11/26/19 1:27 PM, Damien Le Moal wrote:
>>>> f2fs_preallocate_blocks() identifies direct IOs using the IOCB_DIRECT
>>>> flag for a kiocb structure. However, the file system direct IO handler
>>>> function f2fs_direct_IO() may have decided that a direct IO has to be
>>>> exececuted as a buffered IO using the function f2fs_force_buffered_io().
>>>> This is the case for instance for volumes including zoned block device
>>>> and for unaligned write IOs with LFS mode enabled.
>>>>
>>>> These 2 different methods of identifying direct IOs can result in
>>>> inconsistencies generating stale data access for direct reads after a
>>>> direct IO write that is treated as a buffered write. Fix this
>>>> inconsistency by combining the IOCB_DIRECT flag test with the result
>>>> of f2fs_force_buffered_io().
>>>>
>>>> Reported-by: Javier Gonzalez <javier@javigon.com>
>>>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
>>>> ---
>>>>    fs/f2fs/data.c | 4 +++-
>>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>>> index 5755e897a5f0..8ac2d3b70022 100644
>>>> --- a/fs/f2fs/data.c
>>>> +++ b/fs/f2fs/data.c
>>>> @@ -1073,6 +1073,8 @@ int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
>>>>    	int flag;
>>>>    	int err = 0;
>>>>    	bool direct_io = iocb->ki_flags & IOCB_DIRECT;
>>>> +	bool do_direct_io = direct_io &&
>>>> +		!f2fs_force_buffered_io(inode, iocb, from);
>>>>    
>>>>    	/* convert inline data for Direct I/O*/
>>>>    	if (direct_io) {
>>>> @@ -1081,7 +1083,7 @@ int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
>>>>    			return err;
>>>>    	}
>>>>    
>>>> -	if (direct_io && allow_outplace_dio(inode, iocb, from))
>>>> +	if (do_direct_io && allow_outplace_dio(inode, iocb, from))
>>>>    		return 0;
>>>>    
>>>>    	if (is_inode_flag_set(inode, FI_NO_PREALLOC))
>>>>
>>>
>>>
>>
>>
> 
> .
> 
