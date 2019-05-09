Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FE7C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 14:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3656C20989
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 14:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557411623;
	bh=728btKMpGcRm6QCpLxYuNAcXDFUi1xd2ev1v3qU4jzw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=riEpKMGJOwWpAhfLX4cKJuBSdHIFUS38XQCapEKsL+dR14PNQfbXVOZ8+xSJWx0dG
	 3wMyExpihlvGNhqUr6hARa1KqfWFQvyqQgqaDLnNl+H1mO4LBYoW4IRea/86pI+/yW
	 exdXsCqlzkOdcaQSLKxzIXP7xYay2nxSEKxgVWwo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfEIOUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 10:20:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:53274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbfEIOUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 10:20:22 -0400
Received: from devnote2 (unknown [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53AC621479;
        Thu,  9 May 2019 14:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557411621;
        bh=728btKMpGcRm6QCpLxYuNAcXDFUi1xd2ev1v3qU4jzw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o72nheea6Q6avgAcoLCYAO1/oR8LxO3adI2SpbpGGaPk9DYaXr3296eLLkXkpg7UG
         GXPfNjMFjJXpOmRet+BM9EOgZo1/gvwigaAWOykXeFfEva4Qi54FC4CcDpB0sEwVXI
         qhEjVzzvk/uGeOYNbyn/8w9ej4TrOji+TPpvqTnk=
Date:   Thu, 9 May 2019 23:20:04 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
        Joel Fernandes <joel@joelfernandes.org>, yhs@fb.com
Subject: Re: [PATCH v7 2/6] uaccess: Add non-pagefault user-space read
 functions
Message-Id: <20190509232004.7e354456abd654b225a3554a@kernel.org>
In-Reply-To: <20190509091408.GA90202@gmail.com>
References: <155732230159.12756.15040196512285621636.stgit@devnote2>
        <155732233411.12756.16633189392389986702.stgit@devnote2>
        <20190509091408.GA90202@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

On Thu, 9 May 2019 11:14:08 +0200
Ingo Molnar <mingo@kernel.org> wrote:

> * Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
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
> 
> Empty line before return statement: good.
> 
> > +long __weak probe_user_read(void *dst, const void __user *src, size_t size)
> > +    __attribute__((alias("__probe_user_read")));
> > +
> > +long __probe_user_read(void *dst, const void __user *src, size_t size)
> > +{
> > +	long ret = -EFAULT;
> > +	mm_segment_t old_fs = get_fs();
> > +
> > +	set_fs(USER_DS);
> > +	if (access_ok(src, size))
> > +		ret = probe_read_common(dst, src, size);
> > +	set_fs(old_fs);
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(probe_user_read);
> 
> No empty line before return statement: not good.

OK, I'll fix that.

> 
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
> 
> Ditto. Also unbalanced curly braces.

Yeah, thanks!

> 
> > +
> > +/**
> > + * strnlen_unsafe_user: - Get the size of a user string INCLUDING final NUL.
> > + * @unsafe_addr: The string to measure.
> > + * @count: Maximum count (including NUL character)
> > + *
> > + * Get the size of a NUL-terminated string in user space without pagefault.
> > + *
> > + * Returns the size of the string INCLUDING the terminating NUL.
> 
> These phrases exist:
> 
>  'Terminating NULL'
>  'NULL character'
> 
> And we also sometimes talk about 'nil' - but I don't think there's such 
> thing as a 'NUL character'?

OK, it should be "NUL" or "Null character" ( https://en.wikipedia.org/wiki/Null_character )

> 
> I realize that this was probably cloned from existing lib/strnlen_user.c 
> code, but still. ;-)
> 
> > + *
> > + * If the string is too long, returns a number larger than @count. User
> > + * has to check the return value against "> count".
> > + * On exception (or invalid count), returns 0.
> > + *
> > + * Unlike strnlen_user, this can be used from IRQ handler etc. because
> > + * it disables pagefaults.
> 
> 'can be used from IRQ handlers'

OK.

> 
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
> 
> Same problem as before.

OK, I'll fix that.

Thank you!

> 
> Thanks,
> 
> 	Ingo


-- 
Masami Hiramatsu <mhiramat@kernel.org>
