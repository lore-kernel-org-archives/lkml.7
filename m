Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FE8C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 21:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1788206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 21:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbfJGVFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 17:05:43 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35383 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbfJGVFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 17:05:43 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iHaCG-0005vQ-E7; Mon, 07 Oct 2019 21:05:36 +0000
Date:   Mon, 7 Oct 2019 23:05:35 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Jann Horn <jannh@google.com>
Cc:     Todd Kjos <tkjos@google.com>, Martijn Coenen <maco@android.com>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: UAF read in print_binder_transaction_log_entry() on
 ANDROID_BINDERFS kernels
Message-ID: <20191007210534.wqnizdp6pl7gn5qe@wittgenstein>
References: <CAG48ez14Q0-F8LqsvcNbyR2o6gPW8SHXsm4u5jmD9MpsteM2Tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez14Q0-F8LqsvcNbyR2o6gPW8SHXsm4u5jmD9MpsteM2Tw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 10:49:57PM +0200, Jann Horn wrote:
> Hi!
> 
> There is a use-after-free read in print_binder_transaction_log_entry()
> on ANDROID_BINDERFS kernels because
> print_binder_transaction_log_entry() prints the char* e->context_name
> as string, and if the transaction occurred on a binder device from
> binderfs, e->context_name belongs to the binder device and is freed
> when the inode disappears.
> 
> Luckily this shouldn't have security implications, since:
> 
> a) reading the binder transaction log is already a pretty privileged operation
> b) I can't find any actual users of ANDROID_BINDERFS
> 
> I guess there are three ways to fix it:
> 1) Create a new shared global spinlock for binderfs_evict_inode() and
> binder_transaction_log_show(), and let binderfs_evict_inode() scan the
> transaction log for pointers to its name and replace them with
> pointers to a statically-allocated string "{DELETED}" or something
> like that.
> 2) Let the transaction log contain non-reusable device identifiers
> instead of name pointers, and let print_binder_transaction_log_entry()
> look them up in something like a hashtable.
> 3) Just copy the name into the transaction log every time.
> 
> I'm not sure which one is better, or whether there's a nicer fourth
> option, so I'm leaving writing a patch for this to y'all.

Moin,

Thanks for the report.
Android binderfs is enabled by default on Ubuntu and - iirc - Debian
kernels. It is actively used by Anbox to run Android in containers.

The codepath you're referring to is specific to the stats=global mount
option. This was contributed by the Android team for the 5.4 cycle (cf.
[1]). That means there is no released kernel that supports the
stats=global mount option. So all current users cannot be affected by
this bug.

I'll take a look at this tomorrow and see what makes the most sense. I
agree that this is not a security issue. Thanks for catching this early.

If you already have a script that trivially reproduces the bug it'd be
nice if you could paste it. Otherwise we can just add a reproducer based
on your snippet from below. I want to add a regression test for this.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f00834518ed3194b866f5f3d63b71e0ed7f6bc00
     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0e13e452dafc009049a9a5a4153e2f9e51b23915
     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=03e2e07e38147917482d595ad3cf193212ded8ac
     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4feb80faf428a02d407a9ea1952004af01308765

Thanks!
Christian
