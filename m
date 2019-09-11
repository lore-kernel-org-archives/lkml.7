Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3478C49ED7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 00:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E7721D7B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 00:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfIKAPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 20:15:21 -0400
Received: from smtprelay0126.hostedemail.com ([216.40.44.126]:46332 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725916AbfIKAPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 20:15:20 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 0058818224519;
        Wed, 11 Sep 2019 00:15:18 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cream93_8578525e7b644
X-Filterd-Recvd-Size: 4049
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Wed, 11 Sep 2019 00:15:17 +0000 (UTC)
Message-ID: <95a9f6fbc8fc2cf81e9eadc6f7fef8dd3592e60b.camel@perches.com>
Subject: Re: [PATCH v2] printf: add support for printing symbolic error codes
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>
Date:   Tue, 10 Sep 2019 17:15:15 -0700
In-Reply-To: <CAHp75Vdpd5uMCM-n+4vAZLwUpN=-cHnHs1uxoV2MDd5fk+CQig@mail.gmail.com>
References: <20190830214655.6625-1-linux@rasmusvillemoes.dk>
         <20190909203826.22263-1-linux@rasmusvillemoes.dk>
         <CAHp75Vdpd5uMCM-n+4vAZLwUpN=-cHnHs1uxoV2MDd5fk+CQig@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-09-10 at 18:26 +0300, Andy Shevchenko wrote:
> On Mon, Sep 9, 2019 at 11:39 PM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
> > It has been suggested several times to extend vsnprintf() to be able
> > to convert the numeric value of ENOSPC to print "ENOSPC". This is yet
> > another attempt. Rather than adding another %p extension, simply teach
> > plain %p to convert ERR_PTRs. While the primary use case is
> > 
> >   if (IS_ERR(foo)) {
> >     pr_err("Sorry, can't do that: %p\n", foo);
> >     return PTR_ERR(foo);
> >   }
> > 
> > it is also more helpful to get a symbolic error code (or, worst case,
> > a decimal number) in case an ERR_PTR is accidentally passed to some
> > %p<something>, rather than the (efault) that check_pointer() would
> > result in.
> > 
> > With my embedded hat on, I've made it possible to remove this.
> > 
> > I've tested that the #ifdeffery in errcode.c is sufficient to make
> > this compile on arm, arm64, mips, powerpc, s390, x86 - I'm sure the
> > 0day bot will tell me which ones I've missed.
> > 
> > The symbols to include have been found by massaging the output of
> > 
> >   find arch include -iname 'errno*.h' | xargs grep -E 'define\s*E'
> > 
> > In the cases where some common aliasing exists
> > (e.g. EAGAIN=EWOULDBLOCK on all platforms, EDEADLOCK=EDEADLK on most),
> > I've moved the more popular one (in terms of 'git grep -w Efoo | wc)
> > to the bottom so that one takes precedence.
> > +#define E(err) [err + BUILD_BUG_ON_ZERO(err <= 0 || err > 300)] = #err
> > +#define E(err) [err - 512 + BUILD_BUG_ON_ZERO(err < 512 || err > 550)] = #err
> 
> From long term prospective 300 and 550 hard coded here may be forgotten.
> 
> > +const char *errcode(int err)
> We got long, why not to use long type for it?
> 
> > +{
> > +       /* Might as well accept both -EIO and EIO. */
> > +       if (err < 0)
> > +               err = -err;
> > +       if (err <= 0) /* INT_MIN or 0 */
> > +               return NULL;
> > +       if (err < ARRAY_SIZE(codes_0))
> > +               return codes_0[err];
> 
> It won't work if one of the #ifdef:s in the array fails.
> Would it?
> 
> > +       if (err >= 512 && err - 512 < ARRAY_SIZE(codes_512))
> > +               return codes_512[err - 512];
> > +       /* But why? */
> > +       if (IS_ENABLED(CONFIG_MIPS) && err == EDQUOT) /* 1133 */
> > +               return "EDQUOT";
> > +       return NULL;
> > +}
> > +               long err = PTR_ERR(ptr);
> > +               const char *sym = errcode(-err);
> 
> Do we need additional sign change if we already have such check inside
> errcode()?

How is EBUSY differentiated from ZERO_SIZE_PTR ?


