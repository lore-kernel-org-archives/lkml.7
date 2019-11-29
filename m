Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B493C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 22:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 486D92086A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 22:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtdYzZSg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfK2Wwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 17:52:34 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39185 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbfK2Wwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 17:52:34 -0500
Received: by mail-oi1-f193.google.com with SMTP id a67so8514351oib.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 14:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=KmlKmmT0etYCADZ8Ax0Q+YIHnJREMaeSktPwKEyQ4xc=;
        b=WtdYzZSgyrqAOpVsdcCIvWuYbBSyTTULLDQVnIkGGUHFQe0oUsBWKbPPX12pH8HFrP
         9qkgo1C/ZjmkHfu8S+QGtpuv4NstP8x817Jbtk2NerhHWADQoadM+WGfTieOWLeUsUdk
         7dMW3jFlprkPNDcV+pUE39AZz1DyIYpdD3b2a5nCGm1YSJls02o4fy+hycoFnVuH//gR
         8Se4kq++Ww+JE/Z00lAjlZKlMIYQp+wLv2vYJToKlVZN32XPSsAR0Dz1MhmVx/cdqs3y
         SyaUJBY+xZd0Wg4xucVSjgyM2X/SxDqBrflfFcyjkoinXelghnfz9Q9usiltz+oIBIZQ
         s4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=KmlKmmT0etYCADZ8Ax0Q+YIHnJREMaeSktPwKEyQ4xc=;
        b=ACScyy7CN5tPgwU53eqxyg0bd6If85dxlET9O+5hzYV02thh1ON77Z7Wwt2k04SrSV
         vE8oBpjJyNtHDIXaHFBkearqsUQuAl2B81c8f6cIFlmCtqH6RGEHuDE8HdvhdH6UHXgY
         WH4Lk/o7rGv7AmKiFhJngmnKjTEEuIEoe0Pl8muG2eFxquWXNuwDk96L9VrsHhZsJVmd
         iPEsQ0pfwXlo34QrrwfNRq5b1veQ3NjPSEDtMYhUC/R/3G55fi+xjRwiLSSRy/TtCUh/
         RJX97BtD0FBqvRgjOJKq7ZoghHSpWRFqJ+zy78OR2nXr6k2SjUycU2jeHdQnoS3OGvpX
         BIxg==
X-Gm-Message-State: APjAAAWPTgTlIBVRefo6VZrbzoQdUYBhnujoLbvVWwn3PKqFvt0cBV1s
        0JwbehOkb6dJd3e0cuAz9NnaEgOAh+5KYIicoFI7U72M
X-Google-Smtp-Source: APXvYqzJy3DqTapxe8UYY5jPQ08GcLUBwAM1mPKA/eMIQi7diLc4se/ViHwxhxuf11jt6e16ow7AFdYZ6ygLCh3jauM=
X-Received: by 2002:a05:6808:3ab:: with SMTP id n11mr2589367oie.5.1575067952824;
 Fri, 29 Nov 2019 14:52:32 -0800 (PST)
MIME-Version: 1.0
From:   Radu Rendec <radu.rendec@gmail.com>
Date:   Fri, 29 Nov 2019 17:52:22 -0500
Message-ID: <CAD5jUk_E516CvKGUWcfZ7chRjv=8fgSBHppNX7YTpSLf0wk_4Q@mail.gmail.com>
Subject: RCU stall on 4.9.191/CONFIG_PREEMPT, single CPU
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Everyone,

I'm experiencing what appears to be a complete system freeze on a single
CPU embedded system (PowerPC, MPC8378) running Linux 4.9.191 with
CONFIG_PREEMPT enabled.

Enabling all lockup detection in the kernel config revealed RCU stalls,
detected by rcu_preempt (sample included below). These occur every 30
seconds, give or take.

At that point the network stack is hosed (no replies to ARP requests).
Softirqs seem to be hosed as well - I added a test module that logs a
message every 0.5 seconds from a timer callback and, once the "freeze"
occurs, these messages are never printed.

