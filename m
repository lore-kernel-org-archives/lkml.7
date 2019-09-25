Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAF3C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 14:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 007B92146E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 14:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437761AbfIYOgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 10:36:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:41706 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437698AbfIYOgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 10:36:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0D5F1ACC9;
        Wed, 25 Sep 2019 14:36:14 +0000 (UTC)
Date:   Wed, 25 Sep 2019 16:36:12 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joe Perches <joe@perches.com>, Pavel Machek <pavel@ucw.cz>,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] printf: add support for printing symbolic error codes
Message-ID: <20190925143612.3tryimrvyfcqb2ez@pathway.suse.cz>
References: <20190909203826.22263-1-linux@rasmusvillemoes.dk>
 <20190917065959.5560-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917065959.5560-1-linux@rasmusvillemoes.dk>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First, I am sorry that I replay so late. I was traveling the previous
two weeks and was not able to follow the discussion about this patch.

I am fine with adding this feature. But I would like to do it
a cleaner way, see below.


On Tue 2019-09-17 08:59:59, Rasmus Villemoes wrote:
> With my embedded hat on, I've made it possible to remove this.
> 
> I've tested that the #ifdeffery in errcode.c is sufficient to make
> this compile on arm, arm64, mips, powerpc, s390, x86 - I'm sure the
> 0day bot will tell me which ones I've missed.

Please, remove the above two paragraphs in the final patch. They make
sense for review but not for git history.


> Andrew: please consider picking this up, even if we're already in the
> merge window. Quite a few people have said they'd like to see
> something like this, it's a debug improvement in its own right (the
> "ERR_PTR accidentally passed to printf" case), the printf tests pass,
> and it's much easier to start adding (and testing) users around the
> tree once this is in master.

This change would deserve to spend some time in linux-next. Anyway,
it is already too late for 5.4.


> diff --git a/include/linux/errcode.h b/include/linux/errcode.h
> new file mode 100644
> index 000000000000..c6a4c1b04f9c
> --- /dev/null
> +++ b/include/linux/errcode.h

The word "code" is quite ambiguous. I am not sure if it is the name or
the number. I think that it is actually both (the relation between
the two.

Both "man 3 errno" and
https://www.gnu.org/software/libc/manual/html_node/Checking-for-Errors.html#Checking-for-Errors
talks about numbers and symbolic names.

Please use errname or so instead of errcode everywhere.


> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 5960e2980a8a..dc1b20872774 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -164,6 +164,14 @@ config DYNAMIC_DEBUG
>  	  See Documentation/admin-guide/dynamic-debug-howto.rst for additional
>  	  information.
>  
> +config SYMBOLIC_ERRCODE

What is the exact reason to make this configurable, please?

Nobody was really against this feature. The only question
was if it was worth the code complexity and maintenance.
If we are going to have the code then we should use it.

Then there was a concerns that it might be too big for embedded
people. But did it come from people working on embedded kernel
or was it just theoretical?

I would personally enable it when CONFIG_PRINTK is enabled.
We could always introduce a new config option later when
anyone really wants to disable it.

> --- /dev/null
> +++ b/lib/errcode.c
> @@ -0,0 +1,212 @@
> +#define E(err) [err + BUILD_BUG_ON_ZERO(err <= 0 || err > 300)] = #err
> +static const char *codes_0[] = {
> +	E(E2BIG),

I really like the way how the array is initialized.


> diff --git a/lib/test_printf.c b/lib/test_printf.c
> index 944eb50f3862..0401a2341245 100644
> --- a/lib/test_printf.c
> +++ b/lib/test_printf.c
> +static void __init
> +errptr(void)
> +{
> +	test("-1234", "%p", ERR_PTR(-1234));
> +	test(FFFFS "ffffffff " FFFFS "ffffff00", "%px %px", ERR_PTR(-1), ERR_PTR(-256));
> +#ifdef CONFIG_SYMBOLIC_ERRCODE
> +	test("EIO EINVAL ENOSPC", "%p %p %p", ERR_PTR(-EIO), ERR_PTR(-EINVAL), ERR_PTR(-ENOSPC));
> +	test("EAGAIN EAGAIN", "%p %p", ERR_PTR(-EAGAIN), ERR_PTR(-EWOULDBLOCK));

I like that you check more values. But please split it to check
only one value per line to make it better readable.


> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index b0967cf17137..299fce317eb3 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -2111,6 +2112,31 @@ static noinline_for_stack
>  char *pointer(const char *fmt, char *buf, char *end, void *ptr,
>  	      struct printf_spec spec)
>  {
> +	/*
> +	 * If it's an ERR_PTR, try to print its symbolic
> +	 * representation, except for %px, where the user explicitly
> +	 * wanted the pointer formatted as a hex value.
> +	 */
> +	if (IS_ERR(ptr) && *fmt != 'x') {

We had similar code before the commit 3e5903eb9cff70730171 ("vsprintf:
Prevent crash when dereferencing invalid pointers"). Note that the
original code kept the original value also for *fmt == 'K'.

Anyway, the above commit tried to unify the handling of special
values:

   + use the same strings for special values
   + check for special values only when pointer is dereferenced

This patch makes it inconsistent again. I mean that the code will:

   + check for (null) and (efault) only when the pointer is
     dereferenced

   + check for err codes in more situations but not in all
     and not in %s

   + use another style to print the error (uppercase without
      brackets)


I would like to keep it consistent. My proposal is:

1. Print the plain error code name only when
   a new %pe modifier is used. This will be useful
   in the error messages, e.g.

	void *p = ERR_PTR(-ENOMEM);
	if (IS_ERR(foo)) {
		pr_err("Sorry, can't do that: %pe\n", foo);
	return PTR_ERR(foo);

   would produce

	Sorry, can't do that: -ENOMEM


2. Use error code names also in check_pointer_msg() instead
   of (efault). But put it into brackets to distinguish it
   from the expected value, for example:

      /* valid pointer */
      phys_addr_t addr = 0xab;
      printk("value: %pa\n", &addr);
      /* known error code */
      printk("value: %pa\n", ERR_PTR(-ENOMEM));
      /* unknown error code */
      printk("value: %pa\n", ERR_PTR(-1234));

   would produce:

     value: 0xab
     value: (-ENOMEM)
     value: (-1234)


3. Unify the style for the null pointer:

    + use (NULL) instead of (null)

4. Do not use error code names for internal vsprintf error
   to avoid confusion. For example:

    + replace the one (einval) with (%piS-err) or so

How does that sound, please?

Best Regards,
Petr
