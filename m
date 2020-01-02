Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE19BC2D0C2
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 17:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C499E20866
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 17:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgABRxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 12:53:06 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:34354 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbgABRxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 12:53:06 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 001622006F1;
        Thu,  2 Jan 2020 17:53:04 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 40C7B20343; Thu,  2 Jan 2020 18:53:00 +0100 (CET)
Date:   Thu, 2 Jan 2020 18:53:00 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        youling 257 <youling257@gmail.com>
Subject: Re: [PATCH] early init: open /dev/console with O_LARGEFILE
Message-ID: <20200102175300.GA292871@light.dominikbrodowski.net>
References: <20191231150226.GA523748@light.dominikbrodowski.net>
 <20200101003017.GA116793@rani.riverdale.lan>
 <20200101183243.GB183871@rani.riverdale.lan>
 <CAHk-=whzgLPi4szh8xOKysuS9CKaQESngc=n0omBVpwdQ822aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whzgLPi4szh8xOKysuS9CKaQESngc=n0omBVpwdQ822aw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 01, 2020 at 01:39:00PM -0800, Linus Torvalds wrote:
> I'm not saying that the revert is wrong at this point,

Linus, I'd like you to revert the patch nonetheless -- it was quite broken,
it is still broken and probably needs, besides your fix, the O_LARGEFILE
patch I sent out a few days ago.

What is more, I think a different approach is saner, leads to smaller code,
and creates far less risks. And maybe Al Viro likes it a bit more as well :)

At

	https://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git ksys-next

there are a few proof-of-concept patches for three in-kernel-syscalls:

(1) Both ksys_open() and ksys_unlink() can trivially operate properly on a
kernelspace pointer (by means of calling getname_kernel() instead of
getname()), such as:

-static inline long ksys_unlink(const char __user *pathname)
+/* note: operates on a kernelspace pointer to pathname */
+static inline long ksys_unlink(const char *pathname)
 {
-       return do_unlinkat(AT_FDCWD, getname(pathname));
+       return do_unlinkat(AT_FDCWD, getname_kernel(pathname));
 }

(with all callers of ksys_unlinked() checked, of course).


(2) For ksys_mkdir(), we already have a fully vfs-in-kernelspace variant in
devtmpfs::dev_mkdir(), which we can use for ksys_mkdir() as well.


What do you (and others) think of these alternative approaches? If we should
work in this direction, please revert the patch -- the new patches should go
into v5.6 at earliest, and probably be routed via Al Viro (unless he and/or
you want me to have this tree managed independently, and included in
linux-next separately).

Thanks,
	Dominik