I simply do not understand the RCU and scheduler implementation well
enough to figure this out on my own, so any idea or suggestion would be
helpful.

Looking at Documentation/RCU/stallwarn.txt, I found this among the
potential causes for an RCU stall:

    A CPU-bound real-time task in a CONFIG_PREEMPT kernel, which might
    happen to preempt a low-priority task in the middle of an RCU
    read-side critical section.   This is especially damaging if
    that low-priority task is not permitted to run on any other CPU,
    in which case the next RCU grace period can never complete

In my case all tasks are CPU-bound, simply because there is only one
CPU. And yes, I do have realtime tasks (many of them), so any of them
can potentially preempt a low-priority task in the middle of an RCU read
critical section. Does that mean it's a bad idea to run a fully
preemptible kernel on a single CPU? If that were the case, I would
expect to see this kind of problems much sooner/more often, but they are
only triggered by a very specific activity of the application that runs
on top.

Thanks,
Radu Rendec

[  902.232175] INFO: rcu_preempt detected stalls on CPUs/tasks:
[  902.237847]  (detected by 0, t=21002 jiffies, g=8316, c=8315, q=210)
[  902.244203] All QSes seen, last rcu_preempt kthread activity 21002
(602030-581028), jiffies_till_next_fqs=3, root ->qsmask 0x0
[  902.255586] backupRestore   R  running task        0  1525   1254 0x00000000
[  902.262633] Call Trace:
[  902.265093] [9ac0fc60] [8005b2f4] rcu_check_callbacks+0x848/0x860
(unreliable)
[  902.272319] [9ac0fcd0] [8005e878] update_process_times+0x30/0x60
[  902.278328] [9ac0fce0] [8007046c] tick_sched_timer+0x58/0xb4
[  902.283985] [9ac0fd10] [8005f844]
__hrtimer_run_queues.constprop.34+0x100/0x18c
[  902.291291] [9ac0fd50] [8005fae0] hrtimer_interrupt+0xc0/0x290
[  902.297122] [9ac0fda0] [8000a3c8] __timer_interrupt+0x15c/0x20c
[  902.303038] [9ac0fdb0] [8000a610] timer_interrupt+0x9c/0xc8
[  902.308614] [9ac0fdd0] [8000f678] ret_from_except+0x0/0x14
[  902.314106] --- interrupt: 901 at timespec64_add_safe+0x108/0x12c
[  902.314106]     LR = poll_select_set_timeout+0x94/0x110
[  902.325404] [9ac0fe90] [111294e8] 0x111294e8 (unreliable)
[  902.330804] [9ac0feb0] [800e8a1c] poll_select_set_timeout+0x50/0x110
[  902.337155] [9ac0ff10] [800e9d70] SyS_poll+0x68/0x114
[  902.342205] [9ac0ff40] [8000ef6c] ret_from_syscall+0x0/0x38
[  902.347773] --- interrupt: c01 at 0xe5855f8
[  902.347773]     LR = 0xe5855e0
[  902.354994] rcu_preempt kthread starved for 21002 jiffies! g8316
c8315 f0x2 RCU_GP_WAIT_FQS(3) ->state=0x0
[  902.364638] rcu_preempt     R  running task        0     7      2 0x00000800
[  902.371686] Call Trace:
[  902.374126] [9f043d00] [9ac08080] 0x9ac08080 (unreliable)
[  902.379526] [9f043dc0] [80415ca4] __schedule+0x278/0x490
[  902.384835] [9f043e10] [8041608c] schedule+0x3c/0xac
[  902.389799] [9f043e20] [80418e9c] schedule_timeout+0x128/0x240
[  902.395630] [9f043e60] [8005a0d4] rcu_gp_kthread+0x3dc/0xa6c
[  902.401289] [9f043ef0] [80038b7c] kthread+0xbc/0xd0
[  902.406164] [9f043f40] [8000f094] ret_from_kernel_thread+0x5c/0x64
