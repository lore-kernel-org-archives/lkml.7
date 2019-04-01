Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6736EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D5E420883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138855;
	bh=5gRmf+G+hm/T0+o6hzR/d0ZVGt6lESvhrEr+RfBd0CE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V5OwGzyZEUY7qlTADXWTMtqJsfiwAdyAnl9tQhmYAv3qTS+itQ3I7nMN7a2AeEiwV
	 KYvf/N+OlXWqw0QH5JYt/AMYHb3vLE62/Hqoz/7WMGhE1YfZt1L5X5tzfyIj0DQQ5D
	 TxmMhTVpevt3sh7x3ctNRoyu22F3q7TTOX21ZYXI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730724AbfDARON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:14:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:37188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730684AbfDAROH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:14:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4C48205F4;
        Mon,  1 Apr 2019 17:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138847;
        bh=5gRmf+G+hm/T0+o6hzR/d0ZVGt6lESvhrEr+RfBd0CE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oXapc+AwcYtJg1ZJaV1d4GNd1AiE4EGa2k4UFLXXM3DZNf4bsxjVtrcjHmTukwDaX
         G0KDFAQFIo9f7ej75oMWC3GY63VlpEiR9MODF2FhwQJYG+ZrA+bCcJb4gEipD2dbdP
         w31nVb5FFwxeOrQffJRZVnv2FXvJm1DskHQG8mMs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Diana Craciun <diana.craciun@nxp.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.19 039/134] powerpc/fsl: Flush branch predictor when entering KVM
Date:   Mon,  1 Apr 2019 19:01:15 +0200
Message-Id: <20190401170048.353184178@linuxfoundation.org>
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

From: Diana Craciun <diana.craciun@nxp.com>

commit e7aa61f47b23afbec41031bc47ca8d6cb6516abc upstream.

Switching from the guest to host is another place
where the speculative accesses can be exploited.
Flush the branch predictor when entering KVM.

Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kvm/bookehv_interrupts.S |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/powerpc/kvm/bookehv_interrupts.S
+++ b/arch/powerpc/kvm/bookehv_interrupts.S
@@ -75,6 +75,10 @@
 	PPC_LL	r1, VCPU_HOST_STACK(r4)
 	PPC_LL	r2, HOST_R2(r1)
 
+START_BTB_FLUSH_SECTION
+	BTB_FLUSH(r10)
+END_BTB_FLUSH_SECTION
+
 	mfspr	r10, SPRN_PID
 	lwz	r8, VCPU_HOST_PID(r4)
 	PPC_LL	r11, VCPU_SHARED(r4)


