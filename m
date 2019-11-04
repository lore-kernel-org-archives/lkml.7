Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA80CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 06:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6135620848
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 06:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bi7os8Mn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbfKDG2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 01:28:10 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40432 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727911AbfKDG2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 01:28:09 -0500
Received: by mail-pg1-f196.google.com with SMTP id 15so10602674pgt.7;
        Sun, 03 Nov 2019 22:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZYR0xt4j6M9ghT6gn2+jBhsiyfXvuB7wHMizn4V6mhs=;
        b=bi7os8MneiCUSdHm3w8wp6PYtlt3SIcJpGjVPC3e9PC3Q7uf1JJ/E2TQSeIP+gqb3N
         D3FMWZI+HlqfshmITItNDVbMPqlniVZRuFlIt/FhUHWSDA7zXLRJ5btK6I7DiKQqerjW
         kPgBxmJSEx8H8XwSlpqIzbZ0Kkij1iTwhHr9xrzJVbImrHUpc10HxAQfctJ5ZIwv8Tp0
         RrdynQhshXrRMJbsFEoJxc9Qih15/k9oYheyVLasu0NeSUNATDb8AYGRrgSfKNlg7E6o
         GQDJESuDTlAgRmrlTCYupV6HbZ/BuhHTKPmKgbrT+Zyg5txGL2Ha/y/MpQVkBwWobKuz
         xfxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZYR0xt4j6M9ghT6gn2+jBhsiyfXvuB7wHMizn4V6mhs=;
        b=e7Xj4HOCJtISrSryKgwFTvlYew/iwyn/HgOXWBMRZSQns0VVPc1hQ4fGBcYGpE1cL+
         +CETdfVF435rfwckyM8QjxZaZufait46EpN5CzQOXWdPGvtzWSBHnwcpSgYU71dR8xlt
         lPHtA3b3J2wrepZbAbhN20jCtbT50c9fvaubrFYIyGknePUlrwVwrfXm+28Djbs4sxvV
         5YvAOJmfq2NPWNx9VWNBfAFHrZK+a+1mBa/YvBYTFW5y+MHdqvVvHt7pyD0AzCSLS8er
         nJM5qKkrm8rzw4xkY8dabyAm77hsnkmuyclvPs/dd052pNoU4+mlcWKT7MNQSyqnNlG3
         Zd4Q==
X-Gm-Message-State: APjAAAXV73YGyhHkyfGXQXPIrmLyrXf/59DDyzCOtIy3H7RGp7zoM6sk
        vr9RZDXP5OYg8jNxUB2oNRaD/kCP
X-Google-Smtp-Source: APXvYqxkJtkIRCkBSJNATceZJHKNaDtsagBi74sUOjSxtwBqNhWjB7hIbN0o0A/qXdoLJzjQSsqBFg==
X-Received: by 2002:a17:90a:bb0a:: with SMTP id u10mr33656628pjr.14.1572848887315;
        Sun, 03 Nov 2019 22:28:07 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id z7sm7810505pgk.10.2019.11.03.22.28.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 03 Nov 2019 22:28:06 -0800 (PST)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/2] KVM: Fix NULL-ptr defer after kvm_create_vm fails
Date:   Mon,  4 Nov 2019 14:27:58 +0800
Message-Id: <1572848879-21011-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

Reported by syzkaller:

    kasan: CONFIG_KASAN_INLINE enabled
    kasan: GPF could be caused by NULL-ptr deref or user memory access
    general protection fault: 0000 [#1] PREEMPT SMP KASAN
    CPU: 0 PID: 14727 Comm: syz-executor.3 Not tainted 5.4.0-rc4+ #0
    RIP: 0010:kvm_coalesced_mmio_init+0x5d/0x110 arch/x86/kvm/../../../virt/kvm/coalesced_mmio.c:121
    Call Trace:
     kvm_dev_ioctl_create_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:3446 [inline]
     kvm_dev_ioctl+0x781/0x1490 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3494
     vfs_ioctl fs/ioctl.c:46 [inline]
     file_ioctl fs/ioctl.c:509 [inline]
     do_vfs_ioctl+0x196/0x1150 fs/ioctl.c:696
     ksys_ioctl+0x62/0x90 fs/ioctl.c:713
     __do_sys_ioctl fs/ioctl.c:720 [inline]
     __se_sys_ioctl fs/ioctl.c:718 [inline]
     __x64_sys_ioctl+0x6e/0xb0 fs/ioctl.c:718
     do_syscall_64+0xca/0x5d0 arch/x86/entry/common.c:290
     entry_SYSCALL_64_after_hwframe+0x49/0xbe

Commit 9121923c457d ("kvm: Allocate memslots and buses before calling kvm_arch_init_vm") 
moves memslots and buses allocations around, however, if kvm->srcu/irq_srcu fails 
initialization, NULL will be returned instead of error code, NULL will not be intercepted 
in kvm_dev_ioctl_create_vm() and be deferenced by kvm_coalesced_mmio_init(), this patch 
fixes it.

syz repro: https://syzkaller.appspot.com/x/repro.syz?x=13509b84e00000

Reported-by: syzbot+89a8060879fa0bd2db4f@syzkaller.appspotmail.com
Fixes: 9121923c457d ("kvm: Allocate memslots and buses before calling kvm_arch_init_vm") 
Cc: Jim Mattson <jmattson@google.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 virt/kvm/kvm_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index d6f0696..8c272eb 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -675,6 +675,7 @@ static struct kvm *kvm_create_vm(unsigned long type)
 	INIT_HLIST_HEAD(&kvm->irq_ack_notifier_list);
 #endif
 
+	r = -ENOMEM;
 	if (init_srcu_struct(&kvm->srcu))
 		goto out_err_no_srcu;
 	if (init_srcu_struct(&kvm->irq_srcu))
-- 
2.7.4

