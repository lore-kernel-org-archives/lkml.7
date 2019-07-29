Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE65C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 04:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B8D20651
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 04:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="pWsH2tS/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbfG2EAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 00:00:22 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34361 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfG2EAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 00:00:21 -0400
Received: by mail-pf1-f193.google.com with SMTP id b13so27279770pfo.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 21:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aACUck99azplxhbSUUhX33h0BCu7lutqqr7qD5rITk4=;
        b=pWsH2tS/OsIWU1DVrfbd7f/IHXKj5GcE9xvlclJhjQH5d8goLyMRYOeRvrJBvJCfsC
         WAmsfMvcmifkHFS4Flnk4VTYjDxfeMn334Ar1EgjlVOJIdMaN4FWJv4yP2RRTE1vVks9
         fXA1BiLz+6U3fDXeY+CeVNBVWIjMSXGPMflDkBRnmainLlWI8n+5WNPxf71MNPMk4HBb
         M2CdwWJkDP1mMJ4aSu0wmkApKTEwBgG5gM3wxYB36+pWeOuGJ4AWsW+nQLe4Aa6wRhfB
         nRhoJ5cSt5HTusfA+uCW50rydT3oCw0MSbNjX/rrKLCf5tltx4tRQj+t4LRWxlrl0+3A
         BoUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aACUck99azplxhbSUUhX33h0BCu7lutqqr7qD5rITk4=;
        b=n0Q5snWaSdSkPHoJZrX0XSP8lAhuVNmli4U5pXyEe4dZQAi584W/mOZ+Zx1tvdfzVV
         wj3dbA5N+g/k3vicZNl2jfTtBb8UgM/afto5HL4xD4tmTwzcA24vzDrRKPWg2dhiTVm/
         Ry8uOf824uLCwJgzGD0nfKWjWBbijIWmMVmaPXQ9V0hPdWYwqNCdzD/JNczlTAVvO/MG
         euG04rHfa8QHJtJLwrbn6m3hsSZodH2GjKkMV186AvE7VfjnYSrlkZrUP37AI5gQe2Wa
         dwsm51dL3bKQWMrM7CT64RdizMZzVC6nIGVbeZ+rjpTA5YtsW6KdTeXFAG0VgVxoZ7lj
         cEKg==
X-Gm-Message-State: APjAAAUK9Vv+DpQc9iDz08TOSJkXldT0KF1jv8ZqnNAfKX93va1waJOM
        mvfSMYEzCRqwTHjnSw9TjYE=
X-Google-Smtp-Source: APXvYqxymeF2IKXn1Ebm28/9SeMj5KHrKBfN10C58jAVDzWGxHUvSj/e+6pmZ7WQrS70Kk0mW0/bWg==
X-Received: by 2002:a63:3148:: with SMTP id x69mr16261522pgx.300.1564372820654;
        Sun, 28 Jul 2019 21:00:20 -0700 (PDT)
Received: from santosiv.in.ibm.com ([183.82.17.52])
        by smtp.gmail.com with ESMTPSA id g1sm100033948pgg.27.2019.07.28.21.00.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 28 Jul 2019 21:00:19 -0700 (PDT)
From:   Santosh Sivaraj <santosh@fossix.org>
To:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel@vger.kernel.org
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Reza Arbab <arbab@linux.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        christophe leroy <christophe.leroy@c-s.fr>
Subject: [v6 0/6] powerpc: implement machine check safe memcpy
Date:   Mon, 29 Jul 2019 09:30:05 +0530
Message-Id: <20190729040011.5086-1-santosh@fossix.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During a memcpy from a pmem device, if a machine check exception is
generated we end up in a panic. In case of fsdax read, this should
only result in a -EIO. Avoid MCE by implementing memcpy_mcsafe.

Before this patch series:

