Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23ABC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85829229F4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563997393;
	bh=OoLstCwrj4LwdSUJRZg8bJXqPiWJi3vK9rLCWGtd5fA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t2sB5/Gkexn/kse0j8KbcqEH1oU0mZ+COPijZOfx26lzvo0ktYrvtE6Wb80Gia42P
	 QrZpHldrshx25JQJp8FuHWAOJTmb+UmPR+u/GdgrFm6QDB14nWAP/KnqObkGU/S3sB
	 N/a8/4Ksdo1yL6n1uQsjk9jpGfuEX0XeBmUJ5Y/Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390503AbfGXTnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:43:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:45034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390475AbfGXTnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:43:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88EEA21873;
        Wed, 24 Jul 2019 19:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563997384;
        bh=OoLstCwrj4LwdSUJRZg8bJXqPiWJi3vK9rLCWGtd5fA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S0mH8cjiwgvFTyODDIEpEq8VZOonm46WMwXwKIrNtdG3UtPizrPfM0H4oXzf2j/rb
         zRHGNbBtnY/5WLhBXGjfmnwqoeb4oN/kCuJ3VSaVuNJKDmDx2aj3j4o0/hw9Stq6XK
         y0LIN4X9jDKcp+7rR7O3/XyN1JVhPJc25n+Ig7Q4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.2 391/413] powerpc/powernv/idle: Fix restore of SPRN_LDBAR for POWER9 stop state.
Date:   Wed, 24 Jul 2019 21:21:22 +0200
Message-Id: <20190724191802.842404671@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

commit f5a9e488d62360c91c5770bd55a0b40e419a71ce upstream.

commit 10d91611f426 ("powerpc/64s: Reimplement book3s idle code in C")
reimplemented book3S code to pltform/powernv/idle.c. But when doing so
missed to add the per-thread LDBAR update in the core_woken path of
the power9_idle_stop(). Patch fixes the same.

Fixes: 10d91611f426 ("powerpc/64s: Reimplement book3s idle code in C")
Cc: stable@vger.kernel.org # v5.2+
Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20190702105836.26695-1-maddy@linux.vnet.ibm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/platforms/powernv/idle.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -758,7 +758,6 @@ static unsigned long power9_idle_stop(un
 	mtspr(SPRN_PTCR,	sprs.ptcr);
 	mtspr(SPRN_RPR,		sprs.rpr);
 	mtspr(SPRN_TSCR,	sprs.tscr);
-	mtspr(SPRN_LDBAR,	sprs.ldbar);
 
 	if (pls >= pnv_first_tb_loss_level) {
 		/* TB loss */
@@ -790,6 +789,7 @@ core_woken:
 	mtspr(SPRN_MMCR0,	sprs.mmcr0);
 	mtspr(SPRN_MMCR1,	sprs.mmcr1);
 	mtspr(SPRN_MMCR2,	sprs.mmcr2);
+	mtspr(SPRN_LDBAR,	sprs.ldbar);
 
 	mtspr(SPRN_SPRG3,	local_paca->sprg_vdso);
 


