Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08B4C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 09:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC40E20867
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 09:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfJGJ3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 05:29:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41340 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfJGJ3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 05:29:32 -0400
Received: from [185.66.195.251] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iHPKb-00065g-SJ; Mon, 07 Oct 2019 09:29:29 +0000
Date:   Mon, 7 Oct 2019 11:29:28 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     bsingharora@gmail.com, Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+c5d03165a1bd1dead0c1@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH] taskstats: fix data-race
Message-ID: <20191007092927.qpfs553g7oow3qs7@wittgenstein>
References: <20191005112806.13960-1-christian.brauner@ubuntu.com>
 <20191006235216.7483-1-christian.brauner@ubuntu.com>
 <CACT4Y+Z95M0co_vLTvbNDxb5YjuXwMcOBwNxZnJkMb_fLCDXXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+Z95M0co_vLTvbNDxb5YjuXwMcOBwNxZnJkMb_fLCDXXg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 09:31:16AM +0200, Dmitry Vyukov wrote:
> On Mon, Oct 7, 2019 at 1:52 AM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > When assiging and testing taskstats in taskstats_exit() there's a race
> > when writing and reading sig->stats when a thread-group with more than
> > one thread exits:
> >
> > cpu0:
> > thread catches fatal signal and whole thread-group gets taken down
> >  do_exit()
> >  do_group_exit()
> >  taskstats_exit()
> >  taskstats_tgid_alloc()
> > The tasks reads sig->stats holding sighand lock seeing garbage.
> >
> > cpu1:
> > task calls exit_group()
> >  do_exit()
> >  do_group_exit()
> >  taskstats_exit()
> >  taskstats_tgid_alloc()
> > The task takes sighand lock and assigns new stats to sig->stats.
> >
> > Fix this by using READ_ONCE() and smp_store_release().
> >
> > Reported-by: syzbot+c5d03165a1bd1dead0c1@syzkaller.appspotmail.com
> > Cc: Dmitry Vyukov <dvyukov@google.com>
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > ---
> > /* v1 */
> > Link: https://lore.kernel.org/r/20191005112806.13960-1-christian.brauner@ubuntu.com
> >
> > /* v2 */
> > - Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>:
> >   - fix the original double-checked locking using memory barriers
> > ---
> >  kernel/taskstats.c | 19 ++++++++++---------
> >  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

Applied to:
https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=fixes

Should show up in linux-next tomorrow.
Targeting v5.4-rc3.
Cced stable.

Christian
