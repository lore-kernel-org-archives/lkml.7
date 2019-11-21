Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD9FC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 18:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90DFD20672
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 18:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574359300;
	bh=ruTBz8dVya4WaPnyIBDp61iWLDaJrk1pYALVmqj+7Vo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jdSfben6MNm39YwbAOc6gRBGgK7RYkKBIRGHeT5YUT2/lFZTrpAxiK8Sr8cjjqnel
	 t3u3eGXO/e7ZE/liZq8daDwaj8LJODQPELDhr4lnRxGxYwFANtLD04akHtfM0kTpP+
	 SZr4+bd6gUkm3DTcQC6P59ahKqZXy1YRKsayiiE4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfKUSBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 13:01:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:47306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbfKUSBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 13:01:39 -0500
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F193D206F4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 18:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574359298;
        bh=ruTBz8dVya4WaPnyIBDp61iWLDaJrk1pYALVmqj+7Vo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PWALfx7LQ2JlDN3r79NlzOh4KVooG+VZ0qnOW5HSzGcU3OI82ZYUQQZgkZg5u/6ry
         uPbLkk4X059DMbaxwZBM9BLnS1yPPb7VuAGdgYIxp8i+v9zqfZKc63bilGPdYewpuL
         TE6x1Q3LzqclMIsuYHM99hKheZOcuIHCGsKFidjY=
Received: by mail-wm1-f44.google.com with SMTP id t26so4380428wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 10:01:37 -0800 (PST)
X-Gm-Message-State: APjAAAWG3pb9X3D9bMKxytneGluThyRbYGAboBnFTYJHXAUpkeJsj3Gv
        PIVtoByt7i/47VxtM1wD6l62iaStocbU2NaRpstViw==
X-Google-Smtp-Source: APXvYqzhHzqk5yF6OIonrsRfxSV2BGF3FMJRz7HvRWn1XUIvwVYdsgWd8lNDLFm13XUwgW2XCgZQRtVGKYKAEXK8YeM=
X-Received: by 2002:a7b:c1ca:: with SMTP id a10mr12336041wmj.161.1574359296389;
 Thu, 21 Nov 2019 10:01:36 -0800 (PST)
MIME-Version: 1.0
References: <0000000000006e31980579315914@google.com> <000000000000a6993c0597cc8375@google.com>
In-Reply-To: <000000000000a6993c0597cc8375@google.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 21 Nov 2019 10:01:24 -0800
X-Gmail-Original-Message-ID: <CALCETrVfWHPHiOmyJ9iDJDiCD3idPA4BdeM=4FUEO-uuxM07_g@mail.gmail.com>
Message-ID: <CALCETrVfWHPHiOmyJ9iDJDiCD3idPA4BdeM=4FUEO-uuxM07_g@mail.gmail.com>
Subject: Re: INFO: task hung in __do_page_fault (2)
To:     syzbot <syzbot+6b074f741adbd93d2df5@syzkaller.appspotmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andrew Lutomirski <luto@kernel.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        syzkaller-bugs@googlegroups.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 11:52 AM syzbot
<syzbot+6b074f741adbd93d2df5@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this bug to:
>
> commit 0161028b7c8aebef64194d3d73e43bc3b53b5c66
> Author: Andy Lutomirski <luto@kernel.org>
> Date:   Mon May 9 22:48:51 2016 +0000
>
>      perf/core: Change the default paranoia level to 2
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15910e86e00000
> start commit:   18d0eae3 Merge tag 'char-misc-4.20-rc1' of git://git.kerne..
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=17910e86e00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=13910e86e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=342f43de913c81b9
> dashboard link: https://syzkaller.appspot.com/bug?extid=6b074f741adbd93d2df5
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12482713400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=158fd4a3400000
>
> Reported-by: syzbot+6b074f741adbd93d2df5@syzkaller.appspotmail.com
> Fixes: 0161028b7c8a ("perf/core: Change the default paranoia level to 2")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Hi syzbot-

I'm not quite sure how to tell you this in syzbotese, but I'm pretty
sure you've bisected this wrong.  The blamed patch makes no sense.

--Andy
