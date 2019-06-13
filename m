Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9675CC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 672B92080A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560445222;
	bh=NTkyzDj/QTOLghrPG/JLDkCzWtcmWPclnCXZ6csi8dA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=BpfIw5NvddccACZmJqkvhAiekLAmWRQ3EwfuB1PcFAUHroV5jd0Cbwxa6ylavMKZK
	 oag/bBqImrCGPBQ62hLudX37chwxbiGPgtxvCHK/ZYm4Fo3YcV1NUj0W9gbJ5kbXWD
	 pch8sS7TgIALwuG0D1CXFCOH/nUE/1hFkr25NbHY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404501AbfFMRAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:00:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729779AbfFMAEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 20:04:31 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8381A215EA;
        Thu, 13 Jun 2019 00:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560384270;
        bh=NTkyzDj/QTOLghrPG/JLDkCzWtcmWPclnCXZ6csi8dA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PwhK9KDIoVeC2KXyMTN6hRechTgZcxmHUKfC6o0xKoyJM52N4EE9Tk90KuatIgf9i
         3X905okdRCZm9quqBHQxd1WrrwOO1YuXMgfgt3pkNwWDgP6kbVmVhXk3xT+PbA37ho
         198aMxiCu+sXlojynnQhbEz6gXddsNXhRzs7LkF4=
Date:   Wed, 12 Jun 2019 17:04:29 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Michal =?ISO-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Roman Gushchin <guro@fb.com>, Dmitry Safonov <dima@arista.com>
Subject: Re: [PATCH v2 5/6] proc: use down_read_killable mmap_sem for
 /proc/pid/map_files
Message-Id: <20190612170429.baaae5fe6d84b864508a3ec5@linux-foundation.org>
In-Reply-To: <20190612231426.GA3639@gmail.com>
References: <156007465229.3335.10259979070641486905.stgit@buzz>
        <156007493995.3335.9595044802115356911.stgit@buzz>
        <20190612231426.GA3639@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jun 2019 16:14:28 -0700 Andrei Vagin <avagin@gmail.com> wrote:

> On Sun, Jun 09, 2019 at 01:09:00PM +0300, Konstantin Khlebnikov wrote:
> > Do not stuck forever if something wrong.
> > Killable lock allows to cleanup stuck tasks and simplifies investigation.
> 
> This patch breaks the CRIU project, because stat() returns EINTR instead
> of ENOENT:
> 
> [root@fc24 criu]# stat /proc/self/map_files/0-0
> stat: cannot stat '/proc/self/map_files/0-0': Interrupted system call
> 
> Here is one inline comment with the fix for this issue.
> 
> > @@ -2107,7 +2113,10 @@ static struct dentry *proc_map_files_lookup(struct inode *dir,
> >  	if (!mm)
> >  		goto out_put_task;
> >  
> > -	down_read(&mm->mmap_sem);
> > +	result = ERR_PTR(-EINTR);
> > +	if (down_read_killable(&mm->mmap_sem))
> > +		goto out_put_mm;
> > +
> 
> 	result = ERR_PTR(-ENOENT);
> 

yes, thanks.

--- a/fs/proc/base.c~proc-use-down_read_killable-mmap_sem-for-proc-pid-map_files-fix
+++ a/fs/proc/base.c
@@ -2117,6 +2117,7 @@ static struct dentry *proc_map_files_loo
 	if (down_read_killable(&mm->mmap_sem))
 		goto out_put_mm;
 
+	result = ERR_PTR(-ENOENT);
 	vma = find_exact_vma(mm, vm_start, vm_end);
 	if (!vma)
 		goto out_no_vma;



We started doing this trick of using

	ret = -EFOO;
	if (something)
		goto out;

decades ago because it generated slightly better code.  I rather doubt
whether that's still the case.

In fact this:

--- a/fs/proc/base.c~a
+++ a/fs/proc/base.c
@@ -2096,35 +2096,45 @@ static struct dentry *proc_map_files_loo
 	struct dentry *result;
 	struct mm_struct *mm;
 
-	result = ERR_PTR(-ENOENT);
 	task = get_proc_task(dir);
-	if (!task)
+	if (!task) {
+		result = ERR_PTR(-ENOENT);
 		goto out;
+	}
 
-	result = ERR_PTR(-EACCES);
-	if (!ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
+	if (!ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS)) {
+		result = ERR_PTR(-EACCES);
 		goto out_put_task;
+	}
 
-	result = ERR_PTR(-ENOENT);
-	if (dname_to_vma_addr(dentry, &vm_start, &vm_end))
+	if (dname_to_vma_addr(dentry, &vm_start, &vm_end)) {
+		result = ERR_PTR(-ENOENT);
 		goto out_put_task;
+	}
 
 	mm = get_task_mm(task);
-	if (!mm)
+	if (!mm) {
+		result = ERR_PTR(-ENOENT);
 		goto out_put_task;
+	}
 
-	result = ERR_PTR(-EINTR);
-	if (down_read_killable(&mm->mmap_sem))
+	if (down_read_killable(&mm->mmap_sem)) {
+		result = ERR_PTR(-EINTR);
 		goto out_put_mm;
+	}
 
-	result = ERR_PTR(-ENOENT);
 	vma = find_exact_vma(mm, vm_start, vm_end);
-	if (!vma)
+	if (!vma) {
+		result = ERR_PTR(-ENOENT);
 		goto out_no_vma;
+	}
 
-	if (vma->vm_file)
+	if (vma->vm_file) {
 		result = proc_map_files_instantiate(dentry, task,
 				(void *)(unsigned long)vma->vm_file->f_mode);
+	} else {
+		result = ERR_PTR(-ENOENT);
+	}
 
 out_no_vma:
 	up_read(&mm->mmap_sem);

makes no change to the generated assembly with gcc-7.2.0.

And I do think that the above style is clearer and more reliable, as
this bug demonstrates.

