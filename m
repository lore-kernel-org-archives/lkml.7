Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B26ECE58E
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D55FD21848
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbfJIN0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 09:26:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33186 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731083AbfJIN0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 09:26:20 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iIBys-0007l0-8m; Wed, 09 Oct 2019 13:26:18 +0000
Date:   Wed, 9 Oct 2019 15:26:17 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     bsingharora@gmail.com, dvyukov@google.com, elver@google.com,
        linux-kernel@vger.kernel.org, parri.andrea@gmail.com,
        stable@vger.kernel.org,
        syzbot+c5d03165a1bd1dead0c1@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH v5] taskstats: fix data-race
Message-ID: <20191009132616.at3yspm6y3mzp5wg@wittgenstein>
References: <20191009113134.5171-1-christian.brauner@ubuntu.com>
 <20191009114809.8643-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191009114809.8643-1-christian.brauner@ubuntu.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 01:48:09PM +0200, Christian Brauner wrote:
> When assiging and testing taskstats in taskstats_exit() there's a race
> when writing and reading sig->stats when a thread-group with more than
> one thread exits:
> 
> cpu0:
> thread catches fatal signal and whole thread-group gets taken down
>  do_exit()
>  do_group_exit()
>  taskstats_exit()
>  taskstats_tgid_alloc()
> The tasks reads sig->stats without holding sighand lock seeing garbage.
> 
> cpu1:
> task calls exit_group()
>  do_exit()
>  do_group_exit()
>  taskstats_exit()
>  taskstats_tgid_alloc()
> The task takes sighand lock and assigns new stats to sig->stats.
> 
> Fix this by using smp_load_acquire() and smp_store_release().
> 
> Reported-by: syzbot+c5d03165a1bd1dead0c1@syzkaller.appspotmail.com
> Fixes: 34ec12349c8a ("taskstats: cleanup ->signal->stats allocation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

Applied to:
https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=taskstats_syzbot

Merged into:
https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=fixes

Targeting v5.4-rc3.

Thanks!
Christian
