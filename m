Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10921C73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 04:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D008720820
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 04:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbfGNEQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 00:16:40 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:33933 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfGNEQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 00:16:40 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hmVwC-0003P9-VT; Sat, 13 Jul 2019 22:16:37 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hmVwB-0001g7-PM; Sat, 13 Jul 2019 22:16:36 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, izbyshev@ispras.ru, oleg@redhat.com,
        mkubecek@suse.cz, torvalds@linux-foundation.org,
        shasta@toxcorp.com, linux-kernel@vger.kernel.org,
        security@kernel.org
References: <20190713072855.GB23167@avx2> <20190713073209.GC23167@avx2>
Date:   Sat, 13 Jul 2019 23:16:29 -0500
In-Reply-To: <20190713073209.GC23167@avx2> (Alexey Dobriyan's message of "Sat,
        13 Jul 2019 10:32:09 +0300")
Message-ID: <87sgr9gsiq.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hmVwB-0001g7-PM;;;mid=<87sgr9gsiq.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18dsLem1sasOS7YMAwPV80tPD5caM+c7Uo=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] proc: revert /proc/*/cmdline rewrite
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan <adobriyan@gmail.com> writes:

> /proc/*/cmdline continues to cause problems:
>
> 	https://lkml.org/lkml/2019/4/5/825
> 	Subject get_mm_cmdline and userspace (Perl) changing argv0
>
> 	https://marc.info/?l=linux-kernel&m=156294831308786&w=4
> 	[PATCH] proc: Fix uninitialized byte read in get_mm_cmdline()
>
> This patch reverts implementation to the last known good state.
> Revert
>
> 	commit f5b65348fd77839b50e79bc0a5e536832ea52d8d
> 	proc: fix missing final NUL in get_mm_cmdline() rewrite
>
> 	commit 5ab8271899658042fabc5ae7e6a99066a210bc0e
> 	fs/proc: simplify and clarify get_mm_cmdline() function
>
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

Given that this fixes a regression and a bug.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

