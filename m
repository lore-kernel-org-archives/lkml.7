Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA026C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 08:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD5AC218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 08:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbfJBIeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 04:34:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:35462 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726559AbfJBIeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 04:34:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B6F04AD18;
        Wed,  2 Oct 2019 08:34:31 +0000 (UTC)
Date:   Wed, 2 Oct 2019 10:34:29 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Joe Perches <joe@perches.com>, Pavel Machek <pavel@ucw.cz>,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] printf: add support for printing symbolic error codes
Message-ID: <20191002083428.vgvywpavkwhszn6m@pathway.suse.cz>
References: <20190909203826.22263-1-linux@rasmusvillemoes.dk>
 <20190917065959.5560-1-linux@rasmusvillemoes.dk>
 <20190925143612.3tryimrvyfcqb2ez@pathway.suse.cz>
 <0dc89711-fce0-0500-2476-950767b2202a@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dc89711-fce0-0500-2476-950767b2202a@rasmusvillemoes.dk>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2019-09-29 22:09:28, Rasmus Villemoes wrote:
> > On Tue 2019-09-17 08:59:59, Rasmus Villemoes wrote:
> >> With my embedded hat on, I've made it possible to remove this.
> >>
> >> I've tested that the #ifdeffery in errcode.c is sufficient to make
> >> this compile on arm, arm64, mips, powerpc, s390, x86 - I'm sure the
> >> 0day bot will tell me which ones I've missed.
> > 
> > Please, remove the above two paragraphs in the final patch. They make
> > sense for review but not for git history.
>
> Agree for the latter, but not the former - I do want to explain why it's
> possible to configure out; see also below.

I see. It was too cryptic for me. I did not get the proper meaning
and context ;-)

> > This change would deserve to spend some time in linux-next. Anyway,
> > it is already too late for 5.4.
> 
> Yes, it's of course way too late now. Perhaps I should ask you to take
> it via the printk tree? Anyway, let's see what we can agree to.

Yup, I could take it via printk.git.

> >> +config SYMBOLIC_ERRCODE
> > 
> > What is the exact reason to make this configurable, please?
> 
> I am one such person, and while 3K may not be a lot, death by a thousand
> paper cuts...
> 
> > I would personally enable it when CONFIG_PRINTK is enabled.
> 
> Agree. So let's make it 'default y if PRINTK'?

Yeah, it makes perfect sense to me.

> > We could always introduce a new config option later when
> > anyone really wants to disable it.
> 
> No, because by the time the kernel has grown too large for some target,
> it's almost impossible to start figuring out which small pieces can be
> chopped away with suitable config options

OK, if you are the embedded guy and you would appreciate the config
then let's have it. Just please add it by a separate patch,
ideally with some numbers.

