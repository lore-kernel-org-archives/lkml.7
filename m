Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2207C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 21:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C742075B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 21:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="kMR1F6bg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbfHLVvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 17:51:45 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34722 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727696AbfHLVvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 17:51:39 -0400
Received: by mail-qt1-f193.google.com with SMTP id q4so7265637qtp.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 14:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=iILK3toCoRAShc6Bh7nRP60zRRz+Erv6WfY1v74geMg=;
        b=kMR1F6bg3fRTthKLTTPpF3GEFocmjz/QZyvklyt5eQUdKPsv18uVBoop04qVRE7FiK
         0miUL7e+xwxrsPpWrj0wTIYqgpoyd8+icRTiqVbQqyJ4+EqfH45gS7e4IiiAVud/sSGf
         srFVMNt8tDfIsCaCISevJeAceHKqE0rjnQRckcu+UshdOQ4SmjPVSd2KqmFVmddLBpnB
         lo6+Pv+Ua2yVqBTRI5RJ+DPaez5lNyxSibpwCi8W1RForYBGPlguzUCeZe+EVMlXLD0S
         MdTgZ8snDgnn5ChRCNLrIoXBMv0Kr1ApzZ+k+32q2Jvt6V0bdYJsBHVntYWIxv6ZHCCL
         1JAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=iILK3toCoRAShc6Bh7nRP60zRRz+Erv6WfY1v74geMg=;
        b=lTzni75QMG2Q5U+x4G4En9/0ilBQcTBaGzUdFmzAb3mUlo2uOk5bKyl0OMWfGmq/Gg
         ZijXWzxexHQ+pzsteNIk/f0OqzdfTN4nQFsjaJJxXH9uTnMsPjDB2FLOIeJGUgAeSEvl
         ghVi1ai9Ln9i4B459nFVOkoNBQTpxUShErDV7cQhNlkIN4jT13oTVK6sDMhXb+NArHfC
         cnWKoWbB7mediJ73lPKygoq6Ap4DgVZsVK3F+E4Ee+ldaxubGzdHeFJW8KTBp/+vQPde
         QowFrVF0DjprjEzJx3XcH0I87skKghtokdLdySKGSkaY1nvjhmTZi3r/T/3XKHR4TX6L
         zarA==
X-Gm-Message-State: APjAAAVlSqxj23DmXr4LeC2E+zGC7hgKkqOah7oBwxI8nbg8NuQuzGfh
        NrMY9wlsE5LVnrV7H2a3QjZ2Mns+eE4=
X-Google-Smtp-Source: APXvYqy9+Fo1lRLai0S6Yj3orolpYdBovfmsN5AqRWMe8YHwjKGfGG76bynQnDMr+WRbjdaWesGAYQ==
X-Received: by 2002:ac8:4602:: with SMTP id p2mr7291668qtn.291.1565646697784;
        Mon, 12 Aug 2019 14:51:37 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id q42sm10781021qtc.52.2019.08.12.14.51.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 14:51:37 -0700 (PDT)
Message-ID: <1565646695.8572.6.camel@lca.pw>
Subject: "arm64/for-next/core" causes boot panic
From:   Qian Cai <cai@lca.pw>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 12 Aug 2019 17:51:35 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Booting today's linux-next on an arm64 server triggers a panic with
CONFIG_KASAN_SW_TAGS=y pointing to this line,

kfree()->virt_to_head_page()->compound_head()

unsigned long head = READ_ONCE(page->compound_head);

The bisect so far indicates one of those could be bad,

9c1cac424c93 arm64: mm: Really fix sparse warning in untagged_addr()
d2c68de192cf docs: arm64: Add layout and 52-bit info to memory document
2c624fe68715 arm64: mm: Remove vabits_user
b6d00d47e81a arm64: mm: Introduce 52-bit Kernel VAs
ce3aaed87344 arm64: mm: Modify calculation of VMEMMAP_SIZE
c8b6d2ccf9b1 arm64: mm: Separate out vmemmap
c812026c54cf arm64: mm: Logic to make offset_ttbr1 conditional
5383cc6efed1 arm64: mm: Introduce vabits_actual
90ec95cda91a arm64: mm: Introduce VA_BITS_MIN
99426e5e8c9f arm64: dump: De-constify VA_START and KASAN_SHADOW_START
6bd1d0be0e97 arm64: kasan: Switch to using KASAN_SHADOW_OFFSET
14c127c957c1 arm64: mm: Flip kernel VA space
08f103b9a950 arm64/ptrace: Fix typoes in sve_set() comment
2951d5efaf8b arm64: mm: print hexadecimal EC value in mem_abort_decode()
b99286b088ea arm64/prefetch: fix a -Wtype-limits warning
71c67a31f09f init/Kconfig: Fix infinite Kconfig recursion on PPC
42d038c4fb00 arm64: Add support for function error injection
45880f7b7b19 error-injection: Consolidate override function definition
9ce1263033cd selftests, arm64: add a selftest for passing tagged pointers to
kernel
63f0c6037965 arm64: Introduce prctl() options to control the tagged user
addresses ABI
2b835e24b5c6 arm64: untag user pointers in access_ok and __uaccess_mask_ptr
5cf896fb6be3 arm64: Add support for relocating the kernel with RELR relocations
66cbdf5d0c96 arm64: Move TIF_* documentation to individual definitions
13776f9d40a0 arm64: mm: free the initrd reserved memblock in a aligned manner
22ec71615d82 arm64: io: Relax implicit barriers in default I/O accessors
2f8f180b3cee arm64: Remove unused cpucap_multi_entry_cap_cpu_enable()
73961dc1182e arm64: sysreg: Remove unused and rotting SCTLR_ELx field
definitions
332e5281a4e8 arm64: esr: Add ESR exception class encoding for trapped ERET
b3e089cd446b arm64: Replace strncmp with str_has_prefix
3e77eeb7a27f ACPI/IORT: Rename arm_smmu_v3_set_proximity() 'node' local variable
b717480f5415 arm64: remove unneeded uapi/asm/stat.h
c19d050f8088 arm64/kexec: Use consistent convention of initializing
'kxec_buf.mem' with KEXEC_BUF_MEM_UNKNOWN
b907b80d7ae7 arm64: remove pointless __KERNEL__ guards
c87857945b0e arm64: Remove unused assembly macro


