Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBE7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7609D21855
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pi0tluJs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbfCLRRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:17:12 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:40640 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbfCLRQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:16:07 -0400
Received: by mail-it1-f195.google.com with SMTP id l139so5722934ita.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 10:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l6pIbrAZqeanIq+lkaoDuEehGSh5g23Npj75n1AdN1M=;
        b=pi0tluJs2cpb/QgGX3FUAq8gdvg/A1VbsXnyg32OfewnNpS7QDvoyoSrhRZoEb6HZb
         0H3SSkCPtbxyD2kpZP5Uy5MtKWk5tEwURNM3aGwc36Tbgp7AqszkswsPIwcmOu1Tmz0D
         Cj/KIy6fjjd82q66nsB73ed1Fpf7tfz4IZb98/bHk7lMp1e91NyzZNGWgfPO27MedTFJ
         twUHHz/EM0xDO2tu9FJcF5m9KLbAWt0EHas5GdVpkJ02oRyZFGZHrEQKH9rFbHeZZGSf
         o2PyJjUwM2jAOaxKEo6m5H0dDFvdm6d24/+3Suyw0X/IGOne09ZSd/dsIwf5GmFXeoNu
         1zug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l6pIbrAZqeanIq+lkaoDuEehGSh5g23Npj75n1AdN1M=;
        b=kNKUFAdpa4WI2ZuYngs8JA2Kpgs159Sk/pssP6OvM7uXFDQOsUI1dtmY/4pzPkb7DC
         DUVARa80JJ8BfIM74dWW74F5qBYMAX9teKAuf3dVcb5pxlO15PhWFC/f+9MH9HTZXZA/
         nMkDtrk2Ov+lGn8b9xIhA1WoWv9W+UMCrK/nVVYZ5anVMHhEciPyxMn+zMfr6fD73nE6
         kJj+39ToWMaOyL2nwegF9zVmFuMZ2Kzt2RDYEvM1yu3MI3E0D4tpV1h7GILMIo7KMFBE
         6Wcd3xjWnhKZLhNQW0VzyfBConv6tUMeNDdctCp7LF71EDQT03zk0KtddPCfk+9UzQsm
         x4Cg==
X-Gm-Message-State: APjAAAXpazFITkAVqQhYFo5laFs0KEeGhJmR2pHR1zVtyGXrhUJabBzA
        BBMZO9ZOVpH09x9cKmY2Mdoc+RqNSFrfwgocReYGk0eTeR2mBQ==
X-Google-Smtp-Source: APXvYqwAhNx8PsI1LGC2aT/kpErJbzGwss3mZUIkRX6xK8Yoe8s0jiy8CSuqqRhOUjw2IdKGPdpekSFQKCWMLvOSioA=
X-Received: by 2002:a05:660c:3d1:: with SMTP id c17mr2482627itl.166.1552410966022;
 Tue, 12 Mar 2019 10:16:06 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000010b2fc057fcdfaba@google.com> <0000000000008c75b50583ddb5f8@google.com>
 <20190312040829.GQ2217@ZenIV.linux.org.uk> <491ff1c3-91d6-eaa7-f551-46a4f8b90f5a@i-love.sakura.ne.jp>
In-Reply-To: <491ff1c3-91d6-eaa7-f551-46a4f8b90f5a@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 12 Mar 2019 18:15:54 +0100
Message-ID: <CACT4Y+ahcZpJ1Q-TKkCJkyhzGc07XFusuwBcKjg_rfAeos8RWA@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in sys_sendfile64 (2)
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     syzbot <syzbot+1505c80c74256c6118a5@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 3:30 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> (Moving most recipients to bcc: in order to avoid flooding.)
>
> On 2019/03/12 13:08, Al Viro wrote:
> > Umm...  Might be a good idea to add some plausibility filters - it is,
> > in theory, possible that adding a line in a comment changes behaviour
> > (without compiler bugs, even - playing with __LINE__ is all it would
> > take), but the odds that it's _not_ a false positive are very low.
>
> Well, 108 out of 168 tests done during this bisection failed to test.
> With such high failure ratio, it is possible that by chance no crash
> happened during few tests for specific commit; causing a wrong bisection
> result. I expect that when trying to conclude "git bisect good" for
> specific commit, the tests should be repeated until no crash happened
> during 8 successful tests.

Added to https://github.com/google/syzkaller/issues/1051:

Tetsuo points out that if lots (say, 7/8) tests failed with infra
problems, then we should retry/skip or something. This zeroes the
effect of having multiple independent tests.

Thanks.

> Also, this bisection is finding multiple different crash patterns, which
> suggests that the crashed tests are not giving correct feedback to syzbot.

Treating different crashes as just "crash" is intended. Kernel bugs
can manifest in very different ways.
Want fun, search for "bpf: sockhash, disallow bpf_tcp_close and update
in parallel" in  https://syzkaller.appspot.com/?fixed=upstream
It lead to 50+ different failure modes.

> $ grep -F 'run #' bisect.txt\?x\=13220283200000 | wc -l
> 168
> $ grep -F 'Connection timed out' bisect.txt\?x\=13220283200000 | wc -l
> 108
> $ grep -F 'crashed' bisect.txt\?x\=13220283200000
> run #0: crashed: WARNING: ODEBUG bug in netdev_freemem
> run #0: crashed: WARNING: ODEBUG bug in netdev_freemem
> run #1: crashed: INFO: rcu detected stall in corrupted
> run #0: crashed: INFO: rcu detected stall in sys_sendfile64
> run #0: crashed: INFO: rcu detected stall in corrupted
> run #4: crashed: INFO: rcu detected stall in sys_sendfile64
> run #0: crashed: INFO: rcu detected stall in corrupted
> run #1: crashed: INFO: rcu detected stall in corrupted
> run #0: crashed: INFO: rcu detected stall in ext4_file_write_iter
> run #0: crashed: INFO: rcu detected stall in corrupted
> run #0: crashed: INFO: rcu detected stall in sendfile64
> run #0: crashed: INFO: rcu detected stall in corrupted
> run #1: crashed: INFO: rcu detected stall in sendfile64
> run #0: crashed: INFO: rcu detected stall in ext4_file_write_iter
> run #1: crashed: INFO: rcu detected stall in corrupted
> run #0: crashed: INFO: rcu detected stall in corrupted
> run #0: crashed: INFO: rcu detected stall in corrupted
> run #0: crashed: INFO: rcu detected stall in corrupted
> run #1: crashed: INFO: rcu detected stall in corrupted
> run #0: crashed: INFO: rcu detected stall in corrupted
> run #3: crashed: INFO: rcu detected stall in corrupted
> run #0: crashed: INFO: rcu detected stall in do_iter_write
