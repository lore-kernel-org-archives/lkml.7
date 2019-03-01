Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5385C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7083A20851
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VZ+DOAMs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731890AbfCAKlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 05:41:04 -0500
Received: from mail-lj1-f170.google.com ([209.85.208.170]:42212 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfCAKlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 05:41:04 -0500
Received: by mail-lj1-f170.google.com with SMTP id d14so19929619ljl.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 02:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=iVyTvb+JL+tSG0oRvScKJQbHCTQmv9xA8LYTp/OAnA0=;
        b=VZ+DOAMsZBpfbo+LpIbaT2bx3zYam11yoCQEX3C4eazAwP+h85IqQNnn13wlr9iryJ
         T423DwlGbtpYVbwCV4MHBI+jBm9Ft9kaJ/dyVP7gACtbk1fmNef7ebl7MR6ZrEMnscS8
         BI0lAzD1vobXYCRXXzdnF1hOlYcF5F916MwSzOrfgyVOisrEh0ddjE0SAQEFesyEz0ii
         btX3twVp4D0q5Ns3Nj5GR15T4001RjZJSdXtdtaukfz3j3BL6spD+0ch675TsoYlh4KQ
         RegEhUszMMcRuVoldv/oMlBvFkHRNh9ash7tyC3Z5bGCT/m4ATZGA7eqYbHHdLEtdnZx
         TJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=iVyTvb+JL+tSG0oRvScKJQbHCTQmv9xA8LYTp/OAnA0=;
        b=ktTopFYD4BtDf+cZ9AW5ND73x69EAqDHbktM6zT48JvT+5dyx2UjbMWZ1hdCKwR7S5
         +47GOsjQE8NTRW6vkZ26xtKxUw8mLmDKNcAtiEcTI+tt3LP8XXjlUNP7njMoc7pgZavk
         wbI/l7qrusPa8npGYSxaAbH33ki4mBYAGBwxFzZ2pMOrvGuBrM6kU7OwTe6LrADumCm0
         ncgptwt5Jfkq7zB2DivT8O3HrzHuxrZ8MyXDlILcKPiXcPFGEpW1k4oo6tJwTCCHrFZj
         P4yJs6moEgh8Njh4ZsZCtLb+vlepk0BloAM2DJdQ6mD/k+Z7LH1DTKo2nPkHakPm4XUc
         SpIA==
X-Gm-Message-State: APjAAAUAYHcpQklBwLceedS36DJZ4gmle4Uv0kImEVMF0DW+h63jwLYD
        NbTTD/sXUSNHeylkYhwZFBOC0IOqz3kUQxmdwwxzAQ==
X-Google-Smtp-Source: APXvYqySHiInE3fCCgKfdciRvFJ42ILiTykam7FT4+TKhtxNknZQOM0UvQUDgQpbYlOR7BLiScxg5yLm9D0QaPvOujU=
X-Received: by 2002:a2e:6309:: with SMTP id x9mr2158283ljb.75.1551436861623;
 Fri, 01 Mar 2019 02:41:01 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 1 Mar 2019 16:10:50 +0530
Message-ID: <CA+G9fYvTkCZf-5OVU848ceskxhB6tKuabZphLb6XC23Nfe6VGA@mail.gmail.com>
Subject: net/strparser/strparser.c:526 strp_done+0x41/0x50
To:     Netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, yuehaibing@huawei.com,
        vakul.garg@nxp.com, davejwatson@fb.com, doronrk@fb.com,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do you see this Kernel warning  while running selftests bpf tes_sock
on x86_64 running Linux kernel version  5.0.0-rc8-next-20190301 ?

selftests: bpf: test_sock
Test case: bind4 load with invalid access: src_ip6 .. [PASS]
Test case: bind4 load with invalid access: mark .. [PASS]
Test case: bind6 load with invalid access: src_ip4 .. [PASS]
Test case: sock_create load with invalid access: src_port .. [PASS]
Test case: sock_create load w/o expected_attach_type (compat mode) .. [PASS]
Test case: sock_create load w/ expected_attach_type .. [PASS]
Test case: attach type mismatch bind4 vs bind6 .. [PASS]
Test case: attach type mismatch bind6 vs bind4 .. [PASS]
Test case: attach type mismatch default vs bind4 .. [PASS]
Test case: attach type mismatch bind6 vs sock_create .. [PASS]
Test case: bind4 reject all .. [PASS]
Test case: bind6 reject all .. [PASS]
Test case: bind6 deny specific IP & port .. [PASS]
Test case: bind4 allow specific IP & port .. [PASS]
Test case: bind4 allow al[  190.125907] WARNING: CPU: 3 PID: 5841 at
/srv/oe/build/tmp-lkft-glibc/work-shared/intel-corei7-64/kernel-source/net/strparser/strparser.c:526
strp_done+0x41/0x50
l .. [PASS]
Tes[  190.140453] Modules linked in: algif_hash af_alg x86_pkg_temp_thermal fuse
[  190.148702] CPU: 3 PID: 5841 Comm: kworker/3:166 Not tainted
5.0.0-rc8-next-20190301 #1
[  190.156701] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[  190.164180] Workqueue: events sk_psock_destroy_deferred
[  190.169398] RIP: 0010:strp_done+0x41/0x50
[  190.173399] Code: e8 04 51 4d ff 48 8d bb c0 00 00 00 e8 d8 50 4d
ff 48 8b 7b 18 48 85 ff 74 0d e8 aa 83 df ff 48 c7 43 18 00 00 00 00
5b 5d c3 <0f> 0b eb ce 90 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00
55 48
[  190.192137] RSP: 0018:ffffaa2ce728fe00 EFLAGS: 00010246
[  190.197354] RAX: ffffffffa8e09dd0 RBX: ffff9adbfb4bf040 RCX: ffffffffa8492fff
[  190.204479] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9adbfb4bf040
[  190.211602] RBP: ffffaa2ce728fe08 R08: 0000000000000001 R09: 0000000000000000
[  190.218726] R10: 0000000000000000 R11: ffff9adc0fd045c0 R12: ffff9adc9fba1980
[  190.225863] R13: ffff9adbfb4bf000 R14: 0000000000000000 R15: ffff9adc111226c0
[  190.232991] FS:  0000000000000000(0000) GS:ffff9adc9fb80000(0000)
knlGS:0000000000000000
[  190.241068] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  190.246832] CR2: 00007f6c861cbc90 CR3: 00000003b2c9e001 CR4: 00000000003606e0
[  190.253957] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  190.261081] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  190.268213] Call Trace:
[  190.270658]  sk_psock_destroy_deferred+0x29/0x1b0
[  190.275356]  process_one_work+0x281/0x610
[  190.279370]  worker_thread+0x3c/0x3f0
[  190.283034]  kthread+0x12c/0x150
[  190.286265]  ? process_one_work+0x610/0x610
[  190.290443]  ? kthread_park+0x90/0x90
[  190.294102]  ret_from_fork+0x3a/0x50
[  190.297680] irq event stamp: 2014
[  190.300989] hardirqs last  enabled at (2013): [<ffffffffa90d71ac>]
_raw_spin_unlock_irq+0x2c/0x40
[  190.309859] hardirqs last disabled at (2014): [<ffffffffa90cf569>]
__schedule+0xb9/0xa30
[  190.317941] softirqs last  enabled at (1650): [<ffffffffa9400334>]
__do_softirq+0x334/0x445
[  190.326278] softirqs last disabled at (1347): [<ffffffffa8476e70>]
irq_exit+0xc0/0xd0
[  190.334096] ---[ end trace 1a716d569572ba40 ]---
