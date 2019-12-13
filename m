Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7941C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 06:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A24862077B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 06:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="AlbyAYli"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732114AbfLMGNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 01:13:31 -0500
Received: from mail-qt1-f176.google.com ([209.85.160.176]:44714 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfLMGNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 01:13:31 -0500
Received: by mail-qt1-f176.google.com with SMTP id g17so1363413qtp.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 22:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=U4epWknYOkPQuP+2qdxVVLW7k5oIO9qVFJAm3JoMVjA=;
        b=AlbyAYliz1asJXCOtRdcor9SnwWikurekHoYmELGtyM1ahnwQrjvOfiPdbMww1DKNE
         9FgZiOUtQThP4XtdCjt+o92y9h72V+TV8OBPdyqELWXX0tH0COkW3dFPsIH2JS5/JaZF
         4dQWL0wVDMUNaAp/FWnC9oZsti4JvY1SkwvBse9NM63RbVFt6ufPVhT6NgR7yvlM9JBU
         eZs1HRorcGNHf4QKmlF42zWzhG0QMWeZ/Gzv8aROuL3w14qSoTMIUNjIiKZf5gbGCxvd
         cNFA1GHiMnaN1ALYXr2+8nhCh+Zk/V16nqKaluxSnmzq8xIyGNW+ABG7nY1LdH/nz03s
         ndFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=U4epWknYOkPQuP+2qdxVVLW7k5oIO9qVFJAm3JoMVjA=;
        b=jl61du2/tY4Lt2eB9o4syN0aLg7CtyQl+M6oxgwpmzjtk/QLF12LgD+XqQWeIAYv34
         ISvCy9RTJ0H0T89zKzV17ikIabjKHsEgMZaV9kvmnflvtYkQbUTF6UWtm5IffeaQht+H
         R76sTnVdH4zboPkUrhCLVEcp5VF045MkinLFjYHpywGcJRBvyaXhF9Yce3hIKbZK2sYS
         7lot2XlVPPWSgzWHdeLquXbh+YDsEKbqh7I9b9bSP4dVqqNdusY31Ao8qa7wrvNtRISF
         E9c6q6/K5gvue6ibprtYebBrXqZ2qB5C5Tc14blZPXvtFvETm/CSqblq+MVHCXw8ZPLQ
         TyRA==
X-Gm-Message-State: APjAAAX3jNliEGbrut3dTRl8RwnC5BuDvgr5U+wqWWNPIJKjMxt1k7Cp
        mQPPR4hmJ1COuo+ougjKLdigxGVPpTI=
X-Google-Smtp-Source: APXvYqxejny3nPyjxVmCK8WVlMUjqv8c0YXU2iyxYc/c6hbCZyLZsUMp4X7ilyCUfHq+24QonoUr7A==
X-Received: by 2002:ac8:745a:: with SMTP id h26mr10783615qtr.318.1576217609714;
        Thu, 12 Dec 2019 22:13:29 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id l20sm795556qtj.60.2019.12.12.22.13.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 22:13:29 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: "rcu: React to callback overload by aggressively seeking quiescent
 states" hangs on boot
Message-Id: <3DAA2B11-682B-43B4-94F3-A4706D3179F6@lca.pw>
Date:   Fri, 13 Dec 2019 01:13:27 -0500
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Tejun Heo <tj@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The linux-next commit 82150cb53dcb ("rcu: React to callback overload by =
aggressively seeking quiescent states=E2=80=9D)
causes hangs on boot on almost all arches. Reverted it fixed the issue.

=3D=3D=3D x86_64 (Intel) =3D=3D=3D

https://raw.githubusercontent.com/cailca/linux-mm/master/x86.config

[   29.130611][    T0] mce: CPU0: Thermal monitoring enabled (TM1)
[   29.136598][    T0] process: using mwait in idle threads
[   29.140582][    T0] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[   29.146704][    T0] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, =
1GB 4
[   29.150570][    T0] Spectre V1 : Mitigation: usercopy/swapgs barriers =
and __user pointer sanitization
[   29.160584][    T0] Spectre V2 : Mitigation: Full generic retpoline
[   29.166881][    T0] Spectre V2 : Spectre v2 / SpectreRSB mitigation: =
Filling RSB on context switch
[   29.170567][    T0] Spectre V2 : Enabling Restricted Speculation for =
firmware calls
[   29.180569][    T0] Spectre V2 : mitigation: Enabling conditional =
Indirect Branch Prediction Barrier
[   29.190567][    T0] Spectre V2 : User space: Mitigation: STIBP via =
seccomp and prctl
[   29.200569][    T0] Speculative Store Bypass: Mitigation: Speculative =
Store Bypass disabled via prctl and seccomp
[   29.210570][    T0] TAA: Vulnerable: Clear CPU buffers attempted, no =
microcode
[   28.995181][    T0] MDS: Vulnerable: Clear CPU buffers attempted, no =
microcode
[   29.005929][    T0] debug: unmapping init [mem =
0xffffffffb50ec000-0xffffffffb50f0fff]
[   29.035681][    T1] smpboot: CPU0: Intel(R) Xeon(R)=20
<hang =E2=80=A6.>

=3D=3D=3D arm64 =3D=3D=3D

https://raw.githubusercontent.com/cailca/linux-mm/master/arm64.config

[    0.000000][    T0] ITS [mem 0x440100000-0x44011ffff]
[    0.000000][    T0] ITS@0x0000000440100000: allocated 65536 Devices =
@8bfd080000 (flat, esz 8, psz 64K, shr 0)
[    0.000000][    T0] ITS@0x0000000440100000: allocated 32768 Interrupt =
Collections @8bfd020000 (flat, esz 2, psz 16K, shr 0)
[    0.000000][    T0] ITS: using cache flushing for cmd queue
[    0.000000][    T0] GICv3: using LPI property table =
@0x0000000880db0000
[    0.000000][    T0] GIC: using cache flushing for LPI property table
[    0.000000][    T0] GICv3: CPU0: using allocated LPI pending table =
@0x0000000880dd0000
[    0.000000][    T0] arch_timer: cp15 timer(s) running at 200.00MHz =
(phys).
[    0.000000][    T0] clocksource: arch_sys_counter: mask: =
0xffffffffffffff max_cycles: 0x2e2049d3e8, max_idle_ns: 440795210634 ns
[    0.000005][    T0] sched_clock: 56 bits at 200MHz, resolution 5ns, =
wraps every 4398046511102ns
[    0.061872][    T0] Lock dependency validator: Copyright (c) 2006 Red =
Hat, Inc., Ingo Molnar
[    0.070420][    T0] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.075298][    T0] ... MAX_LOCK_DEPTH:          48
[    0.080240][    T0] ... MAX_LOCKDEP_KEYS:        8192
[    0.085379][    T0] ... CLASSHASH_SIZE:          4096
[    0.090496][    T0] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.095722][    T0] ... MAX_LOCKDEP_CHAINS:      65536
[    0.100926][    T0] ... CHAINHASH_SIZE:          32768
[    0.106153][    T0]  memory used by lock dependency info: 6237 kB
[    0.112324][    T0]  memory used for stack traces: 4224 kB
[    0.117902][    T0]  per task-struct memory footprint: 1920 bytes
[    0.158652][    T0] ACPI: Core revision 20191018
[    0.194716][    T0] Calibrating delay loop (skipped), value =
calculated using timer frequency.. 400.00 BogoMIPS (lpj=3D2000000)
[    0.206116][    T0] pid_max: default: 262144 minimum: 2048
[    0.355206][    T0] Dentry cache hash table entries: 8388608 (order: =
10, 67108864 bytes, vmalloc)
[    0.396920][    T0] Inode-cache hash table entries: 4194304 (order: =
9, 33554432 bytes, vmalloc)
[    0.422261][    T0] Mount-cache hash table entries: 131072 (order: 4, =
1048576 bytes, vmalloc)
[    0.431925][    T0] Mountpoint-cache hash table entries: 131072 =
(order: 4, 1048576 bytes, vmalloc)
[    0.736297][    T1] ASID allocator initialised with 32768 entries
[    0.743932][    T1] rcu: Hierarchical SRCU implementation.
[    0.759898][    T1] Platform MSI: ITS@0x400100000 domain created
[    0.766249][    T1] Platform MSI: ITS@0x440100000 domain created
[    0.772602][    T1] PCI/MSI: ITS@0x400100000 domain created
[    0.778561][    T1] PCI/MSI: ITS@0x440100000 domain created
[    0.784292][    T1] Remapping and enabling EFI services.
<hang =E2=80=A6>

