Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEB8C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE333206E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="23ufbG15"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbfFGOOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 10:14:16 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:54643 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727915AbfFGOOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 10:14:15 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id cb936dc6
        for <linux-kernel@vger.kernel.org>;
        Fri, 7 Jun 2019 13:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :from:date:message-id:subject:to:cc:content-type; s=mail; bh=OeF
        uQrPwu5IL9s3FkHC48tIdkYU=; b=23ufbG15/HAhhqr0dMAC739K1BgGl/I8Utg
        AsVQ+mNyxec8wC3umkFHVSI7ZuASjfEZm3t9+Ddfy/ULakh3bcxhqU8hvXWvAr8e
        grZtwRSUNZoHixB0LiWjjsWpylQPnTuVOo2kV9DXK+8TYnqBK+u2AMcHbHDXm6GA
        fyf555l2QowcmHE2KJ1cv1j8uT4wvqEDhRO5cBeIflLLqkyOVX/1kqWwH7yPtegZ
        gpJqw+ToK1UEufsPWUd6X387qv/BAhCzoJYSI1JfdewHUx8aI0xko9Kb4Z7tQJzT
        wMOteKpD+zngSlONO0raVlzz37iFA5j2FSvwRg4J1bPhXwAUa/Q==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f229aa2e (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Fri, 7 Jun 2019 13:42:35 +0000 (UTC)
Received: by mail-ot1-f44.google.com with SMTP id r21so1969409otq.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 07:14:12 -0700 (PDT)
X-Gm-Message-State: APjAAAU+4q/2W/pPwJDOZo33PtVMXK+c0YzTHYZsSfpcQtC6Gl61jmtG
        OxrwLsTH3f44aL/VHWs8VfIlIwf98Jor6fuHrQ8=
X-Google-Smtp-Source: APXvYqxg1/3IwWP3Q+X6sa+o268T3x+BLaVlnwR5sQtXYEWGYFh+6ptuH/NNVB1vpMQyH8Vn635GR+B+GHu7Rr5xZ+k=
X-Received: by 2002:a9d:67d5:: with SMTP id c21mr1179546otn.243.1559916851654;
 Fri, 07 Jun 2019 07:14:11 -0700 (PDT)
MIME-Version: 1.0
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 7 Jun 2019 16:14:00 +0200
X-Gmail-Original-Message-ID: <CAHmME9qBDtO1vJrA2Ch3SQigsu435wR7Q3vTm_3R=u=BE49S-Q@mail.gmail.com>
Message-ID: <CAHmME9qBDtO1vJrA2Ch3SQigsu435wR7Q3vTm_3R=u=BE49S-Q@mail.gmail.com>
Subject: infinite loop in read_hpet from ktime_get_boot_fast_ns
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, clemens@ladisch.de,
        Sultan Alsawaf <sultan@kerneltoast.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Thomas,

After some discussions here prior about the different clocks
available, WireGuard uses ktime_get_boot_fast_ns() pretty extensively.
The requirement is for a quasi-accurate monotonic counter that takes
into account sleep time, and this seems to fit the bill pretty well.
Sultan (CC'd) reported to me a non-reproducible bug he encountered in
4.19.47 (arch's linux-lts package), where the CPU was hung in
read_hpet.

CPU: 1 PID: 7927 Comm: kworker/1:3 Tainted: G           OE     4.19.47-1-lts #1
Hardware name: Dell Inc. XPS 15 9570/02MJVY, BIOS 1.10.1 04/26/2019
Workqueue: wg-crypt-interface wg_packet_tx_worker [wireguard]
RIP: 0010:read_hpet+0x67/0xc0
Code: c0 75 11 ba 01 00 00 00 f0 0f b1 15 a3 3d 1a 01 85 c0 74 37 48
89 cf 57 9d 0f 1f 44 00 00 48 c1 ee 20 eb 04 85 c9 74 12 f3 90 <49> 8b
08 48 89 ca 48 c1 ea 20 89 d0 39 f2 74 ea c3 48 8b 05 89 56
RSP: 0018:ffffb8d382533e18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
RAX: 0000000018a4c89e RBX: 0000000000000000 RCX: 18a4c89e00000001
RDX: 0000000018a4c89e RSI: 0000000018a4c89e RDI: ffffffffb8227980
RBP: 000006c1c3f602a2 R08: ffffffffb8205040 R09: 0000000000000000
R10: 000001d58fd28efc R11: 0000000000000000 R12: ffffffffb8259a80
R13: 00000000ffffffff R14: 0000000518a0d8c4 R15: 000000000010fa5a
FS:  0000000000000000(0000) GS:ffff9b90ac240000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00003663b14d9ce8 CR3: 000000030f20a006 CR4: 00000000003606e0
Call Trace:
 ktime_get_mono_fast_ns+0x53/0xa0
 ktime_get_boot_fast_ns+0x5/0x10
 wg_packet_tx_worker+0x183/0x220 [wireguard]
 process_one_work+0x1f4/0x3e0
 worker_thread+0x2d/0x3e0
 ? process_one_work+0x3e0/0x3e0
 kthread+0x112/0x130
 ? kthread_park+0x80/0x80
 ret_from_fork+0x35/0x40
watchdog: BUG: soft lockup - CPU#1 stuck for 23s! [kworker/1:3:7927]

It looks like RIP is spinning in this loop in read_hpet:

do {
    cpu_relax();
    new.lockval = READ_ONCE(hpet.lockval);
} while ((new.value == old.value) && arch_spin_is_locked(&new.lock));

I imagine this could be a bug in the hpet code, or a failure of the
hpet hardware. But I thought it'd be most prudent to check, first,
whether there are actually very particular conditions on when and
where ktime_get_boot_fast_ns and friends can be called. In other
words, maybe the bug is actually in my code. I was under the
impression that invoking it from anywhere was fine, given the
documentation says "NMI safe", but maybe there are still some
requirements I should keep in mind?

Thanks,
Jason
