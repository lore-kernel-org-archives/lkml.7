Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49815C4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 06:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D2E21927
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 06:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Rt4Ua2Jx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbfI3GKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 02:10:21 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37266 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbfI3GKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 02:10:21 -0400
Received: from zn.tnic (p200300EC2F058B001D5F1DA44E6EEA2E.dip0.t-ipconnect.de [IPv6:2003:ec:2f05:8b00:1d5f:1da4:4e6e:ea2e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AA6A81EC014A;
        Mon, 30 Sep 2019 08:10:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1569823815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=eWiTm3QIKvFb+exZ5gCuoF0D6Nbfykl9B0HLndIZs+A=;
        b=Rt4Ua2JxnLnjWZL+Di9JvAMCdTnLx1LFfrFRXk1UHsegLDEfqrGHTBRfQliuIXsGG8557Z
        8SK65pH25+7bOKkivw46Vm0h9Aq4wMmEaGH8H6Zr2AYAbxybNT0PRU6d/u/fAcv9BeiLG4
        xTUhz1lvV+DZoPM3JyYQ1dHvmkAunjw=
Date:   Mon, 30 Sep 2019 08:10:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Nicholas Mc Guire <hofrat@opentech.at>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: x86/random: Speculation to the rescue
Message-ID: <20190930061014.GC29694@zn.tnic>
References: <alpine.DEB.2.21.1909290010500.2636@nanos.tec.linutronix.de>
 <CAHk-=wgjC01UaoV35PZvGPnrQ812SRGPoV7Xp63BBFxAsJjvrg@mail.gmail.com>
 <CAHk-=wi0vxLmwEBn2Xgu7hZ0U8z2kN4sgCax+57ZJMVo3huDaQ@mail.gmail.com>
 <CAHk-=whKhD-GniDqpRhhF=V2cSxThX56NAdkAUoBkbp0mW5=LA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whKhD-GniDqpRhhF=V2cSxThX56NAdkAUoBkbp0mW5=LA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2019 at 07:59:19PM -0700, Linus Torvalds wrote:
> All my smoke testing looked fine - I disabled trusting the CPU, I
> increased the required entropy a lot, and to actually trigger the
> lockup issue without the broken user space, I made /dev/urandom do
> that "wait for entropy" thing too.

Hohum, seems to get rid of the longish delay during boot on my test
boxes here:

$ grep random /var/log/messages

<--- that's before

Sep 30 07:46:07 cz vmunix: [    0.000000] random: get_random_bytes called from start_kernel+0x304/0x4ac with crng_init=0
Sep 30 07:46:07 cz vmunix: [    1.505641] random: fast init done
Sep 30 07:46:07 cz vmunix: [    7.124808] random: dd: uninitialized urandom read (512 bytes read)
Sep 30 07:46:07 cz vmunix: [    8.507672] random: dbus-daemon: uninitialized urandom read (12 bytes read)
Sep 30 07:46:07 cz vmunix: [    8.518621] random: dbus-daemon: uninitialized urandom read (12 bytes read)
Sep 30 07:46:07 cz vmunix: [    8.565073] random: avahi-daemon: uninitialized urandom read (4 bytes read)
Sep 30 07:46:21 cz vmunix: [   23.092795] random: crng init done
Sep 30 07:46:21 cz vmunix: [   23.096419] random: 3 urandom warning(s) missed due to ratelimiting

<--- that's after and we're 15 secs faster:

Sep 30 07:47:53 cz vmunix: [    0.329599] random: get_random_bytes called from start_kernel+0x304/0x4ac with crng_init=0
Sep 30 07:47:53 cz vmunix: [    1.949216] random: fast init done
Sep 30 07:47:53 cz vmunix: [    4.806132] random: dd: uninitialized urandom read (512 bytes read)
Sep 30 07:47:53 cz vmunix: [    5.954547] random: dbus-daemon: uninitialized urandom read (12 bytes read)
Sep 30 07:47:53 cz vmunix: [    5.965483] random: dbus-daemon: uninitialized urandom read (12 bytes read)
Sep 30 07:47:53 cz vmunix: [    6.014102] random: avahi-daemon: uninitialized urandom read (4 bytes read)
Sep 30 07:47:55 cz vmunix: [    8.238514] random: crng init done
Sep 30 07:47:55 cz vmunix: [    8.240205] random: 3 urandom warning(s) missed due to ratelimiting

Seeing how those uninitialized urandom read warns still happen, I added a
dump_stack() to see when we do wait for the random bytes first and I got this:

[    5.522348] random: dbus-daemon: uninitialized urandom read (12 bytes read)
[    5.532008] random: dbus-daemon: uninitialized urandom read (12 bytes read)
[    5.579922] random: avahi-daemon: uninitialized urandom read (4 bytes read)
[    5.751790] elogind-daemon[1730]: New seat seat0.
[    5.756376] elogind-daemon[1730]: Watching system buttons on /dev/input/event6 (Power Button)
[    5.777381] elogind-daemon[1730]: Watching system buttons on /dev/input/event3 (Power Button)
[    5.781485] elogind-daemon[1730]: Watching system buttons on /dev/input/event5 (Lid Switch)
[    5.783547] elogind-daemon[1730]: Watching system buttons on /dev/input/event4 (Sleep Button)
[    5.885300] elogind-daemon[1730]: Watching system buttons on /dev/input/event0 (AT Translated Set 2 keyboard)
[    5.911602] CPU: 2 PID: 1798 Comm: sshd Not tainted 5.3.0+ #1
[    5.914672] Hardware name: HP HP EliteBook 745 G3/807E, BIOS N73 Ver. 01.39 04/16/2019
[    5.917774] Call Trace:
[    5.920905]  dump_stack+0x46/0x60
[    5.924044]  wait_for_random_bytes.part.32+0x21/0x163
[    5.927256]  ? handle_mm_fault+0x50/0xc0
[    5.930425]  ? _raw_spin_unlock_irq+0x17/0x40
[    5.933604]  ? __do_page_fault+0x225/0x500
[    5.936763]  __x64_sys_getrandom+0x70/0xb0
[    5.939902]  do_syscall_64+0x4c/0x180
[    5.943003]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    5.946152] RIP: 0033:0x7f4417f4d495
[    5.949225] Code: 74 4c 8d 0c 37 41 ba 3e 01 00 00 66 2e 0f 1f 84 00 00 00 00 00 4d 39 c8 73 27 4c 89 ce 31 d2 4c 89 c7 44 89 d0 4c 29 c6 0f 05 <48> 3d 00 f0 ff ff 77 2b 48 85 c0 78 0e 74 3c 49 01 c0 4d 39 c8 72
[    5.952902] RSP: 002b:00007ffc69e6e328 EFLAGS: 00000202 ORIG_RAX: 000000000000013e
[    5.956227] RAX: ffffffffffffffda RBX: 0000000000000020 RCX: 00007f4417f4d495
[    5.959530] RDX: 0000000000000000 RSI: 0000000000000020 RDI: 0000559262c74780
[    5.962820] RBP: 0000559262c708b0 R08: 0000559262c74780 R09: 0000559262c747a0
[    5.966104] R10: 000000000000013e R11: 0000000000000202 R12: 00007ffc69e6e470
[    5.969373] R13: 0000000000000002 R14: 00007f4417f4d460 R15: 000000007fffffff
[    7.852837] random: crng init done
[    7.854637] random: 3 urandom warning(s) missed due to ratelimiting
[   17.767786] elogind-daemon[1730]: New session c1 of user root.

so sshd does getrandom(2) while those other userspace things don't. Oh
well.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
