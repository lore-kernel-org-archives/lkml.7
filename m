Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC44C2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C048206EC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576520970;
	bh=wCDWB/bRhXepO1riftMcvU3VSqlqFKrfo5G149GN9SM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k/EiswATrYDCVqw/cTytWHePFmeO1Py6BdX+OL2ALT9drce+bgnDJEvdEgGQ0qywz
	 G7uflOjvdDZAL2U2HZq43ge6zkGtyhZWITiV6F3t60+WOqHn2vhIqp0IZ+FHjEi8PH
	 ivx5wEifRvlYkczCpt751sJ3SraO5kP+fmi481wM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730813AbfLPSNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:13:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:60108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731122AbfLPSNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:13:38 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE91520CC7;
        Mon, 16 Dec 2019 18:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576520018;
        bh=wCDWB/bRhXepO1riftMcvU3VSqlqFKrfo5G149GN9SM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y8pT9zI9KMTEKtQrusXha1CAdTb05CgkgETTwrbSHG/NRIRTJ6IqzRFokDm7VVu22
         Qa0amchd/Arl2vVWx2W/e1hopL5YosiC4sHYpjYEpjkzMfTyCyJ8W3fPMdVmFtQKNn
         DcA0Q93FJKDLyTnoHUTD52ZiQoZ6PiNRcn8tTuKc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alastair DSilva <alastair@d-silva.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.3 124/180] powerpc: Allow 64bit VDSO __kernel_sync_dicache to work across ranges >4GB
Date:   Mon, 16 Dec 2019 18:49:24 +0100
Message-Id: <20191216174841.122146903@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174806.018988360@linuxfoundation.org>
References: <20191216174806.018988360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alastair D'Silva <alastair@d-silva.org>

commit f9ec11165301982585e5e5f606739b5bae5331f3 upstream.

When calling __kernel_sync_dicache with a size >4GB, we were masking
off the upper 32 bits, so we would incorrectly flush a range smaller
than intended.

This patch replaces the 32 bit shifts with 64 bit ones, so that
the full size is accounted for.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
Cc: stable@vger.kernel.org
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20191104023305.9581-3-alastair@au1.ibm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/vdso64/cacheflush.S |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/powerpc/kernel/vdso64/cacheflush.S
+++ b/arch/powerpc/kernel/vdso64/cacheflush.S
@@ -35,7 +35,7 @@ V_FUNCTION_BEGIN(__kernel_sync_dicache)
 	subf	r8,r6,r4		/* compute length */
 	add	r8,r8,r5		/* ensure we get enough */
 	lwz	r9,CFG_DCACHE_LOGBLOCKSZ(r10)
-	srw.	r8,r8,r9		/* compute line count */
+	srd.	r8,r8,r9		/* compute line count */
 	crclr	cr0*4+so
 	beqlr				/* nothing to do? */
 	mtctr	r8
@@ -52,7 +52,7 @@ V_FUNCTION_BEGIN(__kernel_sync_dicache)
 	subf	r8,r6,r4		/* compute length */
 	add	r8,r8,r5
 	lwz	r9,CFG_ICACHE_LOGBLOCKSZ(r10)
-	srw.	r8,r8,r9		/* compute line count */
+	srd.	r8,r8,r9		/* compute line count */
 	crclr	cr0*4+so
 	beqlr				/* nothing to do? */
 	mtctr	r8


