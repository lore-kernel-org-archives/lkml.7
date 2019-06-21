Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F035C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 23:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A6D52084E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 23:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1T4gOW4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfFUXoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 19:44:01 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34605 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfFUXoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 19:44:00 -0400
Received: by mail-pl1-f193.google.com with SMTP id i2so3725752plt.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 16:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=QxZ9e0XTPOduI9FUa5wofmXf+QGKM7Lf7OKdVPoCjt8=;
        b=e1T4gOW4I2GUjYlhBuNsgnT0QBdeNU5mIFGrpaye98+BOxTzm1FtQqpHM+LKcclQO5
         yUiL/g4PE4wAIPPSvBC8tNezBOgHhlc+TLDYkmksiPlLAL8zBW9POAZOtaRWAE2yBExh
         YlksJ8QMvTXcLv6KjllLgmcA4mY4r3qbxQjoR+6BUXw13XgVdjSgNqBhO6gQ8ErFFGDz
         ZxlCrOHv3XaJe5ymAfDKvpASWGIZHUwl7/Cjs0OVPuB+IhGwkqvX85GAceKfViWR9CDc
         UcdTxngkKUX/PLNGCAd2DgcEm5okFsvFT+JgGjzd/2ROQtSFs3M+wYk7rKYZdULDrPIo
         mUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=QxZ9e0XTPOduI9FUa5wofmXf+QGKM7Lf7OKdVPoCjt8=;
        b=tCBqQpJ9c3Bbp+noquxkyQhELy2EAoigFZ3KBTPnh0KmvXHMS00q5qpNqiwZ/DUeyY
         CRRgSy0yPnzmcTwOEGxCNpXKNAJBPq4cAeR5fui2d0n/qZXGddFUKMGAQ70Yb+GQQsVm
         wvkVAjWsRjj4zCFzWTeK3HZOnHseqd0nAVCwv2I1AgUSe72Pc4XBPFbXWNpzZ0kewT8s
         dPDX3gc4ITh4amrBR8xmjUhM2hDTMQd+cfpEW6UTZ6L6meSCDk29LFa5u3JcmmQaFvlj
         mfaYkdXLO6+C2VFFzdp7NmqXD2if8yLPI35Ksq/ljlO5RiBDqJgsohEnb4h4zY0v08n1
         /EiQ==
X-Gm-Message-State: APjAAAUZFqBB9MFR5r+eaJKPB4bQa4rnMy9n716sQj7xgq0dTzrctI0Q
        jUWC2aifJMqge7YSRdU6ejIs7uYB
X-Google-Smtp-Source: APXvYqxRQWzHN8el66kzI7dItP5s4ofPaQHNaCj914WJtHhu/nCRmYsTPhrB0q4zyEWAwTvm5I8+5g==
X-Received: by 2002:a17:902:29a7:: with SMTP id h36mr83730227plb.158.1561160639943;
        Fri, 21 Jun 2019 16:43:59 -0700 (PDT)
Received: from localhost ([1.144.148.38])
        by smtp.gmail.com with ESMTPSA id c18sm3861782pfc.180.2019.06.21.16.43.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 16:43:59 -0700 (PDT)
Date:   Sat, 22 Jun 2019 09:43:42 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [kernel/isolation] c427534e48:
 BUG:kernel_NULL_pointer_dereference,address
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
References: <20190621082027.GS7221@shao2-debian>
In-Reply-To: <20190621082027.GS7221@shao2-debian>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1561160086.rsh9p04w45.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot's on June 21, 2019 6:20 pm:
> FYI, we noticed the following commit (built with gcc-7):
>=20
> commit: c427534e48381727924529455ddfa67e2985686d ("kernel/isolation: Asse=
t that a housekeeping CPU comes up at boot time")
> https://git.kernel.org/cgit/linux/kernel/git/peterz/queue.git sched/core
>=20
> in testcase: rcuperf
> with following parameters:
>=20
> 	runtime: 300s
> 	perf_type: tasks
>=20
>=20
>=20
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -=
m 2G
>=20
> caused below changes (please refer to attached dmesg/kmsg for entire log/=
backtrace):
>=20
>=20
> +-------------------------------------------------+------------+---------=
---+
> |                                                 | 66567fcbae | c427534e=
48 |
> +-------------------------------------------------+------------+---------=
---+
> | boot_successes                                  | 5          | 0       =
   |
> | boot_failures                                   | 18         | 11      =
   |
> | BUG:kernel_reboot-without-warning_in_test_stage | 18         |         =
   |
> | BUG:kernel_NULL_pointer_dereference,address     | 0          | 11      =
   |
> | Oops:#[##]                                      | 0          | 11      =
   |
> | RIP:housekeeping_verify_smp                     | 0          | 11      =
   |
> | Kernel_panic-not_syncing:Fatal_exception        | 0          | 11      =
   |
> +-------------------------------------------------+------------+---------=
---+
>=20
>=20
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
>=20
>=20
> [    0.562433] BUG: kernel NULL pointer dereference, address: 00000000000=
00000
> [    0.562994] #PF: supervisor read access in kernel mode
> [    0.562994] #PF: error_code(0x0000) - not-present page
> [    0.562994] PGD 0 P4D 0=20
> [    0.562994] Oops: 0000 [#1] SMP PTI
> [    0.562994] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.2.0-rc5-00015-=
gc427534 #1
> [    0.562994] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S 1.10.2-1 04/01/2014
> [    0.562994] RIP: 0010:housekeeping_verify_smp+0x2b/0x41
> [    0.562994] Code: 66 66 66 90 53 83 c8 ff 48 c7 c3 c0 e2 e3 84 48 89 d=
e 89 c7 e8 94 d4 d7 fe 3b 05 22 77 b8 ff 73 13 89 c2 48 8b 0d db eb 28 00 <=
48> 0f a3 11 73 df 31 c0 5b c3 48 c7 c7 f0 0e 8d 84 e8 1b 84 3e fe
> [    0.562994] RSP: 0000:ffffabda00327e18 EFLAGS: 00010293
> [    0.562994] RAX: 0000000000000000 RBX: ffffffff84e3e2c0 RCX: 000000000=
0000000
> [    0.562994] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff8=
4e3e2c0
> [    0.562994] RBP: ffffffff852b7572 R08: 0000000000000044 R09: 000000000=
0000228
> [    0.562994] R10: 0000000000000000 R11: ffff892f4f817e10 R12: ffffffff8=
54a0938
> [    0.562994] R13: 0000000000000002 R14: ffffffff852898d9 R15: 000000000=
0000000
> [    0.562994] FS:  0000000000000000(0000) GS:ffff892fa1e00000(0000) knlG=
S:0000000000000000
> [    0.562994] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.562994] CR2: 0000000000000000 CR3: 000000001ec0a000 CR4: 000000000=
00406f0
> [    0.562994] Call Trace:
> [    0.562994]  do_one_initcall+0x46/0x214
> [    0.562994]  kernel_init_freeable+0x1c7/0x272
> [    0.562994]  ? rest_init+0xd0/0xd0
> [    0.562994]  kernel_init+0xa/0x110
> [    0.562994]  ret_from_fork+0x35/0x40
> [    0.562994] Modules linked in:
> [    0.562994] CR2: 0000000000000000
> [    0.562994] ---[ end trace 1c0ad476e5b7f021 ]---

Oops, housekeeping_verify_smp needs to needs to check
housekeeping_overidden before testing housekeeping_mask.

You want me to resend with a fix?

Thanks,
Nick

=
