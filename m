Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83B2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 970152082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255145;
	bh=UeGPRwtONP938ZIi25rO87cE5xayWz/cBezbJ6WK3Dk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QcTZaf1Uyqni2rGupRQY/Q4k9k83/1tvlvqDIr27sPJc0Ju1n94w/7JXjfS8C0L8a
	 If9y8pWq4nRaU58PYzfddcIvJ3NNOQA+4e6apb3RD+BmVIUrzm1UH59tUCdtrKnk08
	 02x4mBnyNE8VvNMBW8+sBSP9A4y8pjYb3FzkY4/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731978AbfCVLpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:45:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:48786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731971AbfCVLpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:45:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D04A3218B0;
        Fri, 22 Mar 2019 11:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255139;
        bh=UeGPRwtONP938ZIi25rO87cE5xayWz/cBezbJ6WK3Dk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VrtBRaRpQ6O/m98dpak0dcMUdnPzSalv2iGBNh5zUkOQvxyB3t3/+QhfKjx6GlsHA
         /mVzd9ImX472nIWZNndFBQ53dhUEevTRP3jAvHLip4h429gnXhjpvgR6tXT0vdUOCa
         Aw+cgNoJWzjykyFCpIhac27fu8b0pxCCvHgBvyNw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        Zubin Mithra <zsm@chromium.org>
Subject: [PATCH 4.9 118/118] KVM: X86: Fix residual mmio emulation request to userspace
Date:   Fri, 22 Mar 2019 12:16:30 +0100
Message-Id: <20190322111224.617711607@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111215.873964544@linuxfoundation.org>
References: <20190322111215.873964544@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wanpeng Li <kernellwp@gmail.com>

commit bbeac2830f4de270bb48141681cb730aadf8dce1 upstream.

Reported by syzkaller:

The kvm-intel.unrestricted_guest=0

   WARNING: CPU: 5 PID: 1014 at /home/kernel/data/kvm/arch/x86/kvm//x86.c:7227 kvm_arch_vcpu_ioctl_run+0x38b/0x1be0 [kvm]
   CPU: 5 PID: 1014 Comm: warn_test Tainted: G        W  OE   4.13.0-rc3+ #8
   RIP: 0010:kvm_arch_vcpu_ioctl_run+0x38b/0x1be0 [kvm]
   Call Trace:
    ? put_pid+0x3a/0x50
    ? rcu_read_lock_sched_held+0x79/0x80
    ? kmem_cache_free+0x2f2/0x350
    kvm_vcpu_ioctl+0x340/0x700 [kvm]
    ? kvm_vcpu_ioctl+0x340/0x700 [kvm]
    ? __fget+0xfc/0x210
    do_vfs_ioctl+0xa4/0x6a0
    ? __fget+0x11d/0x210
    SyS_ioctl+0x79/0x90
    entry_SYSCALL_64_fastpath+0x23/0xc2
    ? __this_cpu_preempt_check+0x13/0x20

The syszkaller folks reported a residual mmio emulation request to userspace
due to vm86 fails to emulate inject real mode interrupt(fails to read CS) and
incurs a triple fault. The vCPU returns to userspace with vcpu->mmio_needed == true
and KVM_EXIT_SHUTDOWN exit reason. However, the syszkaller testcase constructs
several threads to launch the same vCPU, the thread which lauch this vCPU after
the thread whichs get the vcpu->mmio_needed == true and KVM_EXIT_SHUTDOWN will
trigger the warning.

   #define _GNU_SOURCE
   #include <pthread.h>
   #include <stdio.h>
   #include <stdlib.h>
   #include <string.h>
   #include <sys/wait.h>
   #include <sys/types.h>
   #include <sys/stat.h>
   #include <sys/mman.h>
   #include <fcntl.h>
   #include <unistd.h>
   #include <linux/kvm.h>
   #include <stdio.h>

   int kvmcpu;
   struct kvm_run *run;

   void* thr(void* arg)
   {
     int res;
     res = ioctl(kvmcpu, KVM_RUN, 0);
     printf("ret1=%d exit_reason=%d suberror=%d\n",
         res, run->exit_reason, run->internal.suberror);
     return 0;
   }

   void test()
   {
     int i, kvm, kvmvm;
     pthread_t th[4];

     kvm = open("/dev/kvm", O_RDWR);
     kvmvm = ioctl(kvm, KVM_CREATE_VM, 0);
     kvmcpu = ioctl(kvmvm, KVM_CREATE_VCPU, 0);
     run = (struct kvm_run*)mmap(0, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, kvmcpu, 0);
     srand(getpid());
     for (i = 0; i < 4; i++) {
       pthread_create(&th[i], 0, thr, 0);
       usleep(rand() % 10000);
     }
     for (i = 0; i < 4; i++)
       pthread_join(th[i], 0);
   }

   int main()
   {
     for (;;) {
       int pid = fork();
       if (pid < 0)
         exit(1);
       if (pid == 0) {
         test();
         exit(0);
       }
       int status;
       while (waitpid(pid, &status, __WALL) != pid) {}
     }
     return 0;
   }

This patch fixes it by resetting the vcpu->mmio_needed once we receive
the triple fault to avoid the residue.

Reported-by: Dmitry Vyukov <dvyukov@google.com>
Tested-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Wanpeng Li <wanpeng.li@hotmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Cc: Zubin Mithra <zsm@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx.c |    1 +
 arch/x86/kvm/x86.c |    1 +
 2 files changed, 2 insertions(+)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -5965,6 +5965,7 @@ static int handle_external_interrupt(str
 static int handle_triple_fault(struct kvm_vcpu *vcpu)
 {
 	vcpu->run->exit_reason = KVM_EXIT_SHUTDOWN;
+	vcpu->mmio_needed = 0;
 	return 0;
 }
 
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6769,6 +6769,7 @@ static int vcpu_enter_guest(struct kvm_v
 		}
 		if (kvm_check_request(KVM_REQ_TRIPLE_FAULT, vcpu)) {
 			vcpu->run->exit_reason = KVM_EXIT_SHUTDOWN;
+			vcpu->mmio_needed = 0;
 			r = 0;
 			goto out;
 		}


