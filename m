Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EC0C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 502EC21738
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbfDDOiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 10:38:00 -0400
Received: from www62.your-server.de ([213.133.104.62]:38124 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728487AbfDDOh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 10:37:58 -0400
Received: from [88.198.220.132] (helo=sslproxy03.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hC3V7-00021I-3o; Thu, 04 Apr 2019 16:37:57 +0200
Received: from [2a02:120b:c3fc:feb0:dda7:bd28:a848:50e2] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hC3V6-0001An-SX; Thu, 04 Apr 2019 16:37:56 +0200
Subject: Re: [PATCH v2 bpf-next 05/21] bpf: Introduce
 bpf_sysctl_{get,set}_new_value helpers
To:     Andrey Ignatov <rdna@fb.com>, netdev@vger.kernel.org
Cc:     ast@kernel.org, guro@fb.com, kernel-team@fb.com,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <cover.1553560620.git.rdna@fb.com>
 <1b3f7545f3d14e2277a3206eef2c3fea6329245d.1553560620.git.rdna@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <368fcbf5-4144-c95b-d39a-d756546a67d5@iogearbox.net>
Date:   Thu, 4 Apr 2019 16:37:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1b3f7545f3d14e2277a3206eef2c3fea6329245d.1553560620.git.rdna@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25409/Thu Apr  4 09:53:59 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/26/2019 01:43 AM, Andrey Ignatov wrote:
> Add helpers to work with new value being written to sysctl by user
> space.
> 
> bpf_sysctl_get_new_value() copies value being written to sysctl into
> provided buffer.
> 
> bpf_sysctl_set_new_value() overrides new value being written by user
> space with a one from provided buffer. Buffer should contain string
> representation of the value, similar to what can be seen in /proc/sys/.
> 
> Both helpers can be used only on sysctl write.
> 
> File position matters and can be managed by an interface that will be
> introduced separately. E.g. if user space calls sys_write to a file in
> /proc/sys/ at file position = X, where X > 0, then the value set by
> bpf_sysctl_set_new_value() will be written starting from X. If program
> wants to override whole value with specified buffer, file position has
> to be set to zero.
> 
> Documentation for the new helpers is provided in bpf.h UAPI.
> 
> Signed-off-by: Andrey Ignatov <rdna@fb.com>
> ---
>  fs/proc/proc_sysctl.c      | 22 ++++++++---
>  include/linux/bpf-cgroup.h |  8 ++--
>  include/linux/filter.h     |  3 ++
>  include/uapi/linux/bpf.h   | 38 +++++++++++++++++-
>  kernel/bpf/cgroup.c        | 81 +++++++++++++++++++++++++++++++++++++-
>  5 files changed, 142 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index 72f4a096c146..4d1ab22774f7 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -570,8 +570,8 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *buf,
>  	struct inode *inode = file_inode(filp);
>  	struct ctl_table_header *head = grab_header(inode);
>  	struct ctl_table *table = PROC_I(inode)->sysctl_entry;
> +	void *new_buf = NULL;
>  	ssize_t error;
> -	size_t res;
>  
>  	if (IS_ERR(head))
>  		return PTR_ERR(head);
> @@ -589,15 +589,27 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *buf,
>  	if (!table->proc_handler)
>  		goto out;
>  
> -	error = BPF_CGROUP_RUN_PROG_SYSCTL(head, table, write);
> +	error = BPF_CGROUP_RUN_PROG_SYSCTL(head, table, write, buf, &count,
> +					   &new_buf);
>  	if (error)
>  		goto out;
>  
>  	/* careful: calling conventions are nasty here */
> -	res = count;
> -	error = table->proc_handler(table, write, buf, &res, ppos);
> +	if (new_buf) {
> +		mm_segment_t old_fs;
> +
> +		old_fs = get_fs();
> +		set_fs(KERNEL_DS);
> +		error = table->proc_handler(table, write, (void __user *)new_buf,
> +					    &count, ppos);
> +		set_fs(old_fs);

From quick glance on the set, the above stood out. Afaik, there is an ongoing
effort by Al and other fs/core folks (as visible in the git log) to get rid of
set_fs() calls in the tree with the goal of eliminating this interface /entirely/
(more context on 'why' here: https://lwn.net/Articles/722267/). Is there a better
way to achieve the above w/o needing it?

> +		kfree(new_buf);
> +	} else {
> +		error = table->proc_handler(table, write, buf, &count, ppos);
> +	}
> +
>  	if (!error)
> -		error = res;
> +		error = count;
>  out:
>  	sysctl_head_finish(head);
>  
> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> index b1c45da20a26..1e97271f9a10 100644
> --- a/include/linux/bpf-cgroup.h
> +++ b/include/linux/bpf-cgroup.h
> @@ -113,7 +113,8 @@ int __cgroup_bpf_check_dev_permission(short dev_type, u32 major, u32 minor,
>  
>  int __cgroup_bpf_run_filter_sysctl(struct ctl_table_header *head,
>  				   struct ctl_table *table, int write,
> -				   enum bpf_attach_type type);
> +				   void __user *buf, size_t *pcount,
> +				   void **new_buf, enum bpf_attach_type type);
>  
>  static inline enum bpf_cgroup_storage_type cgroup_storage_type(
>  	struct bpf_map *map)
> @@ -261,11 +262,12 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map *map, void *key,
>  })
>  
>  
> -#define BPF_CGROUP_RUN_PROG_SYSCTL(head, table, write)			       \
> +#define BPF_CGROUP_RUN_PROG_SYSCTL(head, table, write, buf, count, nbuf)       \
>  ({									       \
>  	int __ret = 0;							       \
>  	if (cgroup_bpf_enabled)						       \
>  		__ret = __cgroup_bpf_run_filter_sysctl(head, table, write,     \
> +						       buf, count, nbuf,       \
>  						       BPF_CGROUP_SYSCTL);     \
>  	__ret;								       \
>  })
> @@ -338,7 +340,7 @@ static inline int bpf_percpu_cgroup_storage_update(struct bpf_map *map,
>  #define BPF_CGROUP_RUN_PROG_UDP6_SENDMSG_LOCK(sk, uaddr, t_ctx) ({ 0; })
>  #define BPF_CGROUP_RUN_PROG_SOCK_OPS(sock_ops) ({ 0; })
>  #define BPF_CGROUP_RUN_PROG_DEVICE_CGROUP(type,major,minor,access) ({ 0; })
> -#define BPF_CGROUP_RUN_PROG_SYSCTL(head, table, write) ({ 0; })
> +#define BPF_CGROUP_RUN_PROG_SYSCTL(head,table,write,buf,count,nbuf) ({ 0; })
>  
>  #define for_each_cgroup_storage_type(stype) for (; false; )
>  
