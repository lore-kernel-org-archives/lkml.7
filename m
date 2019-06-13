Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BD8C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 226E221721
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="Z3ugz+Ff"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730935AbfFMQcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:32:32 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:43382 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730849AbfFMIP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:15:59 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 2D01A2E0DEC;
        Thu, 13 Jun 2019 11:15:53 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net [2a02:6b8:0:1619::137])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id r33Oi2NKnn-FpIOJvba;
        Thu, 13 Jun 2019 11:15:53 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1560413753; bh=3Pp0FZ+SZZPig9cVc4N4kq00quoG1v3rR/FRnc5nQlo=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=Z3ugz+Ff549FVPYbsW1FwYyvrcEZnCU0PtHmVPrvXyN4Lwa+e0Ncw0EPOZxhQcz1O
         k69Sg5wa/tGpn+qp7b9yMZ/YcGaHrZ4YTLLl0asqjhVGNUXzHC+405WiI7iP38ZC3h
         78oUFV1856+tDNRRZcBk4TrEGY0so2vdR+NqmNSc=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:a1b1:2ca9:8cc0:4c56])
        by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id ued3RSeVec-FoYS30hb;
        Thu, 13 Jun 2019 11:15:51 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH v2 5/6] proc: use down_read_killable mmap_sem for
 /proc/pid/map_files
To:     Andrei Vagin <avagin@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Roman Gushchin <guro@fb.com>, Dmitry Safonov <dima@arista.com>
References: <156007465229.3335.10259979070641486905.stgit@buzz>
 <156007493995.3335.9595044802115356911.stgit@buzz>
 <20190612231426.GA3639@gmail.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <f15478b5-098f-e1be-0928-62f46cff77e7@yandex-team.ru>
Date:   Thu, 13 Jun 2019 11:15:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612231426.GA3639@gmail.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.06.2019 2:14, Andrei Vagin wrote:
> On Sun, Jun 09, 2019 at 01:09:00PM +0300, Konstantin Khlebnikov wrote:
>> Do not stuck forever if something wrong.
>> Killable lock allows to cleanup stuck tasks and simplifies investigation.
> 
> This patch breaks the CRIU project, because stat() returns EINTR instead
> of ENOENT:
> 
> [root@fc24 criu]# stat /proc/self/map_files/0-0
> stat: cannot stat '/proc/self/map_files/0-0': Interrupted system call

Good catch.

It seems CRIU tests has good coverage for darkest corners of kernel API.
Kernel CI projects should use it. I suppose you know how to promote this. =)

> 
> Here is one inline comment with the fix for this issue.
> 
>>
>> It seems ->d_revalidate() could return any error (except ECHILD) to
>> abort validation and pass error as result of lookup sequence.
>>
>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>> Reviewed-by: Roman Gushchin <guro@fb.com>
>> Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>
>> Reviewed-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> 
> It was nice to see all four of you in one place :).
> 
>> Acked-by: Michal Hocko <mhocko@suse.com>
>> ---
>>   fs/proc/base.c |   27 +++++++++++++++++++++------
>>   1 file changed, 21 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/proc/base.c b/fs/proc/base.c
>> index 9c8ca6cd3ce4..515ab29c2adf 100644
>> --- a/fs/proc/base.c
>> +++ b/fs/proc/base.c
>> @@ -1962,9 +1962,12 @@ static int map_files_d_revalidate(struct dentry *dentry, unsigned int flags)
>>   		goto out;
>>   
>>   	if (!dname_to_vma_addr(dentry, &vm_start, &vm_end)) {
>> -		down_read(&mm->mmap_sem);
>> -		exact_vma_exists = !!find_exact_vma(mm, vm_start, vm_end);
>> -		up_read(&mm->mmap_sem);
>> +		status = down_read_killable(&mm->mmap_sem);
>> +		if (!status) {
>> +			exact_vma_exists = !!find_exact_vma(mm, vm_start,
>> +							    vm_end);
>> +			up_read(&mm->mmap_sem);
>> +		}
>>   	}
>>   
>>   	mmput(mm);
>> @@ -2010,8 +2013,11 @@ static int map_files_get_link(struct dentry *dentry, struct path *path)
>>   	if (rc)
>>   		goto out_mmput;
>>   
>> +	rc = down_read_killable(&mm->mmap_sem);
>> +	if (rc)
>> +		goto out_mmput;
>> +
>>   	rc = -ENOENT;
>> -	down_read(&mm->mmap_sem);
>>   	vma = find_exact_vma(mm, vm_start, vm_end);
>>   	if (vma && vma->vm_file) {
>>   		*path = vma->vm_file->f_path;
>> @@ -2107,7 +2113,10 @@ static struct dentry *proc_map_files_lookup(struct inode *dir,
>>   	if (!mm)
>>   		goto out_put_task;
>>   
>> -	down_read(&mm->mmap_sem);
>> +	result = ERR_PTR(-EINTR);
>> +	if (down_read_killable(&mm->mmap_sem))
>> +		goto out_put_mm;
>> +
> 
> 	result = ERR_PTR(-ENOENT);
> 
>>   	vma = find_exact_vma(mm, vm_start, vm_end);
>>   	if (!vma)
>>   		goto out_no_vma;
>> @@ -2118,6 +2127,7 @@ static struct dentry *proc_map_files_lookup(struct inode *dir,
>>   
>>   out_no_vma:
>>   	up_read(&mm->mmap_sem);
>> +out_put_mm:
>>   	mmput(mm);
>>   out_put_task:
>>   	put_task_struct(task);
>> @@ -2160,7 +2170,12 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
>>   	mm = get_task_mm(task);
>>   	if (!mm)
>>   		goto out_put_task;
>> -	down_read(&mm->mmap_sem);
>> +
>> +	ret = down_read_killable(&mm->mmap_sem);
>> +	if (ret) {
>> +		mmput(mm);
>> +		goto out_put_task;
>> +	}
>>   
>>   	nr_files = 0;
>>   
