Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D990DC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 02:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92EDE218AE
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 02:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551407362;
	bh=jJdgpX1L47vSLflN1xQQdcVG1MpizQEHl3YKACjxcmI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=GYrd1g0GsbsbeA2DzFs+lJwGH/Hr586hDLSs9qF+iyygQRh2F1KHoiCN2T0k7CDY8
	 LAZFDgZgwFIv/KU2nB9hS4v/H23+rcLMBDUEYXLKtAhRQSqCV2/PgUEaKH2NRdOHtp
	 +8tZKL8xlYsDs1nsoT9r/rbgytP8e6XmSLipHd8k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731324AbfCAC3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 21:29:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:34500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725896AbfCAC3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 21:29:20 -0500
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 727B120863;
        Fri,  1 Mar 2019 02:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551407358;
        bh=jJdgpX1L47vSLflN1xQQdcVG1MpizQEHl3YKACjxcmI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZFT5RBPhr/4YRUs20kfnwuZH39H+JLOmAPnVABFgLg9cV4Ue5tnbdbrmKYIyUF3tG
         eKTuaGqfFAXh5ZOA7TymG2vaypwpaHCFDlxs0EBIJt324UI0nSzVpUYiNf4mUFaNxk
         ReL31c2ZGYKD38hQtNtp1g6FSp1F9S7JqjNseuoE=
Date:   Fri, 1 Mar 2019 11:29:15 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Yonghong Song <yhs@fb.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Shuah Khan" <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy Lutomirski" <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        "Andy Lutomirski" <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v5 3/6] uaccess: Add non-pagefault user-space read
 functions
Message-Id: <20190301112915.f00e5d5c894f73da50746bcf@kernel.org>
In-Reply-To: <40eae910-16f3-8c6f-6cc7-c52b77b30ccd@fb.com>
References: <155136974478.2968.3105123100519786079.stgit@devbox>
        <155136983467.2968.13980231890937828195.stgit@devbox>
        <40eae910-16f3-8c6f-6cc7-c52b77b30ccd@fb.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yonghong,

On Thu, 28 Feb 2019 22:49:43 +0000
Yonghong Song <yhs@fb.com> wrote:

> 
> 
> On 2/28/19 8:03 AM, Masami Hiramatsu wrote:
> > Add probe_user_read(), strncpy_from_unsafe_user() and
> > strnlen_unsafe_user() which allows caller to access user-space
> > in IRQ context.
> > 
> > Current probe_kernel_read() and strncpy_from_unsafe() are
> > not available for user-space memory, because it sets
> > KERNEL_DS while accessing data. On some arch, user address
> > space and kernel address space can be co-exist, but others
> > can not. In that case, setting KERNEL_DS means given
> 
> Just curious. Given the list of arch's currently linux supports,
> do you know which arch's fall into "user address space and
> kernel address space" can co-exist, and which arch's cannot?

As far as I can heard, (and based on probe_kernel_read() failure)
sparc32 (and sparc64?), arm64, and s390 will not work.
x86 works, but if user patch the 4G/4G, it shouldn't work.

Thank you,

