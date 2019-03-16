Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FBAC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 15:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE98218E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 15:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfCPPxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 11:53:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33098 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbfCPPxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 11:53:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5963159449;
        Sat, 16 Mar 2019 15:53:02 +0000 (UTC)
Received: from elisabeth (ovpn-200-27.brq.redhat.com [10.40.200.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5CEC84385;
        Sat, 16 Mar 2019 15:52:53 +0000 (UTC)
Date:   Sat, 16 Mar 2019 16:52:41 +0100
From:   Stefano Brivio <sbrivio@redhat.com>
To:     syzbot <syzbot+09d51a30df9fe76edb2a@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, fweisbec@gmail.com, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        netdev@vger.kernel.org, sd@queasysnail.net,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        yoshfuji@linux-ipv6.org, Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in tick_sched_handle
Message-ID: <20190316165241.2855f966@elisabeth>
In-Reply-To: <00000000000093e58e0584374110@google.com>
References: <000000000000551b80057d31a5f7@google.com>
        <00000000000093e58e0584374110@google.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Sat, 16 Mar 2019 15:53:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Mar 2019 07:49:01 -0700
syzbot <syzbot+09d51a30df9fe76edb2a@syzkaller.appspotmail.com> wrote:

> syzbot has bisected this bug to:
> 
> commit b8a51b38e4d4dec3e379d52c0fe1a66827f7cf1e
> Author: Stefano Brivio <sbrivio@redhat.com>
> Date:   Thu Nov 8 11:19:23 2018 +0000
> 
>      fou, fou6: ICMP error handlers for FoU and GUE
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16f943e7200000
> start commit:   b8a51b38 fou, fou6: ICMP error handlers for FoU and GUE
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=15f943e7200000
> console output: https://syzkaller.appspot.com/x/log.txt?x=11f943e7200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b05cfdb4ee8ab9b2
> dashboard link: https://syzkaller.appspot.com/bug?extid=09d51a30df9fe76edb2a
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17359fab400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154a2a37400000
> 
> Reported-by: syzbot+09d51a30df9fe76edb2a@syzkaller.appspotmail.com
> Fixes: b8a51b38 ("fou, fou6: ICMP error handlers for FoU and GUE")

Might be fixed by bc6e019b6ee6 ("fou: Prevent unbounded recursion in GUE
error handler also with UDP-Lite"), testing/checking now.

-- 
Stefano
