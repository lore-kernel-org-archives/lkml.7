Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44136C10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B492183E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553260463;
	bh=SV6XOiXnZD3mO8ReoUkOsLkfx5rEmMY0xQCqBDed/CE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2P+dM9KCBXVFZJIYYatMGIM8sjxBLHEmV7BTEhAv7kcWSscorAEFVoh2ticqq6lkp
	 tT8/Ea3QcHwbM4wgmejMbSIW9QkLRTg8kAfVE4W+CCmhD/z4/UxZ3Y9lV0f8UaW+Cx
	 Kd14CAfHA/mBHOeDeU1wJ41I5rJjUd/JinyIdNI8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbfCVL3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:29:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:57204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729198AbfCVL3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:29:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF72C21939;
        Fri, 22 Mar 2019 11:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254159;
        bh=SV6XOiXnZD3mO8ReoUkOsLkfx5rEmMY0xQCqBDed/CE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=noPPEUHneG6cbEp56kPnat43fHKWb//CSpT5P8NE0GCEULMf9gdjElHfRpZ1/yaMH
         OE3s+bBL7GSAGN6HIjcgFPxQZLoOENJRPs8/UpFfVEH7YpX3LOYhpyn7PxT5J0Lz6J
         3YxXJiStKlYGs5yYtW5CN9SD3YyKKqYhVNtioXK4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 4.4 050/230] KVM: arm/arm64: Fix MMIO emulation data handling
Date:   Fri, 22 Mar 2019 12:13:08 +0100
Message-Id: <20190322111240.212072102@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoffer Dall <christoffer.dall@linaro.org>

commit 83091db981e105d97562d3ed3ffe676e21927e3a upstream.

When the kernel was handling a guest MMIO read access internally, we
need to copy the emulation result into the run->mmio structure in order
for the kvm_handle_mmio_return() function to pick it up and inject the
	result back into the guest.

Currently the only user of kvm_io_bus for ARM is the VGIC, which did
this copying itself, so this was not causing issues so far.

But with the upcoming new vgic implementation we need this done
properly.

Update the kvm_handle_mmio_return description and cleanup the code to
only perform a single copying when needed.

Code and commit message inspired by Andre Przywara.

Reported-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/kvm/mmio.c |   11 ++++++-----
 virt/kvm/arm/vgic.c |    7 -------
 2 files changed, 6 insertions(+), 12 deletions(-)

--- a/arch/arm/kvm/mmio.c
+++ b/arch/arm/kvm/mmio.c
@@ -87,11 +87,10 @@ static unsigned long mmio_read_buf(char
 
 /**
  * kvm_handle_mmio_return -- Handle MMIO loads after user space emulation
+ *			     or in-kernel IO emulation
+ *
  * @vcpu: The VCPU pointer
  * @run:  The VCPU run struct containing the mmio data
- *
- * This should only be called after returning from userspace for MMIO load
- * emulation.
  */
 int kvm_handle_mmio_return(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
@@ -207,15 +206,17 @@ int io_mem_abort(struct kvm_vcpu *vcpu,
 	run->mmio.is_write	= is_write;
 	run->mmio.phys_addr	= fault_ipa;
 	run->mmio.len		= len;
-	if (is_write)
-		memcpy(run->mmio.data, data_buf, len);
 
 	if (!ret) {
 		/* We handled the access successfully in the kernel. */
+		if (!is_write)
+			memcpy(run->mmio.data, data_buf, len);
 		kvm_handle_mmio_return(vcpu, run);
 		return 1;
 	}
 
+	if (is_write)
+		memcpy(run->mmio.data, data_buf, len);
 	run->exit_reason	= KVM_EXIT_MMIO;
 	return 0;
 }
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -821,7 +821,6 @@ static int vgic_handle_mmio_access(struc
 	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
 	struct vgic_io_device *iodev = container_of(this,
 						    struct vgic_io_device, dev);
-	struct kvm_run *run = vcpu->run;
 	const struct vgic_io_range *range;
 	struct kvm_exit_mmio mmio;
 	bool updated_state;
@@ -850,12 +849,6 @@ static int vgic_handle_mmio_access(struc
 		updated_state = false;
 	}
 	spin_unlock(&dist->lock);
-	run->mmio.is_write	= is_write;
-	run->mmio.len		= len;
-	run->mmio.phys_addr	= addr;
-	memcpy(run->mmio.data, val, len);
-
-	kvm_handle_mmio_return(vcpu, run);
 
 	if (updated_state)
 		vgic_kick_vcpus(vcpu->kvm);


