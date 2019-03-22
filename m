Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34ACC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 05:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B56022075D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 05:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfCVFXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 01:23:20 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:45658 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726047AbfCVFXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 01:23:16 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1h7Ce9-000164-Sk; Fri, 22 Mar 2019 05:23:13 +0000
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1h7Ce9-0001p6-Nd; Fri, 22 Mar 2019 05:23:13 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Christoffer Dall" <christoffer.dall@linaro.org>,
        "Christian Borntraeger" <borntraeger@de.ibm.com>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        "Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?=" <rkrcmar@redhat.com>
Date:   Fri, 22 Mar 2019 05:20:18 +0000
Message-ID: <lsq.1553232018.764753734@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 12/16] KVM: Protect device ops->create and list_add
 with kvm->lock
In-Reply-To: <lsq.1553232017.771830163@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.64-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Christoffer Dall <christoffer.dall@linaro.org>

commit a28ebea2adc4a2bef5989a5a181ec238f59fbcad upstream.

KVM devices were manipulating list data structures without any form of
synchronization, and some implementations of the create operations also
suffered from a lack of synchronization.

Now when we've split the xics create operation into create and init, we
can hold the kvm->lock mutex while calling the create operation and when
manipulating the devices list.

The error path in the generic code gets slightly ugly because we have to
take the mutex again and delete the device from the list, but holding
the mutex during anon_inode_getfd or releasing/locking the mutex in the
common non-error path seemed wrong.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
[bwh: Backported to 3.16:
 - Drop change to a failure path that doesn't exist in kvm_vgic_create() 
 - Adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -799,10 +799,13 @@ long kvm_arch_vm_ioctl(struct file *filp
 
 	switch (ioctl) {
 	case KVM_CREATE_IRQCHIP: {
-		if (vgic_present)
-			return kvm_vgic_create(kvm);
-		else
+		int ret;
+		if (!vgic_present)
 			return -ENXIO;
+		mutex_lock(&kvm->lock);
+		ret = kvm_vgic_create(kvm);
+		mutex_unlock(&kvm->lock);
+		return ret;
 	}
 	case KVM_ARM_SET_DEVICE_ADDR: {
 		struct kvm_arm_device_addr dev_addr;
--- a/arch/powerpc/kvm/book3s_xics.c
+++ b/arch/powerpc/kvm/book3s_xics.c
@@ -1239,12 +1239,10 @@ static int kvmppc_xics_create(struct kvm
 	xics->kvm = kvm;
 
 	/* Already there ? */
-	mutex_lock(&kvm->lock);
 	if (kvm->arch.xics)
 		ret = -EEXIST;
 	else
 		kvm->arch.xics = xics;
-	mutex_unlock(&kvm->lock);
 
 	if (ret) {
 		kfree(xics);
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1059,6 +1059,12 @@ struct kvm_device {
 /* create, destroy, and name are mandatory */
 struct kvm_device_ops {
 	const char *name;
+
+	/*
+	 * create is called holding kvm->lock and any operations not suitable
+	 * to do while holding the lock should be deferred to init (see
+	 * below).
+	 */
 	int (*create)(struct kvm_device *dev, u32 type);
 
 	/*
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1624,12 +1624,8 @@ int kvm_vgic_create(struct kvm *kvm)
 	int i, vcpu_lock_idx = -1, ret;
 	struct kvm_vcpu *vcpu;
 
-	mutex_lock(&kvm->lock);
-
-	if (kvm->arch.vgic.vctrl_base) {
-		ret = -EEXIST;
-		goto out;
-	}
+	if (kvm->arch.vgic.vctrl_base)
+		return -EEXIST;
 
 	/*
 	 * Any time a vcpu is run, vcpu_load is called which tries to grab the
@@ -1659,9 +1655,6 @@ out_unlock:
 		vcpu = kvm_get_vcpu(kvm, vcpu_lock_idx);
 		mutex_unlock(&vcpu->mutex);
 	}
-
-out:
-	mutex_unlock(&kvm->lock);
 	return ret;
 }
 
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -587,6 +587,11 @@ static void kvm_destroy_devices(struct k
 {
 	struct list_head *node, *tmp;
 
+	/*
+	 * We do not need to take the kvm->lock here, because nobody else
+	 * has a reference to the struct kvm at this point and therefore
+	 * cannot access the devices list anyhow.
+	 */
 	list_for_each_safe(node, tmp, &kvm->devices) {
 		struct kvm_device *dev =
 			list_entry(node, struct kvm_device, vm_node);
@@ -2322,11 +2327,15 @@ static int kvm_ioctl_create_device(struc
 	dev->ops = ops;
 	dev->kvm = kvm;
 
+	mutex_lock(&kvm->lock);
 	ret = ops->create(dev, cd->type);
 	if (ret < 0) {
+		mutex_unlock(&kvm->lock);
 		kfree(dev);
 		return ret;
 	}
+	list_add(&dev->vm_node, &kvm->devices);
+	mutex_unlock(&kvm->lock);
 
 	if (ops->init)
 		ops->init(dev);
@@ -2334,10 +2343,12 @@ static int kvm_ioctl_create_device(struc
 	ret = anon_inode_getfd(ops->name, &kvm_device_fops, dev, O_RDWR | O_CLOEXEC);
 	if (ret < 0) {
 		ops->destroy(dev);
+		mutex_lock(&kvm->lock);
+		list_del(&dev->vm_node);
+		mutex_unlock(&kvm->lock);
 		return ret;
 	}
 
-	list_add(&dev->vm_node, &kvm->devices);
 	kvm_get_kvm(kvm);
 	cd->fd = ret;
 	return 0;

