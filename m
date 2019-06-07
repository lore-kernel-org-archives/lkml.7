Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F1BC468BC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299772147A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559922429;
	bh=LPrwfWoEtjOZcQQ3V6qTsG9X0ClXaj1tQXm/lMn4NSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XLWJ8GjeX0WPgJs3VVjVoAjFhZQYhHAxprVc959aek8uXMidtx/UhoSBLjjxbfsDU
	 X6e8XFVsQVIJn1gTfHgRUz77DEa+7IxtgLfd1xBG3lspI60bAbMFk5mDs//GrrziX0
	 7bHyRtCpicmSRT/O7MP/vn89BX0+pb1lM8juMfVc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731536AbfFGPrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:47:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:59752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731517AbfFGPrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:47:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EB1521479;
        Fri,  7 Jun 2019 15:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559922424;
        bh=LPrwfWoEtjOZcQQ3V6qTsG9X0ClXaj1tQXm/lMn4NSk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D/KJxyDOWP/IQevPSczKziHjvoHA1kpcHSe1HBHMzd15pSt4hznig/N8yj7lcdjM0
         iBjBx9NRNwoHiUm3rREQKsBleTPdYspHxH2Gg/+PmvQePIK4JEkw4QLeLnt4rtA6oo
         JNQhy94BeWUnFQlWky2vb96YmVTqPDr8G8EsNLOk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Meelis Roos <mroos@linux.ee>,
        James Clarke <jrtc27@jrtc27.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.1 01/85] sparc64: Fix regression in non-hypervisor TLB flush xcall
Date:   Fri,  7 Jun 2019 17:38:46 +0200
Message-Id: <20190607153849.282077170@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607153849.101321647@linuxfoundation.org>
References: <20190607153849.101321647@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Clarke <jrtc27@jrtc27.com>

commit d3c976c14ad8af421134c428b0a89ff8dd3bd8f8 upstream.

Previously, %g2 would end up with the value PAGE_SIZE, but after the
commit mentioned below it ends up with the value 1 due to being reused
for a different purpose. We need it to be PAGE_SIZE as we use it to step
through pages in our demap loop, otherwise we set different flags in the
low 12 bits of the address written to, thereby doing things other than a
nucleus page flush.

Fixes: a74ad5e660a9 ("sparc64: Handle extremely large kernel TLB range flushes more gracefully.")
Reported-by: Meelis Roos <mroos@linux.ee>
Tested-by: Meelis Roos <mroos@linux.ee>
Signed-off-by: James Clarke <jrtc27@jrtc27.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/sparc/mm/ultra.S |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/sparc/mm/ultra.S
+++ b/arch/sparc/mm/ultra.S
@@ -587,7 +587,7 @@ xcall_flush_tlb_kernel_range:	/* 44 insn
 	sub		%g7, %g1, %g3
 	srlx		%g3, 18, %g2
 	brnz,pn		%g2, 2f
-	 add		%g2, 1, %g2
+	 sethi		%hi(PAGE_SIZE), %g2
 	sub		%g3, %g2, %g3
 	or		%g1, 0x20, %g1		! Nucleus
 1:	stxa		%g0, [%g1 + %g3] ASI_DMMU_DEMAP
@@ -751,7 +751,7 @@ __cheetah_xcall_flush_tlb_kernel_range:
 	sub		%g7, %g1, %g3
 	srlx		%g3, 18, %g2
 	brnz,pn		%g2, 2f
-	 add		%g2, 1, %g2
+	 sethi		%hi(PAGE_SIZE), %g2
 	sub		%g3, %g2, %g3
 	or		%g1, 0x20, %g1		! Nucleus
 1:	stxa		%g0, [%g1 + %g3] ASI_DMMU_DEMAP


