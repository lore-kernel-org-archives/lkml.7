Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCADC04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 12:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B5720833
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 12:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfEPMy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 08:54:28 -0400
Received: from relay.sw.ru ([185.231.240.75]:51428 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbfEPMy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 08:54:27 -0400
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1hRFta-0006e6-T8; Thu, 16 May 2019 15:54:02 +0300
Subject: Re: [PATCH RFC 5/5] mm: Add process_vm_mmap()
To:     Kees Cook <keescook@chromium.org>
Cc:     akpm@linux-foundation.org, dan.j.williams@intel.com,
        mhocko@suse.com, keith.busch@intel.com,
        kirill.shutemov@linux.intel.com, pasha.tatashin@oracle.com,
        alexander.h.duyck@linux.intel.com, ira.weiny@intel.com,
        andreyknvl@google.com, arunks@codeaurora.org, vbabka@suse.cz,
        cl@linux.com, riel@surriel.com, hannes@cmpxchg.org,
        npiggin@gmail.com, mathieu.desnoyers@efficios.com,
        shakeelb@google.com, guro@fb.com, aarcange@redhat.com,
        hughd@google.com, jglisse@redhat.com, mgorman@techsingularity.net,
        daniel.m.jordan@oracle.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jann Horn <jannh@google.com>,
        Matthew Wilcox <willy@infradead.org>
References: <155793276388.13922.18064660723547377633.stgit@localhost.localdomain>
 <155793310413.13922.4749810361688380807.stgit@localhost.localdomain>
 <201905151018.42009E4868@keescook>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <f1290283-1528-35da-367a-8c1c62d52354@virtuozzo.com>
Date:   Thu, 16 May 2019 15:54:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <201905151018.42009E4868@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Kees,

On 15.05.2019 21:29, Kees Cook wrote:
> On Wed, May 15, 2019 at 06:11:44PM +0300, Kirill Tkhai wrote:
>> This adds a new syscall to map from or to another
>> process vma. Flag PVMMAP_FIXED may be specified,
>> its meaning is similar to mmap()'s MAP_FIXED.
>>
>> @pid > 0 means to map from process of @pid to current,
>> @pid < 0 means to map from current to @pid process.
>>
>> VMA are merged on destination, i.e. if source task
>> has VMA with address [start; end], and we map it sequentially
>> twice:
>>
>> process_vm_mmap(@pid, start, start + (end - start)/2, ...);
>> process_vm_mmap(@pid, start + (end - start)/2, end,   ...);
>>
>> the destination task will have single vma [start, end].
>>
>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>> ---
>> [...]
>> diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
>> index abd238d0f7a4..44cb6cf77e93 100644
>> --- a/include/uapi/asm-generic/mman-common.h
>> +++ b/include/uapi/asm-generic/mman-common.h
>> @@ -28,6 +28,11 @@
>>  /* 0x0100 - 0x80000 flags are defined in asm-generic/mman.h */
>>  #define MAP_FIXED_NOREPLACE	0x100000	/* MAP_FIXED which doesn't unmap underlying mapping */
>>  
>> +/*
>> + * Flags for process_vm_mmap
>> + */
>> +#define PVMMAP_FIXED	0x01
> 
> I think PVMMAP_FIXED_NOREPLACE should be included from the start too. It
> seems like providing the "do not overwrite existing remote mapping"
> from the start would be good. :)

Good idea :)
>> [...]
>> +unsigned long mmap_process_vm(struct mm_struct *src_mm,
>> +			      unsigned long src_addr,
>> +			      struct mm_struct *dst_mm,
>> +			      unsigned long dst_addr,
>> +			      unsigned long len,
>> +			      unsigned long flags,
>> +			      struct list_head *uf)
>> +{
>> +	struct vm_area_struct *src_vma = find_vma(src_mm, src_addr);
>> +	unsigned long gua_flags = 0;
>> +	unsigned long ret;
>> +
>> +	if (!src_vma || src_vma->vm_start > src_addr)
>> +		return -EFAULT;
>> +	if (len > src_vma->vm_end - src_addr)
>> +		return -EFAULT;
>> +	if (src_vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP))
>> +		return -EFAULT;
>> +	if (is_vm_hugetlb_page(src_vma) || (src_vma->vm_flags & VM_IO))
>> +		return -EINVAL;
>> +        if (dst_mm->map_count + 2 > sysctl_max_map_count)
>> +                return -ENOMEM;
> 
> whitespace damage? Also, I think this should be:
> 
> 	if (dst_mm->map_count >= sysctl_max_map_count - 2) ...

