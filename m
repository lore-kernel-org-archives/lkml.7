Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCCFC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB38720883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139353;
	bh=1OrC+cdwL6XDRqsKmPeFaypxjHGQyxzT2DB9+elw4Y0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fnb+nwxVLBuZsH+/wN8TIWha/YJcbGZ9vTEQjRBsuzG9zY4o1zP+Db9i+RrX9zUef
	 vH7LdYURPOgKkCzt6nAGHPsWz/IGus4Q/rmFQm2BK/tcXH4gKTDVwymPtFV7+LDo2/
	 cCYpBWRWdR2vbWPe6czdbtoVqXbMJnPoctlAT7dY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731650AbfDARWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:22:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731495AbfDARW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:22:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DBC021473;
        Mon,  1 Apr 2019 17:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139347;
        bh=1OrC+cdwL6XDRqsKmPeFaypxjHGQyxzT2DB9+elw4Y0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j7IRIMhZ4v2gI5FPy9x6JHkVFIyMnO8V+ZNeTuUyBL73DbDbzaVNe2gWtI+OjWV8+
         UsMUGpJMslqr6Z4oIHJFpmsNF+MJbYGxv7SgU3uQLfxtDrBw6M/ZDud8F/tNSKW1Bw
         lFNqLe9NaHM6ohKogEYFCR2dtHsIxP7HHxCANu/E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Diana Craciun <diana.craciun@nxp.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 050/107] powerpc/fsl: Flush branch predictor when entering KVM
Date:   Mon,  1 Apr 2019 19:02:05 +0200
Message-Id: <20190401170050.358264973@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170045.246405031@linuxfoundation.org>
References: <20190401170045.246405031@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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


