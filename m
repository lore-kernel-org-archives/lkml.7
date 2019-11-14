Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BB2C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 02:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 020132068E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 02:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfKNCBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 21:01:44 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:60154 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726120AbfKNCBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 21:01:44 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 103F0FB581E56AB6F9E4;
        Thu, 14 Nov 2019 10:01:33 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.96) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Thu, 14 Nov 2019
 10:01:24 +0800
Subject: Re: [PATCH] debugfs: fix potential infinite loop in
 debugfs_remove_recursive
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <oleg@redhat.com>, <jack@suse.cz>, <linux-kernel@vger.kernel.org>,
        <zhengbin13@huawei.com>, <yi.zhang@huawei.com>,
        <chenxiang66@hisilicon.com>, <xiexiuqi@huawei.com>
References: <1572528884-67565-1-git-send-email-yukuai3@huawei.com>
 <20191113151755.7125e914@gandalf.local.home>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <a399ae58-a467-3ff9-5a01-a4a2cdcf4fd6@huawei.com>
Date:   Thu, 14 Nov 2019 10:01:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191113151755.7125e914@gandalf.local.home>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your explanation

On 2019/11/14 4:17, Steven Rostedt wrote:
> On Thu, 31 Oct 2019 21:34:44 +0800
> yu kuai <yukuai3@huawei.com> wrote:
> 
>> debugfs_remove_recursive uses list_empty to judge weather a dentry has
>> any subdentry or not. This can lead to infinite loop when any subdir is in
>> use.
>>
>> The problem was discoverd by the following steps in the console.
>> 1. use debugfs_create_dir to create a dir and multiple subdirs(insmod);
>> 2. cd to the subdir with depth not less than 2;
>> 3. call debugfs_remove_recursive(rmmod).
>>
>> After removing the subdir, the infinite loop is triggered bucause
> 
>    s/bucause/because/
> 
>> debugfs_remove_recursive uses list_empty to judge if the current dir
>> doesn't have any subdentry, if so, remove the current dir and which
>> will never happen.
>>
>> Fix the problem by using simple_empty instead of list_empty.
>>
>> Fixes: 776164c1faac ('debugfs: debugfs_remove_recursive() must not rely on list_empty(d_subdirs)')
>> Reported-by: chenxiang66@hisilicon.com
>> Signed-off-by: yu kuai <yukuai3@huawei.com>
>> ---
>>   fs/debugfs/inode.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
>> index 7b975db..42b28acc 100644
>> --- a/fs/debugfs/inode.c
>> +++ b/fs/debugfs/inode.c
>> @@ -773,8 +773,10 @@ void debugfs_remove_recursive(struct dentry *dentry)
>>   		if (!simple_positive(child))
>>   			continue;
>>   
>> -		/* perhaps simple_empty(child) makes more sense */
>> -		if (!list_empty(&child->d_subdirs)) {
>> +		/* use simple_empty to prevent infinite loop when any
>> +		 * subdentry of child is in use
>> +		 */
> 
> Nit, multi-line comments should be of the form:
> 
> 	/*
> 	 * comment line 1
> 	 * comment line 2
> 	 */
> 
> Not
> 
> 	/* comment line 1
> 	 * comment line 2
> 	 */
> 
> It's known that the networking folks like that method, but it's not
> acceptable anywhere outside of networking.
> 
Do you agree with that list_empty(&chile->d_subdirs) here is not 
appropriate? Since it can't skip the subdirs that is not 
simple_positive(simple_positive() will return false), which is the 
reason of infinite loop.
>> +		if (!simple_empty(child)) {
> 
> Have you tried this with lockdep enabled? I'm thinking that you might
> get a splat with holding parent->d_lock and simple_empty(child) taking
> the child->d_lock.
The locks are taken and released in the right order:
take parent->d_lock
	take child->d_lock
		list_for_each_entry(c, &child->d_sundirs, d_child)
			take c->d_lock
			release c->d_lock
	release child->d_lock
release parent->d_lock
I don't see anything wrong, am I missing something?

Thanks
Yu Kuai
> 
> -- Steve
> 
> 
>>   			spin_unlock(&parent->d_lock);
>>   			inode_unlock(d_inode(parent));
>>   			parent = child;
> 
> 
> .
> 

