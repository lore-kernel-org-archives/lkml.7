Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BE3C76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 02:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C6102238C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 02:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfGZCq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 22:46:59 -0400
Received: from smtprelay0075.hostedemail.com ([216.40.44.75]:45706 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725928AbfGZCq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 22:46:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 4B624181D3368;
        Fri, 26 Jul 2019 02:46:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: crow03_1f320ee7be00f
X-Filterd-Recvd-Size: 3123
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Fri, 26 Jul 2019 02:46:54 +0000 (UTC)
Message-ID: <ffcdd323f2f325fc9e9f2e17e1795ddaddeccd33.camel@perches.com>
Subject: Re: [PATCH 1/2] string: Add stracpy and stracpy_pad mechanisms
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yann Droneaud <ydroneaud@opteya.com>,
        David Laight <David.Laight@aculab.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Stephen Kitt <steve@sk2.org>,
        Nitin Gote <nitin.r.gote@intel.com>,
        "jannh@google.com" <jannh@google.com>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Thu, 25 Jul 2019 19:46:53 -0700
In-Reply-To: <201907251301.E1E32DCCCE@keescook>
References: <cover.1563841972.git.joe@perches.com>
         <7ab8957eaf9b0931a59eff6e2bd8c5169f2f6c41.1563841972.git.joe@perches.com>
         <eec901c6-ca51-89e4-1887-1ccab0288bee@rasmusvillemoes.dk>
         <5ffdbf4f87054b47a2daf23a6afabecf@AcuMS.aculab.com>
         <bc1ad99a420dd842ce3a17c2c38a2f94683dc91c.camel@opteya.com>
         <396d1eed-8edf-aa77-110b-c50ead3a5fd5@rasmusvillemoes.dk>
         <CAHk-=whPA-Vv-OHbUe4M5=ygTknQNOasnLAp-E3zSAaq=pue+g@mail.gmail.com>
         <201907251301.E1E32DCCCE@keescook>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-07-25 at 13:03 -0700, Kees Cook wrote:
> On Wed, Jul 24, 2019 at 10:08:57AM -0700, Linus Torvalds wrote:
> > On Wed, Jul 24, 2019 at 6:09 AM Rasmus Villemoes
> > <linux@rasmusvillemoes.dk> wrote:
> > > The kernel's snprintf() does not behave in a non-standard way, at least
> > > not with respect to its return value.
> > 
> > Note that the kernels snprintf() *does* very much protect against the
> > overflow case - not by changing the return value, but simply by having
> > 
> >         /* Reject out-of-range values early.  Large positive sizes are
> >            used for unknown buffer sizes. */
> >         if (WARN_ON_ONCE(size > INT_MAX))
> >                 return 0;
> > 
> > at the very top.
> > 
> > So you can't actually overflow in the kernel by using the repeated
> > 
> >         offset += vsnprintf( .. size - offset ..);
> > 
> > model.
> > 
> > Yes, it's the wrong thing to do, but it is still _safe_.
> 
> Actually, perhaps we should add this test to strscpy() too?

Doesn't seem to have a reason not to be added
but maybe it's better to add another WARN_ON_ONCE.

> diff --git a/lib/string.c b/lib/string.c
[]
> @@ -182,7 +182,7 @@ ssize_t strscpy(char *dest, const char *src, size_t count)
>  	size_t max = count;
>  	long res = 0;
>  
> -	if (count == 0)
> +	if (count == 0 || count > INT_MAX)
>  		return -E2BIG;
>  
>  #ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> 

