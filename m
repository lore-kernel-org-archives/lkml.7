Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5624C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 20:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E91D20644
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 20:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bGnQvSym"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391203AbfIPUD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 16:03:26 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42433 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391188AbfIPUD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 16:03:26 -0400
Received: by mail-pg1-f195.google.com with SMTP id z12so592392pgp.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 13:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=K9MMfXShmXoSvIjhKLQWDRDFiDu3n+MfJTN+sGiQ2k4=;
        b=bGnQvSymIpD+YH+h6yIfRstItOuZOXuFiK941OC9tY+hPxaJDajaYGxSTWmEyJ59JO
         edv2IMlDsI1aPpPImp4JWxmWc3BNIa/nepq4odIZlM/zb+8bhVhdyaLI37PjRJeuTnuO
         eJORufmtBiEY4HcYLTPLTJ+aCpVwXDPWAgudDlK/IMDXSRk+qefqWqD19nt7pOm7lmiX
         J0zvC5m6FNtvofEi14S8wb+u/oC6j0mGdyWyx4DHZc9qSlnNmEYk3S0yNrSp3RLlIBLn
         X8hNK1p4n+UzumvJ2B/H0n+Ar45St37qsXtGRO7jQU2hEIKRyA1GqUbJ79ncnBgyXful
         Ocuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=K9MMfXShmXoSvIjhKLQWDRDFiDu3n+MfJTN+sGiQ2k4=;
        b=j+jqRyTaV0YDa/HgGoZ0rxmBfxW3xhfNjaiZbGTVPIK7BX72H3ovRaI8EAy9Fqmro6
         4UAiGX4awsf9n976dZjQFEPP4aNPI699traCHpmo05qRojJAFe5CwqBj3X5TkcfGpIvH
         kwHf/2IbuCydA5DYqIguws3JWO7GW/v15CcSrs8uBx35GV9OWHeslOb1+dvGQHNNaAEa
         jDxg6Kon9nnfiLq5iFv/HokkqrmxEjmwp34W8/Imm3j7Lb/uESon4MlSEhzM0QefxdOI
         +7LVV2CGdc9Fo3dc1KIlaixu1OfAcyuXnQ1goYhHZszfLoaDFG60YtTx9qAJJFSH5UVW
         CrzQ==
X-Gm-Message-State: APjAAAXHp1bhB2HomNDRSAtJ+BmJeDVi0jWOubNaJMVuoPSdbVAsF7aC
        RBtHTonp6T2KDaNyfjm8qkPOIg==
X-Google-Smtp-Source: APXvYqxHN8FxSX9nmUGKIX5HATBjY+YlsUCztaSZH/l/KMfUl5nSoI0PbmFiQWTwJS9Xet+V2xg8FQ==
X-Received: by 2002:a63:161b:: with SMTP id w27mr853320pgl.38.1568664204886;
        Mon, 16 Sep 2019 13:03:24 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id u18sm11141860pge.69.2019.09.16.13.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 13:03:24 -0700 (PDT)
Date:   Mon, 16 Sep 2019 13:03:23 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     syzbot <syzbot+38e7237add3712479d65@syzkaller.appspotmail.com>
cc:     andreyknvl@google.com, benjamin.tissoires@redhat.com,
        jikos@kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: WARNING in implement
In-Reply-To: <0000000000002b27c60592b00f38@google.com>
Message-ID: <alpine.DEB.2.21.1909161302370.118156@chino.kir.corp.google.com>
References: <0000000000002b27c60592b00f38@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Sep 2019, syzbot wrote:

> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    f0df5c1b usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=170b213e600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5c6633fa4ed00be5
> dashboard link: https://syzkaller.appspot.com/bug?extid=38e7237add3712479d65
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16830dc1600000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11f2d3fa600000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+38e7237add3712479d65@syzkaller.appspotmail.com
> 
> keytouch 0003:0926:3333.0001: implement() called with too large value 32769
> (n: 1)! (kworker/0:1)
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 12 at drivers/hid/hid-core.c:1370
> implement.cold+0x40/0x81 drivers/hid/hid-core.c:1370
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.3.0-rc7+ #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google
> 01/01/2011
> Workqueue: events hidinput_led_worker
> Call Trace:
> __dump_stack lib/dump_stack.c:77 [inline]
> dump_stack+0xca/0x13e lib/dump_stack.c:113
> panic+0x2a3/0x6da kernel/panic.c:219
> __warn.cold+0x20/0x4a kernel/panic.c:576
> report_bug+0x262/0x2a0 lib/bug.c:186
> fixup_bug arch/x86/kernel/traps.c:179 [inline]
> fixup_bug arch/x86/kernel/traps.c:174 [inline]
> do_error_trap+0x12b/0x1e0 arch/x86/kernel/traps.c:272
> do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:291
> invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1028
> RIP: 0010:implement.cold+0x40/0x81 drivers/hid/hid-core.c:1370
> Code: 00 ef 01 00 48 c7 c2 a0 ac 52 86 48 c7 c6 c0 8a 52 86 4c 8d 88 70 06 00
> 00 e8 3f 3b 1a fe 48 c7 c7 20 8b 52 86 e8 fc 4e d7 fc <0f> 0b 44 21 e5 e9 06
> 3a ff ff e8 64 ad ec fc 49 8d bd 28 19 00 00
> RSP: 0018:ffff8881da20fb88 EFLAGS: 00010082
> RAX: 0000000000000024 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff81288ddd RDI: ffffed103b441f63
> RBP: 0000000000008001 R08: 0000000000000024 R09: ffffed103b643ee7
> R10: ffffed103b643ee6 R11: ffff8881db21f737 R12: 0000000000000001
> R13: ffff8881d28d8000 R14: 0000000000000001 R15: 0000000000000001
> hid_output_field drivers/hid/hid-core.c:1543 [inline]
> hid_output_report+0x2dc/0x4c0 drivers/hid/hid-core.c:1562
> __usbhid_submit_report drivers/hid/usbhid/hid-core.c:593 [inline]
> usbhid_submit_report+0x65c/0xde0 drivers/hid/usbhid/hid-core.c:638
> usbhid_request+0x3c/0x70 drivers/hid/usbhid/hid-core.c:1252
> hidinput_led_worker+0xbd/0x360 drivers/hid/hid-input.c:1495
> process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
> worker_thread+0x96/0xe20 kernel/workqueue.c:2415
> kthread+0x318/0x420 kernel/kthread.c:255
> ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

I assume this is the same issue as 
https://marc.info/?l=linux-kernel&m=156865976021549 and any fix for that 
issue would apply to this one as well.  Looks like syzbot found Benjamin 
and Jiri already.