> ---
>
> 	Cc lists
>
>  fs/proc/base.c |  198 +++++++++++++++++++++++++++++++++------------------------
>  1 file changed, 118 insertions(+), 80 deletions(-)
>
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -210,16 +210,24 @@ static int proc_root_link(struct dentry *dentry, struct path *path)
>  }
>  
>  static ssize_t get_mm_cmdline(struct mm_struct *mm, char __user *buf,
> -			      size_t count, loff_t *ppos)
> +			      size_t _count, loff_t *pos)
>  {
> +	unsigned long count = _count;
>  	unsigned long arg_start, arg_end, env_start, env_end;
> -	unsigned long pos, len;
> +	unsigned long len1, len2, len;
> +	unsigned long p;
>  	char *page;
> +	ssize_t rv;
> +	char c;
>  
>  	/* Check if process spawned far enough to have cmdline. */
>  	if (!mm->env_end)
>  		return 0;
>  
> +	page = (char *)__get_free_page(GFP_KERNEL);
> +	if (!page)
> +		return -ENOMEM;
> +
>  	spin_lock(&mm->arg_lock);
>  	arg_start = mm->arg_start;
>  	arg_end = mm->arg_end;
> @@ -227,96 +235,126 @@ static ssize_t get_mm_cmdline(struct mm_struct *mm, char __user *buf,
>  	env_end = mm->env_end;
>  	spin_unlock(&mm->arg_lock);
>  
> -	if (arg_start >= arg_end)
> -		return 0;
> +	BUG_ON(arg_start > arg_end);
> +	BUG_ON(env_start > env_end);
> +
> +	len1 = arg_end - arg_start;
> +	len2 = env_end - env_start;
>  
> +	/* Empty ARGV. */
> +	if (len1 == 0) {
> +		rv = 0;
> +		goto out_free_page;
> +	}
>  	/*
> -	 * We have traditionally allowed the user to re-write
> -	 * the argument strings and overflow the end result
> -	 * into the environment section. But only do that if
> -	 * the environment area is contiguous to the arguments.
> +	 * Inherently racy -- command line shares address space
> +	 * with code and data.
>  	 */
> -	if (env_start != arg_end || env_start >= env_end)
> -		env_start = env_end = arg_end;
> -
> -	/* .. and limit it to a maximum of one page of slop */
> -	if (env_end >= arg_end + PAGE_SIZE)
> -		env_end = arg_end + PAGE_SIZE - 1;
> -
> -	/* We're not going to care if "*ppos" has high bits set */
> -	pos = arg_start + *ppos;
> -
> -	/* .. but we do check the result is in the proper range */
> -	if (pos < arg_start || pos >= env_end)
> -		return 0;
> -
> -	/* .. and we never go past env_end */
> -	if (env_end - pos < count)
> -		count = env_end - pos;
> -
> -	page = (char *)__get_free_page(GFP_KERNEL);
> -	if (!page)
> -		return -ENOMEM;
> -
> -	len = 0;
> -	while (count) {
> -		int got;
> -		size_t size = min_t(size_t, PAGE_SIZE, count);
> -		long offset;
> +	rv = access_remote_vm(mm, arg_end - 1, &c, 1, FOLL_ANON);
> +	if (rv <= 0)
> +		goto out_free_page;
> +
> +	rv = 0;
> +
> +	if (c == '\0') {
> +		/* Command line (set of strings) occupies whole ARGV. */
> +		if (len1 <= *pos)
> +			goto out_free_page;
> +
> +		p = arg_start + *pos;
> +		len = len1 - *pos;
> +		while (count > 0 && len > 0) {
> +			unsigned int _count;
> +			int nr_read;
> +
> +			_count = min3(count, len, PAGE_SIZE);
> +			nr_read = access_remote_vm(mm, p, page, _count, FOLL_ANON);
> +			if (nr_read < 0)
> +				rv = nr_read;
> +			if (nr_read <= 0)
> +				goto out_free_page;
> +
> +			if (copy_to_user(buf, page, nr_read)) {
> +				rv = -EFAULT;
> +				goto out_free_page;
> +			}
>  
> +			p	+= nr_read;
> +			len	-= nr_read;
> +			buf	+= nr_read;
> +			count	-= nr_read;
> +			rv	+= nr_read;
> +		}
> +	} else {
>  		/*
> -		 * Are we already starting past the official end?
> -		 * We always include the last byte that is *supposed*
> -		 * to be NUL
> +		 * Command line (1 string) occupies ARGV and
> +		 * extends into ENVP.
>  		 */
> -		offset = (pos >= arg_end) ? pos - arg_end + 1 : 0;
> -
> -		got = access_remote_vm(mm, pos - offset, page, size + offset, FOLL_ANON);
> -		if (got <= offset)
> -			break;
> -		got -= offset;
> -
> -		/* Don't walk past a NUL character once you hit arg_end */
> -		if (pos + got >= arg_end) {
> -			int n = 0;
> -
> -			/*
> -			 * If we started before 'arg_end' but ended up
> -			 * at or after it, we start the NUL character
> -			 * check at arg_end-1 (where we expect the normal
> -			 * EOF to be).
> -			 *
> -			 * NOTE! This is smaller than 'got', because
> -			 * pos + got >= arg_end
> -			 */
> -			if (pos < arg_end)
> -				n = arg_end - pos - 1;
> -
> -			/* Cut off at first NUL after 'n' */
> -			got = n + strnlen(page+n, offset+got-n);
> -			if (got < offset)
> -				break;
> -			got -= offset;
> -
> -			/* Include the NUL if it existed */
> -			if (got < size)
> -				got++;
> +		struct {
> +			unsigned long p;
> +			unsigned long len;
> +		} cmdline[2] = {
> +			{ .p = arg_start, .len = len1 },
> +			{ .p = env_start, .len = len2 },
> +		};
> +		loff_t pos1 = *pos;
> +		unsigned int i;
> +
> +		i = 0;
> +		while (i < 2 && pos1 >= cmdline[i].len) {
> +			pos1 -= cmdline[i].len;
> +			i++;
>  		}
> +		while (i < 2) {
> +			p = cmdline[i].p + pos1;
> +			len = cmdline[i].len - pos1;
> +			while (count > 0 && len > 0) {
> +				unsigned int _count, l;
> +				int nr_read;
> +				bool final;
> +
> +				_count = min3(count, len, PAGE_SIZE);
> +				nr_read = access_remote_vm(mm, p, page, _count, FOLL_ANON);
> +				if (nr_read < 0)
> +					rv = nr_read;
> +				if (nr_read <= 0)
> +					goto out_free_page;
> +
> +				/*
> +				 * Command line can be shorter than whole ARGV
> +				 * even if last "marker" byte says it is not.
> +				 */
> +				final = false;
> +				l = strnlen(page, nr_read);
> +				if (l < nr_read) {
> +					nr_read = l;
> +					final = true;
> +				}
> +
> +				if (copy_to_user(buf, page, nr_read)) {
> +					rv = -EFAULT;
> +					goto out_free_page;
> +				}
> +
> +				p	+= nr_read;
> +				len	-= nr_read;
> +				buf	+= nr_read;
> +				count	-= nr_read;
> +				rv	+= nr_read;
> +
> +				if (final)
> +					goto out_free_page;
> +			}
>  
> -		got -= copy_to_user(buf, page+offset, got);
> -		if (unlikely(!got)) {
> -			if (!len)
> -				len = -EFAULT;
> -			break;
> +			/* Only first chunk can be read partially. */
> +			pos1 = 0;
> +			i++;
>  		}
> -		pos += got;
> -		buf += got;
> -		len += got;
> -		count -= got;
>  	}
>  
> +out_free_page:
>  	free_page((unsigned long)page);
> -	return len;
> +	return rv;
>  }
>  
>  static ssize_t get_task_cmdline(struct task_struct *tsk, char __user *buf,
