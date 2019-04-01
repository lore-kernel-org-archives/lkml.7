Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089F8C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCAA220857
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140356;
	bh=U6skYGsxCTT7kmGz1s1mWH+HQlTWmUgBI+5VYh1Rxlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zEx8HDmjXAyYCl9IsgHMzzULkwLR5r81YOMPogynBCoTqjqik893v4WaDeirzhiPR
	 LgLcuDf0dzpWyP7kelRRKgEGtGWFEuvpRq748dW+Z/p3fdkl+ko8j2O4Q53ib+rJsz
	 Wil9EXuv32DovdxA+tJNobI3mYNMAxQ8jEDgXTT8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388415AbfDARjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:39:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388408AbfDARjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:39:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FF5320830;
        Mon,  1 Apr 2019 17:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140351;
        bh=U6skYGsxCTT7kmGz1s1mWH+HQlTWmUgBI+5VYh1Rxlg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pvinp6r+iJrLbwq7SCS7pFqj9tZ6fR2GutqdszqvNSJ3fvz9SYR9/kt5Pzrt40Ez4
         p88XWo7qnj6/Jz5Y/dTb2grzE4y3ymmUdmeJlzU/gs1BOYcAQ+QyWLiK7V1RZV95XQ
         URB6NKaJWlGU2ZAsisSx1Se0eBgwSERZ2pHyZagI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 3.18 47/50] KVM: Reject device ioctls from processes other than the VMs creator
Date:   Mon,  1 Apr 2019 19:03:30 +0200
Message-Id: <20190401170046.436694749@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170041.257273804@linuxfoundation.org>
References: <20190401170041.257273804@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <sean.j.christopherson@intel.com>

commit ddba91801aeb5c160b660caed1800eb3aef403f8 upstream.

KVM's API requires thats ioctls must be issued from the same process
that created the VM.  In other words, userspace can play games with a
VM's file descriptors, e.g. fork(), SCM_RIGHTS, etc..., but only the
creator can do anything useful.  Explicitly reject device ioctls that
are issued by a process other than the VM's creator, and update KVM's
API documentation to extend its requirements to device ioctls.

Fixes: 852b6d57dc7f ("kvm: add device control API")
Cc: <stable@vger.kernel.org>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/virtual/kvm/api.txt |   16 +++++++++++-----
 virt/kvm/kvm_main.c               |    3 +++
 2 files changed, 14 insertions(+), 5 deletions(-)

--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -13,7 +13,7 @@ of a virtual machine.  The ioctls belong
 
  - VM ioctls: These query and set attributes that affect an entire virtual
    machine, for example memory layout.  In addition a VM ioctl is used to
-   create virtual cpus (vcpus).
+   create virtual cpus (vcpus) and devices.
 
    Only run VM ioctls from the same process (address space) that was used
    to create the VM.
@@ -24,6 +24,11 @@ of a virtual machine.  The ioctls belong
    Only run vcpu ioctls from the same thread that was used to create the
    vcpu.
 
+ - device ioctls: These query and set attributes that control the operation
+   of a single device.
+
+   device ioctls must be issued from the same process (address space) that
+   was used to create the VM.
 
 2. File descriptors
 -------------------
@@ -32,10 +37,11 @@ The kvm API is centered around file desc
 open("/dev/kvm") obtains a handle to the kvm subsystem; this handle
 can be used to issue system ioctls.  A KVM_CREATE_VM ioctl on this
 handle will create a VM file descriptor which can be used to issue VM
-ioctls.  A KVM_CREATE_VCPU ioctl on a VM fd will create a virtual cpu
-and return a file descriptor pointing to it.  Finally, ioctls on a vcpu
-fd can be used to control the vcpu, including the important task of
-actually running guest code.
+ioctls.  A KVM_CREATE_VCPU or KVM_CREATE_DEVICE ioctl on a VM fd will
+create a virtual cpu or device and return a file descriptor pointing to
+the new resource.  Finally, ioctls on a vcpu or device fd can be used
+to control the vcpu or device.  For vcpus, this includes the important
+task of actually running guest code.
 
 In general file descriptors can be migrated among processes by means
 of fork() and the SCM_RIGHTS facility of unix domain socket.  These
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2298,6 +2298,9 @@ static long kvm_device_ioctl(struct file
 {
 	struct kvm_device *dev = filp->private_data;
 
+	if (dev->kvm->mm != current->mm)
+		return -EIO;
+
 	switch (ioctl) {
 	case KVM_SET_DEVICE_ATTR:
 		return kvm_device_ioctl_attr(dev, dev->ops->set_attr, arg);


