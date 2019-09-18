Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416B5C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD96218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568788410;
	bh=Eq8nOojIoQBEV2ltmRd9T9w8XNsdLrk8lVfJrb1qrtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KJqSpeCjBD3fPsXBKtlbRX2e2LE/NgclEUF5OumoHKzMGFKqt2bmBwO7sOeW5aUBd
	 IrmbJCylOtHf7YfhM99z/Bu026mwfFgInqN3M4Sa4u4fpZFNjRV8OahF7t5nocdB67
	 4byflWPOnsJtDRkqOc8fb69IOEjt9QML2pI0cTp0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbfIRGUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 02:20:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:39590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728598AbfIRGUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 02:20:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3EEF218AE;
        Wed, 18 Sep 2019 06:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568787638;
        bh=Eq8nOojIoQBEV2ltmRd9T9w8XNsdLrk8lVfJrb1qrtM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KD6ZaZQbWVWXO19Uhx9siPzUDaNTPW7w8wfqMYwzLmS9fYE/Rv7AtdIxuZxgMAo/v
         QRWXctXm30o5BPjxppz4iMEp8xgsiaNbA1kETL2qNb/FFfGj+57Bs4xCKkcQd0dTys
         Pr26xy+W+Owdxy8oD5xWs6SK3QjZlM0Q668RehCY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fuqian Huang <huangfq.daxian@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.14 23/45] KVM: x86: work around leak of uninitialized stack contents
Date:   Wed, 18 Sep 2019 08:19:01 +0200
Message-Id: <20190918061225.380926803@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190918061222.854132812@linuxfoundation.org>
References: <20190918061222.854132812@linuxfoundation.org>
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
@@ -4721,6 +4721,13 @@ int kvm_write_guest_virt_system(struct k
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


