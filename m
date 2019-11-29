Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E2BC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 15:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 050C42075C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 15:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfK2PEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 10:04:00 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6730 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726608AbfK2PD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 10:03:59 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0DE97E1BEBEA91AC02BC;
        Fri, 29 Nov 2019 23:03:54 +0800 (CST)
Received: from [127.0.0.1] (10.133.217.137) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Fri, 29 Nov 2019
 23:03:48 +0800
Subject: Re: [PATCH next 3/3] debugfs: introduce debugfs_create_seq[,_data]
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>
References: <20191129092752.169902-1-wangkefeng.wang@huawei.com>
 <20191129092752.169902-4-wangkefeng.wang@huawei.com>
 <20191129142212.GB3708031@kroah.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <35da2509-1dc4-699d-e209-b534691f6e37@huawei.com>
Date:   Fri, 29 Nov 2019 23:03:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20191129142212.GB3708031@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.217.137]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/11/29 22:22, Greg KH wrote:
> On Fri, Nov 29, 2019 at 05:27:52PM +0800, Kefeng Wang wrote:
>> Like proc_create_seq[,_data] in procfs, introduce a similar
>> debugfs_create_seq[,_data] function, which could drastically
>> reduces the boilerplate code.
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>  fs/debugfs/file.c       | 62 ++++++++++++++++++++++++++++++++++++++++-
>>  include/linux/debugfs.h | 16 +++++++++++
>>  2 files changed, 77 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
>> index 68f0c4b19bef..77522717c9fb 100644
>> --- a/fs/debugfs/file.c
>> +++ b/fs/debugfs/file.c
>> @@ -1107,7 +1107,10 @@ EXPORT_SYMBOL_GPL(debugfs_create_regset32);
>>  #endif /* CONFIG_HAS_IOMEM */
>>  
>>  struct debugfs_entry {
>> -	int (*read)(struct seq_file *seq, void *data);
>> +	union {
>> +		const struct seq_operations *seq_ops;
>> +		int (*read)(struct seq_file *seq, void *data);
>> +	};
>>  	void *data;
>>  };
>>  
>> @@ -1196,3 +1199,60 @@ struct dentry *debugfs_create_single_data(const char *name, umode_t mode,
>>  				   &debugfs_entry_ops);
>>  }
>>  EXPORT_SYMBOL_GPL(debugfs_create_single_data);
>> +
>> +static int debugfs_entry_seq_open(struct inode *inode, struct file *file)
>> +{
>> +	struct debugfs_entry *entry = inode->i_private;
>> +	int ret;
>> +
>> +	entry = debugfs_clear_lowest_bit(entry);
>> +
>> +	ret = seq_open(file, entry->seq_ops);
>> +	if (!ret && entry->data) {
>> +		struct seq_file *seq = file->private_data;
>> +		seq->private = entry->data;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static const struct file_operations debugfs_seq_fops = {
>> +	.open		= debugfs_entry_seq_open,
>> +	.read		= seq_read,
>> +	.llseek		= seq_lseek,
>> +	.release	= seq_release,
>> +};
>> +
>> +/**
>> + * debugfs_create_seq_data - create a file in the debugfs filesystem
>> + * @name: a pointer to a string containing the name of the file to create.
>> + * @mode: the permission that the file should have.
>> + * @parent: a pointer to the parent dentry for this file.  This should be a
>> + *          directory dentry if set.  If this parameter is NULL, then the
>> + *          file will be created in the root of the debugfs filesystem.
>> + * @data: a pointer to something that the caller will want to get to later
>> + *        on.  The inode.i_private pointer will point to this value on
>> + *        the open() call.
>> + * @seq_ops: seq_operations pointer of the seqfile.
>> + *
>> + * This function creates a file in debugfs with the extra data and a seq_ops.
>> + */
>> +struct dentry *debugfs_create_seq_data(const char *name, umode_t mode,
>> +				       struct dentry *parent, void *data,
>> +				       const struct seq_operations *seq_ops)
>> +{
>> +	struct debugfs_entry *entry;
>> +
>> +	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
>> +	if (!entry)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	entry->seq_ops = seq_ops;
>> +	entry->data = data;
>> +
>> +	entry = debugfs_set_lowest_bit(entry);
>> +
>> +	return debugfs_create_file(name, mode, parent, entry,
>> +				   &debugfs_seq_fops);
>> +}
>> +EXPORT_SYMBOL_GPL(debugfs_create_seq_data);
>> diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
>> index 82171f183e93..d32d49983547 100644
>> --- a/include/linux/debugfs.h
>> +++ b/include/linux/debugfs.h
>> @@ -147,6 +147,10 @@ struct dentry *debugfs_create_single_data(const char *name, umode_t mode,
>>  					  int (*read_fn)(struct seq_file *s,
>>  							 void *data));
>>  
>> +struct dentry *debugfs_create_seq_data(const char *name, umode_t mode,
>> +				       struct dentry *parent, void *data,
>> +				       const struct seq_operations *seq_ops);
>> +
>>  bool debugfs_initialized(void);
>>  
>>  ssize_t debugfs_read_file_bool(struct file *file, char __user *user_buf,
> 
> If you notice, I have been removing the return value of the
> debugfs_create_* functions over the past few kernel versions (look at
> 5.5-rc1 for a lot more).  Please don't add any new functions that also
> return a dentry that I then need to go and remove.

Hi Greg, see function debugfs_create_seq_data()and debugfs_create_single_data(),
they are wrapper function of debugfs_create_file(), when remove the debugfs file
called debugfs_remove(), some drivers could do such thing, we must return a dentry
to the caller.

> 
> Just have these be void functions, no need to return anything.
> 
> thanks,
> 
> greg k-h
> 
> .
> 

