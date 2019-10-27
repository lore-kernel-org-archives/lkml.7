Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440C5CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 22:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1698F20717
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 22:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbfJ0Wr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 18:47:29 -0400
Received: from smtprelay0194.hostedemail.com ([216.40.44.194]:51510 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727085AbfJ0Wr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 18:47:29 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 4B0431802B56E;
        Sun, 27 Oct 2019 22:47:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: nail45_410b47253ea55
X-Filterd-Recvd-Size: 3138
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Sun, 27 Oct 2019 22:47:26 +0000 (UTC)
Message-ID: <92212e57d45f4410be654183f5dcb1e98d636ef2.camel@perches.com>
Subject: Re: [PATCH] kernel: sys.c: Avoid copying possible padding bytes in
 copy_to_user
From:   Joe Perches <joe@perches.com>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <error27@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        zhanglin <zhang.lin16@zte.com.cn>
Date:   Sun, 27 Oct 2019 15:47:21 -0700
In-Reply-To: <alpine.DEB.2.21.1910270644590.3186@hadrien>
References: <dfa331c00881d61c8ee51577a082d8bebd61805c.camel@perches.com>
         <alpine.DEB.2.21.1910270644590.3186@hadrien>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-10-27 at 06:47 +0100, Julia Lawall wrote:
> 
> On Sat, 26 Oct 2019, Joe Perches wrote:
> 
> > Initialization is not guaranteed to zero padding bytes so
> > use an explicit memset instead to avoid leaking any kernel
> > content in any possible padding bytes.
> 
> Here is an extract of an email that I sent to Kees at one point that left
> me unsure about what should be done about these situations:
> 
> From Kees:
> 
>     The only way to correctly handle this is:
> 
>     memset(&instance, 0, sizeof(instance));
>     instance.one = 1;
> 
> From me:
> 
> Actually, this document:
> 
> https://wiki.sei.cmu.edu/confluence/display/c/DCL39-C.+Avoid+information+leakage+when+passing+a+structure+across+a+trust+boundary
> 
> says that memset is a "noncompliant solution".  They suggest declaring the
> structure as packed, as well as some other more unpleasant solutions.
> Their point is that 1 will be sitting in a register, and the assignment at
> least might copy the upper bytes of the register into the padding space.

It took me a minute to understand why, but it
is true and possible.

> Is the memset solution nevertheless what is always wanted in the kernel
> when there is padding?

I think yes as at least it makes it consistent.

From the link above, as I understand the __user
gcc extension here
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c61f13eaa1ee17728c41370100d2d45c254ce76f

gcc does not clear padding from initialized structs
marked with __user.

Perhaps adding yet another attribute to struct definitions
and another gcc extension could help.

Perhaps add something like

	#define __uapi __attribute__((__uapi__))

and mark the struct definitions in include/uapi like:

struct ethtool_wolinfo {
	__u32	cmd;
	__u32	supported;
	__u32	wolopts;
	__u8	sopass[SOPASS_MAX];
} __uapi;

so that gcc could make sure any struct padding
is also zeroed if initialized.

Though that doesn't force the compiler to not
perform the possible register optimization shown
in the first document above.

