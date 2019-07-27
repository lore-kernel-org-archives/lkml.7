Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27877C433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 16:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07BA92083B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 16:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387823AbfG0Qtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 12:49:36 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:59564 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387665AbfG0Qtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 12:49:36 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hrPsy-0006KY-RD; Sat, 27 Jul 2019 16:49:33 +0000
Date:   Sat, 27 Jul 2019 17:49:32 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <christian@brauner.io>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>, David Howells <dhowells@redhat.com>,
        Jann Horn <jannh@google.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH v2 1/2] pidfd: add P_PIDFD to waitid()
Message-ID: <20190727164932.GR1131@ZenIV.linux.org.uk>
References: <20190727085201.11743-1-christian@brauner.io>
 <20190727085201.11743-2-christian@brauner.io>
 <CAHk-=whrh5+aHmgqP9YhZ-yzCtUWT8fPi08ZSJdxusx7aHXOQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whrh5+aHmgqP9YhZ-yzCtUWT8fPi08ZSJdxusx7aHXOQQ@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 27, 2019 at 09:28:40AM -0700, Linus Torvalds wrote:

> is the stupid and straightforward thing, but if you want to be
> *clever* you can actually avoid getting a reference to the 'struct
> file *" entirely, and do the fd->pid lookup under rcu_read_lock()
> instead. It's slightly more complex, but it avoids the fdget/fdput
> reference count games entirely.

Yecchhh...  Please, don't do the last part - at least not unless
we really see that in profiles.
