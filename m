Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442F8C43218
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F05820859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390177AbfFJV1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 17:27:35 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:58805 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389193AbfFJV1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 17:27:34 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1haRpD-0007Ex-Hn; Mon, 10 Jun 2019 15:27:31 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1haRpC-0006xo-Kg; Mon, 10 Jun 2019 15:27:31 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     syzbot <syzbot+f625baafb9a1c4bfc3f6@syzkaller.appspotmail.com>
Cc:     aarcange@redhat.com, akpm@linux-foundation.org,
        andrea.parri@amarulasolutions.com, ast@kernel.org,
        avagin@gmail.com, daniel@iogearbox.net, dbueso@suse.de,
        john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, oleg@redhat.com, prsood@codeaurora.org,
        syzkaller-bugs@googlegroups.com
References: <000000000000c0d84e058ad677aa@google.com>
Date:   Mon, 10 Jun 2019 16:27:15 -0500
In-Reply-To: <000000000000c0d84e058ad677aa@google.com> (syzbot's message of
        "Sat, 08 Jun 2019 14:17:00 -0700")
Message-ID: <87ftoh6si4.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1haRpC-0006xo-Kg;;;mid=<87ftoh6si4.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18S7yGkdj8GdsnV3+U9rf+Fa62sIZ/bY/0=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: general protection fault in mm_update_next_owner
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot <syzbot+f625baafb9a1c4bfc3f6@syzkaller.appspotmail.com> writes:

> syzbot has bisected this bug to:
>
> commit e9db4ef6bf4ca9894bb324c76e01b8f1a16b2650
> Author: John Fastabend <john.fastabend@gmail.com>
> Date:   Sat Jun 30 13:17:47 2018 +0000
>
>     bpf: sockhash fix omitted bucket lock in sock_close
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15e978e1a00000
> start commit:   38e406f6 Merge git://git.kernel.org/pub/scm/linux/kernel/g..
> git tree:       net
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=17e978e1a00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=13e978e1a00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=60564cb52ab29d5b
> dashboard link: https://syzkaller.appspot.com/bug?extid=f625baafb9a1c4bfc3f6
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1193d81ea00000
>
> Reported-by: syzbot+f625baafb9a1c4bfc3f6@syzkaller.appspotmail.com
> Fixes: e9db4ef6bf4c ("bpf: sockhash fix omitted bucket lock in sock_close")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

How is mm_update_next_owner connected to bpf?

Eric
