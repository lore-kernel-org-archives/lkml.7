Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B19C4CED0
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C64B218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568787765;
	bh=wAx23GSFUcnVrM32JI4TGHRW8JL6phpNBAgxKz3VXyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K3iNXKjmYEylLs7/NCsK+0j2fHgmEtncJVHMpg/fZ+JgPBe6xA/jK5oMqt8FDXfvv
	 g0ebrC94Rjbvy5jBnglyt67HPRQC1J2T+C/Krb5EftsLBvhwnNbOLV8F/+PKIiOTD0
	 bPRZNj2XaiTJp3iCrdUIN7SlAqIo5wi7s+GvdaWM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbfIRGWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 02:22:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:42738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729459AbfIRGWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 02:22:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B94FD21920;
        Wed, 18 Sep 2019 06:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568787760;
        bh=wAx23GSFUcnVrM32JI4TGHRW8JL6phpNBAgxKz3VXyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JKD9q5TtQDfkPWi0fF9vGCVfsCruOY6x/y+YLUBC4pGqOkgtL8AEspTbkKWtTb6rt
         GNsS7ncJkQBzWfLH1RCOFXDp5vzmPbDXHMapJ/zzi9J+mzS/Q9ToT90P7ibSGGdVqo
         YDEjVY09RMVNMsIqxPLJdXned46+HFi3PNqv0dAo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fuqian Huang <huangfq.daxian@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.19 23/50] KVM: x86: work around leak of uninitialized stack contents
Date:   Wed, 18 Sep 2019 08:19:06 +0200
Message-Id: <20190918061225.490523369@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190918061223.116178343@linuxfoundation.org>
References: <20190918061223.116178343@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fuqian Huang <huangfq.daxian@gmail.com>

commit 541ab2aeb28251bf7135c7961f3a6080eebcc705 upstream.

Emulation of VMPTRST can incorrectly inject a page fault
when passed an operand that points to an MMIO address.
The page fault will use uninitialized kernel stack memory
as the CR2 and error code.

The right behavior would be to abort the VM with a KVM_EXIT_INTERNAL_ERROR
exit to userspace; however, it is not an easy fix, so for now just ensure
that the error code and CR2 are zero.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
Cc: stable@vger.kernel.org
[add comment]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/x86.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5016,6 +5016,13 @@ int kvm_write_guest_virt_system(struct k
 	/* kvm_write_guest_virt_system can pull in tons of pages. */
 	vcpu->arch.l1tf_flush_l1d = true;
 
+	/*
+	 * FIXME: this should call handle_emulation_failure if X86EMUL_IO_NEEDED
+	 * is returned, but our callers are not ready for that and they blindly
+	 * call kvm_inject_page_fault.  Ensure that they at least do not leak
+	 * uninitialized kernel stack memory into cr2 and error code.
+	 */
+	memset(exception, 0, sizeof(*exception));
 	return kvm_write_guest_virt_helper(addr, val, bytes, vcpu,
 					   PFERR_WRITE_MASK, exception);
 }