Sure, thanks.

>> +	if (!IS_NULL_VM_UFFD_CTX(&src_vma->vm_userfaultfd_ctx))
>> +		return -ENOTSUPP;
> 
> Are these various checks from other places? I see simliar things in
> vma_to_resize(). Should these be collected in a single helper for common
> checks in various places?

Yes, some of them are from other places. VM_DONTEXPAND check is because of
we want to filter mappings like AIO rings. Cloning of VM_IO vma may require
additional permissions (and more work), so it's not supported now.

It looks like, we may move find_vma() and first four checks into a helper,
which is common with the function you pointed.

>> +
>> +	if (src_vma->vm_flags & VM_SHARED)
>> +		gua_flags |= MAP_SHARED;
>> +	else
>> +		gua_flags |= MAP_PRIVATE;
>> +	if (vma_is_anonymous(src_vma) || vma_is_shmem(src_vma))
>> +		gua_flags |= MAP_ANONYMOUS;
>> +	if (flags & PVMMAP_FIXED)
>> +		gua_flags |= MAP_FIXED;
> 
> And obviously add MAP_FIXED_NOREPLACE here too...
>>> +	ret = get_unmapped_area(src_vma->vm_file, dst_addr, len,
>> +				src_vma->vm_pgoff +
>> +				((src_addr - src_vma->vm_start) >> PAGE_SHIFT),
>> +				gua_flags);
>> +	if (offset_in_page(ret))
>> +                return ret;
>> +	dst_addr = ret;
>> +
>> +	/* Check against address space limit. */
>> +	if (!may_expand_vm(dst_mm, src_vma->vm_flags, len >> PAGE_SHIFT)) {
>> +		unsigned long nr_pages;
>> +
>> +		nr_pages = count_vma_pages_range(dst_mm, dst_addr, dst_addr + len);
>> +		if (!may_expand_vm(dst_mm, src_vma->vm_flags,
>> +					(len >> PAGE_SHIFT) - nr_pages))
>> +			return -ENOMEM;
>> +	}
>> +
>> +	ret = do_mmap_process_vm(src_vma, src_addr, dst_mm, dst_addr, len, uf);
>> +	if (ret)
>> +                return ret;
>> +
>> +	return dst_addr;
>> +}
>> +
>>  /*
>>   * Return true if the calling process may expand its vm space by the passed
>>   * number of pages
>> diff --git a/mm/process_vm_access.c b/mm/process_vm_access.c
>> index a447092d4635..7fca2c5c7edd 100644
>> --- a/mm/process_vm_access.c
>> +++ b/mm/process_vm_access.c
>> @@ -17,6 +17,8 @@
>>  #include <linux/ptrace.h>
>>  #include <linux/slab.h>
>>  #include <linux/syscalls.h>
>> +#include <linux/mman.h>
>> +#include <linux/userfaultfd_k.h>
>>  
>>  #ifdef CONFIG_COMPAT
>>  #include <linux/compat.h>
>> @@ -295,6 +297,68 @@ static ssize_t process_vm_rw(pid_t pid,
>>  	return rc;
>>  }
>>  
>> +static unsigned long process_vm_mmap(pid_t pid, unsigned long src_addr,
>> +				     unsigned long len, unsigned long dst_addr,
>> +				     unsigned long flags)
>> +{
>> +	struct mm_struct *src_mm, *dst_mm;
>> +	struct task_struct *task;
>> +	unsigned long ret;
>> +	int depth = 0;
>> +	LIST_HEAD(uf);
>> +
>> +	len = PAGE_ALIGN(len);
>> +	src_addr = round_down(src_addr, PAGE_SIZE);
>> +	if (flags & PVMMAP_FIXED)
>> +		dst_addr = round_down(dst_addr, PAGE_SIZE);
>> +	else
>> +		dst_addr = round_hint_to_min(dst_addr);
>> +
>> +	if ((flags & ~PVMMAP_FIXED) || len == 0 || len > TASK_SIZE ||
>> +	    src_addr == 0 || dst_addr > TASK_SIZE - len)
>> +		return -EINVAL;
> 
> And PVMMAP_FIXED_NOREPLACE here...
> 
>> +	task = find_get_task_by_vpid(pid > 0 ? pid : -pid);
>> +	if (!task)
>> +		return -ESRCH;
>> +	if (unlikely(task->flags & PF_KTHREAD)) {
>> +		ret = -EINVAL;
>> +		goto out_put_task;
>> +	}
>> +
>> +	src_mm = mm_access(task, PTRACE_MODE_ATTACH_REALCREDS);
>> +	if (!src_mm || IS_ERR(src_mm)) {
>> +		ret = IS_ERR(src_mm) ? PTR_ERR(src_mm) : -ESRCH;
>> +		goto out_put_task;
>> +	}
>> +	dst_mm = current->mm;
>> +	mmget(dst_mm);
>> +
>> +	if (pid < 0)
>> +		swap(src_mm, dst_mm);
>> +
>> +	/* Double lock mm in address order: smallest is the first */
>> +	if (src_mm < dst_mm) {
>> +		down_write(&src_mm->mmap_sem);
>> +		depth = SINGLE_DEPTH_NESTING;
>> +	}
>> +	down_write_nested(&dst_mm->mmap_sem, depth);
>> +	if (src_mm > dst_mm)
>> +		down_write_nested(&src_mm->mmap_sem, SINGLE_DEPTH_NESTING);
>> +
>> +	ret = mmap_process_vm(src_mm, src_addr, dst_mm, dst_addr, len, flags, &uf);
>> +
>> +	up_write(&dst_mm->mmap_sem);
>> +	if (dst_mm != src_mm)
>> +		up_write(&src_mm->mmap_sem);
>> +
>> +	userfaultfd_unmap_complete(dst_mm, &uf);
>> +	mmput(src_mm);
>> +	mmput(dst_mm);
>> +out_put_task:
>> +	put_task_struct(task);
>> +	return ret;
>> +}
>> +
>>  SYSCALL_DEFINE6(process_vm_readv, pid_t, pid, const struct iovec __user *, lvec,
>>  		unsigned long, liovcnt, const struct iovec __user *, rvec,
>>  		unsigned long, riovcnt,	unsigned long, flags)
>> @@ -310,6 +374,13 @@ SYSCALL_DEFINE6(process_vm_writev, pid_t, pid,
>>  	return process_vm_rw(pid, lvec, liovcnt, rvec, riovcnt, flags, 1);
>>  }
>>  
>> +SYSCALL_DEFINE5(process_vm_mmap, pid_t, pid,
>> +		unsigned long, src_addr, unsigned long, len,
>> +		unsigned long, dst_addr, unsigned long, flags)
>> +{
>> +	return process_vm_mmap(pid, src_addr, len, dst_addr, flags);
>> +}
>> +
>>  #ifdef CONFIG_COMPAT
>>  
>>  static ssize_t
>>
> 
> Looks pretty interesting. I do wonder about "ATTACH" being a sufficient
> description of this feature. "Give me your VMA" and "take this VMA"
> is quite a bit stronger than "give me a copy of that memory" and "I
> will write to your memory" in the sense that memory content changes are
> now happening directly instead of through syscalls. But it's not much
> different from regular shared memory, so, I guess it's fine? :)

Yeah, as a conception it's similar to regular shared memory and to duplication
of vma and PTEs we have during fork(). There are no much differences.
Next time I'll advance the description to focus more on VMA, than on memory.

Thanks for your comments.

Kirill