[    0.000000][    T0] Unable to handle kernel paging request at virtual address
0030ffe001e01588
[    0.000000][    T0] Mem abort info:
[    0.000000][    T0]   ESR = 0x96000004
[    0.000000][    T0]   EC = 0x25: DABT (current EL), IL = 32 bits
[    0.000000][    T0]   SET = 0, FnV = 0
[    0.000000][    T0]   EA = 0, S1PTW = 0
[    0.000000][    T0] Data abort info:
[    0.000000][    T0]   ISV = 0, ISS = 0x00000004
[    0.000000][    T0]   CM = 0, WnR = 0
[    0.000000][    T0] [0030ffe001e01588] address between user and kernel
address ranges
[    0.000000][    T0] Internal error: Oops: 96000004 [#1] SMP
[    0.000000][    T0] Modules linked in:
[    0.000000][    T0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.3.0-rc4-next-
20190812+ #1
[    0.000000][    T0] pstate: 40000089 (nZcv daIf -PAN -UAO)
[    0.000000][    T0] pc : kfree+0x160/0xc98
[    0.000000][    T0] lr : kfree+0x154/0xc98
[    0.000000][    T0] sp : ffff900012e07cc0
[    0.000000][    T0] x29: ffff900012e07d50 x28: 0000000000000100 
[    0.000000][    T0] x27: 8cff000800563c88 x26: 3dff000800566220 
[    0.000000][    T0] x25: 7bff0008005c0800 x24: c3ff00080056a580 
[    0.000000][    T0] x23: 33ff000800563500 x22: 8cff000800563c80 
[    0.000000][    T0] x21: ffff9000109b57a4 x20: 33ff000800563500 
[    0.000000][    T0] x19: ffffffdfffc00000 x18: 0000000000000040 
[    0.000000][    T0] x17: 0000000000400000 x16: ffff900010c00000 
[    0.000000][    T0] x15: 0000000000000000 x14: ffff90001121a590 
[    0.000000][    T0] x13: ffff90001013c6fc x12: ffff900010141c78 
[    0.000000][    T0] x11: 0000000000000001 x10: ffff8fff8fc00000 
[    0.000000][    T0] x9 : 0001000080000000 x8 : 0030ffe001e01580 
[    0.000000][    T0] x7 : ffffffffffffffff x6 : 33ff000800563520 
[    0.000000][    T0] x5 : 0000000000000000 x4 : 0000000000000000 
[    0.000000][    T0] x3 : 0000000000000100 x2 : ffff900012e324f8 
[    0.000000][    T0] x1 : 33ff000800563500 x0 : c40000088056a580 
[    0.000000][    T0] Call trace:
[    0.000000][    T0]  kfree+0x160/0xc98
[    0.000000][    T0]  free_cpumask_var+0xc/0x14
[    0.000000][    T0]  apply_wqattrs_prepare+0x2e4/0x3b0
[    0.000000][    T0]  apply_workqueue_attrs_locked+0x7c/0xdc
[    0.000000][    T0]  alloc_workqueue+0x340/0x69c
[    0.000000][    T0]  workqueue_init_early+0x4b4/0x654
[    0.000000][    T0]  start_kernel+0x210/0x558
[    0.000000][    T0] Code: 97f323d3 d34afc08 927abd08 8b080268 (f9400509) 
[    0.000000][    T0] ---[ end trace 8710f821a534a562 ]---
[    0.000000][    T0] Kernel panic - not syncing: Fatal exception
[    0.000000][    T0] ---[ end Kernel panic - not syncing: Fatal exception ]---
