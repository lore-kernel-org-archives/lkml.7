Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD65AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C51321852
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139134;
	bh=oTYZEUg5VCWcImuyC8I4+j8M41Nv26SkHBrtcwYCL3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0ZSidHIw5xvdNY7XufcQwS1o9i1Lr1s2P9Q9pTn91DiRJGHR9B+bWDAh3KI3snUK/
	 23ghKZRg2oincoUrVqoxSQDB6PNq0w84JpHbIHdA96oJurcg5ilZjjuVbA4pCwxTkb
	 ufJghbCXayaoIbaEx4F7Ko7EBHE0DBpcM+U0r4sY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731442AbfDARSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:18:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731197AbfDARSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:18:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F83421473;
        Mon,  1 Apr 2019 17:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139131;
        bh=oTYZEUg5VCWcImuyC8I4+j8M41Nv26SkHBrtcwYCL3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=msRPex17BvOtnpj73M9ulx2NqZsoFPzxu9DHM34iJG6fodP+jtn6m0jVvn95CGqXB
         kUu29XiKx7GBccYeiOUqgIwo1kYpjjtFrsImTjnDwqipQpPvW54xzliO9YyEYC8j4M
         MTPovnCWqME3ErlyLzaenVBk+0mpl3RYRk5Op3rI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.19 123/134] KVM: Reject device ioctls from processes other than the VMs creator
Date:   Mon,  1 Apr 2019 19:02:39 +0200
Message-Id: <20190401170055.787624185@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2815,6 +2815,9 @@ static long kvm_device_ioctl(struct file
 {
 	struct kvm_device *dev = filp->private_data;
 
+	if (dev->kvm->mm != current->mm)
+		return -EIO;
+
 	switch (ioctl) {
 	case KVM_SET_DEVICE_ATTR:
 		return kvm_device_ioctl_attr(dev, dev->ops->set_attr, arg);


