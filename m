Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7A4C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB6FA218D2
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556109917;
	bh=SPZSMVr6z8nSB8TYQMEgvpbJgmsaw5UH5zLsRz+0/CM=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=GBo5X8HySBubGdtMvKo3T9CZnGnk7AbeKsNmm8UveOdVxrthQS7PiWrRV85NKXox0
	 478WtLTOFO5wcqYw3Gj7ioca8Lsdc73OZCpUDQ1REPV8j+Ut+aJDtHbqC4Ct77u+C4
	 +ewddzqZGf4+VGI+1zOp9FsQkAjqDh5+kjZMXnpc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730297AbfDXMpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:45:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:53348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730026AbfDXMpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:45:14 -0400
Received: from [192.168.0.101] (unknown [58.212.133.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42B58218B0;
        Wed, 24 Apr 2019 12:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556109913;
        bh=SPZSMVr6z8nSB8TYQMEgvpbJgmsaw5UH5zLsRz+0/CM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gzxPgVfOabD9Msp4zd8ZPs7nwd/w1LE/3mBb05VnGJuImWY6T/0Bnfoo8al+Ll2eq
         4Z1QMvReOu7ccjDSWLoXKsdebdkK8bpAPNReMeNRuxyDy8QJRZWxXyv67U0kji4MMg
         BjVu7OqQm4+67XB/at6xxFAa6NC0P+AzXnFTz+b8=
Subject: Re: [PATCH v2 4/5] f2fs: add tracepoint for f2fs_filemap_fault()
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20190415072219.1613-1-yuchao0@huawei.com>
 <20190424091456.GB38756@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <8919a08e-a548-7bd8-c43e-99596e33ca97@kernel.org>
Date:   Wed, 24 Apr 2019 20:45:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190424091456.GB38756@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-4-24 17:14, Jaegeuk Kim wrote:
> On 04/15, Chao Yu wrote:
>> This patch adds tracepoint for f2fs_filemap_fault().
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>> v2:
>> - fix wrong type of @ret parameter
>>  fs/f2fs/file.c              |  2 ++
>>  include/trace/events/f2fs.h | 26 ++++++++++++++++++++++++++
>>  2 files changed, 28 insertions(+)
>>
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index 30d49467578e..578486e03427 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -39,6 +39,8 @@ static vm_fault_t f2fs_filemap_fault(struct vm_fault *vmf)
>>  	ret = filemap_fault(vmf);
>>  	up_read(&F2FS_I(inode)->i_mmap_sem);
>>  
>> +	trace_f2fs_filemap_fault(inode, vmf->pgoff, ret);
> 
> In order to avoid wrong casting warning, how about this?

Confirmed, I used wrong type in v2, thanks for fixing this.

Thanks,

> 
> ---
>  include/trace/events/f2fs.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
> index abe763cc1d0b..c29dea7ac0fe 100644
> --- a/include/trace/events/f2fs.h
> +++ b/include/trace/events/f2fs.h
> @@ -1286,7 +1286,7 @@ DEFINE_EVENT(f2fs__page, f2fs_commit_inmem_page,
>  
>  TRACE_EVENT(f2fs_filemap_fault,
>  
> -	TP_PROTO(struct inode *inode, pgoff_t index, enum vm_fault_reason ret),
> +	TP_PROTO(struct inode *inode, pgoff_t index, vm_fault_t ret),
>  
>  	TP_ARGS(inode, index, ret),
>  
> @@ -1294,7 +1294,7 @@ TRACE_EVENT(f2fs_filemap_fault,
>  		__field(dev_t,	dev)
>  		__field(ino_t,	ino)
>  		__field(pgoff_t, index)
> -		__field(enum vm_fault_reason, ret)
> +		__field(vm_fault_t, ret)
>  	),
>  
>  	TP_fast_assign(
> @@ -1304,10 +1304,10 @@ TRACE_EVENT(f2fs_filemap_fault,
>  		__entry->ret	= ret;
>  	),
>  
> -	TP_printk("dev = (%d,%d), ino = %lu, index = %lu, ret = %u",
> +	TP_printk("dev = (%d,%d), ino = %lu, index = %lu, ret = %lx",
>  		show_dev_ino(__entry),
>  		(unsigned long)__entry->index,
> -		ret)
> +		(unsigned long)__entry->ret)
>  );
>  
>  TRACE_EVENT(f2fs_writepages,
> 
