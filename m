Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B00C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0EDF21473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fa0/u/rK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbfDHPCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:02:18 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:37175 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfDHPCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 11:02:18 -0400
Received: by mail-it1-f193.google.com with SMTP id u65so21508046itc.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 08:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TOCc576NIn+amDyUdAM4HKdCXeGo3EpKDvfX/hvQKTg=;
        b=fa0/u/rKkBOsugD2/pikR6sNZniYbUo93QdE451unN2p3ScYhEelZrBTbWjmcUZFRK
         TZb3N1F8wBRBcDBjioDouEkcrI91aA/FMzb5bvsgC8rYIOgUOJHim1t0qgQvw/SsO/Vy
         zPiWLaWvG4Z4jQPRx1mvd28glCZo6TlJbyM4lNf47ttXK77Pg0bH00pomzs1NYBwC+xO
         AKQGO+PE2KjdiLdprtbOO2UfuVkaLexpNkatzoFHxnQtFQK7a1AKiLrJV41BQod+yRVF
         yEeKp5WJntDrlOM8JIfXQ/CChO/QmDOAlQC+9GYe0yr3x5/yT+1imPyh4BRs4149WYk/
         n1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TOCc576NIn+amDyUdAM4HKdCXeGo3EpKDvfX/hvQKTg=;
        b=RfzpnEAwyHbSEypcILJZ5Z0NysP4NopRBK+DhykZ2kimVmtfJXI+0UmLw2POj0rbDv
         AA2sgAdQPScH8zGvNq0us4+AnRddYVFVr1z3Gglo0gAJaft7JaneDmW79Wsh1iA+CDzx
         tkXMCGWU/xSZE5DMshp4rYPWKJHtz+dfrEW9z62wE97hdoNQ9EfMbc+a/tVmPlFaayue
         5hE/x3ZP7UHOrSksEtS3nHuXiiWUZ38tqzho/QTwQylC/CX0EgKX7sDCmbDOLzKVLTOl
         lWZ1BzoO8k5boTAenrgbiukSmSyXPFF4sZJNFRieCqkp9sMpdMcsatkaAb72behMDWBN
         pL/w==
X-Gm-Message-State: APjAAAWc35z+ndqRXw/NefQUgZBmYCcLHOq6YZEJ1Lfwr/tQJA+D/8nP
        mEsOH5uUdtpVYZkx48jXxLXmWDemgvXKjhCClMDAXA==
X-Google-Smtp-Source: APXvYqzDIxQMDMBx+2zvU86aLUooqgXfgMCINNpd+XSnCoIlpW4k7FaJYvjxcCrMDkAuuNGsG7tm50xGnOtLazej76k=
X-Received: by 2002:a02:7654:: with SMTP id z81mr21259527jab.79.1554735736845;
 Mon, 08 Apr 2019 08:02:16 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000027f6f6056bc8e0f8@google.com>
In-Reply-To: <00000000000027f6f6056bc8e0f8@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 8 Apr 2019 17:02:03 +0200
Message-ID: <CACT4Y+YxLq+1=tF7y9KTdCB4n1Y=G-YAGiWmJG2nko7Z5DGawA@mail.gmail.com>
Subject: Re: WARNING: suspicious RCU usage in corrupted
To:     syzbot <syzbot+5cec30d9329f61f2fb29@syzkaller.appspotmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 9, 2018 at 7:03 PM syzbot
<syzbot+5cec30d9329f61f2fb29@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    036db8bd9637 Merge branch 'for-4.17-fixes' of git://git.ke..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14d187e7800000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=31f4b3733894ef79
> dashboard link: https://syzkaller.appspot.com/bug?extid=5cec30d9329f61f2fb29
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> userspace arch: i386
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1110de07800000

This wasn't reproduced during bisection attempt, happened once a year ago.

#syz invalid

> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+5cec30d9329f61f2fb29@syzkaller.appspotmail.com
>
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> IPVS: ftp: loaded support on port[0] = 21
>
> =============================
> WARNING: suspicious RCU usage
> 4.17.0-rc4+ #64 Not tainted
> -----------------------------
> arch/x86/kernel/traps.c:537 entry code didn't wake RCU!
>
> other info that might help us debug this:
>
>
> RCU used illegally from idle CPU!
> rcu_scheduler_active = 2, debug_locks = 1
> RCU used illegally from extended quiescent state!
> no locks held by swapper/0/0.
>
> stack backtrace:
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report.
> If you forgot to add the Reported-by tag, once the fix for this bug is
> merged
> into any tree, please reply to this email with:
> #syz fix: exact-commit-title
> If you want to test a patch for this bug, please reply with:
> #syz test: git://repo/address.git branch
> and provide the patch inline or as an attachment.
> To mark this as a duplicate of another syzbot report, please reply with:
> #syz dup: exact-subject-of-another-report
> If it's a one-off invalid bug report, please reply with:
> #syz invalid
> Note: if the crash happens again, it will cause creation of a new bug
> report.
> Note: all commands must start from beginning of the line in the email body.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000027f6f6056bc8e0f8%40google.com.
> For more options, visit https://groups.google.com/d/optout.