=3D=3D=3D powerpc =3D=3D=3D

https://raw.githubusercontent.com/cailca/linux-mm/master/powerpc.config

[    0.000000][    T0] SLUB: HWalign=3D128, Order=3D0-0, MinObjects=3D0, =
CPUs=3D128, Nodes=3D256
[    0.000000][    T0] ODEBUG: selftest passed
[    0.000000][    T0] ftrace: allocating 19886 entries in 8 pages
[    0.000000][    T0] ftrace: allocated 8 pages with 1 groups
[    0.000000][    T0] Running RCU self tests
[    0.000000][    T0] rcu: Hierarchical RCU implementation.
[    0.000000][    T0] rcu: 	RCU lockdep checking is enabled.
[    0.000000][    T0] rcu: 	RCU restricting CPUs from NR_CPUS=3D256 =
to nr_cpu_ids=3D128.
[    0.000000][    T0] rcu: 	RCU callback double-/use-after-free =
debug enabled.
[    0.000000][    T0] rcu: RCU calculated value of scheduler-enlistment =
delay is 10 jiffies.
[    0.000000][    T0] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, =
nr_cpu_ids=3D128
[    0.000000][    T0] NR_IRQS: 512, nr_irqs: 512, preallocated irqs: 16
[    0.000000][    T0] xive: Interrupt handling initialized with native =
backend
[    0.000000][    T0] xive: Using priority 7 for all interrupts
[    0.000000][    T0] xive: Using 64kB queues
[    0.000007][    T0] time_init: 56 bit decrementer (max: =
7fffffffffffff)
[    0.003188][    T0] clocksource: timebase: mask: 0xffffffffffffffff =
max_cycles: 0x761537d007, max_idle_ns: 440795202126 ns
[    0.011496][    T0] clocksource: timebase mult[1f40000] shift[24] =
registered
[    0.029470][    T0] printk: console [hvc0] enabled
[    0.029470][    T0] printk: console [hvc0] enabled
[    0.035652][    T0] printk: bootconsole [udbg0] disabled
[    0.035652][    T0] printk: bootconsole [udbg0] disabled
[    0.040864][    T0] Lock dependency validator: Copyright (c) 2006 Red =
Hat, Inc., Ingo Molnar
[    0.040892][    T0] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.040918][    T0] ... MAX_LOCK_DEPTH:          48
[    0.040944][    T0] ... MAX_LOCKDEP_KEYS:        8192
[    0.040969][    T0] ... CLASSHASH_SIZE:    =20
<hang ...>=