> and even harder to get
> upstream to accept such configurability ("why, that would only gain you
> 3K...").

I remeber LWN articles about shrinking the kernel for embeded systems
and that every kB was important.


> >> --- /dev/null
> >> +++ b/lib/errcode.c
> >> @@ -0,0 +1,212 @@
> >> +#define E(err) [err + BUILD_BUG_ON_ZERO(err <= 0 || err > 300)] = #err
> >> +static const char *codes_0[] = {
> >> +	E(E2BIG),
> > 
> > I really like the way how the array is initialized.
> 
> Thanks.
> 
> > 
> >> diff --git a/lib/test_printf.c b/lib/test_printf.c
> >> index 944eb50f3862..0401a2341245 100644
> >> --- a/lib/test_printf.c
> >> +++ b/lib/test_printf.c
> >> +static void __init
> >> +errptr(void)
> >> +{
> >> +	test("-1234", "%p", ERR_PTR(-1234));
> >> +	test(FFFFS "ffffffff " FFFFS "ffffff00", "%px %px", ERR_PTR(-1), ERR_PTR(-256));
> >> +#ifdef CONFIG_SYMBOLIC_ERRCODE
> >> +	test("EIO EINVAL ENOSPC", "%p %p %p", ERR_PTR(-EIO), ERR_PTR(-EINVAL), ERR_PTR(-ENOSPC));
> >> +	test("EAGAIN EAGAIN", "%p %p", ERR_PTR(-EAGAIN), ERR_PTR(-EWOULDBLOCK));
> > 
> > I like that you check more values. But please split it to check
> > only one value per line to make it better readable.
> 
> Hm, ok, but I actually do it this way on purpose - I want to ensure that
> the test where one passes a random not-zero-but-too-small buffer size
> sometimes hits in the middle of the %p output, sometimes just before and
> sometimes just after.

Is this really tested? do_test() function uses buffer for 256 characters.
There are some consistency checks. But any of your test string
is not truncated by the size of the buffer. Do I miss anything, please?

> The very reason I added test_printf was because
> there were some %p extensions that violated the basic rule of
> snprintf()'s return value and/or wrote beyond the provided buffer.

This sounds like a serious bug. Are your aware of any still
existing %p extension that causes this?

> Not a big deal, so if you insist I'll break it up.

Yes, it is not a big deal. But I would still prefer to
understand what is tested. And it is better to have
more tests focused on different aspects than a single
magic one.


> > 
> >> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> >> index b0967cf17137..299fce317eb3 100644
> >> --- a/lib/vsprintf.c
> >> +++ b/lib/vsprintf.c
> >> @@ -2111,6 +2112,31 @@ static noinline_for_stack
> >>  char *pointer(const char *fmt, char *buf, char *end, void *ptr,
> >>  	      struct printf_spec spec)
> >>  {
> >> +	/*
> >> +	 * If it's an ERR_PTR, try to print its symbolic
> >> +	 * representation, except for %px, where the user explicitly
> >> +	 * wanted the pointer formatted as a hex value.
> >> +	 */
> >> +	if (IS_ERR(ptr) && *fmt != 'x') {
> > 
> > We had similar code before the commit 3e5903eb9cff70730171 ("vsprintf:
> > Prevent crash when dereferencing invalid pointers"). Note that the
> > original code kept the original value also for *fmt == 'K'.
> > 
> > Anyway, the above commit tried to unify the handling of special
> > values:
> > 
> >    + use the same strings for special values
> >    + check for special values only when pointer is dereferenced
> > 
> > This patch makes it inconsistent again. I mean that the code will:
> > 
> >    + check for (null) and (efault) only when the pointer is
> >      dereferenced
> > 
> >    + check for err codes in more situations but not in all
> >      and not in %s
> >
> >    + use another style to print the error (uppercase without
> >       brackets)
> > 
> > 
> > I would like to keep it consistent. My proposal is:
> > 
> > 1. Print the plain error code name only when
> >    a new %pe modifier is used. This will be useful
> >    in the error messages, e.g.
> > 
> > 	void *p = ERR_PTR(-ENOMEM);
> > 	if (IS_ERR(foo)) {
> > 		pr_err("Sorry, can't do that: %pe\n", foo);
> > 	return PTR_ERR(foo);
> > 
> >    would produce
> > 
> > 	Sorry, can't do that: -ENOMEM
> 
> Well, we can certainly do that. However, I didn't want that for two
> reasons: (1) I want plain %p to be more useful when passed an ERR_PTR.
> Printing the value, possibly symbolically, doesn't leak anything about
> kernel addresses, so the hashing is pointless and just makes the
> printk() less useful - and non-repeatable across reboots, making
> debugging needlessly harder. (2) With a dedicated extension, we have to
> define what happens if a non-ERR_PTR gets passed as %pe argument. [and
> (3), we're running out of %p<foo> namespace].
>
> So, if you have some good answer to (2) I can do that - but if the
> answer is "fall through to handling it as just a normal %p", well, then
> we haven't really won much. And I don't see what else we could do -
> print "(!ERR_PTR)"?

This made me to remember the long discussion about filtering kernel
pointers, see
https://lkml.kernel.org/r/1506816410-10230-1-git-send-email-me@tobin.cc

It was basically about that %p might leak information. %pK failed
because it did not force people to remove the dangerous %p calls.
It ended with hashing %p to actually force people to convert %p
into something more useful and safe.

IMHO, the most extreme was a wish to get rid of %p and %pa
completely, see
https://lkml.kernel.org/r/CA+55aFwac2BzgZs-X1_VhekkuGfuLqNui2+2DbvLiDyptS-rXQ@mail.gmail.com

I do not think that exposing ERR_PTR values might be dangerous.
Well, it would be great to confirm this by some security guys.
Anyway, I do not think that it is a good idea to make %p
more useful again.

I would print the hashed pointer value when the value passed
to %pe is out of range.

Best Regards,
Petr
