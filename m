Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB4AC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 16:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7F4E21900
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 16:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NvrwuZ+Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfCPQH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 12:07:26 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:44855 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfCPQH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 12:07:26 -0400
Received: by mail-io1-f46.google.com with SMTP id u12so10848680iop.11
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 09:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dqevfmxoyMI/aj2Yk4IbEfN3VVA7deEP+msqdb6wo2k=;
        b=NvrwuZ+YW87KZCtOcGAg6k1hS8a4qx1ohitFOUIRfqMF1w8/xA0JIfJA7Vq19tsQUr
         hjLElj0VG4LB1Do3i6fFaXpTZBM0UkfJ3z2A+BcYJMB7Cr8k6vWHIS/Ma/ecPq3CUc0V
         NAA3zuiGyxepUoVZNaaYtcm6vqZCstysP4ROE82+siB4oEIHCU93Roh4zerTkNfR9THK
         Fdu66b0E/H4Zi2C/9Cw/vke4ABiW4KmwJhht2ePrEY/WoX6L9VfyLfy6FWwLq+A4OPpl
         qA1jfD8zEqcm3ouww9FNt+HLdjHcBq8ghyHLi8vmqmifdYtxQC4/RsE32kgJ5kb17pGs
         PqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dqevfmxoyMI/aj2Yk4IbEfN3VVA7deEP+msqdb6wo2k=;
        b=qiK9NXtQvMcUqC9+N5HafQL8584qxz6+lSM/wBq5uoqtBnItV3+ZSiHss4N5aMW19I
         y7OYVSWZl0ixV+o2cos4dsR9vEFmrGudwYZhefXyvcnL9BexRS1HBSxSeqEk6n4dcfyE
         JMBslpv/tXhDIwrnohlAOHjKFj1eLG9oCgi6uZWhIzBY2sAzjeXDbK3fwqeI0GLT+fOP
         wb/dUOT+HUZr2nk9YCQO2qNYFy8uvr1weaebAfaMxIYSLgMaLmOdMuRGqJ6Jt49PGkZQ
         3wf529ibNZGm88e/nJbFDsrDZryunnAO2GEDLh3sGZXDvQbtZ9FxI5K5Jk9TgTuL7kAT
         bA/A==
X-Gm-Message-State: APjAAAU3rUgK7PednqZ3XRLWkFdvN2LU0seKdd6QNDrwwWDo67v+fjXz
        LBOM0ldQ/cQU9ik9fIVhn1TaVDOLXuS7GKMDzEZ3sQb48i656Q==
X-Google-Smtp-Source: APXvYqy7E69c8xSFC++LpXd4h5BNSKlWUOwEiIkL1XFF94Vmqk0HShkUOeoBdbuKD+0aiIU1z0KwuETBdwpyZzLAHu0=
X-Received: by 2002:a6b:c3cc:: with SMTP id t195mr5932067iof.11.1552752445496;
 Sat, 16 Mar 2019 09:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000551b80057d31a5f7@google.com> <00000000000093e58e0584374110@google.com>
 <20190316165241.2855f966@elisabeth>
In-Reply-To: <20190316165241.2855f966@elisabeth>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 16 Mar 2019 17:07:13 +0100
Message-ID: <CACT4Y+ZCc70MNC+BVhXjE7BX=CavZxYPduzz+9imz7FBfQ586Q@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in tick_sched_handle
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     syzbot <syzbot+09d51a30df9fe76edb2a@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Sabrina Dubroca <sd@queasysnail.net>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Eric Dumazet <eric.dumazet@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2019 at 4:53 PM Stefano Brivio <sbrivio@redhat.com> wrote:
>
> On Sat, 16 Mar 2019 07:49:01 -0700
> syzbot <syzbot+09d51a30df9fe76edb2a@syzkaller.appspotmail.com> wrote:
>
> > syzbot has bisected this bug to:
> >
> > commit b8a51b38e4d4dec3e379d52c0fe1a66827f7cf1e
> > Author: Stefano Brivio <sbrivio@redhat.com>
> > Date:   Thu Nov 8 11:19:23 2018 +0000
> >
> >      fou, fou6: ICMP error handlers for FoU and GUE
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16f943e7200000
> > start commit:   b8a51b38 fou, fou6: ICMP error handlers for FoU and GUE
> > git tree:       upstream
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=15f943e7200000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=11f943e7200000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=b05cfdb4ee8ab9b2
> > dashboard link: https://syzkaller.appspot.com/bug?extid=09d51a30df9fe76edb2a
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17359fab400000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154a2a37400000
> >
> > Reported-by: syzbot+09d51a30df9fe76edb2a@syzkaller.appspotmail.com
> > Fixes: b8a51b38 ("fou, fou6: ICMP error handlers for FoU and GUE")
>
> Might be fixed by bc6e019b6ee6 ("fou: Prevent unbounded recursion in GUE
> error handler also with UDP-Lite"), testing/checking now.

Yes, most likely it is. The bug was just never closed as fixed. But
the last crash happened 2 months ago.
So I would say we just mark this as fixed:

#syz fix:
fou: Prevent unbounded recursion in GUE error handler also with UDP-Lite

Next after root cause bisection is fix bisection, so this part will be
automated to some degree as well.
