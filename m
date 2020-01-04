Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06CBC32771
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 23:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7449F24653
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 23:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgADXwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 18:52:01 -0500
Received: from trent.utfs.org ([94.185.90.103]:35320 "EHLO trent.utfs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbgADXwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 18:52:01 -0500
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id 77FF96003F;
        Sun,  5 Jan 2020 00:51:57 +0100 (CET)
Date:   Sat, 4 Jan 2020 15:51:57 -0800 (PST)
From:   Christian Kujau <lists@nerdbynature.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH] Re: filesystem being remounted supports timestamps until
 2038
In-Reply-To: <CAHk-=wim6VGnxQmjfK_tDg6fbHYKL4EFkmnTjVr9QnRqjDBAeA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.99999.375.2001041545350.21037@trent.utfs.org>
References: <alpine.DEB.2.21.99999.375.1912201332260.21037@trent.utfs.org> <alpine.DEB.2.21.99999.375.1912261445200.21037@trent.utfs.org> <CAHk-=wim6VGnxQmjfK_tDg6fbHYKL4EFkmnTjVr9QnRqjDBAeA@mail.gmail.com>
User-Agent: Alpine 2.21.99999 (DEB 375 2019-10-29)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Dec 2019, Linus Torvalds wrote:
> >     When file systems are remounted a couple of times per day (e.g. rw/ro for backup
> >     purposes), dmesg gets flooded with these messages. Change pr_warn into pr_debug
> >     to make it stop.
> 
> How about just doing it once per mount?

Yes, once per mount would work, and maybe not print a warning on remounts 
at all.

Commit f8b92ba67c5d ("mount: Add mount warning for impending timestamp 
expiry") introduced:

   Mounted %s file system at %s supports timestamps until [...]

in mnt_warn_timestamp_expiry(), but then 0ecee6699064 ("fs/namespace.c: 
fix use-after-free of mount in mnt_warn_timestamp_expiry") changed this to

  %s filesystem being %s at %s supports timestamps until [...]

in order to fix a use-after-free.

> Of course, if you actually unmount and completely re-mount a
> filesystem, then that would still warn multiple times, but at that
> point I think it's reasonable to do.

Yes, of course. Umount/remount cycles should still issue a warning, but 
"-o remount" should not, IMHO.

Thanks,
Christian.
-- 
BOFH excuse #108:

The air conditioning water supply pipe ruptured over the machine room
