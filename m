Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F075CCA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 08:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C040B20B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 08:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733201AbfJ1IIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 04:08:32 -0400
Received: from smtprelay0240.hostedemail.com ([216.40.44.240]:36683 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731255AbfJ1IIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 04:08:32 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id DDE991800AC9D;
        Mon, 28 Oct 2019 08:08:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: worm22_ff7ace23cd13
X-Filterd-Recvd-Size: 2208
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Mon, 28 Oct 2019 08:08:29 +0000 (UTC)
Message-ID: <8e34d30364b9306465a72c283ff59f453f8ea232.camel@perches.com>
Subject: Re: [PATCH] kernel: sys.c: Avoid copying possible padding bytes in
 copy_to_user
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <error27@gmail.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Mon, 28 Oct 2019 01:08:24 -0700
In-Reply-To: <20191028071856.GA1944@kadam>
References: <dfa331c00881d61c8ee51577a082d8bebd61805c.camel@perches.com>
         <20191028071856.GA1944@kadam>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-10-28 at 10:18 +0300, Dan Carpenter wrote:
> On Sat, Oct 26, 2019 at 12:46:08PM -0700, Joe Perches wrote:
> > Initialization is not guaranteed to zero padding bytes so
> > use an explicit memset instead to avoid leaking any kernel
> > content in any possible padding bytes.
[]
> > diff --git a/kernel/sys.c b/kernel/sys.c
[]
> > @@ -1279,11 +1279,13 @@ SYSCALL_DEFINE1(uname, struct old_utsname __user *, name)
> >  
> >  SYSCALL_DEFINE1(olduname, struct oldold_utsname __user *, name)
> >  {
> > -	struct oldold_utsname tmp = {};
> > +	struct oldold_utsname tmp;
> 
> oldold_utsname doesn't have an struct holes.  It looks like this:

It's not struct holes that could be a problem.
It's possible struct padding after the last element.

> struct oldold_utsname {
>         char sysname[9];
>         char nodename[9];
>         char release[9];
>         char version[9];
>         char machine[9];
> };

Nominally 45 bytes.

A compiler _could_ pad to 48 for arbitrary alignment.
gcc does not pad and the struct size actually is 45
so for gcc (and I did not check clang), it's not a
real problem.

The patch still is a possible trivial improvement as
the memset is not done when name is NULL.