> 
> Thanks!
> 
> Yonghong
> 
> 
> > address is treated as a kernel address space.
> > Also strnlen_user() is only available from user context since
> > it can sleep if pagefault is enabled.
> > 
> > To access user-space memory without pagefault, we need
> > these new functions which sets USER_DS while accessing
> > the data.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >    Changes in v5:
> >     - Simplify probe_user_read() (Thanks, Peter!)
> >     - Add strnlen_unsafe_user()
> >    Changes in v3:
> >     - Use user_access_ok() for probe_user_read().
> >    Changes in v2:
> >     - Simplify strncpy_from_unsafe_user() using strncpy_from_user()
> >       according to Linus's suggestion.
> >     - Simplify probe_user_read() not using intermediate function.
> > ---
> >   include/linux/uaccess.h |   14 +++++
> >   mm/maccess.c            |  122 +++++++++++++++++++++++++++++++++++++++++++++--
> >   2 files changed, 130 insertions(+), 6 deletions(-)
> > 
> > diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> > index 1afd9dfabe67..5be7f9adb418 100644
> > --- a/include/linux/uaccess.h
> > +++ b/include/linux/uaccess.h
> > @@ -258,6 +258,17 @@ extern long probe_kernel_read(void *dst, const void *src, size_t size);
> >   extern long __probe_kernel_read(void *dst, const void *src, size_t size);
> >   
> >   /*
> > + * probe_user_read(): safely attempt to read from a location in user space
> > + * @dst: pointer to the buffer that shall take the data
> > + * @src: address to read from
> > + * @size: size of the data chunk
> > + *
> > + * Safely read from address @src to the buffer at @dst.  If a kernel fault
> > + * happens, handle that and return -EFAULT.
> > + */
> > +extern long probe_user_read(void *dst, const void __user *src, size_t size);
> > +
> > +/*
> >    * probe_kernel_write(): safely attempt to write to a location
> >    * @dst: address to write to
> >    * @src: pointer to the data that shall be written
> > @@ -270,6 +281,9 @@ extern long notrace probe_kernel_write(void *dst, const void *src, size_t size);
> >   extern long notrace __probe_kernel_write(void *dst, const void *src, size_t size);
> >   
> >   extern long strncpy_from_unsafe(char *dst, const void *unsafe_addr, long count);
> > +extern long strncpy_from_unsafe_user(char *dst, const void __user *unsafe_addr,
> > +				     long count);
> > +extern long strnlen_unsafe_user(const void __user *unsafe_addr, long count);
> >   
> >   /**
> >    * probe_kernel_address(): safely attempt to read from a location
> > diff --git a/mm/maccess.c b/mm/maccess.c
> > index ec00be51a24f..d1b2ec78d9ef 100644
> > --- a/mm/maccess.c
> > +++ b/mm/maccess.c
> > @@ -5,8 +5,20 @@
> >   #include <linux/mm.h>
> >   #include <linux/uaccess.h>
> >   
> > +static __always_inline long
> > +probe_read_common(void *dst, const void __user *src, size_t size)
> > +{
> > +	long ret;
> > +
> > +	pagefault_disable();
> > +	ret = __copy_from_user_inatomic(dst, src, size);
> > +	pagefault_enable();
> > +
> > +	return ret ? -EFAULT : 0;
> > +}
> > +
> >   /**
> > - * probe_kernel_read(): safely attempt to read from a location
> > + * probe_kernel_read(): safely attempt to read from a kernel-space location
> >    * @dst: pointer to the buffer that shall take the data
> >    * @src: address to read from
> >    * @size: size of the data chunk
> > @@ -29,17 +41,45 @@ long __probe_kernel_read(void *dst, const void *src, size_t size)
> >   	mm_segment_t old_fs = get_fs();
> >   
> >   	set_fs(KERNEL_DS);
> > -	pagefault_disable();
> > -	ret = __copy_from_user_inatomic(dst,
> > -			(__force const void __user *)src, size);
> > -	pagefault_enable();
> > +	ret = probe_read_common(dst, (__force const void __user *)src, size);
> >   	set_fs(old_fs);
> >   
> > -	return ret ? -EFAULT : 0;
> > +	return ret;
> >   }
> >   EXPORT_SYMBOL_GPL(probe_kernel_read);
> >   
> >   /**
> > + * probe_user_read(): safely attempt to read from a user-space location
> > + * @dst: pointer to the buffer that shall take the data
> > + * @src: address to read from. This must be a user address.
> > + * @size: size of the data chunk
> > + *
> > + * Safely read from user address @src to the buffer at @dst. If a kernel fault
> > + * happens, handle that and return -EFAULT.
> > + */
> > +
> > +long __weak probe_user_read(void *dst, const void __user *src, size_t size)
> > +    __attribute__((alias("__probe_user_read")));
> > +
> > +long __probe_user_read(void *dst, const void __user *src, size_t size)
> > +{
> > +	long ret = -EFAULT;
> > +	mm_segment_t old_fs = get_fs();
> > +
> > +	/*
> > +	 * Since this can be called in IRQ context, we carefully set the
> > +	 * USER_DS and use user_access_ok() which checks segment setting
> > +	 * instead of task context.
> > +	 */
> > +	set_fs(USER_DS);
> > +	if (user_access_ok(src, size))
> > +		ret = probe_read_common(dst, src, size);
> > +	set_fs(old_fs);
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(probe_user_read);
> > +
> > +/**
> >    * probe_kernel_write(): safely attempt to write to a location
> >    * @dst: address to write to
> >    * @src: pointer to the data that shall be written
> > @@ -66,6 +106,7 @@ long __probe_kernel_write(void *dst, const void *src, size_t size)
> >   }
> >   EXPORT_SYMBOL_GPL(probe_kernel_write);
> >   
> > +
> >   /**
> >    * strncpy_from_unsafe: - Copy a NUL terminated string from unsafe address.
> >    * @dst:   Destination address, in kernel space.  This buffer must be at
> > @@ -105,3 +146,72 @@ long strncpy_from_unsafe(char *dst, const void *unsafe_addr, long count)
> >   
> >   	return ret ? -EFAULT : src - unsafe_addr;
> >   }
> > +
> > +/**
> > + * strncpy_from_unsafe_user: - Copy a NUL terminated string from unsafe user
> > + *				address.
> > + * @dst:   Destination address, in kernel space.  This buffer must be at
> > + *         least @count bytes long.
> > + * @unsafe_addr: Unsafe user address.
> > + * @count: Maximum number of bytes to copy, including the trailing NUL.
> > + *
> > + * Copies a NUL-terminated string from unsafe user address to kernel buffer.
> > + *
> > + * On success, returns the length of the string INCLUDING the trailing NUL.
> > + *
> > + * If access fails, returns -EFAULT (some data may have been copied
> > + * and the trailing NUL added).
> > + *
> > + * If @count is smaller than the length of the string, copies @count-1 bytes,
> > + * sets the last byte of @dst buffer to NUL and returns @count.
> > + */
> > +long strncpy_from_unsafe_user(char *dst, const void __user *unsafe_addr,
> > +			      long count)
> > +{
> > +	mm_segment_t old_fs = get_fs();
> > +	long ret;
> > +
> > +	if (unlikely(count <= 0))
> > +		return 0;
> > +
> > +	set_fs(USER_DS);
> > +	pagefault_disable();
> > +	ret = strncpy_from_user(dst, unsafe_addr, count);
> > +	pagefault_enable();
> > +	set_fs(old_fs);
> > +	if (ret >= count) {
> > +		ret = count;
> > +		dst[ret - 1] = '\0';
> > +	} else if (ret > 0)
> > +		ret++;
> > +	return ret;
> > +}
> > +
> > +/**
> > + * strnlen_unsafe_user: - Get the size of a user string INCLUDING final NUL.
> > + * @unsafe_addr: The string to measure.
> > + * @count: Maximum count (including NUL character)
> > + *
> > + * Get the size of a NUL-terminated string in user space without pagefault.
> > + *
> > + * Returns the size of the string INCLUDING the terminating NUL.
> > + *
> > + * If the string is too long, returns a number larger than @count. User
> > + * has to check the return value against "> count".
> > + * On exception (or invalid count), returns 0.
> > + *
> > + * Unlike strnlen_user, this can be used from IRQ handler etc. because
> > + * it disables pagefaults.
> > + */
> > +long strnlen_unsafe_user(const void __user *unsafe_addr, long count)
> > +{
> > +	mm_segment_t old_fs = get_fs();
> > +	int ret;
> > +
> > +	set_fs(USER_DS);
> > +	pagefault_disable();
> > +	ret = strnlen_user(unsafe_addr, count);
> > +	pagefault_enable();
> > +	set_fs(old_fs);
> > +	return ret;
> > +}
> > 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
