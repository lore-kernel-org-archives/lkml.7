Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20075C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 09:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1DEC206A3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 09:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557393255;
	bh=O0H9VMAqC7wNghzyMsp+TfEzir01DKrhvxZzqGjWN0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tc/KGbZmxPmWcA8aLVgUvjm5SMG8tbnXEWlRI5AOvmBGLjjEHbha4qOefkgEEXtDC
	 QSIpqSujy/wMn0snxMG5J0XiSRdwNip1lBuGnCkN7O79kyorYSkdIMaamSqikJAL16
	 XgQlF7oeWIfbazMFhrVQLE8yeBNe5tLL8p0Je2Ag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfEIJON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 05:14:13 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46872 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfEIJON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 05:14:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id r7so1300680wrr.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 02:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n2PPgaUDt8nIFjgJXkfdOKyrT6Vwlbh1gjpRTaotzks=;
        b=hwMlt/AKgtqLaf9ArLn40hZZ5E8ymQ7HSQNLkVbJyelwJMe4sETPbGG2R43uLUyqc/
         aBbUco3MEqXYCQijTsMFakWP/2XAzeMWO/iOG5gUUvqdCjAIfD+b6DMtfqIuoN+XQfin
         nJ6dIl6Cf4qrK5Pypb0iYdkj61+kgJy941imXuadeeXr0t39TDhH+k7Mp9ZJwqeK/pV6
         cN9/iIdakQ8y117VeCQAkf16ufro40Efy7Dnt/RmcJ4kE4KGiPEZbeqJRVS0GeeIJPiT
         X7u0esrch7R96AmmGH4o86HfqDFkI7Hfc9S7drvW2c1v1D3e4o7dvvzQBKxKaAWHjmI6
         Ws0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=n2PPgaUDt8nIFjgJXkfdOKyrT6Vwlbh1gjpRTaotzks=;
        b=MFMmH3emzwJp27tZPUTO5AmvkrrMvqAoJcOUc9yEI7+PUYQxxNsMHfSbOs4MqozO6d
         /zTR7Sr55j5l5eHm0+CWv7OSkGnp1mLb/4PM0nSHr+krh2az63pYb9v44SO2yrHbRIQ3
         Xrx5dnchMknVR/eynHeSUQNWk/NznFcRx7vAHAv0YTw0QzHUHaUHf4rAUs6iz8iFnv7p
         x/p86ctnuy/v1gMyWB0DSgsoqREkmfgkb+VEiQdwY074Cxvn/cv2dIYZiIABJbxDYaxf
         Qy49yWEZanL8SEWZ2ehR6k1F7ugF+Gdb9MmixiqHQiZjbL1E2cIX1oD2LVnyyoxJjDU0
         nQmg==
X-Gm-Message-State: APjAAAWu0c/xLirK2Dg4iZAB5yK2i6WfrtghK4wjm8wPbDIyZnWZiku2
        SOwQsnHVNs8PpMGF+8RsU2I=
X-Google-Smtp-Source: APXvYqyRc3+WzUDnhwD75Kzy72WIIdZx8YAYSn0peY8hJ30tcz3PJzECiVySH3e5IWTwDgMar2jsgQ==
X-Received: by 2002:adf:fb11:: with SMTP id c17mr2083625wrr.237.1557393251561;
        Thu, 09 May 2019 02:14:11 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id n1sm1397371wmc.19.2019.05.09.02.14.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 02:14:10 -0700 (PDT)
Date:   Thu, 9 May 2019 11:14:08 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
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
Message-ID: <20190509091408.GA90202@gmail.com>
References: <155732230159.12756.15040196512285621636.stgit@devnote2>
 <155732233411.12756.16633189392389986702.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155732233411.12756.16633189392389986702.stgit@devnote2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Masami Hiramatsu <mhiramat@kernel.org> wrote:

> +static __always_inline long
> +probe_read_common(void *dst, const void __user *src, size_t size)
> +{
> +	long ret;
> +
> +	pagefault_disable();
> +	ret = __copy_from_user_inatomic(dst, src, size);
> +	pagefault_enable();
> +
> +	return ret ? -EFAULT : 0;
> +}

Empty line before return statement: good.

> +long __weak probe_user_read(void *dst, const void __user *src, size_t size)
> +    __attribute__((alias("__probe_user_read")));
> +
> +long __probe_user_read(void *dst, const void __user *src, size_t size)
> +{
> +	long ret = -EFAULT;
> +	mm_segment_t old_fs = get_fs();
> +
> +	set_fs(USER_DS);
> +	if (access_ok(src, size))
> +		ret = probe_read_common(dst, src, size);
> +	set_fs(old_fs);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(probe_user_read);

No empty line before return statement: not good.

> +long strncpy_from_unsafe_user(char *dst, const void __user *unsafe_addr,
> +			      long count)
> +{
> +	mm_segment_t old_fs = get_fs();
> +	long ret;
> +
> +	if (unlikely(count <= 0))
> +		return 0;
> +
> +	set_fs(USER_DS);
> +	pagefault_disable();
> +	ret = strncpy_from_user(dst, unsafe_addr, count);
> +	pagefault_enable();
> +	set_fs(old_fs);
> +	if (ret >= count) {
> +		ret = count;
> +		dst[ret - 1] = '\0';
> +	} else if (ret > 0)
> +		ret++;
> +	return ret;
> +}

Ditto. Also unbalanced curly braces.

> +
> +/**
> + * strnlen_unsafe_user: - Get the size of a user string INCLUDING final NUL.
> + * @unsafe_addr: The string to measure.
> + * @count: Maximum count (including NUL character)
> + *
> + * Get the size of a NUL-terminated string in user space without pagefault.
> + *
> + * Returns the size of the string INCLUDING the terminating NUL.

These phrases exist:

 'Terminating NULL'
 'NULL character'

And we also sometimes talk about 'nil' - but I don't think there's such 
thing as a 'NUL character'?

I realize that this was probably cloned from existing lib/strnlen_user.c 
code, but still. ;-)

> + *
> + * If the string is too long, returns a number larger than @count. User
> + * has to check the return value against "> count".
> + * On exception (or invalid count), returns 0.
> + *
> + * Unlike strnlen_user, this can be used from IRQ handler etc. because
> + * it disables pagefaults.

'can be used from IRQ handlers'

> + */
> +long strnlen_unsafe_user(const void __user *unsafe_addr, long count)
> +{
> +	mm_segment_t old_fs = get_fs();
> +	int ret;
> +
> +	set_fs(USER_DS);
> +	pagefault_disable();
> +	ret = strnlen_user(unsafe_addr, count);
> +	pagefault_enable();
> +	set_fs(old_fs);
> +	return ret;
> +}

Same problem as before.

Thanks,

	Ingo
