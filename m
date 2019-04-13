Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFE3C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 20:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B46E12147A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 20:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9FHoL69"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfDMUxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 16:53:55 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35089 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfDMUxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 16:53:55 -0400
Received: by mail-wm1-f66.google.com with SMTP id y197so3213552wmd.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 13:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:message-id:date:mime-version:content-language
         :content-transfer-encoding;
        bh=Ua4z8qc6IjJbM9MH/N9wRKtyAbSdXoaDrC9cAetrvlA=;
        b=Q9FHoL69or3tyapPNk+Z1/pPsn0zWgJiuwyicqE8EQ7J41CXK/jYiMfEpTA+E8RfZ0
         0VGsQAghftZBMa3bRPKfEhR0XXR8OzBQumv+6u5NTXGOYini9oG1sbtxu9Q81DDkGFwb
         fDkKwXOg+trfKyL2en+JrvXgndG9YcmTWtwoAg+kHHztnn/YD+4CZfaQHD0lCWdraE/N
         q8OFfB1Mbo1SNh0H0+4y1Jq2gtlOqkyHLMEgzcr+84Pe6MqmSMIllLcbCr9z6mwAPVk8
         vld2B/z5LIGFnraa0gnmcrIrHqAYV2gcVZQxNDmp7c6gSSL9xUxt9qZ3jnUOAk/oCnPL
         E+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:message-id:date:mime-version
         :content-language:content-transfer-encoding;
        bh=Ua4z8qc6IjJbM9MH/N9wRKtyAbSdXoaDrC9cAetrvlA=;
        b=tLm7L7DTN7e3+A/7AJALX67dVbP+KHUbyi/DnjGRMrZN3aENecZp7lOpUstJjF2UkQ
         ghU0ZkKcmeiWGrgIwuNQTF7Dqijv+WMRqvd9bthLk/0e8dJuu7IRzlFv7flc7cr/Bbeg
         OPFvYEPJxT4m/69GJ7rAhWsUbrxPk0GjUZ1I4LC5IDM4mKYL0Rz9DliZeFkSxI5gqhHs
         nls9mobcR3VusXCCS66/66+WUSA6bX7XytivFjwrsHF8ag+ouRrTbe44+8mLZmsJdraO
         FeanBpWrf1fhoXUy71NbYnifaI/bj7RW3Yc7c8seQwVmqdlxTh0R2de+II5R3qUWpM+n
         oUjQ==
X-Gm-Message-State: APjAAAVYhBpZ6p0cdWPD41M1lKJ/KxYwefetPxrXb02glvMLHR7Fpv2x
        XhexiSyyYvH6TUPy7bPmhSQqPqo=
X-Google-Smtp-Source: APXvYqwNRLVwecoOBc09gDImwnHaiEHyhxR6UrKAi7ICdEWAj4Txakoxr7E4wacTmj1X4bJ2jMkVQw==
X-Received: by 2002:a1c:c504:: with SMTP id v4mr16600750wmf.45.1555188833526;
        Sat, 13 Apr 2019 13:53:53 -0700 (PDT)
Received: from localhost (33.red-83-38-164.dynamicip.rima-tde.net. [83.38.164.33])
        by smtp.gmail.com with ESMTPSA id w9sm18848617wmi.0.2019.04.13.13.53.53
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2019 13:53:53 -0700 (PDT)
From:   Xose Vazquez Perez <xose.vazquez@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, x86 team <x86@kernel.org>
Subject: bug disabling NX (noexec=off)
Message-ID: <c090ad3c-1f2f-c148-dd44-a58df0788588@gmail.com>
Date:   Sat, 13 Apr 2019 22:53:52 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Intel Core i3-2120 + kernel-5.0.7 x86_64 from Fedora:

[    0.000000] microcode: microcode updated early to revision 0x2e, date = 2018-04-10
[    0.000000] Linux version 5.0.7-300.fc30.x86_64 (mockbuild@bkernel04.phx2.fedoraproject.org) (gcc version 9.0.1 20190312 (Red Hat 9.0.1-0.10) (GCC)) #1 SMP Mon Apr 8 18:28:09 UTC 2019
[    0.000000] Command line: BOOT_IMAGE=(hd0,msdos1)/boot/vmlinuz-5.0.7-300.fc30.x86_64 root=UUID=ea93877a-9487-4416-9f32-9d1fba2a639a ro quiet audit=0 usb-storage.delay_use=0 net.ifnames=0
plymouth.enable=0 pti=off spectre_v2=off spectre_v2_user=off spec_store_bypass_disable=off l1tf=off noexec=off
[...]
[    0.000000] NX (Execute Disable) protection: disabled by kernel command line option
[    0.000000] ------------[ cut here ]------------
[    0.000000] attempted to set unsupported pgprot: 8000000000000163 bits: 8000000000000000 supported: 7fffffffffffffff
[    0.000000] WARNING: CPU: 0 PID: 0 at arch/x86/include/asm/pgtable.h:537 __early_set_fixmap+0xa2/0xff
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.7-300.fc30.x86_64 #1
[    0.000000] RIP: 0010:__early_set_fixmap+0xa2/0xff
[    0.000000] Code: ed be ff 49 21 cc 4c 39 e2 74 21 80 3d b8 a2 bb ff 00 75 18 4c 31 e2 48 c7 c7 68 b6 09 ac c6 05 a5 a2 bb ff 01 e8 ae ba 95 fe <0f> 0b 4c 89 e7 4c 09 ef ff 14 25 98 e2 22 ac 48 89
c6 48 89 df ff
[    0.000000] RSP: 0000:ffffffffac203de8 EFLAGS: 00010082 ORIG_RAX: 0000000000000000
[    0.000000] RAX: 0000000000000000 RBX: ffffffffac972000 RCX: 0000000000000078
[    0.000000] RDX: 0000000000000001 RSI: 0000000000000092 RDI: 0000000000000047
[    0.000000] RBP: ffffffffff200000 R08: 0000000000000001 R09: 0000000000000024
[    0.000000] R10: 0000000000000c1c R11: 0000000000000003 R12: 0000000000000163
[    0.000000] R13: 00000000000f0000 R14: 0000000000010000 R15: 0000000000000000
[    0.000000] FS:  0000000000000000(0000) GS:ffffffffac73a000(0000) knlGS:0000000000000000
[    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.000000] CR2: ffff888046212ff8 CR3: 00000000467de000 CR4: 00000000000406a0
[    0.000000] Call Trace:
[    0.000000]  ? __early_ioremap+0x10b/0x189
[    0.000000]  ? dmi_scan_machine+0xfe/0x209
[    0.000000]  ? setup_arch+0x436/0xc9f
[    0.000000]  ? start_kernel+0x65/0x519
[    0.000000]  ? secondary_startup_64+0xa4/0xb0
[    0.000000] random: get_random_bytes called from print_oops_end_marker+0x26/0x40 with crng_init=0
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] SMBIOS 2.6 present.
[...]


The same happens in a T61 with an Intel Core 2 Duo T7300.


Thanks.
