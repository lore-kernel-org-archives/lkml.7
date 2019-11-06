Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A02C5DF60
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 00:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A9C214D8
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 00:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrfifYu2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730292AbfKFAKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 19:10:01 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37697 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbfKFAKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 19:10:01 -0500
Received: by mail-pg1-f195.google.com with SMTP id z24so11261712pgu.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 16:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=RUUtX0apsQ2BI1Hch4x1+/e3L04nSqXL217e+kXR5qs=;
        b=lrfifYu22Tme0P2pvZ7okn6VeqdKFRCy5Hek2wScU3v5ujiN40B6sHI8GutKN7etJV
         uvCcgDS0ZgGmh6FtKRhjfckCpKiO9Xtn2N3H0NR6UTHKU1fSc2pa+DuWq/w9ee6z3atz
         jRN+Fc0d88yXzQiZFO3VCkTkZNYkgTa+TMHnya5TMCFaUBDjjnf6Md0fileGBrgbl9c2
         jN8aPLfA3h1/74Imd8TMRqsbNDKgtapL51EkLm7qXNmN3PEkKCcj7mYWiAHzu+08i7Ol
         GgsA5r09At5cfhIVUU5WqYtOZ0HCKe06d3YhqRBn/28bE5MxBIie7p6JEKOC5aKU3Ij+
         qRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RUUtX0apsQ2BI1Hch4x1+/e3L04nSqXL217e+kXR5qs=;
        b=ZqY56NIIi/FO6fE7MyDhSP++cUH9VgMBhKbqzrheX4+j14+O8HcUsIOsNd+9bMdkDp
         qW6BBL5pabSV1zGMSkFAUmjJLzmMmqYbNNlo4SFqFawtuhAaSKJGHZPAivy3iG8ve3yK
         91LmbmlpT00J55fEqa8e7VxL+nEatYhX7LY8CKWjxjN0KWY2pX+kCElzEzXE7dcUAg1z
         abBsXcmoyjjVkQIOicKz05paztLdxnpCvk+kx39hAn8NPB97dyJOy0URFgHds4Z5rgUo
         EbyoVoBMFRJceZ7NG9GlXgkZMWgW+v5hVBb8LZ51QiMsprb6GmcwXcmjPL4BxzfXUJY4
         hxXw==
X-Gm-Message-State: APjAAAX5URL6t0n60W64jKM14M0Zm9LIeKXlCfELoHPGF7clQuIM3KG2
        NIpwr3Py/2S0zDxtUlsdGeE=
X-Google-Smtp-Source: APXvYqxcFvOxsgj8CPm36Ul8kED5DMYkX5aZc0aLEdLBQOAXP6hM9L6JqYk46VcFft0N0dHnWFCu7g==
X-Received: by 2002:a63:29c2:: with SMTP id p185mr18956651pgp.39.1572999000046;
        Tue, 05 Nov 2019 16:10:00 -0800 (PST)
Received: from u2f459ca2e0dd5b.ant.amazon.com ([54.240.193.1])
        by smtp.googlemail.com with ESMTPSA id i123sm24799734pfe.145.2019.11.05.16.09.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Nov 2019 16:09:58 -0800 (PST)
Message-ID: <27b57b11aadf1bd41ad8326101713ca0be7b8edf.camel@gmail.com>
Subject: Re: KCSAN: data-race in taskstats_exit / taskstats_exit
From:   Balbir Singh <bsingharora@gmail.com>
To:     syzbot <syzbot+c5d03165a1bd1dead0c1@syzkaller.appspotmail.com>,
        elver@google.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Date:   Wed, 06 Nov 2019 11:09:54 +1100
In-Reply-To: <0000000000009b403005942237bf@google.com>
References: <0000000000009b403005942237bf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-10-04 at 21:26 -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    b4bd9343 x86, kcsan: Enable KCSAN for x86
> git tree:       https://github.com/google/ktsan.git kcsan
> console output: https://syzkaller.appspot.com/x/log.txt?x=125329db600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c0906aa620713d80
> dashboard link: https://syzkaller.appspot.com/bug?extid=c5d03165a1bd1dead0c1
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+c5d03165a1bd1dead0c1@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KCSAN: data-race in taskstats_exit / taskstats_exit
> 
> write to 0xffff8881157bbe10 of 8 bytes by task 7951 on cpu 0:
>   taskstats_tgid_alloc kernel/taskstats.c:567 [inline]
>   taskstats_exit+0x6b7/0x717 kernel/taskstats.c:596
>   do_exit+0x2c2/0x18e0 kernel/exit.c:864
>   do_group_exit+0xb4/0x1c0 kernel/exit.c:983
>   get_signal+0x2a2/0x1320 kernel/signal.c:2734
>   do_signal+0x3b/0xc00 arch/x86/kernel/signal.c:815
>   exit_to_usermode_loop+0x250/0x2c0 arch/x86/entry/common.c:159
>   prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
>   syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
>   do_syscall_64+0x2d7/0x2f0 arch/x86/entry/common.c:299
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> read to 0xffff8881157bbe10 of 8 bytes by task 7949 on cpu 1:
>   taskstats_tgid_alloc kernel/taskstats.c:559 [inline]
>   taskstats_exit+0xb2/0x717 kernel/taskstats.c:596
>   do_exit+0x2c2/0x18e0 kernel/exit.c:864
>   do_group_exit+0xb4/0x1c0 kernel/exit.c:983
>   __do_sys_exit_group kernel/exit.c:994 [inline]
>   __se_sys_exit_group kernel/exit.c:992 [inline]
>   __x64_sys_exit_group+0x2e/0x30 kernel/exit.c:992
>   do_syscall_64+0xcf/0x2f0 arch/x86/entry/common.c:296
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 

Sorry I've been away and just catching up with email

I don't think this is a bug, if I interpret the report correctly it shows a
race

static struct taskstats *taskstats_tgid_alloc(struct task_struct *tsk)
{
	struct signal_struct *sig = tsk->signal;
	struct taskstats *stats;

#1	if (sig->stats || thread_group_empty(tsk)) <- the check of sig->stats
		goto ret;

	/* No problem if kmem_cache_zalloc() fails */
	stats = kmem_cache_zalloc(taskstats_cache, GFP_KERNEL);

	spin_lock_irq(&tsk->sighand->siglock);
	if (!sig->stats) {
#2		sig->stats = stats; <- here in setting sig->stats
		stats = NULL;
	}
	spin_unlock_irq(&tsk->sighand->siglock);

	if (stats)
		kmem_cache_free(taskstats_cache, stats);
ret:
	return sig->stats;
}

The worst case scenario is that we might see sig->stats as being NULL when two
threads belonging to the same tgid. We do free up stats if we got that wrong

Am I misinterpreting the report?

Balbir Singh.