```
bash-4.4# mount -o dax /dev/pmem0 /mnt/pmem/
[ 7621.714094] Disabling lock debugging due to kernel taint
[ 7621.714099] MCE: CPU0: machine check (Severe) Host UE Load/Store [Not recovered]
[ 7621.714104] MCE: CPU0: NIP: [c000000000088978] memcpy_power7+0x418/0x7e0
[ 7621.714107] MCE: CPU0: Hardware error
[ 7621.714112] opal: Hardware platform error: Unrecoverable Machine Check exception
[ 7621.714118] CPU: 0 PID: 1368 Comm: mount Tainted: G   M              5.2.0-rc5-00239-g241e39004581
#50
[ 7621.714123] NIP:  c000000000088978 LR: c0000000008e16f8 CTR: 00000000000001de
[ 7621.714129] REGS: c0000000fffbfd70 TRAP: 0200   Tainted: G   M              
(5.2.0-rc5-00239-g241e39004581)
[ 7621.714131] MSR:  9000000002209033 <SF,HV,VEC,EE,ME,IR,DR,RI,LE>  CR: 24428840  XER: 00040000
[ 7621.714160] CFAR: c0000000000889a8 DAR: deadbeefdeadbeef DSISR: 00008000 IRQMASK: 0
[ 7621.714171] GPR00: 000000000e000000 c0000000f0b8b1e0 c0000000012cf100 c0000000ed8e1100 
[ 7621.714186] GPR04: c000020000001100 0000000000010000 0000000000000200 03fffffff1272000 
[ 7621.714201] GPR08: 0000000080000000 0000000000000010 0000000000000020 0000000000000030 
[ 7621.714216] GPR12: 0000000000000040 00007fffb8c6d390 0000000000000050 0000000000000060 
[ 7621.714232] GPR16: 0000000000000070 0000000000000000 0000000000000001 c0000000f0b8b960 
[ 7621.714247] GPR20: 0000000000000001 c0000000f0b8b940 0000000000000001 0000000000010000 
[ 7621.714262] GPR24: c000000001382560 c00c0000003b6380 c00c0000003b6380 0000000000010000 
[ 7621.714277] GPR28: 0000000000000000 0000000000010000 c000020000000000 0000000000010000 
[ 7621.714294] NIP [c000000000088978] memcpy_power7+0x418/0x7e0
[ 7621.714298] LR [c0000000008e16f8] pmem_do_bvec+0xf8/0x430
... <snip> ...
```

After this patch series:

```
bash-4.4# mount -o dax /dev/pmem0 /mnt/pmem/
[25302.883978] Buffer I/O error on dev pmem0, logical block 0, async page read
[25303.020816] EXT4-fs (pmem0): DAX enabled. Warning: EXPERIMENTAL, use at your own risk
[25303.021236] EXT4-fs (pmem0): Can't read superblock on 2nd try
[25303.152515] EXT4-fs (pmem0): DAX enabled. Warning: EXPERIMENTAL, use at your own risk
[25303.284031] EXT4-fs (pmem0): DAX enabled. Warning: EXPERIMENTAL, use at your own risk
[25304.084100] UDF-fs: bad mount option "dax" or missing value
mount: /mnt/pmem: wrong fs type, bad option, bad superblock on /dev/pmem0, missing codepage or helper
program, or other error.
```

MCE is injected on a pmem address using mambo. The last patch which adds a nop
is only for testing on mambo, where r13 is not restored upon hitting vector 200.

The memcpy code can be optimised by adding VMX optimizations and GAS macros can
be used to enable code reusablity, which I will send as another series.

---
Change-log:
v6:
* Don't return pfn, all callees are expecting physical address anyway [nick]
* Patch re-ordering: move exception table patch before memcpy_mcsafe patch [nick]
* Reword commit log for search_exception_tables patch [nick]

v5:
* Don't use search_exception_tables since it searches for module exception tables
  also [Nicholas]
* Fix commit message for patch 2 [Nicholas]

v4:
* Squash return remaining bytes patch to memcpy_mcsafe implemtation patch [christophe]
* Access ok should be checked for copy_to_user_mcsafe() [christophe]

v3:
* Drop patch which enables DR/IR for external modules
* Drop notifier call chain, we don't want to do that in real mode
* Return remaining bytes from memcpy_mcsafe correctly
* We no longer restore r13 for simulator tests, rather use a nop at 
  vector 0x200 [workaround for simulator; not to be merged]

v2:
* Don't set RI bit explicitly [mahesh]
* Re-ordered series to get r13 workaround as the last patch
--

Balbir Singh (2):
  powerpc/mce: Fix MCE handling for huge pages
  powerpc/memcpy: Add memcpy_mcsafe for pmem

Reza Arbab (1):
  powerpc/mce: Make machine_check_ue_event() static

Santosh Sivaraj (3):
  extable: Add function to search only kernel exception table
  powerpc/mce: Handle UE event for memcpy_mcsafe
  powerpc: add machine check safe copy_to_user

 arch/powerpc/Kconfig                 |   1 +
 arch/powerpc/include/asm/mce.h       |   6 +-
 arch/powerpc/include/asm/string.h    |   2 +
 arch/powerpc/include/asm/uaccess.h   |  14 ++
 arch/powerpc/kernel/mce.c            |  16 +-
 arch/powerpc/kernel/mce_power.c      |  65 +++++---
 arch/powerpc/lib/Makefile            |   2 +-
 arch/powerpc/lib/memcpy_mcsafe_64.S  | 239 +++++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/ras.c |   9 +-
 include/linux/extable.h              |   2 +
 kernel/extable.c                     |  11 +-
 11 files changed, 326 insertions(+), 41 deletions(-)
 create mode 100644 arch/powerpc/lib/memcpy_mcsafe_64.S

-- 
2.20.1

