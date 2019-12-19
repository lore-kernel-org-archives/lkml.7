Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774CCC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 03:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49398218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 03:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="JSxWh4JN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfLSD61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 22:58:27 -0500
Received: from mail-qt1-f179.google.com ([209.85.160.179]:42109 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfLSD60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 22:58:26 -0500
Received: by mail-qt1-f179.google.com with SMTP id j5so3883625qtq.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 19:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=k4eq1tsjI4N+dCmP20F1GO1zoclUAiI9XzZa4bk41AM=;
        b=JSxWh4JNgDw5y5egNZ3/7bjSQC/JVAYkHHqX3nzDCX2424bAsFc3WRCe5E+oTj6DvQ
         j/K5JgLO3OYuPHWapJ2eb4D0a64qDY7uUSUseKMI096/91NwIqr2UCzJdIB10wCa820m
         NhRKA8m0DtklGVgLL1HEpMARh1k6cuv1dOrWMhDnXjacDCV4ipCI510PuivLPdRArxS8
         ezzWeSc/QTslhtIj0+ABHU7DSYU4wvVkYSSy6NhNRy3P9kdl9pwBEdUkuvLiydnsqP1B
         8bp1HulUQxpQh3ragXhXZBblRO/jz27Y90vxPcb8eLVuNqiQEho0fXo/dVjAyFcxRacE
         oaCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=k4eq1tsjI4N+dCmP20F1GO1zoclUAiI9XzZa4bk41AM=;
        b=EI2Wbu4PyDirznUPeK3OXQ0MukFabhEutmRdsnI+hyua7Ze81cfbqupUgdR1MSzzjR
         Io27gpKI/7oa9mPi+yvHM+qrcZDV90W6cZ3g0IBbyLfDmm9vliKM8U2H6Ki1MOi2X8iz
         5r8DYVOyR6kLaXnyL7doIcj3g6B71j3lWmr+fHPMpuQDuCCkJnMqW4PnoG4JKbMrGxV5
         n/cw4h0qXnO77hbRw4HxEkIcUvfHDzMiN3pcRYLmjzE+jK6s/aNW7JWnSynGFuTVKorN
         LataW26TI7ZymDhU/HtSLEWOBVZuwqiIHkZIhYL0SAbGHD+xEudLkX8csqFHHK/RJHzi
         M0GQ==
X-Gm-Message-State: APjAAAUD+vKXKzMvh6URFZhYzJIYNUbJs3Lm7CVDykjEWDBNqBop73dU
        pildBRVCWj/mZ8/USOP4vWMIPg==
X-Google-Smtp-Source: APXvYqwzAXwA84CQs9N+g8dkcmOZfbmLTVIwbfth/35AMLn7h9U9KE/Wnrx9F2pYBFTImam8NRcW8w==
X-Received: by 2002:aed:3e12:: with SMTP id l18mr5140425qtf.91.1576727905487;
        Wed, 18 Dec 2019 19:58:25 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id j194sm1367615qke.83.2019.12.18.19.58.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Dec 2019 19:58:24 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: "ftrace: Rework event_create_dir()" triggers boot error messages
Message-Id: <0FA8C6E3-D9F5-416D-A1B0-5E4CD583A101@lca.pw>
Date:   Wed, 18 Dec 2019 22:58:23 -0500
Cc:     clang-built-linux@googlegroups.com,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The linux-next commit "ftrace: Rework event_create_dir()=E2=80=9D [1] =
triggers boot warnings
for Clang-build (Clang version 8.0.1) kernels (reproduced on both arm64 =
and powerpc).
Reverted it (with trivial conflict fixes) on the top of today=E2=80=99s =
linux-next fixed the issue.

configs:
https://raw.githubusercontent.com/cailca/linux-mm/master/arm64.config
https://raw.githubusercontent.com/cailca/linux-mm/master/powerpc.config

[1] https://lore.kernel.org/lkml/20191111132458.342979914@infradead.org/

[  115.799327][    T1] Registered efivars operations
[  115.849770][    T1] clocksource: Switched to clocksource =
arch_sys_counter
[  115.901145][    T1] Could not initialize trace point =
events/sys_enter_rt_sigreturn
[  115.908854][    T1] Could not create directory for event =
sys_enter_rt_sigreturn
[  115.998949][    T1] Could not initialize trace point =
events/sys_enter_restart_syscall
[  116.006802][    T1] Could not create directory for event =
sys_enter_restart_syscall
[  116.062702][    T1] Could not initialize trace point =
events/sys_enter_getpid
[  116.069828][    T1] Could not create directory for event =
sys_enter_getpid
[  116.078058][    T1] Could not initialize trace point =
events/sys_enter_gettid
[  116.085181][    T1] Could not create directory for event =
sys_enter_gettid
[  116.093405][    T1] Could not initialize trace point =
events/sys_enter_getppid
[  116.100612][    T1] Could not create directory for event =
sys_enter_getppid
[  116.108989][    T1] Could not initialize trace point =
events/sys_enter_getuid
[  116.116058][    T1] Could not create directory for event =
sys_enter_getuid
[  116.124250][    T1] Could not initialize trace point =
events/sys_enter_geteuid
[  116.131457][    T1] Could not create directory for event =
sys_enter_geteuid
[  116.139840][    T1] Could not initialize trace point =
events/sys_enter_getgid
[  116.146908][    T1] Could not create directory for event =
sys_enter_getgid
[  116.155163][    T1] Could not initialize trace point =
events/sys_enter_getegid
[  116.162370][    T1] Could not create directory for event =
sys_enter_getegid
[  116.178015][    T1] Could not initialize trace point =
events/sys_enter_setsid
[  116.185138][    T1] Could not create directory for event =
sys_enter_setsid
[  116.269307][    T1] Could not initialize trace point =
events/sys_enter_sched_yield
[  116.276811][    T1] Could not create directory for event =
sys_enter_sched_yield
[  116.527652][    T1] Could not initialize trace point =
events/sys_enter_munlockall
[  116.535126][    T1] Could not create directory for event =
sys_enter_munlockall
[  116.622096][    T1] Could not initialize trace point =
events/sys_enter_vhangup
[  116.629307][    T1] Could not create directory for event =
sys_enter_vhangup
[  116.783867][    T1] Could not initialize trace point =
events/sys_enter_sync
[  116.790819][    T1] Could not create directory for event =
sys_enter_sync
[  117.723402][    T1] pnp: PnP ACPI init
[  117.736379][    T1] system 00:00: [mem 0x30000000-0x3fffffff window] =
could not be reserved
[  126.020353][    T1] pnp: PnP ACPI: found 1 devices
[  126.093919][    T1] NET: Registered protocol family 2
[  126.180007][    T1] tcp_listen_portaddr_hash hash table entries: =
65536 (order: 6, 4718592 bytes, vmalloc)
[  126.206510][    T1] TCP established hash table entries: 524288 =
(order: 6, 4194304 bytes, vmalloc)
[  126.227766][    T1] TCP bind hash table entries: 65536 (order: 6, =
4194304 bytes, vmalloc)
[  126.240146][    T1] TCP: Hash tables configured (established 524288 =
bind 65536)=
