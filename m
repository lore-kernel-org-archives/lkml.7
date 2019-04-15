Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4669C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A6F2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555354260;
	bh=4GBuBPB77KQs7W0AjAGn6yo+ryMFRVsWoWXtaraMY7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qJ4gI1ak1nThVWgbLw8qGcHQlcLP7nrVWsB8C6iwDUj4WE1BYmLiyOwYVp9T4pUGO
	 98PhvyXKzq0chrNWAnhBmPrGN7k6UBCMqtEYSgPoMUKBRaNxDlyDNy+5YIEX28YGVc
	 2yoiKi7p1gpA7cCFjv6yk6wh7ear+aE8yE7U9Ytw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbfDOSu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:50:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:48958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728220AbfDOSqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:46:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF3E7218D3;
        Mon, 15 Apr 2019 18:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555353974;
        bh=4GBuBPB77KQs7W0AjAGn6yo+ryMFRVsWoWXtaraMY7o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y/OhqItL0Po61uvvfnOQONxqppNsEieWsNCXmCelFQjaJ1/KQXM1lcc0naVhbG4Lo
         WX0E0uaeNohbGOdRe7Oybu+wF2WbgNj+NUvaduHO9cB/BpEACbkc18QSewppJST/ur
         maW8eTR3Kf9yMtjB32kP1Kqd+ysQ8aFnreuQmt/c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Diana Craciun <diana.craciun@nxp.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 39/76] powerpc/fsl: Flush branch predictor when entering KVM
Date:   Mon, 15 Apr 2019 20:44:03 +0200
Message-Id: <20190415183717.789327618@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183707.712011689@linuxfoundation.org>
References: <20190415183707.712011689@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit e7aa61f47b23afbec41031bc47ca8d6cb6516abc upstream.

Switching from the guest to host is another place
where the speculative accesses can be exploited.
Flush the branch predictor when entering KVM.

Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kvm/bookehv_interrupts.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kvm/bookehv_interrupts.S b/arch/powerpc/kvm/bookehv_interrupts.S
index 81bd8a07aa51..612b7f6a887f 100644
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
-- 
2.19.1



